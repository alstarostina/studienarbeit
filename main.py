import numpy as np
import scipy
from oct2py import octave

x00_all = np.array([
	# 0 Platte_t,
	# 29.3,
	# 21.31157915, 
	# 23.99104478, # gut!
	13, 
	# 1 Waende_t,
	# 21.9,
	# 13.91926439,  
	2, 
	# 2 dg_surface_geom_t,
	# 3.7,
	# 1.23333333,
	2,
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
	3,
	# 24 I_BG_quer_b,
	80,
	# 25 I_BG_quer_h,
	130,
	# 26 I_BG_quer_t,
	3,
	# 27 I_BG_quer_s,
	5,	
	# 28 Saeulen_Seiten_w,
	200,
	# 29 Saeulen_Seiten_h,
	250,
	# 30 Saeulen_Seiten_t
	10.
])

#x00_all = np.array([23.720641823024398,15.093793110602078,1.0486440678037159,100.0,70.0,5.0,50.0,70.0,3.0,2.0,100.0,150.0,5.0,10.0,50.0,80.0,10.0,5.0,120.0,250.0,10.0,40.0,30.0,3.0])
#x00_all = np.array([23.754936838925424,15.127430948611654,1.1376214967764928,100.0482731828066,70.03219394743887,5.1951873218661735,49.99419969899615,70.00170839424678,2.9074287787918363,1.9352557762606986,100.00093440466054,150.00495891820788,4.999463630210258,10.012888727672545,50.0060021627139,80.03168820723653,9.98895706184435,4.957197724991066,120.0391056794531,249.99296303940486,9.52212152522604,40.012041086399435,30.011191136804538,3.1780262655382256])

# x00 = x00_all[0:3]
x00 = x00_all
#x00 = np.array(list(x00_all[0:3]) + list(x00_all[14:18]) + list(x00_all[21:]))
#x00 = np.array(list(x00_all[14:18]))

# we allow our structure to develop in a given interval
lower_bounds = x00/3
upper_bounds = x00*3
# no component should be smaller than 1 mm due to manufacturing:
lower_bounds[lower_bounds < 2] = 2 
# we allow higher wall thickness
upper_bounds[1] = 16

# add to constraints
bounds = scipy.optimize.Bounds(lower_bounds, upper_bounds, True)


def extend_vector(vec):
	return list(vec)
	# vec2 = np.copy(x00_all)
	# vec2[0:3] = vec[0:3]
	# vec2[14:18] = vec[3:7]
	# vec2[21:] = vec[7:]
	# vec2[14:18] = vec[:]
	# return list(vec) + list(x00_all)[3:]
	# return list(vec2)


def vector_to_str(vec):
	vec = extend_vector(vec)
	return ','.join([f'{v}' for v in list(vec)])


class OptimizationFunctional:
	def __init__(self, penalty=5e-1, target_modal_energy=8.4) -> None:
		self.penalty = penalty 
		self.target_modal_energy = target_modal_energy
		self.msh_file = 'waggon.msh' 
	
	def train_analysis(self, vec):
		print(self.msh_file, 1, *extend_vector(vec))
		res = octave.train_analysis_v2(self.msh_file, 1, *extend_vector(vec))
		mode, mass = res[0,0], res[0,1]
		return mode, mass
	
	def __call__(self, vec, *args):
		mode, mass = self.train_analysis(vec) 
		#energy = (mode-self.target_modal_energy)**2 + self.penalty * mass**2
		#energy = - (mode)**2 + (mass-8.9)**2
		# energy = - (mode)**2 + 1e-1 * np.exp(100*(mass - 9)) 
		energy = - mode**2 + self.penalty * mass ** 2 
		print (f'    energy = {mode}, mass = {mass}')
		return energy 


to_optimize = OptimizationFunctional()


def saver(vec):
	mode, mass = to_optimize.train_analysis(vec)
	print (f'> energy = {mode}, mass = {mass}')
	print (f'> vec = {vector_to_str(vec)}')

print('start:')
print(vector_to_str(x00))
saver(x00)

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
