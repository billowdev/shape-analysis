function [mn] = UnNormalizeMomentCentralMoment(f, m, n)
    mn00=NormalizeMoment(f,0,0);
    mn10=NormalizeMoment(f,1,0);
    mn01=NormalizeMoment(f,0,1);
    xbar = mn10/mn00
    ybar = mn01/mn00
    mn=0;
    for i=1:size(f,1)
        for j=1:size(f,2)
            mn=mn+((i-xbar)^m)*((j-ybar)^n)*f(i,j);
        end
    end
end
