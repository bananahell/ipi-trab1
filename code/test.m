%fileReader = matlab.io.datastore.DsFileReader("../img/madril.jpg");

%img = imread('./img/mandril.jpg');
%imshow(img);
%[rows, columns, numberOfColorBands] = size(img);
%imgSlices = [];
%for i = 1:numberOfColorBands
%    imgSlices(i) = img(:,:,i);
%end

% Filtering no dominio transformado
clear all;
close all;

f = double(imread('cameraman.tif'));
F = fftshift(fft2(f));

[u,v] = meshgrid(1:256,1:256);
z = (u-129).^2 + (v-129).^2; 

for r = 128:-9:1                 % sequencia de filtros ideais
    %H = double(z<r.^2);         %  passa-baixas
    H = double(z>r.^2);      %  passa-altas
    F1 = F;  F1(round(sqrt(z))==r)=1e6;
    figure(1);  imshow(log(abs(F1)),[]);
    G = F .* H;
    g = real(ifft2(ifftshift(G)));
    figure(2); imshow(g,[]); pause;
    mean(g(:).^2)       % nota: a energia da imagem reduzida
end;

for r = 128:-9:1;                 % sequencia de filtros gaussianos
    H = exp(-z/(2*r.^2));         %  passa-baixas
    H = 1 - H;                      %  passa-altas
    figure(1); mesh(H);
    G = F .* H;
    g = real(ifft2(ifftshift(G)));
    figure(2); imshow(g,[]); pause;
end;
