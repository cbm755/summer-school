%% Load Image and add noise
% Read image and convert to double
u = double(imread('swan-512.jpg'));
r = u(:,:,1);
g = u(:,:,2);
b = u(:,:,3);
u = 0.299*r + 0.587*g + 0.144*b;

%%
% Add normal noise with mean 0 and variance 25
u = u + 25.0*randn (size(u));

%%
% Display before image
figure
colormap gray
imagesc(uint8(u));
title('before');