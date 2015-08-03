function y = symbolic_cardinal(nodes, k)
%SYMBOLIC_CARDINAL  Return the symbolic cardinal polynomial
%   L = symbolic_cardinal(nodes, k) returns a symbolic expression
%   for the cardinal polynomial L_{n,k-1} where n = length(nodes).
%
%   Examples:
%   L2 = symbolic_cardinal([0 1 3 4.5], 2)
%   L4 = symbolic_cardinal([0 1 3 4.5], 4)
%
%   Returns:
%
%          x*(x - 3)*(x - 9/2)     x*(x - 3)*(x - 9/2)
%   L2  =  -------------------  =  -------------------
%          1*(1 - 3)*(1 - 9/2)              7
%
%            x*(x - 1)*(x - 3)       x*(x - 1)*(x - 3)
%   L4  =  ---------------------  =  -----------------
%          (4.5)*(4.5-1)*(4.5-3)         189 / 8
%
%   Note: k ranges from 1,...,n+1 unlike 0,...,n in the lectures.
%
%   2014-01-29, Gregory Bailey, Colin Macdonald.
%   public domain.

  if (k <= 0) || (k > length(nodes))
    error(sprintf('k must be in [1,%d]', length(nodes)));
  end

  syms x

  %% construct the numerator factors
  num = x - nodes;
  % discard the kth entry
  num = num([1:k-1 k+1:end]);

  %% construct the denominator factors
  % This should be just:
  %dem = num(nodes(k))
  % but this doesn't work in Matlab because () means index the
  % array.  Instead we use a loop.  "bsxfun" probably works too.
  dem = sym([]);
  for i=1:length(num)
    dem(i) = subs(num(i), x, nodes(k));
  end

  %% construct the L_{n,k}(x) polynomial
  y = prod(num) / prod(dem);

