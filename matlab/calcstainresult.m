function [imageDecon] = calcstainresult(imageDecon, Imax, funContrast, varargin)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%% input layer
if ~exist('funContrast', 'var'), funContrast = []; end

%% reverse deconvolution
imageDecon = Imax* exp(-imageDecon);
imageDecon = Imax - uint8(imageDecon);

%% apply constrast stretching
if ~isempty(funContrast)

end

end