h = 0.01e-9; %time step
start_time = 0;
end_time = 16e-9;
number_of_points = (end_time - start_time)/(h);
t = linspace(start_time, end_time, number_of_points);
V = zeros(11, 1);

vout = zeros(1, round(number_of_points));
Ut = zeros(1, round(number_of_points));

for n = 1:number_of_points
    Ut(n) = U(t(n));
end

for n = 1:number_of_points-1
    [G, C, b] = getcircuit6(U(t(n)));
    [G1, C1, b1] = getcircuit6(U(t(n+1)));
    % Solution for Trapezoidal Rule
    left_side = G + 2/h*C;  
    right_side = (2/h*C - G)*V + b + b1;
    V = left_side\right_side;
    vout(n) = V(7);
end

figure('Name', 'Circuit 6 (Trapezoidal Rule)')
plot(t/(10^(-9)), Ut)
hold on;
plot(t/(10^(-9)), vout)
hold off;
grid on;

% The input signal
function val = U(t)
    [t0, t1, t2, t3] = deal(2e-9, 3e-9, 13e-9, 14e-9);
    [A0, A1, A3] = deal(0, 5, 0);
    
    if t<t0
        val = A0;
    elseif (t0 < t) && (t < t1)
        val = 5/(3e-9 - 2e-9) * t - 10;
    elseif (t1 < t) && (t < t2)
        val = A1;
    elseif (t > t2) && (t < t3)
        val =  -5/(3e-9 - 2e-9) * t + 70;
    else
        val = A3;
    end
end