close all;
clear;

addpath('stamps/')
addpath('test-simulations')

rval = 10;
rin = 20;
rout = 50;
cval = 10*10^(-9);
output_node = 6;

global G C b;
num_nodes = 6;
G = sparse(num_nodes, num_nodes);
C = sparse(num_nodes, num_nodes);
b = sparse(num_nodes , 1);

vol_prima(1, 0, 1);
res(1, 2, rin);
cap(2, 0, cval);
res(2, 3, rval);
cap(3, 0, cval);
res(3, 4, rval);
cap(4, 0, cval);
res(4, 5, rval);
cap(5, 0, cval);
res(5, 6, rval);
cap(6, 0, cval);
res(6, 0, rout);

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
q = 2;
[Q, H] = arnoldi(A, R, q);

H = ctranspose(Q)*A*Q;
eig(H)

sum_inner_products(Q)

Gr = Q'*G*Q;
Cr = Q'*C*Q;
br = Q'*b;

Gr + Gr'

% Fequency domain solution
Voutr_q2 = zeros(num_points, 1);
for i=1:num_points
    s = 1i * 2* pi * freqs(i);
    Ar = Gr + s*Cr;
    sols = Ar^(-1)*br; % sols (solutions) are z
    x_app = Q*sols;
    Voutr_q2(i) = abs(x_app(output_node));
end

% Get the A and R matrices
[A, R] = get_AR(G, C, b);
q = 3;
[Q, H] = arnoldi(A, R, q);

H = ctranspose(Q)*A*Q;
eig(H)

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
q = 4;
[Q, H] = arnoldi(A, R, q);

H = ctranspose(Q)*A*Q;
eig(H)

sum_inner_products(Q)

Gr = Q'*G*Q;
Cr = Q'*C*Q;
br = Q'*b;

Gr + Gr'

% Fequency domain solution
Voutr_q4 = zeros(num_points, 1);
for i=1:num_points
    s = 1i * 2* pi * freqs(i);
    Ar = Gr + s*Cr;
    sols = Ar^(-1)*br; % sols (solutions) are z
    x_app = Q*sols;
    Voutr_q4(i) = abs(x_app(output_node));
end

figure('Name', 'Time Domain (circuit1)')
loglog(freqs, Vout)
hold on
loglog(freqs, Voutr_q2)
loglog(freqs, Voutr_q3)
loglog(freqs, Voutr_q4)
hold off
grid on;
legend('Original MNA Formulation', ...
    'Reduced Circuit For q=2', ...
    'Reduced Circuit For q=3', ...
    'Reduced Circuit (q=4)');
xlabel('Freq. (Hz)')
ylabel('Vout (V)')
