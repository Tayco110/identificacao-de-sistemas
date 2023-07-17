function plot_tangent_line(time, output)
    % Calcula os valores de interesse
    y0 = output(1);
    y_final = output(end);
    y_632 = y0 + 0.632 * y_final;

    slope = diff(output) ./ diff(time);
    [max_slope, max_slope_idx] = max(slope);
    yTangent = (time - time(max_slope_idx)) * max_slope + output(max_slope_idx);

    index_t1 = find(yTangent >= y0, 1);
    index_t2 = find(yTangent >= y_632, 1);
    index_t3 = find(yTangent >= y_final, 1);

    t1 = time(index_t1);
    t2 = time(index_t2);
    t3 = time(index_t3);

    % Plota o gráfico e a reta tangente
    plot(time, output, 'k', 'LineWidth', 1);
    hold on
    grid on
    plot(time, yTangent, 'r--', 'LineWidth', 1);

    % Adiciona marcadores nos pontos relevantes
    scatter(time(max_slope_idx), yTangent(max_slope_idx), 'filled', 'MarkerFaceColor', 'blue');
    scatter(t1, yTangent(index_t1), 'filled', 'MarkerFaceColor', 'blue');
    scatter(t2, yTangent(index_t2), 'filled', 'MarkerFaceColor', 'blue');
    scatter(t3, yTangent(index_t3), 'filled', 'MarkerFaceColor', 'blue');

    % Adiciona linhas tracejadas partindo dos eixos x e y até os pontos relevantes
    plot([time(max_slope_idx), time(max_slope_idx)], [0, yTangent(max_slope_idx)], 'b--');
    plot([0, time(max_slope_idx)], [yTangent(max_slope_idx), yTangent(max_slope_idx)], 'b--');
    plot([t1, t1], [0, yTangent(index_t1)], 'b--');
    plot([0, t1], [yTangent(index_t1), yTangent(index_t1)], 'b--');
    plot([t2, t2], [0, yTangent(index_t2)], 'b--');
    plot([0, t2], [yTangent(index_t2), yTangent(index_t2)], 'b--');
    plot([t3, t3], [0, yTangent(index_t3)], 'b--');
    plot([0, t3], [yTangent(index_t3), yTangent(index_t3)], 'b--');

    hold off
    
    % Ajusta os limites do eixo y
    ylim([output(1) - 0.25, max(output) + 0.25]);
    xlim([time(1), max(time)]);
    
    % Exibe o ponto de máxima inflexão
    disp(['Ponto de máxima inflexão encontrado: ', num2str(yTangent(max_slope_idx))]);
    disp(['No instante de tempo: ', num2str(time(max_slope_idx)),'s']);
end
