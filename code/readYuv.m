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
% Returns each of the YUV components.
%
function [Y, U, V] = readYuv(fileName, width, height, frame)
    global showTimes;
    % Starts timer and gets basic variables
    tStart = tic;
    resolution = width * height;
    % Gets right frame by multiplying it by the size of the YUV frames,
    % so Y = 1, U = 0.25, V = 0.25
    startByte = (resolution * 1.5) * (frame);

    % Reads the file and goes to right frame
    fileReader = matlab.io.datastore.DsFileReader(fileName);
    seek(fileReader, startByte);

    % Extracts the YUV components from the fileReader
    % The file came crooked, so I needed to flip and rotate the image
    Y = rot90(flip(reshape(read(fileReader, resolution), width, height), 2));
    U = rot90(flip(reshape(read(fileReader, resolution/4), width/2, height/2), 2));
    V = rot90(flip(reshape(read(fileReader, resolution/4), width/2, height/2), 2));

    % Modified in main
    if showTimes
        disp("readYuv done in " + toc(tStart) + " seconds!");
    end
end
