%% Solving the 2-D nonlinear diffusion equation
%
%  u = nonlinear_diffusion(U, dt,g,N) where U is a 2D matrix representing
%       the initial conditions, g is a function evaluating g(|\nabla u|) and N is the number of timesteps
%
%
% Boundary Conditions = Zero-neumann
%
% $$u_t = (g(s) u_x)_x + (g(s) u_y)_y$$
%
% $$\frac{\partial u}{\partial x}(0,y,t) = 0$$
%
% $$\frac{\partial u}{\partial x}(L,y,t) = 0$$
%
% $$\frac{\partial u}{\partial y}(x,0,t) = 0$$
%
% $$\frac{\partial u}{\partial y}(x,L,t) = 0$$
%
function u = nonlinear_diffusion(u, dt, g,N)
  %%
  % Get size of initial condition matrix
  [nx ny] = size(u);

  %% 
  % Setup indexing. We don't update the boundary pixels, as they are set by
  % the boundary conditions
  i=2:nx-1;
  j=2:ny-1;
  
  u_x = zeros(size(u));
  u_y = zeros(size(u));
  %%
  % Loop through timesteps
  for it=1:N
      u_x(i,j) = u(i+1,j)-u(i-1,j);
      u_y(i,j) = u(i,j+1)-u(i,j-1);
      u_x(:,1) = u_x(:,2);
      u_x(:,ny) = u_x(:,ny-1);
      u_y(1,:) = u_y(2,:);
      u_y(nx,:) = u_y(nx-1,:);
      K = g(sqrt(u_x.^2+u_y.^2));

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