addpath("stamps/");
addpath("test-circuits/");

load("circuit2.mat", 'G', 'C', 'b');

% The output node
output_node = 4;

% Simulation params
num_points = 1000;
f_start = 0;
f_end = 20*10^6;
freqs = linspace(f_start, f_end, num_points);
Vout = zeros(num_points, 1);
phaseOut = zeros(num_points, 1);

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
    phaseOut(i) = phase(sols(output_node));
end

figure('Name', 'Freq. Domain (circuit2)')
plot(freqs, Vout);
grid on;
xlabel('Freq.')
ylabel('|V at Node 4|')

% figure('Name', 'Phase. (circuit2)')
% plot(freqs, phaseOut)
% grid on;
% xlabel('Freq.')
% ylabel('Phase')