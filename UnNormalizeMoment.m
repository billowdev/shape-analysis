function [mn] = UnNormalizeMoment(f, m, n)
	mn=0;
	for x=1:size(f,1)
		for y=1:size(f,2)
			mn = mn+((x^m)*(y^n)*f(x,y));
		end
	end
end

