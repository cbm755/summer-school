% stiffness: forward Euler and backward Euler
% on u' = -100(u-cos(t)) - sin(t)

Hf = figure(1); clf;
%hold on
%H = get(Hf, 'children');  set(H, 'fontsize', 16);

ms = 'markersize';
tmax = 1; exact = cos(tmax);

%% First, use forward euler
for logk = 2:10
  k = .5^logk;
  nsteps = tmax/k;
  t = 0; v = cos(t); f = -sin(t);
  for n = 1:nsteps
    t = (n-1)*k;
    % try this:
    %f = -sin(t)
    % then this:
    f = -sin(t) -100*(v - cos(t));
    vnew = v + k*f;
    v = vnew;
  end
  error = abs(v(end) - exact);
  loglog(k,error,'.k',ms,34)

  H = get(Hf, 'children');  set(H, 'fontsize', 16);
  axis([.5e-3 .5 1e-7 1e11]), grid on, hold on
  xlabel('step size k')
  ylabel('error')
  %pause
end

%% Next, backward Euler
for logk = 2:10
  k = .5^logk;
  nsteps = tmax/k;
  t = 0; v = cos(t); f = -sin(t);
  for n = 1:nsteps
    t = (n-1)*k;
    % backward Euler: vnew = v + k*f(t+k, vnew)
    % sub in an re-arrange, carefully this time ;-)
    vnew = (v + k*(-sin(t+k)  + 100*cos(t+k)))  / (1+k*100);
    v = vnew;
  end
  error = abs(v(end) - exact);
  loglog(k,error,'.r', ms, 24)
  %pause
end

