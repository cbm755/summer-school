%% Solving the 1-D isotropic diffusion equation by the Finite Difference
%
%  u = isotropic_diffusion1D(U, DTD, N) where U is a vector representing
%       the initial conditions, DTD is the timestep dt multiplied by the
%       diffusion constant D, and N is the number of timesteps
%
% Method: Forward Time, Centered Space.
%
% Boundary Conditions = Zero-neumann
%
function u = isotropic_diffusion1D(u, dtD, N)
  %%
  % Get size of initial condition matrix
  n = max(size(u));

  % Setup indexing. We don't update the boundary pixels, as they are set by
  % the boundary conditions
  i=2:n-1;
  
  % Loop through timesteps
  for it=1:N
      % Use Forward Time, Centered Space
      u(i)= dtD*(u(i+1)+u(i-1)) + (1-2*dtD)*u(i);
      
      % Zero-neumann boundary conditions
      u(1) = u(2);
      u(n) = u(n-1);
  end
end
