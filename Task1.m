close all;  
clear;

set(0,'DefaultFigureWindowStyle','docked')

addpath("stamps/")

% Simulation params
num_points = 1000;
f_start = 0;
f_end = 3e6;
freqs = linspace(f_start, f_end, num_points);
Vout = zeros(num_points, 1);

% Initiliaze the G, C, b matrices
num_nodes = 3;
global G C b;
G = sparse(num_nodes, num_nodes);
C = sparse(num_nodes, num_nodes);
b = sparse(num_nodes, 1);

% populate the matrices from the MNA
output_node = 3;
res(1, 2, 1000);
cap(2, 0, 463e-12);
ind(2, 3, 23.1e-6);
res(3, 0, 50);
vol(1, 0, 10);

% Fequency domain solution
% s = j*2pi*f
for i=1:num_points
    s = 1i * 2* pi * freqs(i);
    left_side = G + s*C;
    right_side = b;
    sols = left_side \ right_side;
    Vout(i) = abs(sols(3));
end

figure(1)
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

figure(2)
plot(t, Vout)
hold on
plot(t, Vin)
hold off
grid on;
xlabel('Time (s)')
ylabel('Signals')
