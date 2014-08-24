% solving van der Pol equation using Matlab's ode45 command

C = 10;

% the ODE rhs function as an "anonymous function".  Can also be an
% separate .m file.
f = @(t,u)  [u(2); ...
             -C*(u(1)^2 - 1).*u(2) - u(1)];

U0 = [2; -0.65];  % initial condition

[tt,YY] = ode45(f, [0 50], U0);

u1 = YY(:,1);
clf;
plot(tt, u1, 'k*-');

