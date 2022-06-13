import numpy as np
import scipy
from oct2py import octave

x00_all = np.array([
	# Platte_t,
	# 29.3,
	# 21.31157915, 
	23.99104478,
	# Waende_t,
	# 21.9,
	# 13.91926439,  
	14.27326964,
	# dg_surface_geom_t,
	# 3.7,
	# 1.23333333,
	1.21834555,
	# Beam_b,
	100,
	# Beam_h,
	70,
	# Beam_t,
	5,
	# I_langtr_i_b,
	50,
	# I_langtr_i_h,
	70,
	# I_langtr_i_t,
	3,
	# I_langtr_i_s,
	2,
	# I_haupt_b,
	100,
	# I_haupt_h,
	150,
	# I_haupt_t,
	5,
	# I_haupt_s,
	10,
	# wichtig
	# I_b,
	50,
	# I_h,
	80,
	# I_t,
	10,
	# I_s,
	5,
	# I_BG_quer_b,
  80,
  # I_BG_quer_h,
  130,
  #I_BG_quer_t,
  3,
  #I_BG_quer_s,
  5,	
	# Saeulen_f_w,
	120,
	# Saeulen_f_h,
	250,
	# Saeulen_f_t
	10,
])

#x00 = x00_all[0:3]
x00 = x00_all#[0:3]

lower_bounds = x00/3
upper_bounds = x00*3

bounds = scipy.optimize.Bounds(lower_bounds, upper_bounds, True)


def extend_vector(vec):
	# return list(vec) + list(x00_all)[3:]
	return list(vec)


def print_vector(vec):
	vec = extend_vector(vec)
	print(','.join([f'{v}' for v in list(vec)]))


class OptimizationFunctional:
	def __init__(self, penalty=1e-1, target_modal_energy=8.4) -> None:
		self.penalty = penalty 
		self.target_modal_energy = target_modal_energy
		self.msh_file = 'waggon.msh' 
	
	def __call__(self, vec, *args):
		print(vec)
		res = octave.train_analysis_v2(self.msh_file, 1, *extend_vector(vec))
		mode, mass = res[0,0], res[0,1]
		#energy = (mode-self.target_modal_energy)**2 + self.penalty * mass**2
		#energy = - (mode)**2 + (mass-8.9)**2
		energy = - (mode)**2 + 5e-1 * np.exp(100*(mass - 9)) 
		#energy = - (mode)**2 + self.penalty * mass ** 2 
		print(mode, mass, energy, vec)
		return energy 


to_optimize = OptimizationFunctional()


def saver(vec):
	print_vector(vec)
	print('-->')
	to_optimize(vec)
	print('--<')


x0 = x00 

res = scipy.optimize.minimize(
	fun=to_optimize,
	method = 'L-BFGS-B',
	x0=x0,
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
