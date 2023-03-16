close all;  
clear;

addpath("stamps/")

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

save('test-circuits/circuit1.mat', 'G', 'C', 'b')