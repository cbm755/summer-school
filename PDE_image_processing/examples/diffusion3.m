%% Isotropic diffusion for image processing 3
% Read image and convert to double
u = double(imread('../images/peppersbw.png'));
%%
% Add normal noise with mean 0 and variance 10
u = u + 10.0*randn (size(u));

%%
% Display before image
figure
subplot(2,2,1)
colormap gray
imagesc(uint8(u));
title('before');

subplot(2,2,2)
colormap gray
plot(u(round(size(u,1)/2)+3,:));
ylabel('u')

%%
% Run diffusion
alpha = 0.0;
beta = 1;
dt = 0.1;
u = anisotropic_diffusion(u,dt,alpha,beta,20);

%%
% Display result
subplot(2,2,3)
imagesc(uint8(u));
title('after');

subplot(2,2,4)
colormap gray
plot(u(size(u,1)/2+3,:));
ylabel('u')

