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