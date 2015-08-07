%% Example of a gaussian low-pass filter
% Read image and convert to double
u = double(imread('squares.bmp'));

%%
% Add normal noise with mean 0 and variance 10
u = u + 10.0*randn (size(u));

%%
% Display "before" image
figure
subplot(2,2,1)
colormap gray
imagesc(uint8(u));
title('before');

subplot(2,2,2)
colormap gray
plot(u(size(u,1)/2,:));
ylabel('u')

%%
% Create 2D gaussian for convolution. We use *meshgrid* to generate x
% and y coordinates (using dx=dy=1) and then calculate a guassian function
% f
t = 1.0;
D = 1.0;
sigma = sqrt(2*D*t);
[nx ny] = size(u);
[x y]=meshgrid(round(-nx/2):round(nx/2), round(-ny/2):round(ny/2));
f=exp(-x.^2/(2*sigma^2)-y.^2/(2*sigma^2));
f=f./sum(f(:));

%%
% Take convolution of gaussian and image
u = conv2(u,f,'same');

%%
% Display result
subplot(2,2,3)
imagesc(uint8(u));
title('after');
subplot(2,2,4)
colormap gray
plot(u(size(u,1)/2,:));
ylabel('u')
