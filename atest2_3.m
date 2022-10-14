%Example of good monitor function  
%Solution has accuracy to the level 10^-4
a=6.55;
b=6.6;
mid=(a+b)/2;
c=b-mid;

x=chnkr.r(1,: );
y=chnkr.r(2,: );
%f = 10.*sin(50.*(x-y).^2 +5.*x.^2+50+10.*exp(x.^2+y.^2))';
%g = cos(10.*(x+y).^2 +200.*y.^2);
%f = exp(x.^2+y.^2)'+sin(50.*(x-y).^2)';
%g=  exp(x.^2-y.^3);
%f = 100.*sin(5000.*x.^2)';
%g = cos(1000.*y.^2);

f = sin(10.*x)';
g = cos(15.*y.^2);

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
p=0:35; 
A=cos(p'.*acos((x_cb-mid).*1/c));
A=A';      
A=A(1:30,1:30);
a=A\rhs                        
sol=colleagueeigs(29,a');
sol=sol.*c+mid

figure
scatter(real(sol),imag(sol))
figure
plot(x(1,1:200),f(1:200,1))