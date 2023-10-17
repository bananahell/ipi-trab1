% Get Reject Notch Filter.
%
% Gets the Butterworth mask with the radius asked for both the places in the
% image with the frequency's position.
%
% radiusAndPosition - Array containing the radius and the X and Y coordinates of
% the frequency requested.
% nRows - Number of rows of the image.
% nCols - Number of columns of the image.
% n - Exponent used in Butterworth's equation.
%
% Returns both masks with a low-pass in the right coordinates.
%
function [filterMaskPositive, filterMaskNegative] = getRejectNotchFilter(radiusAndPosition, nRows, nCols, n)
    global showTimes;
    % Starts timer and gets basic variables
    tStart = tic;
    % Get the info of the radius and the offset position
    radius = radiusAndPosition(1);
    v = radiusAndPosition(2);
    u = radiusAndPosition(3);

    % Put the mask's position in the right offset requested in relation to
    % center
    [x, y] = meshgrid(1:nCols, 1:nRows);
    positiveDistances = sqrt((x - ((floor(nCols/2)+1) + u)).^2 + (y - ((floor(nRows/2)+1) + v)).^2);
    negativeDistances = sqrt((x - ((floor(nCols/2)+1) - u)).^2 + (y - ((floor(nRows/2)+1) - v)).^2);

    % Determine the circular mask with the radius requested using Butterworth
    filterMaskPositive = sqrt(1./(1 + (radius./positiveDistances).^(2*n)));
    filterMaskNegative = sqrt(1./(1 + (radius./negativeDistances).^(2*n)));

    % Modified in main
    if showTimes > 2
        disp("getRejectNotchFilter done in " + toc(tStart) + " seconds!");
    end
end
