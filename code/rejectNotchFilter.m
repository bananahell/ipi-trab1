% LaPlace Filter.
%
% Reads an image, filters it with a high-pass filter, then adds the
% filtered result to the original, enhancing the image's borders.
%
% fileName - The image to be filtered.
%
% Returns the filtered, and resulting images.
%
function originalImg = rejectNotchFilter(fileName)
    global showTimes;
    % Starts timer and gets basic variables
    tStart = tic;
    
    originalImg = imread(fileName);

    % Modified in main
    if showTimes > 1
        disp("rejectNotchFilter done in " + toc(tStart) + " seconds!");
    end
end
