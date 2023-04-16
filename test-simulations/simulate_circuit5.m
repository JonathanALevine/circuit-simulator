addpath("stamps/");
addpath("test-circuits/");

load("circuit5.mat", 'G', 'C', 'b');

% The output node
output_node = 10;

% Simulation params
num_points = 1000;
f_start = 1;
f_end = 4*10^3;
freqs = linspace(f_start, f_end, num_points);
Vout = zeros(num_points, 1);
PhaseOut = zeros(num_points, 1);

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
    PhaseOut(i) = phase(sols(output_node));
end

figure('Name', 'Freq. Domain (circuit5)')
plot(freqs, Vout);
grid on;
xlabel('Freq.')
ylabel('V_{out} (V)')

figure('Name', 'Phase. Domain (circuit5)')
plot(freqs, PhaseOut);
grid on;
xlabel('Freq.')
ylabel('Phase (Deg.)')