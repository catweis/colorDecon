function [imageOut] = removeblack(imageIn, replaceValue, varargin)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%% input layer
if ~exist('replaceValue'), replaceValue = 256; end

%% detect black areas
imageGray = rgb2gray(imageIn);
maskBlack = imageGray <5;
maskBlack =repmat(maskBlack, [1,1,3]);

%% remove it 
imageOut = imageIn;
imageOut(maskBlack)= replaceValue;

end

