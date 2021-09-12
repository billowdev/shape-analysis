% 2. ใช้คําสั่ง Matlab เพื่อคํานวณ Hu Moment Invariant h1-h7 ของภาพไบนารีทำการหมุนภาพ 30 องศา
%  และย่อภาพลงครึ่งหนึ่ง แล้วคํานวณ Hu Moment Invariant ของ ภาพไบนารีที่ถูกแปลงไป 
%  เปรียบเทียบ Hu Moment Invariant ที่คํานวณได้ทั้งสองครั้ง

clc
clear
[filename pathname] = uigetfile({'*.jpg';'*.png';'*.bmp';'*.tiff';'*.gif'}, 'File Selector');
pathf = strcat(pathname, filename);
f = imread(pathf);
f = im2bw(f);

% ------ Original Image
figure(1),
subplot(3,1,1), imagesc(f) , title("ภาพต้นฉบับ");

% ทําการหมุนภาพ 30 องศา 
rotateImage = imrotate(f, 30);
subplot(3,1,2), imagesc(rotateImage), title("หมุน 30 องศา");

%  --------------------------------------------------- Hu Moment Invariant h1-h7  ---------------------------- %
% https://en.wikipedia.org/wiki/Image_moment

% h1 = n20 + n02
% h2 = (n20 - n02 ) ^ 2 + 4(n11^2)
% h3 = (n30 - 3(n12)) ^ 2  + ( (3n21 - n03) ^ 2 )
% h4 = ( (n30 + n12) ^ 2 ) + (n21 + n03 ) ^2
% h5 = ( n30 - 3(n12) ) * (n30 + n12) [ ( n30 + n12 )^2 - 3(n21 + n03)^2 ] + (3(n21) - n03) * (n21 - n03) * [ 3(n30 + n 12)^2 - (n21 + n03)^2 ]
% h6 = (n20 - n02) * [(n30 + n12)^2 - (n21 + n03)^2 ] + 4(n11)*(n30+n12) * (n21 + n03)
% h7 = (3(n21) - n03) * (n30 + n12) * [ (n30 + n12)^2 - 3(n21 + n03)^2 ] - (n30 - 3(n12)) * (n21 + n03) * (n21 + n03) [ 3(n30 + n12)^2 - (n21 + n03)^2]

% calculate Hu momnet
v11 = hu_moment(rotateImage, 1, 1);
v02 = hu_moment(rotateImage, 0, 2);
v20 = hu_moment(rotateImage, 2, 0);
v12 = hu_moment(rotateImage, 1, 2);
v21 = hu_moment(rotateImage, 2, 1);
v30 = hu_moment(rotateImage, 3, 0);
v03 = hu_moment(rotateImage, 0, 3);

h1_1 = v20+v02;
h2_1 = ((v20 - v02 ) ^2 ) + ( 4*(v11^2) );
h3_1 = ( (v30 - 3*(v12)) ^ 2 ) + ( (3*v21 - v03) ^ 2 );
h4_1 = ( (v30 + v12) ^ 2 ) + ((v21 + v03 ) ^2);
h5_1 = ( v30 - 3*(v12) ) * (v30 + v12) * ( ( ( v30 + v12 )^2 ) - 3*(v21 + v03)^2 ) + (3*(v21) - v03) * (v21 - v03) * ( 3*( (v30 + v12)^2) - (v21 + v03)^2 );
h6_1 = (v20 - v02) * (( (v30 + v12)^2 ) - ( (v21 + v03)^2 ) ) + 4*(v11) * (v30 + v12) * (v21 + v03);
h7_1 = (3*(v21) - v03) * (v30 + v12) *  ( (v30 + v12)^2 - 3 *( (v21 + v03)^2) ) - (v30 - 3*(v12) ) * (v21 + v03) * (v21 + v03) * ( 3* (v30 + v12)^2 - (v21 + v03)^2 );


% fprintf("\n h1_1 Rotate = " + h1_1);
% fprintf("\n h2_1 Rotate = " + h2_1);
% fprintf("\n h3_1 Rotate = " + h3_1);
% fprintf("\n h4_1 Rotate = " + h4_1);
% fprintf("\n h5_1 Rotate = " + h5_1);
% fprintf("\n h6_1 Rotate = " + h6_1);
% fprintf("\n h7_1 Rotate = " + h7_1);

