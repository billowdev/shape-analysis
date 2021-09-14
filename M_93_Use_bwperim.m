% 3.คํานวณเส้นรอบรูป P, และพื้นที่ A, ของภาพไบนารีโดยใช้ Bit Quadโดยที่
% 	𝐴_0=1/4 𝑛{𝑄_1 }+1/2 𝑛{𝑄_2 }+7/8 𝑛{𝑄_3 }+𝑛{𝑄_4 }+3/4 𝑛{𝑄_𝐷 }
% 	𝑃_0=𝑛{𝑄_2 }+  1/√2 𝑛{𝑄_1 }+𝑛{𝑄_3 }+2𝑛{𝑄_𝐷 } 
% และโดยที่ 𝑄_(1 ,)  𝑄_(2 ,  )  𝑄_(3 ,  )  𝑄_4  และ 𝑄_(𝐷 ) ถูกนิยามในรูปที่ 9.3

% https://www.mathworks.com/help/images/ref/bwperim.html

clc
clear
[filename pathname] = uigetfile({'*.png';'*.jpg';'*.bmp';'*.tiff';'*.gif'}, 'File Selector');
pathf = strcat(pathname, filename);
f = imread(pathf);

f = im2bw(f);
% perimeter เส้นรอบรูป P
% Find perimeter of objects in binary image
% Calculate the perimeters of objects in the image.
BW = bwperim(f, 8);

figure(1),
imshowpair(f, BW, 'montage'),
title("Binary image                    Imshowpair                    bwperim");

% ------------------------- %


% METHODS TO ESTIMATE 
% AREAS AND PERIMETERS OF BLOB-LIKE OBJECTS: 
% A COMPARISON
% source = https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.143.4018&rep=rep1&type=pdf

% Measuring boundary length
%  source = https://www.crisluengo.net/archives/310/

% ----------------------------------------- %
% A novel bit-quad-based Euler number computing algorithm

% source = https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4659806/

