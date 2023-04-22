clear;

addpath('stamps/')
addpath('test-simulations')

res_val = 10;
res1_val = 20;
res2_val = 50;
cap_val = 10*10^(-9);
output_node = 7;

global G C b;
num_nodes = 7;
G = sparse(num_nodes, num_nodes);
C = sparse(num_nodes, num_nodes);
b = sparse(num_nodes , 1);

cur(1, 0, 1);
res(1, 0, res1_val);
cap(1, 0, cap_val);
res(1, 2, res_val);
cap(2, 0, cap_val);
res(2, 3, res_val);
cap(3, 0, cap_val);
res(3, 4, res_val);
cap(4, 0, cap_val);
res(4, 5, res_val);
cap(5, 0, cap_val);
res(5, 0, res1_val);
res(3, 6, res_val);
cap(6, 0, cap_val);
res(6, 7, res_val);
cap(7, 0, cap_val);

% Simulation params
num_points = 1000;
f_start = 10*10^3;
f_end = 10*10^6;
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

G + G'

% Get the A and R matrices
[A, R] = get_AR(G, C, b);
q = 3;
[Q, H] = arnoldi(A, R, q);

sum_inner_products(Q)

Gr = Q'*G*Q;
Cr = Q'*C*Q;
br = Q'*b;

Gr + Gr'

% Fequency domain solution
Voutr_q3 = zeros(num_points, 1);
for i=1:num_points
    s = 1i * 2* pi * freqs(i);
    Ar = Gr + s*Cr;
    sols = Ar^(-1)*br; % sols (solutions) are z
    x_app = Q*sols;
    Voutr_q3(i) = abs(x_app(output_node));
end

% Get the A and R matrices
[A, R] = get_AR(G, C, b);
q = 5;
[Q, H] = arnoldi(A, R, q);

sum_inner_products(Q)

Gr = Q'*G*Q;
Cr = Q'*C*Q;
br = Q'*b;
[Ar, Rr] = get_AR(sparse(Gr), sparse(Cr), sparse(br));


Gr + Gr'

% Fequency domain solution
Voutr_q5 = zeros(num_points, 1);
for i=1:num_points
    s = 1i * 2* pi * freqs(i);
    Ar = Gr + s*Cr;
    sols = Ar^(-1)*br; % sols (solutions) are z
    x_app = Q*sols;
    Voutr_q5(i) = abs(x_app(output_node));
end

figure('Name', 'Time Domain (circuit1)')
loglog(freqs, Vout)
hold on
loglog(freqs, Voutr_q3)
loglog(freqs, Voutr_q5)
hold off
grid on;
legend('Original MNA Formulation', 'Reduced Circuit For q=3', 'Reduced Circuit For q=5');
xlabel('Freq. (Hz)')
ylabel('Vout (V)')