%  --------------------------------------------------- Hu Moment Invariant h1-h7  ---------------------------- %



% ย่อภาพลงครึ่งหนึ่ง
[row, column] = size(rotateImage);
rotateAndResize = imresize(rotateImage, [(row/2) (column/2)]);
subplot(3,1,3), imagesc(rotateAndResize), title("ลดขนาดลงครึ่งหนึ่ง");


%  --------------------------------------------------- Hu Moment Invariant h1-h7  ---------------------------- %

% calculate Hu momnet
v11 = hu_moment(rotateAndResize, 1, 1);
v02 = hu_moment(rotateAndResize, 0, 2);
v20 = hu_moment(rotateAndResize, 2, 0);
v12 = hu_moment(rotateAndResize, 1, 2);
v21 = hu_moment(rotateAndResize, 2, 1);
v30 = hu_moment(rotateAndResize, 3, 0);
v03 = hu_moment(rotateAndResize, 0, 3);

h1_2 = v20+v02;
h2_2 = ((v20 - v02 ) ^2 ) + ( 4*(v11^2) );
h3_2 = ( (v30 - 3*(v12)) ^ 2 ) + ( (3*v21 - v03) ^ 2 );
h4_2 = ( (v30 + v12) ^ 2 ) + ((v21 + v03 ) ^2);
h5_2 = ( v30 - 3*(v12) ) * (v30 + v12) * ( ( ( v30 + v12 )^2 ) - 3*(v21 + v03)^2 ) + (3*(v21) - v03) * (v21 - v03) * ( 3*( (v30 + v12)^2) - (v21 + v03)^2 );
h6_2 = (v20 - v02) * (( (v30 + v12)^2 ) - ( (v21 + v03)^2 ) ) + 4*(v11) * (v30 + v12) * (v21 + v03);
h7_2 = (3*(v21) - v03) * (v30 + v12) *  ( (v30 + v12)^2 - 3 *( (v21 + v03)^2) ) - (v30 - 3*(v12) ) * (v21 + v03) * (v21 + v03) * ( 3* (v30 + v12)^2 - (v21 + v03)^2 );

% fprintf("\n h1_2 After = " + h1_2);
% fprintf("\n h2_2 After = " + h2_2);
% fprintf("\n h3_2 After = " + h3_2);
% fprintf("\n h4_2 After = " + h4_2);
% fprintf("\n h5_2 After = " + h5_2);
% fprintf("\n h6_2 After = " + h6_2);
% fprintf("\n h7_2 After = " + h7_2);

%  --------------------------------------------------- Hu Moment Invariant h1-h7  ---------------------------- %



% Output ------------------
% --------------- Rotate ---------------     Imresize ----------- % 
fprintf("\n h1_1 Rotate = " + h1_1 + "\n h1_2 Resize = " + h1_2 + "\n" );
fprintf("\n h2_1 Rotate = " + h2_1 + "\n h2_2 Resize = " + h2_2 + "\n" );
fprintf("\n h3_1 Rotate = " + h3_1 + "\n h3_2 Resize = " + h3_2 + "\n" );
fprintf("\n h4_1 Rotate = " + h4_1 + "\n h4_2 Resize = " + h4_2 + "\n" );
fprintf("\n h5_1 Rotate = " + h5_1 + "\n h5_2 Resize = " + h5_2 + "\n" );
fprintf("\n h6_1 Rotate = " + h6_1 + "\n h6_2 Resize = " + h6_2 + "\n" );
fprintf("\n h7_1 Rotate = " + h7_1 + "\n h7_2 Resize = " + h7_2 + "\n" );

% fprintf("\n h1_2 After = " + h1_2);
% fprintf("\n h2_2 After = " + h2_2);
% fprintf("\n h3_2 After = " + h3_2);
% fprintf("\n h4_2 After = " + h4_2);
% fprintf("\n h5_2 After = " + h5_2);
% fprintf("\n h6_2 After = " + h6_2);
% fprintf("\n h7_2 After = " + h7_2);


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
    


