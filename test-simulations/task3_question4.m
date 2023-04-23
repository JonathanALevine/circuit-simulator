close all;
clear;

set(0,'DefaultFigureWindowStyle','docked');

% Get the MNA matrices
n1 = 8;
n2 = 32;
[G, C, b, n_out] = rlc_mesh(n1, n2);
output_node = n_out;

figure('Name', 'spy(G)')
spy(G)

% FN2 = 'figures/spy(G)';   
% print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG
% 
figure('Name', 'spy(C)')
spy(C)

% FN2 = 'figures/spy(C)';   
% print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG

% simulation params
num_points = 1000;
f_start = 0;
f_end = 1*10^9;
freqs = linspace(f_start, f_end, num_points);
Vout = zeros(num_points, 1);

% Fequency domain solution
% s = j*2pi*f
for i=1:num_points
    s = 1i * 2* pi * freqs(i);
    A = G + s*C;
    [L, U, P, Q] = lu(A, 0.01);
    z = L \ (P*b);
    y = U\z;
    sols = Q*y;
    Vout(i) = abs(sols(output_node));
end

% Reduced model for q=10
[A, R] = get_AR(G, C, b);
q = 10;
[Q, H] = arnoldi(A, R, q);

sum_inner_products(Q)

Gr = Q'*G*Q;
Cr = Q'*C*Q;
br = Q'*b;

Gr + Gr'

% Fequency domain solution
Voutr_q10 = zeros(num_points, 1);
for i=1:num_points
    s = 1i * 2* pi * freqs(i);
    Ar = Gr + s*Cr;
    sols = Ar^(-1)*br; % sols (solutions) are z
    x_app = Q*sols;
    Voutr_q10(i) = abs(x_app(output_node));
end

% Reduced model for q=10
[A, R] = get_AR(G, C, b);
q = 25;
[Q, H] = arnoldi(A, R, q);

sum_inner_products(Q)

Gr = Q'*G*Q;
Cr = Q'*C*Q;
br = Q'*b;

Gr + Gr'

% Fequency domain solution
Voutr_q25 = zeros(num_points, 1);
for i=1:num_points
    s = 1i * 2* pi * freqs(i);
    Ar = Gr + s*Cr;
    sols = Ar^(-1)*br; % sols (solutions) are z
    x_app = Q*sols;
    Voutr_q25(i) = abs(x_app(output_node));
end

% Reduced model for q=10
[A, R] = get_AR(G, C, b);
q = 40;
[Q, H] = arnoldi(A, R, q);

sum_inner_products(Q)

Gr = Q'*G*Q;
Cr = Q'*C*Q;
br = Q'*b;

Gr + Gr'

% Fequency domain solution
Voutr_q40 = zeros(num_points, 1);
for i=1:num_points
    s = 1i * 2* pi * freqs(i);
    Ar = Gr + s*Cr;
    sols = Ar^(-1)*br; % sols (solutions) are z
    x_app = Q*sols;
    Voutr_q40(i) = abs(x_app(output_node));
end

figure('Name', 'Time Domain (rlc mesh circuit)')
plot(freqs/10^9, Vout, 'b--', LineWidth=5)
hold on
plot(freqs/10^9, Voutr_q10, LineWidth=2)
plot(freqs/10^9, Voutr_q25, LineWidth=2)
plot(freqs/10^9, Voutr_q40, LineWidth=2)
hold off
grid on;
legend('Original MNA Formulation', ...
    'Reduced Circuit (q=10)', ...
    'Reduced Circuit (q=25)', ...
    'Reduced Circuit (q=40)');
xlabel('Freq. (GHz)')
ylabel('Vout (V)')

% uncomment to save the fig
% FN2 = 'figures/rlc_mesh_circuit';   
% print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG