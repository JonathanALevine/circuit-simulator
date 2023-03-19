close all;
clear;

addpath("stamps/")

% Initiliaze the G, C, b matrices
num_nodes = 16;
global G C b;
G = sparse(num_nodes, num_nodes);
C = sparse(num_nodes, num_nodes);
b = sparse(num_nodes, 1);

% populate the matrices from the MNA
output_node = 12;

voltage_source = 1;
cap_val = 1*10^(-9);
res_val = 1;
ind_val = 1*10^(-6);
source_load_resistor = 50;

vol(1, 0, voltage_source); % input voltage source
res(1, 2, source_load_resistor); % source resistance
cap(2, 0, cap_val);

res(2, 3, res_val);
ind(3, 4, ind_val);
cap(4, 0, cap_val);

res(4, 5, res_val);
ind(5, 6, ind_val);
cap(6, 0, cap_val);

res(6, 7, res_val);
ind(7, 8, ind_val);
cap(8, 0, cap_val);

res(8, 9, res_val);
ind(9, 10, ind_val);
cap(10, 0, cap_val);

res(10, 0, source_load_resistor);

res(6, 11, res_val);
ind(11, 12, ind_val);
cap(12, 0, cap_val);

res(12, 0, source_load_resistor);

res(6, 13, res_val);
ind(13, 14, ind_val);
cap(14, 0, cap_val);

res(14, 15, res_val);
ind(15, 16, ind_val);
cap(16, 0, cap_val);

res(16, 0, source_load_resistor);

save('test-circuits/circuit4.mat', 'G', 'C', 'b')