%% Perona-Malik
% Read image and convert to double
u = double(imread('project/swan-512.jpg'));
r = u(:,:,1);
g = u(:,:,2);
b = u(:,:,3);
u = 0.299*r + 0.587*g + 0.144*b;

%%
% Add normal noise with mean 0 and variance 10
u = u + 25.0*randn (size(u));

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
lambda = 5;
g = @(s) 1./(1+s.^2/lambda^2);
u = nonlinear_diffusion(u,dt,g,400);

%%
% Display result
subplot(2,2,3)
imagesc(uint8(u));
title('after');

subplot(2,2,4)
colormap gray
plot(u(size(u,1)/2+3,:));
ylabel('u')


