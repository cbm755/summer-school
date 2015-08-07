% Order of accuracy convergence study for heat equation
%    backward Euler in time
%    second-order centered differences in space
%    zero-dirichlet BCs:  u(-1)=u(1)=0

% Compute solution for various grid sizes:
Hf = figure(1); clf; hold on;
H = get(Hf, 'children');  set(H, 'fontsize', 16);
kk = []; hh = []; uu = [];
for logh = 1:8
  h = 2^(-logh);
  x = (-1+h:h:1-h)';
  k = .1*h;
  %k = 0.1*sqrt(h);
  u = exp(-10*x.^4./(1-x.^2));       % smooth initial data
  % sparse matrix for implicit terms:
  N = length(x);
  a = (1+2*k/h^2); b = -k/h^2;
  main = a*sparse(ones(N,1));
  off  = b*sparse(ones(N-1,1));
  B = diag(main) + diag(off,1) + diag(off,-1);
  tmax = 1/8;
  nsteps = tmax/k;
  hold off, shg
  plt = plot(x,u,'*-','linewidth',4);
  t = 0;
  title(sprintf('h = %g, t = %g', h, t));
  axis([-1 1 -.01 1.01]), grid on
  disp('press enter'); %pause
  for step = 1:nsteps
    u = B\u;            % backward Euler
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

