function [G, C, b] = getcircuit6(Ut)
    % this gets the MNA matrices of circuit 6 given an input signal Ut    
    % Initiliaze the G, C, b matrices
    num_nodes = 7;
    global G C b;
    G = sparse(num_nodes, num_nodes);
    C = sparse(num_nodes, num_nodes);
    b = sparse(num_nodes, 1);
    % populate the matrices from the MNA
    output_node = 7;
    vol(1, 0, Ut);
    res(1, 2, 25);
    ind(2, 3, 10*10^(-9));
    cap(3, 0, 1*10^(-12));
    res(3, 4, 0.01);
    ind(4, 5, 10*10^(-9));
    cap(5, 0, 1*10^(-12));
    res(5, 6, 0.01);
    ind(6, 7, 100*10^(-9));
    cap(7, 0, 1*10^(-12));
    res(7, 0, 400);
    return;
end