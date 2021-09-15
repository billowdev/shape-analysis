% M_91_Eigen-value_Eigen-vector.m
% 1.ใช้คําสั่ง Matlab เพื่อคํานวณ Moment of Inertia Covariance Matrix ของภาพไบนารี
% หา Eigen-value และ Eigen-vector ทําการหมุนภาพ 30 องศา 
% และย่อภาพลงครึ่งหนึ่ง แล้ว คํานวณ Moment of Inertia Covariance Matrix 
% ของภาพไบนารีที่ถูกแปลงไป เปรียบเทียบ Eigen-value และ Eigen-vector ที่คํานวณได้ทั้งสองครั้ง

clc
clear
[filename pathname] = uigetfile({'*.jpg';'*.png';'*.bmp';'*.tiff';'*.gif'}, 'File Selector');
pathf = strcat(pathname, filename);
f = imread(pathf);
f = im2bw(f);

a = (f(:,:,1));

% ลบค่าเฉลี่ย
aa = im2double(a);
b = matrix2rowvector(aa);
mn = mean(b);
fdata = b - mn;

% https://www.mathworks.com/help/symbolic/eig.html

% Eigen-values ------ Original Image
eigValues1 = eig(fdata*fdata'); 
% returns a symbolic vector containing the eigenvalues of the square symbolic matrix A.

% Eigen-vector   ------ Original Image
eigVector1 = eig(vpa(fdata*fdata')); 
% returns numeric eigenvalues using variable-precision arithmetic.

% ทําการหมุนภาพ 30 องศา 
rotateImage = imrotate(a, 30);
figure(1)


% ย่อภาพลงครึ่งหนึ่ง
[row, column] = size(rotateImage);
rotateAndResize = imresize(rotateImage, [(row/2) (column/2)]);


% Moment of Inertia Covariance Matrix

doubleImg = im2double(rotateAndResize);
toRow = matrix2rowvector(doubleImg);
mn2 = mean(toRow);
fdata2 = toRow - mn2;
C = cov(toRow); % Covariance Matrix 

% Eigen-values ------ Original Image
eigValues2 = eig(fdata2*fdata2'); 
% returns a symbolic vector containing the eigenvalues of the square symbolic matrix A.

% Eigen-vector   ------ Original Image
eigVector2 = eig(vpa(fdata2*fdata2')); 
% returns numeric eigenvalues using variable-precision arithmetic.


subplot(3,1,1), imagesc(f) , title("ภาพต้นฉบับ");
subplot(3,1,2), imagesc(rotateImage), title("หมุน 30 องศา");
subplot(3,1,3), imagesc(rotateAndResize), title("ลดขนาดลงครึ่งหนึ่ง");

fprintf("ค่า Eigen-value ของภาพต้นฉบับ = " + eigValues1 )
fprintf("\nค่า Eigen-vector ของภาพต้นฉบับ =  ")
str = sym(eigVector1)
fprintf("หลังจากหมุน ค่า Covariance Matrix = " + C + "\n-----")

fprintf("\nค่า Eigen-value หลังจากหมุน = " + eigValues1)
fprintf("\nค่า Eigen-vector หลังจากหมุน")
sym(eigVector2)



