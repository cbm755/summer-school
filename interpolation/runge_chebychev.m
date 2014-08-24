function runge_chebychev
% script to illustrate Runge phenomenon
%m = input('enter number of interpolating polynomials: ');

lw = 'linewidth';
z = linspace(-5.5,5.5,1000);
t=1./(1+z.^2);
plot(z,t,'-k', lw,2);
axis([-5.5 5.5 -2.5 3.5 ])
xlabel('x')
ylabel('y')
legend('y=1/(1+x^2)')
title(sprintf('original function'))



m = 5 ;
n = 1 ;
for k=1:m
% n = input('enter degree of interpolating polynomial: ');
  input('next polynomial');
  n = 2 * n ;
  %x = linspace(-5,5,n+1);
  x = 5*chebpts(n+1)';
  y = 1./(1+x.*x);
  t1 = 1./(1+z.^2);
  h1_line=plot(z,t1,'-k', lw,2);
  hold on
  plot(x, -0.5*ones(size(x)), 'kx');
  t=Newtonpol(x,y,z);
  h2_line = plot(z,t,'r', lw,2);
  err = max(t1 - t');
  [n err]
  axis([-5.5 5.5 -2.5 3.5 ])
  title(sprintf('example of divergence (n = %2.0f)', n))
  xlabel('x')
  ylabel('y')
  legend('y=1/(1+x^2)', 'interp. pts', 'interpolant')
  hold off
end

function [yi,a] = Newtonpol(x,y,xi)
  a=divdiff(x,y);
  n=length(a);
  val=a(n);
  for m = n-1:-1:1
    val=(xi-x(m)).*val + a(m);
  end
  yi=val(:);

function a = divdiff(x,y)
  n=length(x);
  for k=1:n-1
    y(k+1:n) = (y(k+1:n) - y(k))./(x(k+1:n)-x(k));
  end
  a=y(:);
