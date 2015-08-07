%% Solving the 2-D isotropic diffusion equation by the Finite Difference
%
%  u = isotropic_diffusion(U, DTD, N) where U is a 2D matrix representing
%       the initial conditions, DTD is the timestep dt multiplied by the
%       diffusion constant D, and N is the number of timesteps
%
% Method: Forward Time, Centered Space.
%
% Boundary Conditions = Zero-neumann
%
% $$u_t(x,y,t) = D (u_{xx}(x,y,t) + u_{xx}(x,y,t))$$
%
% $$u^{n+1}_i = \Delta t D (u^n_{i+1,j} + u^n_{i-1,j} + u^n_{i,j+1} + u^n_{i,j-1}) + (1-4\Delta t D)u^n_{i,j})$$
%
% $$\frac{\partial u}{\partial x}(0,y,t) = 0$$
%
% $$\frac{\partial u}{\partial x}(L,y,t) = 0$$
%
% $$\frac{\partial u}{\partial y}(x,0,t) = 0$$
%
% $$\frac{\partial u}{\partial y}(x,L,t) = 0$$
%
function u = isotropic_diffusion(u, dtD, N)
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
      % Use Forward Time, Centered Space
      u(i,j)= dtD*(u(i+1,j)+u(i-1,j)+u(i,j+1)+u(i,j-1)) + (1-4*dtD)*u(i,j);
      
      %% 
      % Zero-neumann boundary conditions
      u(1,:) = u(2,:);
      u(nx,:) = u(nx-1,:);
      u(:,1) = u(:,2);
      u(:,ny) = u(:,ny-1);
  end
end
