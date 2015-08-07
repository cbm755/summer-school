% order of accuracy study for Crank-Nicolson
%         soln of heat eq.  u_t = u_xx, u(-1)=u(1)=0 

% Compute solution for various grid sizes:
Hf = figure(1); clf; hold on;
H = get(Hf, 'children');  set(H, 'fontsize', 16);
hh = []; kk = []; uu = [];
for logh = 1:8
  h = 2^(-logh);
  x = (-1+h:h:1-h)';
  k = .25*h;
  u = exp(-10*x.^4./(1-x.^2));

  N = length(x);
  e = ones(N,1);
  L = spdiags([e  -2*e  e], [-1 0 1], N,N);
  %L(1,end) = 1; L(end,1) = 1;
  L = 1/h^2 * L;
  I = speye(size(L));

  % sparse matrix for implicit/explicit terms:
  B = I - (k/2)*L;
  A = I + (k/2)*L;

  % or, fully discrete:
  if (1==0)
    a = (1+k/h^2); b = -.5*k/h^2;
    main = a*sparse(ones(L,1));
    off  = b*sparse(ones(L-1,1));
    B = diag(main) + diag(off,1) + diag(off,-1);
    % sparse matrix for explicit terms:
    a = (1-k/h^2); b = .5*k/h^2;
    main = a*sparse(ones(L,1));
    off  = b*sparse(ones(L-1,1));
    A = diag(main) + diag(off,1) + diag(off,-1);
  end

  tmax = 1/8;
  nsteps = tmax/k;
  hold off, shg
  plt = plot(x,u,'linewidth',4);
  axis([-1 1 -.01 1.01]), grid
  for step = 1:nsteps
    u = B\(A*u);                       % trapezium rule
    t = step*k;
    set(plt,'ydata',u)
    title(sprintf('h = %g, t = %g', h, t));
    drawnow
  end
  hh = [hh; h]; kk = [kk; k]; uu = [uu; u(x==1/2)];
end

% Plot deviations of u(x=1/2,t=1/8) from finest-grid value:
Hf = figure(2); clf;
I = 1:length(kk)-2;
loglog(kk(I), kk(I), 'r--')
H = get(Hf, 'children');  set(H, 'fontsize', 16);
text(.013,.025,'k', 'fontsize',16,'color','r')
grid on, hold on
loglog(kk(I),kk(I).^2,'--r'), grid on
text(.013,.0004,'k^2', 'fontsize',16,'color','r')
loglog(kk(I),abs(uu(I)-uu(end)),'.-k','markersize',24)
xlabel('time step size k')
ylabel('error at  t=0.1')


Hf = figure(3); clf;
I = 1:length(hh)-2;
loglog(hh(I), 0.05*hh(I), 'r--')
H = get(Hf, 'children');  set(H, 'fontsize', 16);
text(.3,.025, 'h', 'fontsize',16,'color','r')
grid on, hold on
loglog(hh(I),(0.05*hh(I)).^2, 'r--')
text(.3,.0004, 'h^2', 'fontsize',16,'color','r')
loglog(hh(I),abs(uu(I)-uu(end)),'.-k','markersize',24)
xlabel('spatial step size h')
ylabel('error at  t=0.1')
