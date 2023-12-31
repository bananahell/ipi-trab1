% YUV Enlarger.
%
% This is the entire question 1 of the course's project, so it reads an YUV file
% appropriately, turns it into a RGB image, turns it into a RGB image in a
% better way, then finally makes larger versions of each.
% It calls readYuv, enlargeImg, and enlargeImgBetter.
%
% fileName - The name of the file.
% width - width of the image, so the Y component.
% heigth - height of the image, so the Y component.
% frame - frame in the video where the image is to be extracted from.
%
% Returns the original RGB image, the RGB made better, and the larger versions
% of each.
%
function filterResults = yuvEnlarger(fileName, width, height, frame)
    global showTimes;
    tStart = tic;
    filterResults = struct;

    % Read the YUV file
    [yComp, uComp, vComp] = readYuv(fileName, width, height, frame);

    % Gets versions of the components U and V the same size as Y
    largeU = enlargeImg(uComp);
    largeV = enlargeImg(vComp);
    % Same as above but better
    betterLargeU = enlargeImgBetter(uComp);
    betterLargeV = enlargeImgBetter(vComp);

    % Compose the 3 dimensional matrix with the components
    yuvImg = yComp;
    yuvImg(:,:,2) = largeU;
    yuvImg(:,:,3) = largeV;
    % Same as above but better
    yuvImgBetter = yComp;
    yuvImgBetter(:,:,2) = betterLargeU;
    yuvImgBetter(:,:,3) = betterLargeV;

    % Turn both YUV images into RGB images
    filterResults.rgbImg = ycbcr2rgb(yuvImg);
    filterResults.rgbImgBetter = ycbcr2rgb(yuvImgBetter);

    % Enlarges each of the 3 components to get an overall larger image
    largeY = enlargeImg(yComp);
    largeU = enlargeImg(largeU);
    largeV = enlargeImg(largeV);
    % Same as above but better
    betterLargeY = enlargeImgBetter(yComp);
    betterLargeU = enlargeImgBetter(betterLargeU);
    betterLargeV = enlargeImgBetter(betterLargeV);

    % Compose the 3 dimensional matrix with the larger components
    yuvImgLarge = largeY;
    yuvImgLarge(:,:,2) = largeU;
    yuvImgLarge(:,:,3) = largeV;
    % Same as above but better
    yuvImgBetterLarge = betterLargeY;
    yuvImgBetterLarge(:,:,2) = betterLargeU;
    yuvImgBetterLarge(:,:,3) = betterLargeV;

    % Turn both larger YUV images into larger RGB images
    filterResults.rgbImgLarge = ycbcr2rgb(uint8(yuvImgLarge));
    filterResults.rgbImgBetterLarge = ycbcr2rgb(uint8(yuvImgBetterLarge));

    % Modified in main
    if showTimes > 1
        disp("yuvEnlarger done in " + toc(tStart) + " seconds!");
    end
end
