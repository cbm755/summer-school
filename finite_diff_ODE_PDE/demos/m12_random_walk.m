%random walk (~ Brownian motion) of 300 particles:
%         the "physics" of the heat equation.
%         Quit with ^C, and then try hist(x) or hist(y).

figure(1); clf;
%hold off, shg
N = 300;
x = zeros(N,1); y = zeros(N,1);
dots = plot(x,y,'.k','markersize',24);
axis([-1 1 -1 1]), axis square, axis off
while 1
  x = x + .01*randn(N,1);
  y = y + .01*randn(N,1);
  set(dots,'xdata',x,'ydata',y)
  drawnow
end

