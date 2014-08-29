%% Isotropic diffusion for image processing 4
% Read image and convert to double
u = double(imread('squares.bmp'));

%%
% Add normal noise with mean 0 and variance 10
%u = u + 20.0*randn (size(u));

%%
% Display before image
figure
subplot(3,2,1)
colormap gray
imagesc(uint8(u));
title('before');

subplot(3,2,2)
colormap gray
plot(u(size(u,1)/2+3,:));
ylabel('u')

%%
% Run diffusion
dt = 0.1;
D = 1;
u = isotropic_diffusion(u,dt*D,200);

%%
% Display result
subplot(3,2,3)
imagesc(uint8(u));
title('after');

subplot(3,2,4)
colormap gray
plot(u(size(u,1)/2+3,:));
ylabel('u')

%%
% shock filter
dt = 0.1;
u = shock_filter(u,dt,50);
% Display result
subplot(3,2,5)
imagesc(uint8(u));
title('after');

subplot(3,2,6)
colormap gray
plot(u(size(u,1)/2+3,:));
ylabel('u')