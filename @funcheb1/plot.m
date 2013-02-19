function varargout = plot(f,varargin)
%PLOT   Basic inear plot for FUNCHEB1 objects. 
%   PLOT(F) plots the FUNCHEB1 object F.
%
%   PLOT(F,S) allows various line types, plot symbols, and colors to be used
%   when S is a character string made from one element from any or all the
%   following 3 columns:
%  
%            b     blue          .     point              -     solid
%            g     green         o     circle             :     dotted
%            r     red           x     x-mark             -.    dashdot 
%            c     cyan          +     plus               --    dashed   
%            m     magenta       *     star             (none)  no line
%            y     yellow        s     square
%            k     black         d     diamond
%            w     white         v     triangle (down)
%                                ^     triangle (up)
%                                <     triangle (left)
%                                >     triangle (right)
%                                p     pentagram
%                                h     hexagram
%   The entries from the centre columns are plotted at the Chebyshev grid being
%   used to represent F. If no options from this column are chosen, '.' is
%   chosen by default.
%
%   The X,Y pairs, or X,Y,S triples, can be followed by parameter/value pairs to
%   specify additional properties of the lines. For example, 
%            F = funcheb1(@sin);
%            plot(F, 'LineWidth', 2, 'Color', [.6 0 0]) 
%   will create a plot with a dark red line width of 2 points.
%
%   H1 = PLOT(F) returns a column vector of handles to lineseries objects, one
%   handle per plotted line (in the case of vector -values FUNCHEB1 objects).
%   [H1, H2] returns a second vector of column handles, this time for each of
%   the marker plots.

% Store the hold state of the current axis:
holdState = ishold;

%%
% Plot the curve (prolonging is faster than evaluating on a equispaced grid):
xx = funcheb1.chebpts(2001);
g = prolong(f, 2001);
ff = g.values;
if ( isreal(ff) )
    h1 = plot(xx, ff, varargin{:}); 
else
    h1 = plot(ff, varargin{:}); 
end
set(h1, 'Marker', 'none') 
hold on

%%

% Plot the points:
xk = funcheb1.chebpts(length(f));
fk = f.values;
if ( isreal(ff) )
    h2 = plot(xk, fk, varargin{:});
else
    h2 = plot(fk, varargin{:});
end

% Change the style accordingly:
set(h2,'LineStyle', 'none')
if ( all(strcmp(get(h2, 'Marker'),'none')) )
    set(h2,'Marker', '.')
end

%%
% Return hold state to what it was before:
if ( ~holdState )
    hold off
end

% Give an output if one was requested:
if ( nargout > 0 )
    varargout{1} = h1;
    varargout{2} = h2;
end

end

