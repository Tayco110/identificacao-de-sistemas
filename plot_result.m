function plot_result(time, output, G)
    %u = ones(size(time));  % Step input signal
    %y = lsim(G, u, time);
    hold on;
    plot(time, output, 'r');  % Dados de entrada
    step(G);  % Resposta ao degrau de G(s) aproximada
    %plot(time, y);
    grid on;
    legend('G(s) real', 'Saída para G(s) aproximada');
end
