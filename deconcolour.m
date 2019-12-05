function [Stains] = deconcolour(imageIn, M, removeBlack, funContrast, vis, varargin)

%% input layer
if exist('vis')==0, vis = true; end

if ~exist('removeBlack'), removeBlack = true; end

if ~exist('funContrast'), funContrast = []; end

if exist('imageIn') == 0, imageIn = imread('testImage.jpg'); end

if size(imageIn,3) > 3, imageIn = imageIn(:,:,1:3); end 
Imax = 256;

%% remove black image-parts
if removeBlack
    imageIn = removeblack(imageIn, 256);
end

%% define the color values
if exist('M')~=1 
    %   R      G     B 
    M = [0.18, 0.20, 0.08; ... % Hematoxylin
        0.01, 0.13, 0.01; ...  % Eosin
        0.10, 0.21, 0.29];     % DAB
end

MNorm = [M(1,:)/norm(M(1,:));...
        M(2,:)/norm(M(2,:));...
        M(3,:)/norm(M(3,:))];

%% Convert RGB intensity to optical density (absorbance)
imageOD = -log10((double(imageIn)+1)./Imax);

%% convert the image to matrix with values per pixel
imageOD = reshape(imageOD,3,[]);

%% calculate the color deconvolution
imageDecon = M \ imageOD;
imageDecon = reshape(imageDecon', size(imageIn,1), size(imageIn,2), []);

%% convert the color-deconvolution results to a staining result
Stains = cell(3,1);
for i = 1:3
    Stains{i}= calcstainresult(imageDecon(:,:,i), Imax, funContrast);
end

%% output layer
if vis
   figure(),
   subplot(2,3, 1:3), imagesc(imageIn), title('input image')
   for i =1:3
        subplot(2,3,i+3), imagesc(Stains{i}),
        title(['staining', num2str(i)]), colorbar, colormap parula
   end
end
    
end
