%% Isotropic diffusion for image processing 1
% Read image and convert to double
u = double(imread('squares.bmp'));

%%
% Add normal noise with mean 0 and variance 10
u = u + normrnd (0, 10, size(u));

%%
% Display before image
figure
subplot(2,2,1)
colormap gray
imshow(uint8(u));
title('before');

subplot(2,2,2)
colormap gray
plot(u(size(u,1)/2,:));
ylabel('u')

%%
% Run diffusion
dt = 0.1;
D = 1;
u = isotropic_diffusion(u, dt*D, 10);

%%
% Display result
subplot(2,2,3)
imshow(uint8(u));
title('after');

subplot(2,2,4)
colormap gray
plot(u(size(u,1)/2,:));
ylabel('u')
