close all;
clear;

addpath("stamps/")

% Initiliaze the G, C, b matrices
num_nodes = 9;
global G C b;
G = sparse(num_nodes, num_nodes);
C = sparse(num_nodes, num_nodes);
b = sparse(num_nodes, 1);

% populate the matrices from the MNA
output_node = 9;

vol(1, 0, 1);


save('test-circuits/circuit5.mat', 'G', 'C', 'b')