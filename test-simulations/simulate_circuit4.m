addpath("stamps/");
addpath("test-circuits/");

load("circuit4.mat", 'G', 'C', 'b');

% The output node
output_node = 12;
voltage_source_current_row = 17;

% Simulation params
num_points = 1000;
f_start = 1;
f_end = 20*10^6;
freqs = linspace(f_start, f_end, num_points);
Vout = zeros(num_points, 1);
input_impedence = zeros(num_points, 1);

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
    source_current = sols(voltage_source_current_row);
    input_impedence(i) = 1 / abs(source_current);
end

% results from hspice
% Set the file path and name
file_path = 'circuit4.csv';
% Read the file
data = readtable(file_path);
% Extract the columns
freq1 = data.freq;
real_part = data.real;
imag_part = data.im;
Vout_hspice = sqrt(real_part.^2 + imag_part.^2);

% results from hspice
% Set the file path and name
file_path = 'circuit4_source_current.csv';
% Read the file
data = readtable(file_path);
% Extract the columns
freq2 = data.freq;
real_part = data.real;
imag_part = data.im;
source_current_hspice = sqrt(real_part.^2 + imag_part.^2);
input_impedence_hspice = 1./source_current_hspice;

figure('Name', 'Freq. Domain (circuit4)')
loglog(freqs, 20*log10(Vout), 'b--', LineWidth=3);
ylim([-80 0]);
hold on;
loglog(freq1, 20*log10(Vout_hspice), LineWidth=2)
hold off;
grid on;
legend('MNA Solution', 'HSPICE')
xlabel('Freq. (Hz)')
ylabel('V_{out} (dB)')

FN2 = 'figures/circuit4_freq_domain';   
print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG

figure('Name', 'Input Impdence (circuit4)')
plot(freqs, input_impedence, 'b--', LineWidth=3);
hold on;
plot(freq2, input_impedence_hspice, LineWidth=2);
hold off
grid on;
legend('MNA Solution', 'HSPICE')
xlabel('Freq. (Hz)')
ylabel('Z_{input} (\Omega)')

FN2 = 'figures/circuit4_input_impedence';
print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG