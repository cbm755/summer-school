%% Unsharp Mask
%

%% Load image
u = double(imread('../images/squares.bmp'));

%% Display image
figure(1)
colormap gray
imagesc(uint8(u))

%% Diffuse
dt = 0.1;
D = 1;
u_d = u;
u_d = isotropic_diffusion(u, dt*D, 20);
figure(2)
imagesc(uint8(u_d))

%% Subtract Diffused Image
u_e = u - u_d;
figure(3)
imagesc(uint8(u_e))

%% Add Edge Image to Original Image
u_f = u + u_e;
figure(4)
colormap gray
imagesc(uint8(u_f))

%% Show What Happens In a Single Line
i = size(u,1)/2+1
figure(5)
hold on
plot(u(i,:))
plot(u_d(i,:),'r')
plot(u_e(i,:),'b')

%% Enhanced Edges
figure(6)
plot(u_f(i,:))

