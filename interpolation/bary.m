function beta = bary(nodes, x)
%BARY  Barycentric Lagrange Interpolation weights
%   nodes is vector [x0 x1 x2 ... xn].
%   x is the scalar point we want to interpolate at.
%   This routine gives us beta_k such that
%   f(x) \approx sum_{k=0}^{n} beta_k f_k
%
%   This is the version we wrote together as a demo.


  %% Special case
  % We found we need this special case when x is
  % exactly one of the nodes.
  fail = x == nodes;
  if any(fail)
    beta = fail;   % ironic, fail is correct! wtf? :-)
    return  % skip rest of the code
  end


  n = length(nodes)-1;

  %% Weights
  %wk = 1 / ( (xk-x0)*(xk-x1)...(skip one)...(xk-xn) )
  wk = zeros(size(nodes));
  for k=1:(n+1)
    % nodes is a vector of length n + 1
    % othernodes is a vector, length n
    othernodes = nodes([1:(k-1) (k+1):(n+1)]);
    wk(k) = 1 / prod( nodes(k) - othernodes );
  end

  %% Barycentric weights
  % component-wise division
  numer = wk ./ (x - nodes);
  denom = sum(numer);

  beta = numer / denom;

