%% Isotropic diffusion for image processing 2
% Read image and convert to double
u = double(imread('../images/squares.bmp'));

%%
% Add normal noise with mean 0 and variance 10
u = u + 10.0*randn (size(u));

%%
% Use a loop to show the results of applying diffusion from 0 <= t <=
% 250. An image is shown every 10 time units
figure
colormap gray
for i=0:25
  subplot('Position',[0.2*mod(i,5) 0.2*floor((24-i)/5.0) 0.19 0.19])
  imshow(uint8(u));
  axis off;

  dt = 0.1;
  D = 1;
  u = isotropic_diffusion(u, dt*D, 100);
end