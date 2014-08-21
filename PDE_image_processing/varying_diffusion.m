%% Solving the 2-D diffusion equation with spatially varying D by the Finite Difference
%
%  u = varying_diffusion(U, dt,f,N) where U is a 2D matrix representing
%       the initial conditions, f is a function evaluating K(x,y) and N is the number of timesteps
%
%
% Boundary Conditions = Zero-neumann
%
% $$u_t = (K(x,y) u_x)_x + (K(x,y) u_y)_y$$
%
% $$\frac{\partial u}{\partial x}(0,y,t) = 0$$
%
% $$\frac{\partial u}{\partial x}(L,y,t) = 0$$
%
% $$\frac{\partial u}{\partial y}(x,0,t) = 0$$
%
% $$\frac{\partial u}{\partial y}(x,L,t) = 0$$
%
function u = varying_diffusion(u, dt, f,N)
  %%
  % Get size of initial condition matrix
  [nx ny] = size(u);

  %% 
  % Setup indexing. We don't update the boundary pixels, as they are set by
  % the boundary conditions
  i=2:nx-1;
  j=2:ny-1;
  
  [I,J] = meshgrid(0:1/nx:1,0:1/ny:1);
  K = f(I,J);
  
  %%
  % Loop through timesteps
  for it=1:N
      %% 
      % Forward time, centred space 
      u(i,j) = u(i,j) + 0.5*dt*( ...
                    (K(i+1,j)+K(i,j)).*u(i+1,j) + ...
                    (K(i-1,j)+K(i,j)).*u(i-1,j) + ...
                    (K(i,j+1)+K(i,j)).*u(i,j+1) + ...
                    (K(i,j-1)+K(i,j)).*u(i,j-1) - ...
                    (K(i+1,j)+K(i-1,j)+K(i,j+1)+K(i,j-1)+4*K(i,j)).*u(i,j));
      
      %% 
      % Zero-neumann boundary conditions
      u(1,:) = u(2,:);
      u(nx,:) = u(nx-1,:);
      u(:,1) = u(:,2);
      u(:,ny) = u(:,ny-1);
  end
end
