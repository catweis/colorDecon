function [stainResult] = calcstainresult(deconResult, Imax, funContrast, varargin)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%% input layer
if ~exist('funContrast'), funContrast = []; end

%% reverse deconvolution
stainResult = deconResult;
stainResult = Imax* exp(-stainResult(:)');
stainResult = reshape(stainResult', size(deconResult,1), size(deconResult,2), 1);
stainResult = Imax - uint8(stainResult);

%% apply constrast stretching
if ~isempty(funContrast)

end

end

