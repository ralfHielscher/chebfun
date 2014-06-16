function pass = test_coefficients( pref )
% Test to check that Chebfun2 can compute its bivariate tensor Chebyshev 
% coefficients correctly.

if ( nargin < 1 ) 
    pref = chebfunpref; 
end 
tol = 100 * pref.eps; 

n = 10; 
f = chebpoly(n); 
g = chebpoly(n); 
h = chebfun2(@(x,y) f(x).*g(y)); 
X = chebpoly2(h); 

pass(1)  = (abs( X(end-n,end-n) -1) < tol );  
X(end-n,end-n) = X(end-n,end-n)-1;
pass(2) =  (norm(X) < tol ); 

% Are cheb2poly and cheb2polyval inverses?  
f=chebfun2( @(x,y) cos(x+y) ); 
lenc = length(f.cols); 
lenr = length(f.rows);
[xx, yy] = chebfun2.chebpts2(lenc,lenr); 
vals = f(xx, yy); 
X = chebfun2.coeffs2vals( chebpoly2( f ) ); 
pass(3) = ( (norm(X-vals)) < tol );

end