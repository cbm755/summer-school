
function u = shock_filter(u, dt,N)
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
      u_xp = u(i+1,j)-u(i,j);
      u_xn = u(i,j)-u(i-1,j);
      u_yp = u(i,j+1)-u(i,j);
      u_yn = u(i,j)-u(i,j-1);
      u_x2 = (u_xp + u_xn).^2;
      u_y2 = (u_yp + u_yn).^2;
      u_xu_y = (u_xp + u_xn).*(u_yp + u_yn);
      u_xx = u(i+1,j) - 2*u(i,j) + u(i-1,j);
      u_yy = u(i,j+1) - 2*u(i,j) + u(i,j-1);
      u_xy = u(i+1,j+1) - u(i-1,j+1) - u(i+1,j-1) + u(i-1,j-1);
      L = u_xx.*u_x2 + 2*u_xu_y.*u_xy + u_yy.*u_y2;
      u(i,j) = u(i,j) - dt*sqrt(arrayfun(@minmod,u_xp,u_xn).^2 + arrayfun(@minmod,u_yp,u_yn).^2).*sign(L);
      
      %% 
      % Zero-neumann boundary conditions
      u(1,:) = u(2,:);
      u(nx,:) = u(nx-1,:);
      u(:,1) = u(:,2);
      u(:,ny) = u(:,ny-1);
  end
end

function m = minmod(x,y)
    if (x*y) > 0
        m = sign(x)*min(abs(x),abs(y));
    else
        m = 0;
    end
end