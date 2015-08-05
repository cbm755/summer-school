%% DEMO: diff poly interp to approx f''
% On Octave, you'll need to load the symbolic package:
% >> pkg load symbolic
% On Matlab, you'll probably need the Symbolic Toolbox.

syms x
syms x0 x1 x2
syms f0 f1 f2
syms h

% make the cardinal symbolic
L0 = symbolic_cardinal([x0 x1 x2], 1)
L1 = symbolic_cardinal([x0 x1 x2], 2)
L2 = symbolic_cardinal([x0 x1 x2], 3)

p = f0*L0 + f1*L1 + f2*L2

% the general result
p2 = diff(p, x, x)

% now assume equispaced, i.e., at points
% x1 - h, x1, x1 + h
subs(p2, {x0, x2}, {x1 - h, x1 + h})

