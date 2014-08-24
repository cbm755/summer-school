
%% Grid for the example in the nodes
h = 0.1;
Nx = 3;  hx = h;  x1 = hx*[1:Nx]';
Ny = 4;  hy = h;  y1 = hy*[1:Ny]';

%% form a 2D grid
% then "stretch" it into 2 vectors for x and y
[xx,yy] = meshgrid(x1,y1);
x = xx(:); y = yy(:);
% note the ordering: sweeps upward in y first (see figure in notes)
% mostly we try to avoid thinking about this sort of detail.
[x(1) y(1)]
[x(2) y(2)]


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
% reproduce matrix in lectures
h^2*full(Dxx)
h^2*full(Dyy)
h^2*full(L)
