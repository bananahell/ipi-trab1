% Enlarge image better.
%
% Enlarges an image by taking each of its pixels and getting their averages
% with the next pixel in the axis, if possible, to grids of 2x2 pixels,
% "doubling each pixels' width and height size".
%
% origImg - The image to have its pixels "doubled".
%
% Returns the enlarged image.
%
function largeImg = enlargeImgBetter(origImg)
    global showTimes;
    % Starts timer and gets basic variables
    tStart = tic;
    [width, height] = size(origImg);
    largeImg = zeros(width * 2, height * 2);

    % First makes the large image with the original pixels and 3 black
    % pixels to its right and below it, waiting to be filled by the
    % original pixel's value
    for i = 1:width
        for j = 1:height
            largeImg(((i-1)*2)+1, ((j-1)*2)+1) = origImg(i, j);
        end
    end

    % Here the black surrounding pixels are filled with the value of the
    % original pixel and the next if possible, of only the original if not
    for i = 1:width*2
        for j = 1:height*2
            if mod(i, 2) == 1 && mod(j, 2) == 0
                if j+1 < height*2
                    largeImg(i, j) = (largeImg(i, j-1) + largeImg(i, j+1)) / 2;
                else
                    largeImg(i, j) = largeImg(i, j-1);
                end
            elseif mod(i, 2) == 0 && mod(j, 2) == 1
                if i+1 < width*2
                    largeImg(i, j) = (largeImg(i-1, j) + largeImg(i+1, j)) / 2;
                else
                    largeImg(i, j) = largeImg(i-1, j);
                end
            elseif mod(i, 2) == 0 && mod(j, 2) == 0
                if i+1 < width*2 && j+1 < height*2
                    largeImg(i, j) = (largeImg(i-1, j-1) + largeImg(i+1, j+1)) / 2;
                else
                    largeImg(i, j) = largeImg(i-1, j-1);
                end
            end
        end
    end

    % Modified in main
    if showTimes > 2
        disp("enlargeImgBetter done in " + toc(tStart) + " seconds!");
    end
end
