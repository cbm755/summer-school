% implicit solution of heat eq  u_t = u_xx, u(-1)=u(1)=0.
% Method-of-lines version

% Grid and initial data:
h = .025;                    % space step
k = 0.5*h;                   % time step
x = (-1+h:h:1-h)';           % grid
%x = (-1+h:h:1)';            % grid, for periodic
v = abs(x-0.2)<.3;           % initial data: square wave


figure(1); clf;
plt = plot(x,v,'k.-', 'linewidth',4);
axis([-1 1 -.01 1.01])
grid on

% Sparse matrix to execute finite difference operation:
N = length(x);
a = -2/h^2;
b = 1/h^2;
main = a*sparse(ones(N,1));
off  = b*sparse(ones(N-1,1));
L = diag(main) + diag(off,1) + diag(off,-1);
%L(1,end) = b; L(end,1) = b;  %  uncomment for periodic BCs

Tf = 2;
% adjust either final time or time-step to have integer steps
numsteps = ceil(Tf / k);
%k = Tf / numsteps
Tf = k*numsteps;

% Time-stepping:
I = speye(size(L));
A = I - k * L;

for n=1:numsteps
  %vnew = v + k*(L*v);     %forward euler
  %vnew = v + k*(L*vnew);  % backward euler
  vnew = A \ v;
  v = vnew;
  set(plt,'ydata',v)
  drawnow
  %pause
end

