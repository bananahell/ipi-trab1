% Putting source folder in Matlab path
clear;
clc;
close all;

% Check if Windows or Unix for different bars
comp = computer();
if isequal(comp, 'PCWIN64')
    barChar = '\';
else
    barChar = '/';
end

% Build folders to add to path.
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
% If true, show execution time of each function
global showTimes;
showTimes = false;
tStartAll = tic;
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

disp("All done in " + toc(tStartAll) + " seconds!");
