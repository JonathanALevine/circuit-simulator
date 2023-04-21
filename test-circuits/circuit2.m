close all;
clear;

addpath("stamps/")

% Initiliaze the G, C, b matrices
num_nodes = 4;
global G C b;
G = sparse(num_nodes, num_nodes);
C = sparse(num_nodes, num_nodes);
b = sparse(num_nodes, 1);

% populate the matrices from the MNA
output_node = 4;
cap(1, 0, 0.319*10^(-6));
res(1, 0, 5);
ind(1, 0, 0.799*10^(-9));
res(1, 2, 5);
cap(2, 3, 63.72*10^(-12));
cap(3, 0, 0.319*10^(-6));
res(3, 0, 5);
res(4, 5, 5);
res(4, 0, 1000);
cur(1, 0, 1);

save('test-circuits/circuit2.mat', 'G', 'C', 'b')