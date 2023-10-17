% Sharpen Filters.
%
% First simply apply a high-pass LaPlacian 3x3 center 8 filter on image.
% Then apply a low-pass Gaussian 3x3 sigma 0.5 filter to then apply a high-pass
% LaPlacian 3x3 center 4 filter on image.
% Finally apply a low-pass Gaussian 3x3 sigma 1 filter to then apply a high-pass
% LaPlacian 3x3 center 4 filter on image.
%
% fileName - The name of the file.
%
% Returns the filtered images and them applied on the image.
%
function filterResults = sharpenFilters(fileName)
    global showTimes;
    % Starts timer and gets basic variables
    tStart = tic;
    filterResults = struct;

    % Reads image
    imgIn = imread(fileName);
    filterResults.imgOriginal = imgIn;

    % Filters and applies LaPlacian filter with a 3x3 kernel center 8
    kernel = [1 1 1; 1 -8 1; 1 1 1];
    filterResults.laplaceFiltered3x3center8 = imfilter(imgIn, kernel);
    filterResults.laplaceFinal3x3center8 = imgIn - filterResults.laplaceFiltered3x3center8;

    % Filters with a Gaussian filter with a 3x3 sigma 0.5 kernel and applies a
    % LaPlacian filter with a 3x3 kernel center 4
    kernel = fspecial('gaussian', 3, 0.5);
    tempFilteredImg = imfilter(imgIn, kernel);
    kernel = [0 1 0; 1 -4 1; 0 1 0];
    filterResults.lagaussFiltered3x3center4sigmaHalf = imfilter(tempFilteredImg, kernel);
    filterResults.lagaussFinal3x3center4sigmaHalf = imgIn - filterResults.lagaussFiltered3x3center4sigmaHalf;

    % Filters with a Gaussian filter with a 3x3 sigma 1 kernel and applies a
    % LaPlacian filter with a 3x3 kernel center 4
    kernel = fspecial('gaussian', 3, 1);
    tempFilteredImg = imfilter(imgIn, kernel);
    kernel = [0 1 0; 1 -4 1; 0 1 0];
    filterResults.lagaussFiltered3x3center4sigma1 = imfilter(tempFilteredImg, kernel);
    filterResults.lagaussFinal3x3center4sigma1 = imgIn - filterResults.lagaussFiltered3x3center4sigma1;

    % Modified in main
    if showTimes > 1
        disp("sharpenFilters done in " + toc(tStart) + " seconds!");
    end
end
