function result = sum_inner_products(Q)
    m = size(Q, 2);
    result = 0;
    for i = 1:m
        for j = i+1:m
            result = result + Q(:,i)'*Q(:,j);
        end
    end
end

