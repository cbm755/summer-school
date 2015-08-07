%% Unsharp Mask
%

%% Load image
u = double(imread('../images/monarch.jpg'));

%% Display image
figure(1)
imagesc(uint8(u))

%% Diffuse
dt = 0.1;
D = 1;
u_d = u;
%u_d = isotropic_diffusion(u, dt*D, 20);
u_d(:,:,1) = isotropic_diffusion(u(:,:,1), dt*D, 200);
u_d(:,:,2) = isotropic_diffusion(u(:,:,2), dt*D, 200);
u_d(:,:,3) = isotropic_diffusion(u(:,:,3), dt*D, 200);
figure(2)
imagesc(uint8(u_d))

%% Subtract Diffused Image
u_e = u - u_d;
figure(3)
imagesc(uint8(u_e))

%% Add Edge Image to Original Image
u_f = u + u_e;
figure(4)
imagesc(uint8(u_f))
