% Reject Notch Filter.
%
% Reads an image with Moire effect and removes it operating a Butterworth
% reject notch filter on the image.
% It calls getRejectNotchFilter.
%
% fileName - The image to be filtered.
% radiusAndPosition - Array containing the radius and the X and Y coordinates of
% the frequency requested.
% n - Exponent used in Butterworth's equation.
%
% Returns the original image with its original Fourier transform, the
% Butterworth mask used, and the filtered image.
%
function filterResults = rejectNotchFilter(fileName, radiusAndPositions, n)
    global showTimes;
    % Starts timer and gets basic variables
    tStart = tic;
    filterResults = struct;

    % Read image and get it as double
    imgIn = imread(fileName);
    filterResults.imgOriginal = imgIn;
    imgDouble = double(imgIn);

    % Get shifted Fourier transformed image
    [nRows, nCols] = size(imgDouble);
    imgDoubleFourier = fftshift(fft2(imgDouble));
    filterResults.imgFourier = uint8(255 * mat2gray(uint8(log(abs(imgDoubleFourier)))));

    % Get each of the masks specified by the input array
    masks = cell(1, size(radiusAndPositions, 1)*2);
    for i = 1:1:size(radiusAndPositions, 1)
        [filterMaskPositive, filterMaskNegative] = getRejectNotchFilter(radiusAndPositions(i,:), nRows, nCols, n);
        masks{((i-1)*2)+1} = filterMaskPositive;
        masks{((i-1)*2)+2} = filterMaskNegative;
    end

    % Unite every mask into one and only mask
    resultMask = ones(nRows, nCols);
    for i = 1:1:size(masks, 2)
        resultMask = resultMask .* masks{i};
    end
    filterResults.resultMask = uint8(resultMask.*255);

    % Apply the mask into the Fourier transformed image and transforms it back
    resultImg = imgDoubleFourier .* resultMask;
    resultImg = uint8(real(ifft2(ifftshift(resultImg))));
    filterResults.resultImg = resultImg;

    % Modified in main
    if showTimes > 1
        disp("rejectNotchFilter done in " + toc(tStart) + " seconds!");
    end
end
