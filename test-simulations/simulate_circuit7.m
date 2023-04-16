clear;

addpath('helper-functions/')

h = 0.5e-9; % the time step
start_time = 0;
end_time = 20e-9;

number_of_points = get_num_points(start_time, end_time, h);


[G, C, b] = getcircuit7;


% The input signal
function val = U(t)
    f = 10e+8;
    val = sin(2*pi*f*t);
end