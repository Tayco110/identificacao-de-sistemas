function plot_result(time, output, G)
    L = time(end)/(length(time) - 1);
    t = time(1):L:time(end);
    out_est = step(G, t);  % Resposta ao degrau de G(s) aproximada
    hold on;
    plot(time, output, 'r','LineWidth', 1);  % Dados de entrada
    plot(time, out_est, 'k','LineWidth', 1);  % Dados estimados
    grid on;
    legend('G(s) real', 'Saída para G(s) aproximada');
end
