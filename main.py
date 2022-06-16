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

def parameters_to_str(vec, prefix=''):
	lines = []
	lines.append(f"0 Platte_t \t= {vec[0]} (original = {x00_all[0]}, diff = {abs(x00_all[0] - vec[0])/x00_all[0]})")
	lines.append(f"1 Waende_t \t= {vec[1]} (original = {x00_all[1]}, diff = {abs(x00_all[1] - vec[1])/x00_all[1]})")
	lines.append(f"2 dg_surface_geom_t \t= {vec[2]} (original = {x00_all[2]}, diff = {abs(x00_all[2] - vec[2])/x00_all[2]})")
	lines.append(f"3 Beam_b \t= {vec[3]} (original = {x00_all[3]}, diff = {abs(x00_all[3] - vec[3])/x00_all[3]})")
	lines.append(f"4 Beam_h \t= {vec[4]} (original = {x00_all[4]}, diff = {abs(x00_all[4] - vec[4])/x00_all[4]})")
	lines.append(f"5 Beam_t \t= {vec[5]} (original = {x00_all[5]}, diff = {abs(x00_all[5] - vec[5])/x00_all[5]})")
	lines.append(f"6 I_langtr_i_b \t= {vec[6]} (original = {x00_all[6]}, diff = {abs(x00_all[6] - vec[6])/x00_all[6]})")
	lines.append(f"7 I_langtr_i_h \t= {vec[7]} (original = {x00_all[7]}, diff = {abs(x00_all[7] - vec[7])/x00_all[7]})")
	lines.append(f"8 I_langtr_i_t \t= {vec[8]} (original = {x00_all[8]}, diff = {abs(x00_all[8] - vec[8])/x00_all[8]})")
	lines.append(f"9 I_langtr_i_s \t= {vec[9]} (original = {x00_all[9]}, diff = {abs(x00_all[9] - vec[9])/x00_all[9]})")
	lines.append(f"10 I_haupt_b \t= {vec[10]} (original = {x00_all[10]}, diff = {abs(x00_all[10] - vec[10])/x00_all[10]})")
	lines.append(f"11 I_haupt_h \t= {vec[11]} (original = {x00_all[11]}, diff = {abs(x00_all[11] - vec[11])/x00_all[11]})")
	lines.append(f"12 I_haupt_t \t= {vec[12]} (original = {x00_all[12]}, diff = {abs(x00_all[12] - vec[12])/x00_all[12]})")
	lines.append(f"13 I_haupt_s \t= {vec[13]} (original = {x00_all[13]}, diff = {abs(x00_all[13] - vec[13])/x00_all[13]})")
	lines.append(f"14 I_b \t= {vec[14]} (original = {x00_all[14]}, diff = {abs(x00_all[14] - vec[14])/x00_all[14]})")
	lines.append(f"15 I_h \t= {vec[15]} (original = {x00_all[15]}, diff = {abs(x00_all[15] - vec[15])/x00_all[15]})")
	lines.append(f"16 I_t \t= {vec[16]} (original = {x00_all[16]}, diff = {abs(x00_all[16] - vec[16])/x00_all[16]})")
	lines.append(f"17 I_s \t= {vec[17]} (original = {x00_all[17]}, diff = {abs(x00_all[17] - vec[17])/x00_all[17]})")
	lines.append(f"18 Saeulen_f_w \t= {vec[18]} (original = {x00_all[18]}, diff = {abs(x00_all[18] - vec[18])/x00_all[18]})")
	lines.append(f"19 Saeulen_f_h \t= {vec[19]} (original = {x00_all[19]}, diff = {abs(x00_all[19] - vec[19])/x00_all[19]})")
	lines.append(f"20 Saeulen_f_t  \t= {vec[20]} (original = {x00_all[20]}, diff = {abs(x00_all[20] - vec[20])/x00_all[20]})")
	lines.append(f"21 Beam_fenster_w \t= {vec[21]} (original = {x00_all[21]}, diff = {abs(x00_all[21] - vec[21])/x00_all[21]})")
	lines.append(f"22 Beam_fenster_h \t= {vec[22]} (original = {x00_all[22]}, diff = {abs(x00_all[22] - vec[22])/x00_all[22]})")
	lines.append(f"23 Beam_fenster_t \t= {vec[23]} (original = {x00_all[23]}, diff = {abs(x00_all[23] - vec[23])/x00_all[23]})")
	lines.append(f"24 I_BG_quer_b \t= {vec[24]} (original = {x00_all[24]}, diff = {abs(x00_all[24] - vec[24])/x00_all[24]})")
	lines.append(f"25 I_BG_quer_h \t= {vec[25]} (original = {x00_all[25]}, diff = {abs(x00_all[25] - vec[25])/x00_all[25]})")
	lines.append(f"26 I_BG_quer_t \t= {vec[26]} (original = {x00_all[26]}, diff = {abs(x00_all[26] - vec[26])/x00_all[26]})")
	lines.append(f"27 I_BG_quer_s \t= {vec[27]} (original = {x00_all[27]}, diff = {abs(x00_all[27] - vec[27])/x00_all[27]})")
	lines.append(f"28 Saeulen_Seiten_w \t= {vec[28]} (original = {x00_all[28]}, diff = {abs(x00_all[28] - vec[28])/x00_all[28]})")
	lines.append(f"29 Saeulen_Seiten_h \t= {vec[29]} (original = {x00_all[29]}, diff = {abs(x00_all[29] - vec[29])/x00_all[29]})")
	lines.append(f"30 Saeulen_Seiten_t \t= {vec[30]} (original = {x00_all[30]}, diff = {abs(x00_all[30] - vec[30])/x00_all[30]})")
	return '\n'.join([prefix + l for l in lines])


x00 = x00_all

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


def vector_to_str(vec):
	vec = extend_vector(vec)
	return ','.join([f'{v}' for v in list(vec)])


class OptimizationFunctional:
	def __init__(self, penalty=5e-1) -> None:
		self.penalty = penalty 
		self.msh_file = 'waggon.msh' 
	
	def train_analysis(self, vec):
		print(self.msh_file, 1, *extend_vector(vec))
		res = octave.train_analysis_v2(self.msh_file, 1, *extend_vector(vec))
		mode, mass = res[0,0], res[0,1]
		return mode, mass
	
	def __call__(self, vec, *args):
		mode, mass = self.train_analysis(vec) 
		# energy = - (mode)**2 + 1e-1 * np.exp(100*(mass - 9)) 
		energy = - mode ** 2 + self.penalty * mass ** 2
		print (f'    energy = {mode}, mass = {mass}')
		return energy 


class Save:
	def __init__(self) -> None:
		self.energies = []
		self.masses = []
	
	def __call__(self, vec):
		mode, mass = to_optimize.train_analysis(vec)
		print(f'> energy = {mode}, mass = {mass}')
		print(f'> vec = {vector_to_str(vec)}')
		print(parameters_to_str(vec, prefix='> '))
		self.energies.append(mode)
		self.masses.append(mass)
		print(f'all energies {self.energies}')
		print(f'all masses   {self.masses}')



if __name__ == '__main__':
	to_optimize = OptimizationFunctional()

	saver = Save()

	print('start:')
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
