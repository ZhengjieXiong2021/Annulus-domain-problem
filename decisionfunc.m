function output = decisionfunc(chnkr,a,b)
%determine the ratio between largest coefficient of Chebyshev polynomials and the 30th coefficient is
%greater than 10^8 or not.
    output = false;
    mid=(a+b)/2;
    c=b-mid;
    
    x=chnkr.r(1,: );
    y=chnkr.r(2,: );
    
    f = 0.1 +sin(5.1*x+2.1*y+21.1*(x-0.81*y)+4.1*(x-y).^2 +x.^2)';
    g = cos(0.5+2.4*x+3.1*y -16.1*(x+0.81*y)+ 3.2*(x+y).^2 +y.^2);
    
    n=30;
    k=1:n;
    x_cb=mid+c*cos((2*k-1)/(2*n)*pi); %Chebyshev points
    rhs=zeros(size(x_cb));
    for i=1:n
        zk=x_cb(i);
        fkern = @(s,t) chnk.helm2d.kern(zk,s,t,'d');
        opts = [];
        D = chunkermat(chnkr,fkern,opts);
        sys = 0.5*eye(chnkr.npt) + D;
        rhs(i)=1/(g*(sys\f));
    end
    rhs=rhs';
    p=0:n+1; 
    A=cos(p'.*acos((x_cb-mid).*1/c));
    A=A';      
    A=A(1:n,1:n);
    a=A\rhs;
    a=abs(real(a))
    max(a)/a(30,1)
    if max(a)/a(30,1) > 10^8
        output= true;
    end  
end