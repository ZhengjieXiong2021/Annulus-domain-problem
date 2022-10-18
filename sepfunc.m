function sepfunc(chnkr,a,b)
%function that separates the interval [a,b] in multiple intervals
    global alist
    global blist
    if decisionfunc(chnkr,a,b)
        x=a;
        y=b;
        alist=[alist,x];
        blist=[blist,y];
    else
        c=(a+b)/2;
        sepfunc(chnkr,a,c);
        sepfunc(chnkr,c,b);
    end
end