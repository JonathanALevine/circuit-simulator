close all;
clear;

set(0,'DefaultFigureWindowStyle','docked');

addpath('stamps/')
addpath('test-simulations')

% part 1
simulate_circuit6_with_trap_rule;
simulate_circuit6_with_back_euler;

% part 2
simulate_circuit7_with_back_euler;
simulate_circuit7_with_trap_rule;
