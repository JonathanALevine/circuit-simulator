close all;
clear;

addpath("stamps/")

% Initiliaze the G, C, b matrices
num_nodes = 10;
global G C b;
G = sparse(num_nodes, num_nodes);
C = sparse(num_nodes, num_nodes);
b = sparse(num_nodes, 1);

% populate the matrices from the MNA
output_node = 10;

vol(1, 0, 1);

res(1, 2, 9606); % res 1
res(2, 0, 23280); % res 2
res(2, 3, 6800); % res 3

cap(2, 4, 94.9*10^(-9)); % cap 1
cap(3, 0, 20.5*10^(-9)); % cap 2

res(4, 5, 9304); % res 4
cap(5, 6, 15*10^(-9)); % cap 3
res(5, 6, 52107); % res 5
res(5, 10, 9304); % res 6

res(6, 7, 9304); % res 7
cap(7, 8, 15*10^(-9)); % cap 4
res(8, 9, 20000); % res 8
res(9, 10, 20000); % res 9

vcvs(4, 0, 3, 4, 50000); % A1
vcvs(6, 0, 0, 5, 50000); % A2
vcvs(8, 0, 0, 7, 50000); % A3
vcvs(10, 0, 0, 9, 50000); %A4

save('test-circuits/circuit5.mat', 'G', 'C', 'b')