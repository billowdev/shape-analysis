function [v1,d1] = swap_matrix(v,d)
	a=sum(d);
	mx=max(a);
	m=size(d);
	row=m(1);
	col=m(2);

	if mx == a(1)
		for i=1:col
			d1(:,i) = d(:,col-i+1);
			v1(:,i) = v(:,col-i+1);
		end
	else
		v1=v; d1=d;
	end
end