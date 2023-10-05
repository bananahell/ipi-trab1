% LaPlace Filter.
%
% Reads an image, filters it with a high-pass filter, then adds the
% filtered result to the original, enhancing the image's borders.
%
% fileName - The image to be filtered.
%
% Returns the filtered, and resulting images.
%
function [filteredImg, finalImg] = laplaceFilter(imgIn, kernel)
    global showTimes;
    % Starts timer and gets basic variables
    tStart = tic;
    
    % Applies kernel using convolution
    filteredImg = imfilter(imgIn, kernel);
    
    % The filter can be positive or negative, so it can also be subtracted
    if kernel(2,2) < 0
        finalImg = imgIn - filteredImg;
    else    
        finalImg = imgIn + filteredImg;
    end

    % Modified in main
    if showTimes > 1
        disp("laplaceFilter done in " + toc(tStart) + " seconds!");
    end
end
