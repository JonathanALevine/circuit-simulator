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

A = G + 1i*C;

figure('Name', 'Spy(A)')
spy(A)
FN2 = 'figures/spy_A';   
print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG

A = G + s*C;
[L, U, P, Q] = lu(A, 0.01);

figure('Name', 'Spy(L)')
spy(L)
FN2 = 'figures/spy_L';   
print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG

figure('Name', 'Spy(U)')
spy(U)
FN2 = 'figures/spy_U';   
print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG

figure('Name', 'Spy(LU)')
spy(L+U)
FN2 = 'figures/spy_LU';   
print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG

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
    PhaseOut(i) = rad2deg(phase(sols(output_node)));
end

% results from hspice
% Set the file path and name
file_path = 'circuit5_magnitude.csv';
% Read the file
data = readtable(file_path);
% Extract the columns
freq1 = data.freq;
Vout_mag_hspice = data.mag_vout;

% results from hspice
% Set the file path and name
file_path = 'circuit5_phase.csv';
% Read the file
data = readtable(file_path);
% Extract the columns
freq2 = data.freq;
Vout_phase_hspice = data.phase_vout;

figure('Name', 'Freq. Domain (circuit5)')
subplot(2, 1, 1)
plot(freqs, Vout, 'b--', LineWidth=3);
hold on;
plot(freq1, Vout_mag_hspice, LineWidth=2);
hold off;
grid on;
legend('MNA Solution', 'HSPICE')
xlabel('Freq. (Hz)')
ylabel('V_{out} (V)')

subplot(2, 1, 2)
plot(freqs, PhaseOut, 'b--', LineWidth=3);
hold on;
plot(freq2, Vout_phase_hspice, LineWidth=2)
hold off;
grid on;
legend('MNA Solution', 'HSPICE')
xlabel('Freq. (Hz)')
ylabel('Phase (Deg.)')

FN2 = 'figures/circuit5';   
print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG