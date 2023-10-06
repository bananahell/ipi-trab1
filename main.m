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
imgResultsPath = imgPath + barChar + "results" + barChar;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[rgbImg, rgbImgBetter, rgbImgLarge, rgbImgBetterLarge] = yuvEnlarger(imgPath + "foreman.yuv", 352, 288, 10);

figure("Name", "Q1-1 YUV to RGB");
imshow(rgbImg, []);
imwrite(rgbImg, convertStringsToChars(imgResultsPath + "Q1-1 YUV to RGB.png"));
figure("Name", "Q1-2 YUV to RGB better");
imshow(rgbImgBetter, []);
imwrite(rgbImgBetter, convertStringsToChars(imgResultsPath + "Q1-2 YUV to RGB better.png"));

figure("Name", "Q1-3 YUV to RGB large");
imshow(rgbImgLarge, []);
imwrite(rgbImgLarge, convertStringsToChars(imgResultsPath + "Q1-3 YUV to RGB large.png"));
figure("Name", "Q1-4 YUV to RGB better large");
imshow(rgbImgBetterLarge, []);
imwrite(rgbImgBetterLarge, convertStringsToChars(imgResultsPath + "Q1-4 YUV to RGB better large.png"));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
filterResults = sharpenFilters(convertStringsToChars(imgPath + "Image1.pgm"));

figure("Name", "Q2-1 LaPlace Original");
imshow(filterResults.imgOriginal, []);
imwrite(filterResults.imgOriginal, convertStringsToChars(imgResultsPath + "Q2-1 LaPlace Original.png"));

figure("Name", "Q2-2 LaPlace filtered (k 3x3 c-8)");
imshow(filterResults.laplaceFiltered3x3center8, []);
imwrite(filterResults.laplaceFiltered3x3center8, convertStringsToChars(imgResultsPath + "Q2-2 LaPlace filtered (k 3x3 c-8).png"));
figure("Name", "Q2-3 LaPlace added (k 3x3 c-8)");
imshow(filterResults.laplaceFinal3x3center8, []);
imwrite(filterResults.laplaceFinal3x3center8, convertStringsToChars(imgResultsPath + "Q2-3 LaPlace added (k 3x3 c-8).png"));

figure("Name", "Q2-4 LaPlace filtered (k 3x3 c-4)");
imshow(filterResults.laplaceFiltered3x3center4, []);
imwrite(filterResults.laplaceFiltered3x3center4, convertStringsToChars(imgResultsPath + "Q2-4 LaPlace filtered (k 3x3 c-4).png"));
figure("Name", "Q2-5 LaPlace added (k 3x3 c-4)");
imshow(filterResults.laplaceFinal3x3center4, []);
imwrite(filterResults.laplaceFinal3x3center4, convertStringsToChars(imgResultsPath + "Q2-5 LaPlace added (k 3x3 c-4).png"));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rejectNotchFilterResult = rejectNotchFilter(convertStringsToChars(imgPath + "moire.tif"));

figure("Name", "Q3-1 Reject Notch original");
imshow(rejectNotchFilterResult, []);
imwrite(rejectNotchFilterResult, convertStringsToChars(imgResultsPath + "Q3-1 Reject Notch original.png"));

% Modified in the beginning of the project's code
if showTimes > 0
    disp("All done in " + toc(tStart) + " seconds!");
end
