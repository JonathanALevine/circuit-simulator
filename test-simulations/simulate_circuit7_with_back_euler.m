clear;

addpath('helper-functions/')

n1 = 8;
n2 = 50;

h = 0.5e-9; % the time step
start_time = 0;
end_time = 20e-9;

number_of_points = get_num_points(start_time, end_time, h);

t = linspace(start_time, end_time, number_of_points);

V = zeros(395, 1);

V_node1 = zeros(1, round(number_of_points));
V_node100 = zeros(1, round(number_of_points));
Ut = zeros(1, round(number_of_points));

for n = 1:number_of_points
    Ut(n) = source(t(n));
end

for n = 1:number_of_points-1
    [G, C, b] = get_circuit7(n1, n2, source(t(n)));
    [G1, C1, b1] = get_circuit7(n1, n2, source(t(n+1)));
    % Solution for Trapezoidal Rule
    left_side = G + 1/h*C;  
    right_side = (1/h*C)*V + b1;

    [L, U, P, Q] = lu(left_side, 0.01);
    z = L \ (P*right_side);
    y = U\z;
    V = Q*y;

    V_node1(n) = V(1);
    V_node100(n) = V(100);
end

figure('Name', 'Circuit 7 (Backward Euler)')
plot(t/(10^(-9)), Ut, LineWidth=2)
hold on;
plot(t/(10^(-9)), V_node1, LineWidth=2);
plot(t/(10^(-9)), V_node100, LineWidth=2);
hold off;
legend('Input Signal', 'Node 1', 'Node 100')
grid on;
xlabel('Time (ns)')
ylabel('Signal (V)')

FN2 = 'figures/circuit7_back_euler';   
print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG

% The input signal
function val = source(t)
    f = 10^8;
    val = sin(2*pi*f*t);
end