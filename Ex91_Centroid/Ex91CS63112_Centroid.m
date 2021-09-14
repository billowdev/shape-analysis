% Centroid การหาจุดศูนย์ถ่วงของภาพ
% พร้อมทั้งหาแกนหลัก (Principle Axis) 
% ซึ่งคือ eigen vector 
clear
clf
f=imread('testImg.png');
f=im2double(f(:,:,1));

% calculate centroid
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
theta = acos(dot([v(1,1), v(1,2)], [1,0]))*180/pi
