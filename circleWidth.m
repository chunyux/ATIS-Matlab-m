function d = circleWidth(xs,ys,xfit_result,yfit_result,Rfit_result,u,e)
    xsv=xs(:); 
    ysv=ys(:);
    A = [xsv ysv ones(size(xsv))];
    b = -(xsv.^2+ysv.^2);
    F = (A*u-b)'*(A*u-b)/(length(xsv)+1);
    
    ffw = F;
    ffn = F;
    Rw = Rfit_result;
    Rn = Rfit_result;
    
    while abs(ffn - F)<e*F
        Rn  = Rn - 1; 
        u(3) = xfit_result^2 + yfit_result^2 - Rn^2;
        ffn = (A*u-b)'*(A*u-b)/(length(xsv)+1);
    end
    
    while abs(ffw - F)<e*F
        Rw  = Rw + 1; 
        u(3) = xfit_result^2 + yfit_result^2 - Rw^2;
        ffw = (A*u-b)'*(A*u-b)/(length(xsv)+1);
    end
    d = Rw - Rn;
        