%% Isotropic diffusion for image processing 4
% Read image and convert to double
u = double(imread('squares.bmp'));

%%
% Add normal noise with mean 0 and variance 10
u = u + 20.0*randn (size(u));

%%
% Display before image
figure
subplot(2,2,1)
colormap gray
imagesc(uint8(u));
title('before');

subplot(2,2,2)
colormap gray
plot(u(size(u,1)/2+3,:));
ylabel('u')

%%
% Run diffusion
dt = 0.1;
f = @(x,y) 1-sin(pi*x).*sin(pi*y);
u = varying_diffusion(u,dt,f,400);

%%
% Display result
subplot(2,2,3)
imagesc(uint8(u));
title('after');

subplot(2,2,4)
colormap gray
plot(u(size(u,1)/2+3,:));
ylabel('u')

