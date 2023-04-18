function [A, R] = get_AR(G, C, b)
    [L, U, P, Q] = lu(G, 0.01);
    z = L \ P*((-1)*C);
    y = U \ z;
    A = Q*y;
    
    z = L \ P*b;
    y = U \ z;
    R = Q*y;
    return;
end

