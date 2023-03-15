function vcvs(nd1,nd2,ni1,ni2,val)
% Adds the stamp of a dependent voltage-controlled 
% voltage-source(VCVS)to the matrices in circuit 
% representation.
%
%   ni1 O-------(+)        |----------o nd1
%                          |
%                         /+\
%                      | /   \    Vnd1-Vnd2 = val*(Vni1-Vni2)
%                Ivcvs | \   /
%                      V  \-/ 
%                          |
%   ni2 O-------(-)        |----------o nd2
%
%  (1) "nd1 & nd2" are the nodes across the dependent
%                  voltage source.
%  (2) "ni1 & ni2" are the nodes corresponding to the 
%                  controller voltage
%
%   nd1: (+) node   \
%   nd2: (-) node   |----->  Vnd1-Vnd2 = val*(Vni1-Vni2)
%   ni1: (+) node   |
%   ni2: (-) node   /
%---------------------------------------------------------------

% Define global variables
global G C b;
% Get the current size of the G matrix
d = size(G, 1);
% Add new row/column
xr = d+1;
% Fill in the new row and column values
% For the b vector and the C matrix add 0
b(xr) = 0;
C(xr, xr) = 0;
G(xr, xr) = 0;
% Add the values to the G matrix
if (ni1 ~= 0)
    G(xr, ni1) = G(xr, ni1)-val;
end

if (ni2 ~= 0)
    G(xr, ni2) = G(xr, ni2)+val;
end

if (nd1 ~= 0)
    G(nd1, xr) = G(nd1, xr)+1;
    G(xr, nd1) = G(xr, nd1)+1;
end

if (nd2 ~= 0)
    G(nd2, xr) = G(nd2, xr)-1;
    G(xr, nd2) = G(xr, nd2)-1;
end  

end
