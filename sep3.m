a=1;
b=10;
alist=[a];
blist=[b];
a_output=[0];
b_output=[0];
while true
    x=alist(1);
    y=blist(1);
    alist(1)=[];
    blist(1)=[];
    if decisionfunc(chnkr,x,y)
        a_output=[a_output,x]
        b_output=[b_output,y]
    else
        z=(x+y)/2;
        alist=[alist,x,z];
        blist=[blist,z,y];
    end   
    if isempty(alist)
        break
    end
end
a_output(1)=[];
a_output=sort(a_output);
b_output(1)=[];
b_output=sort(b_output);
output=cat(1,a_output,b_output)