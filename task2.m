close all;  
clear;

set(0,'DefaultFigureWindowStyle','docked');

h = 0.1e-9; %time step
start_time = 0;
end_time = 20e-9;
number_of_points = (30e-6 -0)/(h);
t = linspace(0, 30*10^(-6), number_of_points);

for n = 1:number_of_points
    Ut(n) = U(t(n));
end

plot(t, Ut)
