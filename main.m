% Putting source folder in Matlab path
clear;
clc;

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

% Project's code
imgPath = "." + barChar + "img" + barChar;

[yComp, uComp, vComp] = readYuv(imgPath + "foreman.yuv", 352, 288, 2);

largeY = enlargeImg(yComp);

figure;
imshow(yComp);
figure;
imshow(largeY);
