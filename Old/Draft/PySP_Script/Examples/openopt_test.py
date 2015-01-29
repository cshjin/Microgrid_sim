from openopt import NLP
from numpy import *
 
x0 = [0,0,0] # start point estimation
 
# define objective function as a Python language function
# of course, you can use "def f(x):" for multi-line functions instead of "f = lambda x:"
f = lambda x: (x[0]-1)**2 + (x[1]-2)**2 + (x[2]-3)**4
 
# form box-bound constraints lb <= x <= ub
lb = [-inf, 5, -inf] # lower bound
 
# form general linear constraints Ax <= b
A = [4, 0, -5]
b = -1
 
# form general nonlinear constraints c(x) <= 0
c = lambda x: (x[0] - 10)**2 + (x[1]+1) ** 2 - 50
 
# optionally you can provide derivatives (user-supplied or from automatic differentiation)
# for objective function and/or nonlinear constraints, see further doc below
 
p = NLP(f, x0, lb=lb, A=A, b=b, c=c)
r = p.solve('ralg')
print r.xf # [ 6.25834211  4.99999931  5.20667372]