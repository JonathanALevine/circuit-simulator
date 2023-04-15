close all;  
clear;

set(0,'DefaultFigureWindowStyle','docked');

addpath('stamps/')
addpath('test-simulations')

simulatecircuit6_with_trap_rule;

simulatecircuit6_with_back_euler;