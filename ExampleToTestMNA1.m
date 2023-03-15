close all; 
clc;  
clear all; %intialization

% Simulation params
num_points = 1000;
f_start = 0;
f_end = 3e6;
freqs = linspace(f_start, f_end, num_points);
Vout = zeros(num_points);

% Initiliaze the G, C, b matrices
n_nodes = 3;
global G C b;
G = GetG(n_nodes);
C = GetC(n_nodes);
b = Getb(n_nodes);

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