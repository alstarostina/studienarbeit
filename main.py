import numpy as np
import scipy
from oct2py import octave

x00 = np.array([
	13., 
	2., 
	2., 
	## Saeulen_f_{w,h,t}:
	120., 
	250., 
	10.,
	## T_{b,h,t,s}:
	50.,
	80.,
	10.,
	5.,
	## I_haupt_{b,h,t,s}:
	100,
	150,
	5,
	10,
	## Saeulen_Seiten_{w,h,t}:
	200,
	250,
	10
])

lower_bounds = x00/3
upper_bounds = x00*3
upper_bounds[1] = 20 

bounds = scipy.optimize.Bounds(lower_bounds, upper_bounds, True)


def extend_vector(vec):
	# return [13., 2., 2.] + list(vec)
	return list(vec)
	'''
	return [vec[0], 
		vec[1], 
		vec[2], 
		120., 
		250., 
		10.,
		## T_{b,h,t,s}:
		50.,
		80.,
		10.,
		5.,
		## I_haupt_{b,h,t,s}:
		100,
		150,
		5,
		10,
		## Saeulen_Seiten_{w,h,t}:
		200,
		250,
		10
	]
	'''


def print_vector(vec):
	vec = extend_vector(vec)
	print(f'Platte_t {vec[0]}')
	print(f'Waende_t {vec[1]}')
	print(f'dg_surface_geom_t {vec[2]}')
	print(f'Saeulen_f_w {vec[3]}')
	print(f'Saeulen_f_h {vec[4]}')
	print(f'Saeulen_f_t {vec[5]}')
	print(f'T_b {vec[6]}')
	print(f'T_h {vec[7]}')
	print(f'T_t {vec[8]}')
	print(f'T_s {vec[9]}')
	print(','.join([f'{v}' for v in list(vec)]))


class OptimizationFunctional:
	def __init__(self, penalty=1e-2, target_modal_energy=8.4) -> None:
		self.penalty = penalty 
		self.target_modal_energy = target_modal_energy
		self.msh_file = 'waggon.msh' 
	
	def __call__(self, vec, *args):
		print(vec)
		res = octave.train_analysis(self.msh_file, 1, *extend_vector(vec))
		mode, mass = res[0,0], res[0,1]
		energy = (mode-self.target_modal_energy)**2 + self.penalty * mass**2
		#energy = - (mode)**2 + (mass-8.9)**2
		#energy = - (mode)**2 + np.exp(100*(mass - 9)) 
		#energy = - (mode)**2 + self.penalty * mass ** 2 
		print(mode, mass, energy, vec)
		return energy 


to_optimize = OptimizationFunctional()


def saver(vec):
	print_vector(vec)
	print('-->')
	to_optimize(vec)
	print('--<')


x0 = np.array([
	24.660, # 13., 
	16.556, # 2., 
	2.8503, # 2., 
	## Saeulen_f_{w,h,t}:
	120., 
	250., 
	10.,
	## T_{b,h,t,s}:
	50.,
	80.,
	10.,
	5.,
	## I_haupt_{b,h,t,s}:
	100,
	150,
	5,
	10,
	## Saeulen_Seiten_{w,h,t}:
	200,
	250,
	10
])

'''
x0 = np.array([
	14.743756944679314,4.420414172863627,1.8279984444801536,120.14542177730809,249.98855314314596,8.918429589739524,50.267894192867686,80.28236249331064,11.095596791847846,5.527072541931002,99.99820038096011,150.05626156496314,5.325610534242109,10.128540998765784,200.01434931621438,249.99692698246045,9
])
'''

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