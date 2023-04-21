load("circuit1.mat", 'G', 'C', 'b');

% The output node
output_node = 3;

% Simulation params
num_points = 1000;
f_start = 0;
f_end = 3e6;
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

% results from hspice
% Set the file path and name
file_path = 'circuit1.csv';
% Read the file
data = readtable(file_path);
% Extract the columns
freq = data.freq;
real_part = data.real;
imag_part = data.im;
Vout_hspice = sqrt(real_part.^2 + imag_part.^2);

figure('Name', 'Freq. Domain (circuit1)')
plot(freqs, Vout, 'b--', LineWidth=3);
hold on;
plot(freq, Vout_hspice, LineWidth=2)
hold off;
grid on;
legend('MNA Solution', 'HSPICE')
xlabel('Freq. (Hz)')
ylabel('|V at Node 3| (V)')

FN2 = 'figures/circuit1_freq_domain';   
print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG

% time-domain solution
freq = 1*10^6;
T = 1/freq;
t = linspace(0, 3*T, num_points);

w = 2*pi*freq;
s = 1i*w;

A = G + s*C;

x = A\b;

Vout_amp = abs(x(output_node));
Vout_phase = phase(x(output_node));

Vout = Vout_amp*sin(2*pi*freq*t - Vout_phase);

Vin = 10*cos(2*pi*freq*t);

figure('Name', 'Time Domain (circuit1)')
plot(t/10^(-6), Vout, LineWidth=2)
hold on
plot(t/10^(-6), Vin, LineWidth=2)
hold off
grid on;
legend('Vout', 'Vin')
xlabel('Time (\mu s)')
ylabel('Signal (V)')

FN2 = 'figures/circuit1_time_domain';   
print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG