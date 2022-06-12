import numpy as np
import scipy
from oct2py import octave


class OptimizationFunctional:
	def __init__(self, penalty=1e-8, target_modal_energy=8.4) -> None:
		self.penalty = penalty 
		self.target_modal_energy = target_modal_energy
		self.msh_file = 'waggon.msh' 
	
	def __call__(self, vec, *args):
		res = octave.train_analysis(self.msh_file, 1, 
			vec[0], 
			vec[1], 
			vec[2], 
			120,	# Saeulen_f_w
			250,	# Saeulen_f_h
			vec[3], 
			vec[4], 
			vec[5],
			vec[6],
			vec[7],
		)
		mode, mass = res[0,0], res[0,1]
		energy = (mode-self.target_modal_energy)**2 + self.penalty * mass**2
		print(mode, mass, energy, vec)
		return energy 


to_optimize = OptimizationFunctional()


def saver(vec):
	print(f'results {vec}')

x0 = np.array([
	13., 
	2., 
	2., 
	#120., 
	#250., 
	10.,
	50.,
	80.,
	10.,
	5.
])

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
	callback=saver
)