function [mn] = NormalizeMoment(f, m, n)
    mn = 0;
    j = size(f,1);k=size(f,2);
    for x=1:size(f,1)
        for y=1:size(f,2)
            mn=mn+((x^m)*(y^n)*f(x,y));
        end
    end
    mn=mn/(J^m*K^n);
end
