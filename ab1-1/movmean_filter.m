function filtered_output = movmean_filter(output, window_size)
    % Verifica se o tamanho da janela é válido
    if window_size < 1 || window_size > numel(output)
        error('O tamanho da janela é inválido!');
    end
    
    % Calcula a média móvel e preenche o vetor de saída filtrado
    filtered_output = movmean(output, window_size);
    
    % Plota os dados de entrada e saída filtrados
    plot(output, 'r', 'LineWidth', 0.5); % Dados de entrada (azul)
    hold on
    plot(filtered_output, 'b', 'LineWidth', 1); % Dados filtrados (vermelho)
    hold off
    
    % Configuração do gráfico
    grid on
    legend('Dados de entrada', 'Dados filtrados');
    xlabel('Amostras');
    ylabel('Valor');
    title('Dados com e sem filtro (Média Móvel)');
end
