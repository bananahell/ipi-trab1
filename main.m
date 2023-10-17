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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project's code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Shows the time of execution of each part of the code (accumulative)
% 0 = show none
% 1 = show only main
% 2 = show question times
% 3 = show everything
global showTimes;
showTimes = 2;
tStart = tic;
imgPath = "." + barChar + "img" + barChar;
imgResultsPath = imgPath + "results" + barChar;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
yuvEnlargerResult = yuvEnlarger(imgPath + "foreman.yuv", 352, 288, 1);

figure("Name", "Q1-1 YUV to RGB");
imshow(yuvEnlargerResult.rgbImg, []);
imwrite(yuvEnlargerResult.rgbImg, convertStringsToChars(imgResultsPath + "Q1-1 YUV to RGB.png"));
figure("Name", "Q1-2 YUV to RGB better");
imshow(yuvEnlargerResult.rgbImgBetter, []);
imwrite(yuvEnlargerResult.rgbImgBetter, convertStringsToChars(imgResultsPath + "Q1-2 YUV to RGB better.png"));

figure("Name", "Q1-3 YUV to RGB large");
imshow(yuvEnlargerResult.rgbImgLarge, []);
imwrite(yuvEnlargerResult.rgbImgLarge, convertStringsToChars(imgResultsPath + "Q1-3 YUV to RGB large.png"));
figure("Name", "Q1-4 YUV to RGB better large");
imshow(yuvEnlargerResult.rgbImgBetterLarge, []);
imwrite(yuvEnlargerResult.rgbImgBetterLarge, convertStringsToChars(imgResultsPath + "Q1-4 YUV to RGB better large.png"));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sharpenFiltersResult = sharpenFilters(convertStringsToChars(imgPath + "Image1.pgm"));

figure("Name", "Q2-1 LaPlace Original");
imshow(sharpenFiltersResult.imgOriginal, []);
imwrite(sharpenFiltersResult.imgOriginal, convertStringsToChars(imgResultsPath + "Q2-1 LaPlace Original.png"));

figure("Name", "Q2-2 LaPlace filtered (k 3x3 c-8)");
imshow(sharpenFiltersResult.laplaceFiltered3x3center8, []);
imwrite(sharpenFiltersResult.laplaceFiltered3x3center8, convertStringsToChars(imgResultsPath + "Q2-2 LaPlace filtered (k 3x3 c-8).png"));
figure("Name", "Q2-3 LaPlace added (k 3x3 c-8)");
imshow(sharpenFiltersResult.laplaceFinal3x3center8, []);
imwrite(sharpenFiltersResult.laplaceFinal3x3center8, convertStringsToChars(imgResultsPath + "Q2-3 LaPlace added (k 3x3 c-8).png"));

figure("Name", "Q2-4 Gauss LaPlace filtered (3x3 sigma 0.5 k 3x3 c-4)");
imshow(sharpenFiltersResult.lagaussFiltered3x3center4sigmaHalf, []);
imwrite(sharpenFiltersResult.lagaussFiltered3x3center4sigmaHalf, convertStringsToChars(imgResultsPath + "Q2-4 Gauss LaPlace filtered (3x3 sigma 0.5 k 3x3 c-4).png"));
figure("Name", "Q2-5 Gauss LaPlace added (3x3 sigma 0.5 k 3x3 c-4)");
imshow(sharpenFiltersResult.lagaussFinal3x3center4sigmaHalf, []);
imwrite(sharpenFiltersResult.lagaussFinal3x3center4sigmaHalf, convertStringsToChars(imgResultsPath + "Q2-5 Gauss LaPlace added (3x3 sigma 0.5 k 3x3 c-4).png"));

figure("Name", "Q2-6 Gauss LaPlace filtered (3x3 sigma 1 k 3x3 c-4)");
imshow(sharpenFiltersResult.lagaussFiltered3x3center4sigma1, []);
imwrite(sharpenFiltersResult.lagaussFiltered3x3center4sigma1, convertStringsToChars(imgResultsPath + "Q2-6 Gauss LaPlace filtered (3x3 sigma 1 k 3x3 c-4).png"));
figure("Name", "Q2-7 Gauss LaPlace added (3x3 sigma 1 k 3x3 c-4)");
imshow(sharpenFiltersResult.lagaussFinal3x3center4sigma1, []);
imwrite(sharpenFiltersResult.lagaussFinal3x3center4sigma1, convertStringsToChars(imgResultsPath + "Q2-7 Gauss LaPlace added (3x3 sigma 1 k 3x3 c-4).png"));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
radiusAndPositions = [[10,39,30]; [10,-39,30]; [5,78,30]; [5,-78,30]];
rejectNotchFilterResult = rejectNotchFilter(convertStringsToChars(imgPath + "moire.tif"), radiusAndPositions, 4);

figure("Name", "Q3-1 Reject Notch original");
imshow(rejectNotchFilterResult.imgOriginal, []);
imwrite(rejectNotchFilterResult.imgOriginal, convertStringsToChars(imgResultsPath + "Q3-1 Reject Notch original.png"));

figure("Name", "Q3-2 Reject Notch original Fourier");
imshow(rejectNotchFilterResult.imgFourier, []);
imwrite(rejectNotchFilterResult.imgFourier, convertStringsToChars(imgResultsPath + "Q3-2 Reject Notch original Fourier.png"));

figure("Name", "Q3-3 Reject Notch mask");
imshow(rejectNotchFilterResult.resultMask, []);
imwrite(rejectNotchFilterResult.resultMask, convertStringsToChars(imgResultsPath + "Q3-3 Reject Notch mask.png"));

figure("Name", "Q3-4 Reject Notch result");
imshow(rejectNotchFilterResult.resultImg, []);
imwrite(rejectNotchFilterResult.resultImg, convertStringsToChars(imgResultsPath + "Q3-4 Reject Notch result.png"));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Modified in the beginning of the project's code
if showTimes > 0
    disp("All done in " + toc(tStart) + " seconds!");
end
