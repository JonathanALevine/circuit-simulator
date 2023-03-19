function SimulateCircuit4()
    addpath("stamps/");
    addpath("test-circuits/");
    
    load("circuit4.mat", 'G', 'C', 'b');

    % The output node
    output_node = 12;
    input_current_node = 17;

    % Simulation params
    num_points = 1000;
    f_start = 1;
    f_end = 20*10^6;
    freqs = linspace(f_start, f_end, num_points);
    Vout = zeros(num_points, 1);
    input_impedence = zeros(num_points, 1);
    
    % Fequency domain solution
    % s = j*2pi*f
    for i=1:num_points
        s = 1i * 2* pi * freqs(i);
        A = G + s*C;
        [L, U, P, Q] = lu(A, 0.01);
        z = L \ (P*b);
        y = U\z;
        sols = Q*y;
        Vout(i) = abs(sols(output_node));
        input_impedence(i) = 1 / abs(sols(input_current_node));
    end
    
    figure('Name', 'Freq. Domain (circuit4)')
    loglog(freqs, 20*log10(Vout));
    ylim([-80 0]);
    grid on;
    xlabel('Freq.')
    ylabel('V_{out} (dB)')

    figure('Name', 'Input Impdence (circuit4)')
    plot(freqs, input_impedence);
    grid on;
    xlabel('Freq.')
    ylabel('Z_{input} (\Omega)')

end