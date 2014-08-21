%% Solving the 2-D anisotropic diffusion equation by the Finite Difference
%
%  u = anisotropic_diffusion(U, DTD, N) where U is a 2D matrix representing
%       the initial conditions, DTD is the timestep dt multiplied by the
%       diffusion constant D, and N is the number of timesteps
%
%
% Boundary Conditions = Zero-neumann
%
% $$u_t(x,y,t) = \alpha u_{NN}(x,y,t) + \beta u_{TT}(x,y,t)$$
%
% $$\frac{\partial u}{\partial x}(0,y,t) = 0$$
%
% $$\frac{\partial u}{\partial x}(L,y,t) = 0$$
%
% $$\frac{\partial u}{\partial y}(x,0,t) = 0$$
%
% $$\frac{\partial u}{\partial y}(x,L,t) = 0$$
%
function u = anisotropic_diffusion(u, dt, alpha,beta,N)
  %%
  % Get size of initial condition matrix
  [nx ny] = size(u);

  %% 
  % Setup indexing. We don't update the boundary pixels, as they are set by
  % the boundary conditions
  i=2:nx-1;
  j=2:ny-1;
  
  %%
  % Loop through timesteps
  for it=1:N
      %% 
      % Forward time, centred space 
      u_x2 = (u(i+1,j)-u(i-1,j)).^2;
      u_y2 = (u(i,j+1)-u(i,j-1)).^2;
      A = alpha * u_x2 + beta * u_y2;
      B = (alpha-beta) * (u(i+1,j)-u(i-1,j)).*(u(i,j+1)-u(i,j-1));
      C = beta * u_x2 + alpha * u_y2;
      u_xx = u(i+1,j) - 2*u(i,j) + u(i-1,j);
      u_yy = u(i,j+1) - 2*u(i,j) + u(i,j-1);
      u_xy = u(i+1,j+1) - u(i-1,j+1) - u(i+1,j-1) + u(i-1,j-1);
      u(i,j) = u(i,j) + dt*(A.*u_xx + B.*u_xy + C.*u_yy)./(u_x2+u_y2);
      
      %% 
      % Zero-neumann boundary conditions
      u(1,:) = u(2,:);
      u(nx,:) = u(nx-1,:);
      u(:,1) = u(:,2);
      u(:,ny) = u(:,ny-1);
  end
end
