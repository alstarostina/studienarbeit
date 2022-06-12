import numpy as np
import scipy
from oct2py import octave


def to_optimize(vec, *args):
	energy = octave.train_analysis(1, vec[0], vec[1], vec[2])
	print(energy, vec)
	return (energy-8)**2


def saver(vec):
	print(f'results {vec}')


res = scipy.optimize.minimize(
	fun=to_optimize,
	method = 'L-BFGS-B',
	x0=np.array([18., 2., 2.]),
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