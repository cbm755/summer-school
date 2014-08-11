function p=lagrange(knots,data)

%LAGRANGE  Plots the Lagrange polynomial interpolant for the 
%given DATA at the given KNOTS

p=lagrange_poly(knots,data);

left=min(knots);right=max(knots);range=right-left;
top=max(data);bottom=min(data);height=top-bottom;
x=linspace(left-0.1*range,right+0.1*range,500);
y=polyval(p,x);            

plot(knots,data,'gx','linewidth',3,'markersize',20),hold on,plot(x,y)
axis([left-0.1*range,right+0.1*range,bottom-0.1*height,top+0.1*height])

function p = lagrange_poly(knots,data)

%LAGRANGE_POLY  Lagrange interpolation polynomial.
%   P = LAGRANGE_POLY(KNOTS,DATA) returns a vector containing the
%   coefficients of the Lagrange polynomial for the function
%   values in the vector DATA evaluated at the points KNOTS.
% 
%   The N coefficients are ordered so that P(1) is the
%   coefficient corresponding to x^(N-1) and P(N) is the
%   coefficient for x^0, i.e., the polynomial l(x) is defined
%   by l(x) = P(1)x^(N-1) + P(2)x^(N-2) + ... + P(N)x^0.
%
%   The function computes the coefficients of the Lagrange
%   polynomial using the constructive method shown in lectures.

    p = 0;
    for k=1:length(knots),
      p = p + generate_L(k,knots)*data(k);
    end;


% Subfunction for generating the individual components
function Lk = generate_L(k,knots)
    these_points = knots([1:(k-1) (k+1):end]);
    Lk = poly(these_points);
    the_scale_factor = prod(knots(k)-these_points);
    Lk = Lk/the_scale_factor;
