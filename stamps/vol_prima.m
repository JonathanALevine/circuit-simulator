function vol(n1,n2,val)
% Adds the stamp of an independent voltage source with a value
% of "val" (Volts) connected between nodes n1 and n2 to the 
% matrices in circuit representation.
%
%                   val 
%                  /  \
%      n1 O-------(+  -)--------O n2    where Vsrc= val (volts)
%                  \  /
%             Isrc ---->
%---------------------------------------------------------------

% Define global variables
global G C b;
% Get the current size of the G MNA matrix
d = size(G, 1);
% Add new row/column
xr = d+1; 
% Fill in the new row and column values
b(xr) = val;
G(xr, xr) = 0;
C(xr, xr) = 0;

if (n1 ~= 0)
    G(n1,xr) = G(n1,xr)+1;
    G(xr,n1) = G(xr,n1)+1;
end

if (n2 ~= 0)
    G(n2,xr) = G(n2,xr)-1;
    G(xr,n2) = G(xr,n2)-1;
end

end
