%% Loading and displaying images in Matlab
%

%% Load image
% A = *imread*(FILENAME,FMT) reads a grayscale or color image from the file
% specified by the string FILENAME. 
%     
% The text string FMT specifies the format of the file by its standard
% file extension. For example, specify 'gif' for Graphics Interchange 
% Format files.
%  
% The return value A is an uint8 array containing the image data.

u_int8_gray = imread('../images/peppersbw.png');
u_int8_color = imread('../images/peppers.png');


%% Display image
% Use either *imagesc* or *imagesc* to display images
%
% *imagesc*(I) displays a grayscale or truecolor image
% *imagesc*(I) is similar, but scales the pixel values to use the full
% colormap
%
% We will use *figure*(H) to open a new plotting window, where H is an 
% integer representing the id, or handle of the window. 
% 
% We will show the result result of *imagesc* and *imagesc* in separate 
% subplots.
% H = *subplot*(m,n,p), breaks the Figure window into an m-by-n matrix of 
% small axes, selects the p-th axes for the current plot, and returns the 
% axes handle.

figure(1)
subplot(2,2,1)
imagesc(u_int8_gray)
subplot(2,2,2)
imagesc(u_int8_gray)
subplot(2,2,3)
imagesc(u_int8_color)
subplot(2,2,4)
imagesc(u_int8_color)

%% Color image
% color images of size NxM are contained in matricies with size NxMx3
% where the last dimension is the different channels (Red, Green and Blue)

figure(2)
subplot(2,3,1)
imagesc(u_int8_color(:,:,1))
title('red')
subplot(2,3,2)
imagesc(u_int8_color(:,:,2))
title('green')
subplot(2,3,3)
imagesc(u_int8_color(:,:,3))
title('blue')

subplot(2,3,4)
%imagesc(rgb2gray(u_int8_color))
title('greyscale')
subplot(2,3,5)
imagesc(u_int8_color)
title('color')
%% Convert datatype to double
% Convert image matrix to the double datatype. pixel values can now be
% represented as real numbers instead of integers
u = double(u_int8_gray);

%% Add noise
% We artificially add some noise to the image using normrnd
%
%   randn Normally distributed pseudorandom numbers.
%     R = randn(N) returns an N-by-N matrix containing pseudorandom values drawn
%     from the standard normal distribution.  randn(M,N) or randn([M,N]) returns
%     an M-by-N matrix. randn(M,N,P,...) or randn([M,N,P,...]) returns an
%     M-by-N-by-P-by-... array. randn returns a scalar.  randn(SIZE(A)) returns
%     an array the same size as A.
%
% We add normal noise with mean 0 and variance 20

u = u + 20.0*randn (size(u));
figure(3)
imagesc(uint8(u))

