%find eigenvalue on [7.05,7.15]
x=chnkr.r(1,: );
y=chnkr.r(2,: );
f = sin(4*(x-y).^2 +x.^2)';
g = cos(3.2*(x+y).^2 +y.^2);

n=50;
k=1:n;
x_cb=7.1+0.05*cos((2*k-1)/(2*n)*pi); %Chebyshev points
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
p=0:55; 
A=cos(p'.*acos((x_cb-7.1).*20));
A=A';      
A=A(1:50,1:50);
a=A\rhs                        
sol=colleagueeigs(49,a');
sol=sol/20+7.1