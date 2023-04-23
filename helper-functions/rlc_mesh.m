function [G,C,b,n_out] = rlc_mesh(n1, n2)
    %
    % Generates PRIMA compatible MNA matrices G, C and b for ...
    %the RLC mesh
    % network given in this Assignment.
    %
    % Sructure:
    % −−−−−−−−−
    % It is a 2D mesh of RL branches between nodes along n1 x ...
    %n2 traces where
    % each node is connected to ground by a capacitor.
    %
    % Input at Near−end:
    % −−−−−−−−−−−−−−−−−−
    % The near end in this network is connected to a (unit) ...
    %voltage source
    % with a 50 ohm resistance.
    %
    % Out−put node at Far−end:
    % −−−−−−−−−−−−−−−−−−−−−−−−
    % The far end (pointed to as "Vout" in the figure) is left ...
    %open,
    % where n_out is the node number for this output node.
    %
    % It Returns G, C, b matrices and n_out, the output node ...
    %number.
    %
    % Course: ELEC5508, Dept.of Electronics, Carleton Uniersity
    %−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
    pitch = 3*(n2-1);
    n = n1*pitch - n2 + 3;
    n_out = n;
    G = sparse(n,n);
    C = sparse(n,n);
    b = sparse(n,1);
    r = 1.1719e-3;
    c = 1.8499e-13;
    L = 4.5875e-8;
    g_sub = [1/r,-1/r; -1/r, 1/r];
    for bb = 1:n2
        for aa = 1:n1
            if bb == 1
                node = 2;
                node_r1 = 3+(aa-1)*pitch;
                node_r2 = node_r1 + 1;
            else
                node = 2+(aa-1)*pitch+(bb-1)*2;node_r1 = node + 1;
                node_r2 = node + 2;
                node_d1 = 1+(aa-1)*pitch+(n2-1)*2+bb;
                node_d2 = node + pitch;
            end
            % RL connecting to the node to the right of current node
            if bb < n2
                nr = size(G,1) + 1;
                G([node node_r1],[node node_r1]) = ...
                G([node node_r1],[node node_r1]) + g_sub;
                G(nr,nr) = 0;
                G([node_r1 node_r2],nr) = [1;-1];
                G(nr,[node_r1 node_r2]) = [-1,1];
                C(nr,nr) = L;
                b(nr,1) = 0;
            end
            % RL connecting to the node below the current node
            if bb > 1 && aa < n1
                nr = size(G,1) + 1;
                G([node node_d1],[node node_d1]) = ...
                G([node node_d1],[node node_d1]) + g_sub;
                G(nr,nr) = 0;
                G([node_d1 node_d2],nr) = [1;-1];
                G(nr,[node_d1 node_d2]) = [-1,1];
                C(nr,nr) = L;
                b(nr,1) = 0;
            end
            % Capacitor to ground
            C(node,node) = C(node,node) + c;
        end
    end
    % Source
    nr = size(G)+1;
    G(nr,nr) = 0;
    G(1,nr)=1;
    G(nr,1)= -1;
    C(nr,nr)= 0;
    b(nr,1)= -1; %Voltage source
    G([1 2],[1 2])=G([1 2],[1 2]) + [1/50,-1/50; -1/50,1/50];
end 

