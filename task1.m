close all;  
clear;

set(0,'DefaultFigureWindowStyle','docked')

addpath("stamps/")
addpath("test-circuits/")

% Simulation params
num_points = 1000;
f_start = 0;
f_end = 3e6;
freqs = linspace(f_start, f_end, num_points);
Vout = zeros(num_points, 1);

load("circuit1.mat")

% Fequency domain solution
% s = j*2pi*f
for i=1:num_points
    s = 1i * 2* pi * freqs(i);
    left_side = G + s*C;
    right_side = b;
    sols = left_side \ right_side;
    Vout(i) = abs(sols(3));
end

figure('Name', 'Freq. Domain (circuit1)')
plot(freqs, Vout);
grid on;
xlabel('Freq.')
ylabel('|V at Node 3|')

% time-domain solution
freq = 1*10^6;
T = 1/freq;
t = linspace(0, 3*T, num_points);

w = 2*pi*freq;
s = 1i*w;

A = G + s*C;

x = A\b;

Vout_amp = abs(x(3));
Vout_phase = phase(x(3));

Vout = Vout_amp*sin(2*pi*freq*t - Vout_phase);

Vin = 10*sin(2*pi*freq*t);

figure('Name', 'Time Domain (circuit1)')
plot(t, Vout)
hold on
plot(t, Vin)
hold off
grid on;
xlabel('Time (s)')
ylabel('Signals')
