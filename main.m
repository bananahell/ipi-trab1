% Putting source folder in Matlab path
close all;
clear;
clc;

% Check if Windows or Unix for different bars
comp = computer();
if isequal(comp, 'PCWIN64')
    barChar = '\';
else
    barChar = '/';
end

% Build folders to add to path
home = pwd;
src = home;
disp("Adding " + src + " to the Matlab Path");
addpath(src);

src = [home barChar 'code'];
disp("Adding " + src + " to the Matlab Path");
addpath(src);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project's code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Shows the time of execution of each part of the code (accumulative)
% 0 = show only all
% 1 = show only main
% 2 = show question times
% 3 = show everything
global showTimes;
showTimes = 1;
tStart = tic;
imgPath = "." + barChar + "img" + barChar;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[rgbImg, rgbImgBetter, rgbImgLarge, rgbImgBetterLarge] = yuvEnlarger(imgPath + "foreman.yuv", 352, 288, 10);

figure("Name", "YUV to RGB image");
imshow(rgbImg, []);
figure("Name", "YUV better to RGB image");
imshow(rgbImgBetter, []);

figure("Name", "YUV to RGB image large");
imshow(rgbImgLarge, []);
figure("Name", "YUV better to RGB image large");
imshow(rgbImgBetterLarge, []);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

filterResults = sharpenFilters(convertStringsToChars(imgPath + "Image1.pgm"));

figure("Name", "Before LaPlace kernel 3x3 center 8");
imshow(filterResults.imgOriginal, []);

figure("Name", "LaPlace Filtered kernel 3x3 center 8");
imshow(filterResults.laplaceFiltered3x3center8, []);
figure("Name", "LaPlace Added kernel 3x3 center 8");
imshow(filterResults.laplaceFinal3x3center8, []);

figure("Name", "LaPlace Filtered kernel 3x3 center 4");
imshow(filterResults.laplaceFiltered3x3center4, []);
figure("Name", "LaPlace Added kernel 3x3 center 4");
imshow(filterResults.laplaceFinal3x3center4, []);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rejectNotchFilterResult = rejectNotchFilter(convertStringsToChars(imgPath + "moire.tif"));

figure("Name", "Reject Notch Filter Original");
imshow(rejectNotchFilterResult, []);

% Modified in the beginning of the project's code
if showTimes > 0
    disp("All done in " + toc(tStart) + " seconds!");
end
