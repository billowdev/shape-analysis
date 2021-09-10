clear
% Image A, B
letterA=imread('A.png');
letterB=imread('B.png');
% Image spin
rletterA = imrotate(letterA,10,'bilinear','crop');
% Scale Image
sletterA = imresize(letterA,2);

subplot(221), imagesc(letterA); colormap(gray)
subplot(222), imagesc(rletterA); colormap(gray)
subplot(223), imagesc(sletterA); colormap(gray)
subplot(224), imagesc(letterB); colormap(gray)

% calculate Hu momnet
v02 = hu_moment(letterA, 0, 2);
v20 = hu_moment(letterA, 2, 0);
hul_letterA = v20+v02

v02 = hu_moment(rletterA, 0, 2);
v20 = hu_moment(rletterA, 2, 0);
hul_rletterA = v20+v02

v02 = hu_moment(sletterA, 0, 2);
v20 = hu_moment(sletterA, 2, 0);
hul_sletterA = v20+v02


v02 = hu_moment(letterB, 0, 2);
v20 = hu_moment(letterB, 2, 0);
hul_letterB = v20+v02

% Hu Function
function [vmn] = hu_moment(f,m,n)
I = im2double(f);
m00 = NormalizeMoment(I,0,0);
umn = UnNormalizeMoment(I,m,n);
m00 = (m00^(m+n+2));
m00 = sqrt(m00);

vmn=umn/m00;

function [mn] = UnNormalizeMoment(f, m, n)
    mn=0;
    for x=1:size(f,1)
        for y=1:size(f,2)
            mn = mn+((x^m)*(y^n)*f(x,y));
        end
    end
end

function [mn] = NormalizeMoment(f, m, n)
    mn=0;
    j=size(f,1); k=size(f,2);
    for x=1:size(f,1)
        for y=1:size(f,2)
            mn = mn+((x^m)*(y^n)*f(x,y));
        end
    end
mn=mn/(j^m*k^n);
end
end


