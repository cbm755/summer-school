function [ews, evs] = m28_ellipse_eigen(a, b, make_plots)
%ELLIPSE  Calculate eigenvalues/modes of ellipse
%   [ews] = ellipse(a,b);
%      returns the first 20 eigenvalues in 'ews' for an ellipse with
%      major axis a and minor axis b.
%
%   [ews] = ellipse(a,b,false);
%   [ews] = ellipse(a,b,true);
%      disables/enables the eigenmode plots.
%
%   [ews,evs] = ellipse(a,b);
%      if you want the eigenfunctions and the eigenvalues.  The
%      eigenfunctions are the columns of evs.  See plotting code
%      for how to use them.
%
%   This code is inspired by:
%     <matlabroot>/toolbox/matlab/sparfun/numgrid.m
%   and uses matlab's DELSQ to build an approximate Laplacian.

  if nargin == 0;
    a = 1;
    b = 0.5;
  end
  if nargin < 3
    make_plots = true;
  end

  n = 200;  % larger value gives more accuracy but slower

  % make a rectangular grid that will contain the ellipse
  ac = ceil(a);   bc = ceil(b);
  x1d = linspace(-ac,ac,ac*n+1);
  y1d = linspace(-bc,bc,bc*n+1);
  dx = x1d(2) - x1d(1);
  dy = y1d(2) - y1d(1);
  if abs(dx - dy) > 1e-14
    error('dx must equal dy');
  end
  [x,y] = meshgrid(x1d,y1d);


  %% An implicit representation of the shape
  % negative inside and positive outside.
  % ellipse: x^2/a^2 + y^2/b^2 = 1
  A = x.^2 / a^2 + y.^2 / b^2 - 1;
  % or a rectangle:
  %A = max(abs(x)-a, abs(y)-b);

  %% Build a grid
  % this is from numgrid.m: we choose an ordering for the points
  % inside the ellipse (all other points are labeled 0).
  G1 = A < 0;             % first, label points inside with a 1.
  k = find(G1);           % now find the linear index of these.
  G = zeros(size(x));    % new all zero matrix
  G(k) = (1:length(k))'; % label them inside ones from 1 upwards

  %figure(2); clf;
  %spy(G)
  %axis equal

  % build a finite different approximation to the Laplacian based on
  % the grid G
  L = delsq(G);
  L = 1/dx^2 * L;


  %% find the first 20 smallest magnitude eigenvalues
  tic
  [evs, ews, flag] = eigs(L, 20, 'sm');
  toc
  if flag ~= 0
    error('convergence problem');
  end
  ews = diag(ews);
  % sort the eigenvalues, we want the smallest first
  [ews,I] = sort(ews);
  % and re-arrange the eigenvectors too
  evs = evs(:,I);

  if (make_plots)
    figure(1); clf
    tic;
    for s = 1:16
      ev = evs(:,s);
      subplot(4,4,s);
      u = zeros(size(G));
      u(G>0) = ev;
      u(G==0) = nan;   % optional, hide the outside
      pcolor(x,y,u);
      shading flat;
      axis equal
      hold on;
      th = linspace(0,2*pi,512);
      H = plot(a*cos(th),b*sin(th),'k-');
    end

    figure(2); clf
    ev = evs(:,10);
    lambda = ews(10);
    u = zeros(size(G));
    u(G>0) = ev;
    %u(G==0) = nan;   % optional, hide the outside
    pcolor(x,y,u);
    shading flat;
    axis equal
    hold on;
    th = linspace(0,2*pi,512);
    H = plot(a*cos(th),b*sin(th),'k-');
    set(H, 'linewidth', 2);

    title(sprintf('10th eigenmode, lambda = %g,  a = %g, b = %g', ...
                  lambda, a, b));
    toc
    drawnow
    pause(0);
  end

