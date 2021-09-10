% Centroid การหาจุดศูนย์ถ่วงของภาพ
% พร้อมทั้งหาแกนหลัก (Principle Axis) 
% ซึ่งคือ eigen vector 
clear
clf
f=imread('testImg.png');
f=im2double(f(:,:,1));
% calculate centroid
% (X-bar_K) = (M_U (1,0))/(M_U (0,0))
% (y-bar_j) = (M_U (0,1))/(M_U (0,0))
xbar = UnNormalizeMoment(f,1,0)/UnNormalizeMoment(f,0,0)
ybar = UnNormalizeMoment(f,0,1)/UnNormalizeMoment(f,0,0)
% Calculate Convariance Matrix
U20 = UnNormalizeMoment(f,2,0);
U02 = UnNormalizeMoment(f,0,2);
U11 = UnNormalizeMoment(f,1,1);
% Find Eigen Vector
C(1,1) = U20; C(2,2)=U02;
C(1,2) = U11; C(2,1)=U11;

[v,d] = eig(C)
feature = d(2,2)/d(1,1)

sc=60;

% Plot Centroid
figure(1), imshow(f)
hold on 
plot(ybar, xbar, 'or')
% Plot vector of Eigen Vector แกนหลัก
quiver(ybar, xbar, sc*v(1,1),sc*v(1,2))
quiver(ybar, xbar, sc*v(2,1),sc*v(2,2))

hold off
theta = acose(dot([v(1,2)],[1,0]))*180/pi

% function for Calculate Moment
function [mn] = UnNormalizeMoment(f, m, n)

mn=0;
for x=1:size(f,1)
    for y=1:size(f,2)
        mn = mn+((x^m)*(y^n)*f(x,y));
    end
end

function [mn] = UnNormalizeMoment(f, m, n)
mn = 0;
j = size(f,1);k=size(f,2);
for x=1:size(f,1)
    for y=1:size(f,2)
        mn=mn+((x^m)*(y^n)*f(x,y));
    end
end
mn=mn/(J^m*K^n);

function [mn] = UnNormalizeMoment(f, m, n)
mn00=NormalizeMoment(f,0,0);
mn10=NormalizeMoment(f,1,0);
mn01=NormalizeMoment(f,0,1);
xbar = mn10/mn00
ybar = mn01/mn00
mn=0;
for i=1:size(f,1)
    for j=1:size(f,2)
        mn=mn+((i-xbar)^m)*((j-ybar)^n)*f(i,j);
    end
end

end
end
end
