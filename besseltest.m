function val = besseltest(m,lambda)
% compute eqution g
% m is the order of Bessel function and lambda is the eigenvalue we want to test
    if m==0
        val=besselj(1,lambda).*bessely(1,0.5.*lambda)-bessely(1,lambda).*besselj(1,0.5.*lambda);
        val=abs(val);
    else
        lhs=0.125.*(besselj(m-1,lambda)-besselj(m+1,lambda)).*(bessely(m-1,0.5*lambda)-bessely(m+1,0.5.*lambda));
        rhs=0.125.*(besselj(m-1,0.5.*lambda)-besselj(m+1,0.5.*lambda)).*(bessely(m-1,lambda)-bessely(m+1,lambda));
        val=abs(lhs-rhs);
    end
end
