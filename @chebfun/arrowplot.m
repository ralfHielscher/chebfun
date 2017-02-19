function varargout = arrowplot(f,varargin)
%ARROWPLOT   Chebfun plot with arrowhead at end
%   ARROWPLOT(F,G), where F and G are CHEBFUNs with the same
%   domain, plots the curve (F,G) in the plane with an arrowhead.
%
%   ARROWPLOT(F), where F is a complex CHEBFUN, plots the curve
%   (real(F),imag(F)) in the plane with an arrowhead.
%
%   Arguments can also be quasimatrices, in which case several
%   curves are plotted.
%
%   Plotting options can be passed in the usual fashion.
%
% Examples:
%
%   t = chebfun('t',[0,6]);
%   f = sin(t); g = cos(t), arrowplot(f,g);
%
%   h = exp((-.2+3i)*t); arrowplot(h,'color','r')
%
%   A = []; for k = 1:3, A = [A exp((-.1*k+1i)*t)]; end, arrowplot(A)

% Copyright 2017 by The University of Oxford and The Chebfun Developers.
% See http://www.chebfun.org/ for Chebfun information.

% Parse arguments
if ~isreal(f)
    if nargin < 2
        opts = {};
    end
else
    g = varargin{1};
    varargin(1) = [];
    f = f + 1i*g;
    if nargin < 3
        opts = {};
    end
end

% Evaluate the derivative of input CHEBFUNs to get slope information
fp = diff(f);

% Get domain information, and evaluate functions and derivatives at the correct
% point:
fdom = domain(f);
fend = feval(f, fdom(end));
fpend = feval(fp, fdom(end));

% Normalise the slopes
for aCounter=1:length(fpend)
    fpend(aCounter) = 0.001*fpend(aCounter)/norm(fpend(aCounter),2);
end

% Plot the complex valued CHEBFUNs
pp = plot(f,varargin{:});

% Loop through the pieces, and plot arrows at the end
for aCounter=1:length(fend)
    % Create a vector of arrow annotations, then set their properties below
    h(aCounter) = annotation('arrow');
    set(h(aCounter),'parent', gca, ...
        'position', [real(fend(aCounter)) imag(fend(aCounter)) ...
            real(fpend(aCounter)) imag(fpend(aCounter))], ...
        'HeadLength', 7, 'HeadWidth', 7, ...
        'Color', pp(aCounter).Color, varargin{:});
end

% Return a handle to the plot if method called with an output
if ( nargout == 1)
    varargout{1} = pp;
end

end