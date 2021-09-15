function [vmn] = hu_moment(f,m,n)
	I = im2double(f);
	m00 = NormalizeMoment(I,0,0);
	umn = UnNormalizeMoment(I,m,n);
	m00 = (m00^(m+n+2));
	m00 = sqrt(m00);
	
	vmn=umn/m00;
	
end