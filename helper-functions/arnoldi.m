function [Q, H] = arnoldi(A, R, q)
    n = length(A);
    Q = zeros(n, q+1);
    H = zeros(q+1, n);
    Q(:,1) = R/normest(R);
    for j=1:q
        z = A*Q(:,j);
        for i=1:j
            H(i, j) = Q(:,i)'*z;
            z = z - H(i, j) * Q(:,i);
        end
        if normest(z) == 0
            break;
        end
        H(j+1, j) = normest(z);
        Q(:,j+1) = z / H(j+1, j);
    end
end