% Compute error on a known soln: use for "convergence study"

%% Grid for periodic boundary conditions
%Nx = 64;  hx = 2/Nx;  x1 = (hx:hx:2)';
%Ny = 32;  hy = 1/Ny;  y1 = (hy:hy:1)';

%% Grid for non-periodic case
% double Nx,Ny, observe change in error
Nx = 50;  hx = 2/(Nx+1);  x1 = (hx:hx:2-hx)';
Ny = 30;  hy = 1/(Ny+1);  y1 = (hy:hy:1-hy)';

%% form a 2D grid
% then "stretch" it into 2 vectors for x and y
[xx,yy] = meshgrid(x1,y1);
x = xx(:); y = yy(:);


%% Initial condition
%u = double( ...
%    (abs(x-.5)<.4 & abs(y-.5)<.07) | (abs(x-.5)<.07 & abs(y-.5)<.4));
uexactf = @(x,y,t) exp(-5*pi^2*t) .* sin(2*pi*x) .* sin(1*pi*y);
u = uexactf(x,y,0);

e = ones(Nx,1);
Dx = spdiags([e  -2*e  e], [-1 0 1], Nx, Nx);
%Dx(1,end) = 1;  Dx(end,1) = 1;  % periodic BCs
Dx = 1/hx^2 * Dx;
Ix = speye(size(Dx));

e = ones(Ny,1);
Dy = spdiags([e  -2*e  e], [-1 0 1], Ny, Ny);
%Dy(1,end) = 1;  Dy(end,1) = 1;  % periodic BCs
Dy = 1/hy^2 * Dy;
Iy = speye(size(Dy));

%% Kronecker products to build 2D operators
% meshgrid order (correct thing here is dependent on the ordering
% chosen by meshgrid and (:))
Dxx = kron(Dx, Iy);
Dyy = kron(Ix, Dy);

% if you use ndgrid (instead of meshgrid)
%Dxx = kron(Iy, Dx);
%Dyy = kron(Dy, Ix);

L = Dxx + Dyy;

I = speye(size(L));

figure(1); clf;
spy(L)
disp('paused'); pause

%k = 0.1*min(hx,hy);
k = 0.25*min(hx^2,hy^2);
% Time-stepping:
Tf = 0.1;
% adjust either final time or time-step to have integer steps
numsteps = ceil(Tf / k);
%k = Tf / numsteps
Tf = k*numsteps;

A = I - k*L;

for n = 1:numsteps
  if mod(n, 10) == 0
    uu = reshape(u,size(xx));
    pcolor(xx,yy,uu);
    shading flat
    colorbar
    %surf(xx,yy,uu);
    title(sprintf('t = %6.4f',t), 'fontsize',20)
    xlabel('x'); ylabel('y');
    drawnow();
    %disp('paused'); pause
  end
  t = n*k;
  u = u + k * (L*u);  % forward Euler
  %u = A \ u;   % backward Euler

  % compute error
  err = norm(u - uexactf(x,y,t),inf)
end
