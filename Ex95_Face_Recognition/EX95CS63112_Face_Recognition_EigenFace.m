% Face_Recognition_EigenFace.m
% Face Data 
% https://tinyurl.com/3yckm894

clc
clear
% Pre-Processing
a = imread('train_faceData/real_00000.jpg');
m = size(a);
row = m(1);
col = m(2);

% --------------------------------------------- Figure 1 ------------------------------------------------ %
% อ่านข้อมูลภาพใบหน้า 50 ภาพ (Read data for 50 face images.)

for ii=1:50
	if ii<11
		c00=sprintf('train_faceData/real_0000%d.jpg', ii-1);
	else
		c00=sprintf('train_faceData/real_000%d.jpg', ii-1);
	end
	a = imread(c00);
	aa=(a(:,:,1));

	f1=figure(1);
	M=10;
	N=5;

	% แสดงภาพใบหน้า 50 ภาพ (50 face images are displayed.)
	c00=sprintf('subplot(%d,%d,%d)', M,N,ii);
    set(f1, 'Position', [0 0 600 850]);
	eval(c00);
	imagesc(a);
	colormap(gray)
	axis off

	% ลบค่าเฉลี่ย (minus the mean)
	aaa=im2double(aa);
	b=matrix2rowvector(aaa);
	mn(ii) = mean(b);
	fdata(ii,:) = b - mn(ii);

end

% --------------------------------------------- Figure 2 ------------------------------------------------ %
% คำนวณไอแกนเวกเตอร์ (Calculate icon vector)

c = fdata*fdata';
[v,d] = eig(c); 
[v,d] = swap_matrix(v,d);

% คำนวณไอแกนเฟส
efdata = v'*fdata;

% แสดงไอแกนเฟส
for ii=1:50
    e=efdata(ii,:);
    f = rowvector2matrix(e,row,col);
    if ii<51
        c00=sprintf('ef%d=f;', ii-1);
        eval(c00);
    else
        c00=sprintf('ef%d=f;', ii-1);
    end
end

% -------------------------------------- %

f2=figure(2)
set(f2, 'Position', [650 0 600 850]);
M=10;
N=5;
count=0;
for i=1:M
    for j=1:N
        count=count+1;
        c00=sprintf('subplot(%d, %d, %d)', M, N, count);
        eval(c00);
        if count<51
            % c00=sprintf('imagesc(ef0%d);', count-1);
            c00=sprintf('imagesc(ef%d);', count-1);
            eval(c00);
            colormap(gray);
            axis off
        else
            c00=sprintf('imagesc(ef%d)', count-1);
            eval(c00);
            colormap(gray)
            axis off
        end
    end
end

% --------------------------------------------- Figure 3 ------------------------------------------------ %
% คำนวณสัมประสิทธิ์โดยการโปรเจคชันข้อมูลใบหน้าลงบนไอแกนเฟส (Calculate the coefficients by projecting the face data onto the igan phase.)
omeca=efdata*fdata';

% สร้างภาพคืน 

rcdata=omeca*efdata;

% แสดงภาพที่สร้างคืน
for ii=1:50
    e=rcdata(ii,:);
    f=rowvector2matrix(e,row,col)+mn(ii);
    if ii<50
        c00=sprintf('rf%d=f;', ii-1);
        eval(c00);
    else
        c00=sprintf('rf%d=f;',ii-1);
        eval(c00);
    end
end

f3 = figure(3);
set(f3, 'Position', [650 0 600 850]);
M=10;
N=5;
count=0;

for i=1:M
    for j=1:N
        count=count+1;

        c00=sprintf('subplot(%d,%d,%d)',M,N,count);
        eval(c00);
        if count<51
            c00=sprintf('imagesc(rf%d)', count-1);
            eval(c00);
            colormap(gray)
            axis off
        else
            c00=sprinf('imagesc(rf%d', count-1);
            eval(c00);
            colormap(gray)
            axis off
        end
    end
end

%  ------------------------------------------------------ %
% ระบุใบหน้าที่ไม่รู้จัก (Identify unknown faces)

[filename pathname] = uigetfile({'*.jpg';'*.png';'*.bmp';'*.tiff';'*.gif'}, 'File Selector');
pathf = strcat(pathname, filename);
a = imread(pathf);

a = a(:,:,1);
a = im2double(a);
aa = matrix2rowvector(a);
pr = efdata*aa';          

for ii=1:50
    er(ii) = sum(abs(omeca(:,ii)-pr));
end

[Y, I] = min(er);
f4 = figure(4), subplot(2,1,1)
set(f4, 'Position', [700 50 400 650]);
imagesc(a);
colormap(gray)

axis off

if I<51
    c00=sprintf('train_faceData/real_0000%d.jpg', I-1);
    
else
    c00=sprintf('train_faceData/real_0000%d.jpg', I-1); 
end

%  ------------------------------------------------------ %
% ระบุใบหน้าที่รู้จัก (Identify known faces)
try
    a = imread(c00);
    aa = a(:,:,1);
    figure(4), subplot(2,1,2)
    imagesc(a);
    colormap(gray)
    title('Person Identified');
    axis off
catch
    imagesc(a);
    colormap(gray)
    title('Person Anonumous');
    axis off
end

