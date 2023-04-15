addpath("stamps/");
addpath("test-circuits/");

load("circuit3.mat", 'G', 'C', 'b');

% The output node
output_node = 4;

% Simulation params
num_points = 100000;
f_start = 1000;
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

figure('Name', 'Freq. Domain (circuit3)')
semilogx(freqs, 20*log10(Vout));
grid on;
xlabel('Freq.')
ylabel('V_{out} (dB)')