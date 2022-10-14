a=9.95;
b=10;
mid=(a+b)/2;
c=b-mid;

x=chnkr.r(1,: );
y=chnkr.r(2,: );

f = sin(8.*x)';
g = cos(8.*(x+y));

n=50;
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
p=0:55; 
A=cos(p'.*acos((x_cb-mid).*1/c));
A=A';      
A=A(1:50,1:50);
a=A\rhs                        
sol=colleagueeigs(49,a');
sol=sol.*c+mid

figure
scatter(real(sol),imag(sol))
figure
plot(x(1,1:200),f(1:200,1))