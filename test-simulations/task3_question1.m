close all;
clear;

addpath('stamps/')
addpath('test-simulations')

% Question 1
global G C b;
num_nodes = 2;
G = sparse(num_nodes, num_nodes);
C = sparse(num_nodes, num_nodes);
b = sparse(num_nodes, 1);

cur(1, 0, 1);
res(1, 0, 1);
cap(1, 0, 1);
ind(1, 2, 1);
cap(2, 0, 1);
res(2, 0, 1);

[L, U, P, Q] = lu(G, 0.01);
z = L \ P*((-1)*C);
y = U \ z;
A = Q*y;

z = L \ P*b;
y = U \ z;
R = Q*y;

q1 = R / normest(R)

h11 = q1' * A * q1;

w = A*q1 - h11*q1;
h21 = normest(w);

q2 = w / h21

q1'*q2

Q = [q1 q2]

q = 2;
[Q, H] = arnoldi(A, R, q)

