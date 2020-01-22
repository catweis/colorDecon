function [imageDecon] = deconcolor(imageIn, M, removeBlack, funContrast, vis, varargin)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%% input layer
% input image
numb_channels = 3;

if ~exist('imageIn', 'var'), imageIn = imread('testImage.jpg'); end

if size(imageIn, 3) > numb_channels, imageIn = imageIn(:, :, 1:numb_channels); end 

Imax = double(max(imageIn(:)));

% define the color values
if ~exist('M', 'var') || ~(ismatrix(M) && size(M, 2) == numb_channels)  
    %   R      G     B 
    M = [0.18, 0.20, 0.08; ... % Hematoxylin
         0.01, 0.13, 0.01; ...  % Eosin
         0.10, 0.21, 0.29];     % DAB
end

numb_stains = size(M,1);

if ~exist('removeBlack', 'var'), removeBlack = true; end

if ~exist('funContrast', 'var'), funContrast = []; end

if ~exist('vis', 'var'), vis = true; end

%% remove black image-parts
if removeBlack
    imageIn = removeblack(imageIn, Imax);
end
%% normalize filter
for i = 1:numb_stains
    M(i, :) = M(i,:)/norm(M(i,:));      
end

%% convert RGB intensity to optical density (absorbance)
% +1 in order to avoid ln(0)
imageOD = -log10(double(imageIn+1)./Imax);

%% convert the image to matrix where each row represents a pixel and each column represents the specific color channel (R G B)
imageOD = reshape(imageOD, [], numb_channels);

%% calculate the color deconvolution xA = B (CM = OD)
imageDecon = imageOD / M;

%% convert the color-deconvolution results to a staining result
% reverse deconvolution
imageDecon = Imax* exp(-imageDecon);
imageDecon = Imax - uint8(imageDecon);

% apply constrast stretching
if ~isempty(funContrast)

end

% reshape back to image
imageDecon = reshape(imageDecon, size(imageIn, 1), size(imageIn, 2), numb_stains);

%% output layer
if vis
   figure(),
   subplot(2, numb_stains, 1:numb_stains), imagesc(imageIn), title('input image')
   for i = 1:numb_stains
        subplot(2, numb_stains, i+numb_stains), imagesc(imageDecon(:, :, i)),
        title(['staining', num2str(i)]), colorbar, colormap parula
    end
end
    
end
