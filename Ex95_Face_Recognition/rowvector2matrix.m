function[out] = rowvector2matrix(in, row, col)
	m=size(in);
    for i=1:row
        for j=1:col
            out(i,j) = in((i-1)*col+j);
        end
    end
end