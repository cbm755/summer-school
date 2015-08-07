%% 1D Isotropic diffusion for image processing
% create top-hat vector to diffuse
u = zeros(1,1000);
u(400:600) = 254;

%%
% Add normal noise with mean 0 and variance 10
u = u + 10.0*randn (size(u));

%%
% Display before image
figure
subplot(2,1,1);
plot(u);
title('before');

%%
% Run diffusion
dt = 0.1;
D = 1;
u = isotropic_diffusion1D(u, dt*D, 1000);

%%
% Display result
subplot(2,1,2);
plot(u);
title('after');

pause;
