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
vol(1, 0, 1);
res(1, 2, 50);
ind(2, 0, 0.3176*10^(-6));
cap(2, 0, 0.319*10^(-6));
ind(2, 3, 1.59*10^(-6));
cap(3, 4, 6.372*10^(-9));
ind(4, 0, 0.3176*10^(-6));
cap(4, 0, 0.319*10^(-6));
res(4, 0, 50);

save('test-circuits/circuit3.mat', 'G', 'C', 'b')