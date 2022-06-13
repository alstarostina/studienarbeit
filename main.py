import numpy as np
import scipy
from oct2py import octave

x00_all = np.array([
	# 0 Platte_t,
	# 29.3,
	21.31157915, 
	#23.99104478, # gut!
	# 1 Waende_t,
	# 21.9,
	13.91926439,  
	# 14.27326964, #gut
	# 2 dg_surface_geom_t,
	# 3.7,
	1.23333333,
	# 1.21834555, #gut
	# 3 Beam_b,
	100,
	# 4 Beam_h,
	70,
	# 5 Beam_t,
	5,
	# 6 I_langtr_i_b,
	50,
	# 7 I_langtr_i_h,
	70,
	# 8 I_langtr_i_t,
	3,
	# 9 I_langtr_i_s,
	2,
	# 10 I_haupt_b,
	100,
	# 11 I_haupt_h,
	150,
	# 12 I_haupt_t,
	5,
	# 13 I_haupt_s,
	10,
	# wichtig
	# 14 I_b,
	50,
	# 15 I_h,
	80,
	# 16 I_t,
	10,
	# 17 I_s,
	5,
	# 18 Saeulen_f_w,
	120,
	# 19 Saeulen_f_h,
	250,
	# 20 Saeulen_f_t
	10,
	# 21 Beam_fenster_w,
	40,
	# 22 Beam_fenster_h,
	30,
	# 23 Beam_fenster_t
	3
])

# x00 = x00_all[0:3]
# x00 = x00_all
x00 = np.array(list(x00_all[0:3]) + list(x00_all[14:18]) + list(x00_all[21:]))

# we allow our structure to develop in a given interval
lower_bounds = x00/3
upper_bounds = x00*3
# no component should be smaller than 1 mm due to manufacturing:
lower_bounds[lower_bounds < 1] = 1 

# add to constraints
bounds = scipy.optimize.Bounds(lower_bounds, upper_bounds, True)


def extend_vector(vec):
	vec2 =  np.copy(x00_all)
	vec2[0:3] = vec[0:3]
	vec2[14:18] = vec[3:7]
	vec2[21:] = vec[7:]
	# return list(vec) + list(x00_all)[3:]
	return list(vec2)


def vector_to_str(vec):
	vec = extend_vector(vec)
	return ','.join([f'{v}' for v in list(vec)])


class OptimizationFunctional:
	def __init__(self, penalty=1e-0, target_modal_energy=8.4) -> None:
		self.penalty = penalty 
		self.target_modal_energy = target_modal_energy
		self.msh_file = 'waggon.msh' 
	
	def train_analysis(self, vec):
		res = octave.train_analysis_v2(self.msh_file, 1, *extend_vector(vec))
		mode, mass = res[0,0], res[0,1]
		return mode, mass
	
	def __call__(self, vec, *args):
		mode, mass = self.train_analysis(vec) 
		#energy = (mode-self.target_modal_energy)**2 + self.penalty * mass**2
		#energy = - (mode)**2 + (mass-8.9)**2
		energy = - (mode)**2 + 5e-1 * np.exp(100*(mass - 9)) 
		# energy = - (mode)**2 + self.penalty * mass ** 2 
		# print (f'energy = {mode}, mass = {mass}')
		return energy 


to_optimize = OptimizationFunctional()


def saver(vec):
	mode, mass = to_optimize.train_analysis(vec)
	print (f'> energy = {mode}, mass = {mass}')
	print (f'> vec = {vector_to_str(vec)}')

res = scipy.optimize.minimize(
	fun=to_optimize,
	method = 'L-BFGS-B',
	x0=x00,
	options={
		#'disp': 1, 
		'maxiter': 1000,
		#'gtol': 1e-16,
		#'ftol': 1e-16,
		'maxcor': 1,
		'iprint': 100,
		'maxls': 100
	},
	bounds=bounds,
	callback=saver
)