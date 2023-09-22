% Read YUV
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
% Each of the YUV components.
%
function largeImg = enlargeImg(origImg)
    % Starts timer and gets basic variables
    tStart = tic;
    [width, height] = size(origImg);
    largeImg = zeros(width * 2, height * 2);

    for i = 1:width
        for j = 1:height
            largeImg(((i-1)*2)+1, ((j-1)*2)+1) = origImg(i, j);
        end
    end

    for i = 1:width*2
        for j = 1:height*2
            if largeImg(i, j) == 0
                if i ~= 1 && largeImg(i-1, j) ~= 0
                    largeImg(i, j) = largeImg(i-1, j);
                elseif j ~= 1 && largeImg(i, j-1) ~= 0
                    largeImg(i, j) = largeImg(i, j-1);
                end
            else
                largeImg(i, j) = largeImg(i, j);
            end
        end
    end

    disp("enlargeImg done in " + toc(tStart) + " seconds!");
end
