% Sharpen Filters.
%
% Reads an YUV image from a byte encoded file. The image is organized in
% the file as 4:2:0, so it's actually a video, with its Y component double
% the width and height dimensions of the U and V components.
%
% fileName - The name of the file.
% width - width of the image, so the Y component.
% heigth - height of the image, so the Y component.
% frame - frame in the video where the image is to be extracted from.
%
% Returns each of the YUV components.
%
function filterResults = sharpenFilters(fileName)
    global showTimes;
    % Starts timer and gets basic variables
    tStart = tic;
    filterResults = struct;
    
    % Reads image
    imgIn = imread(fileName);
    filterResults.imgOriginal = imgIn;
    
    % Filters and applies filter with a 3x3 kernel center 8
    kernel = [1 1 1; 1 -8 1; 1 1 1];
    [filteredImg, finalImg] = laplaceFilter(imgIn, kernel);
    filterResults.laplaceFiltered3x3center8 = filteredImg;
    filterResults.laplaceFinal3x3center8 = finalImg;
    
    % Filters and applies filter with a 3x3 kernel center 4
    % This kernel is why it's a LaPlace filter
    kernel = [0 1 0; 1 -4 1; 0 1 0];
    [filteredImg, finalImg] = laplaceFilter(imgIn, kernel);
    filterResults.laplaceFiltered3x3center4 = filteredImg;
    filterResults.laplaceFinal3x3center4 = finalImg;

    % Modified in main
    if showTimes > 1
        disp("sharpenFilters done in " + toc(tStart) + " seconds!");
    end
end
