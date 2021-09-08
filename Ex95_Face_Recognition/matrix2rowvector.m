function [out] = matrix2rowvector(in)
	m=size(in);
	row=m(1);
	col=m(2);
	for i=1:row
		out((i-1)*col+1:i*col)=in(i,:);
	end
end