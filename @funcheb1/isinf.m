function out = isinf(f)
%ISINF  Test if a FUNCHEB1 is unbounded.
%   ISINF(F) returns true if F has any infinite values and false otherwise.
%
% See also ISFINITE, ISNAN.

% Copyright 2013 by The University of Oxford and The Chebfun Developers. 
% See http://www.chebfun.org/ for Chebfun information.

% Check if any values are infinite:
out = any(isinf(f.values(:)));

end
