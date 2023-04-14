function val = U(t)
    [t0, t1] = deal(0, 10*10^(-6));
    [A0, A1] = deal(0, 5);
    
    if t< t0
        val = A0;
        
    elseif t < t1
        val = 5/(10*10^(-6)) * t;
        
    else
        val = 5;
        
    end
end