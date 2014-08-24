% A multistep method that is consistent but unstable and thus doesn't
% converge

lambda = 2;
f = @(t,u)  lambda*u;
u0 = 1;

Tf = 1;
k = 0.1;  % desired time step
numsteps = ceil(Tf / k)  % now adjust to have integer steps
k = Tf / numsteps        % modified time step

Hf = figure(1); clf;
hold on;
set(get(Hf, 'children'), 'fontsize', 16);
ms = 'markersize';


plot(0, u0, 'ko', ms, 12);
tt = linspace(0, Tf, 1000);
plot(tt, exp(lambda*tt), 'k-');  % exact solution
grid on; xlabel('t'); ylabel('u');

%% Initial condition
vold = u0;

%% this multistep method is not self starting
% try forward Euler
%v = vold + k*f(0,v);
% or use the exact soln
v = exp(lambda*k);

plot(k, v, 'b.', ms, 20)

% start at t_2 (because we used above to get t_1 soln)
for n = 2:numsteps
  t = k*(n-1);
  vnew = -4*v + 5*vold + k*( ...
      4*f(t, v) + 2*f(t-k, vold));

  plot(t+k, vnew, 'r.', ms, 20)
  drawnow
  pause

  vold = v;
  v = vnew;
end

