function [G, C, b] = get_circuit7(n1, n2, Ut)
    % This code generates an MNA matrix for a 2D mesh, constituted
    % of resistors % between n1 x n2 nodes with each node
    % connected to the ground by a capacitor.
    % The near end is connected to a source with a 50−ohm resistor
    % and the far end will be open.
    %−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−−
    % n1 = 8; %Width
    % n2 = 50; %Length
    n = n1*(n2-1) + 2;
    global G C b;
    G = sparse(n,n);
    C = sparse(n,n);
    b = sparse(n,1);

    r = 30;
    c = 6.3499e-14;
    for bb = 1:n2
        for aa = 1:n1
            if bb == 1
                node = 2;
                node_r = 2+(bb-1)*n1+aa;
            else
                node = 2+(bb-2)*n1+aa;
                node_r = node + n1;
            end
            node_d = node + 1;
            % Resistor connecting to the node to the right of ... current node
            if bb < n2
                res(node, node_r, r);
            end
            % Resistor connecting to the node below the current ... node
            if bb > 1 && aa < n1
                res(node, node_d, r);
            end
            % Capacitor to ground
            cap(node, 0, c);
        end
    end
    % Source with source resistor are connected to the near end
    vol(1, 0, Ut);
    res(1, 2, 50);
    %End
end