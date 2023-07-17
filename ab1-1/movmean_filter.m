function filtered_output = movmean_filter(output, window_size)
    % Verifica se o tamanho da janela � v�lido
    if window_size < 1 || window_size > numel(output)
        error('O tamanho da janela � inv�lido!');
    end
    
    % Calcula a m�dia m�vel e preenche o vetor de sa�da filtrado
    filtered_output = movmean(output, window_size);
    
    % Plota os dados de entrada e sa�da filtrados
    plot(output, 'r', 'LineWidth', 0.5); % Dados de entrada (azul)
    hold on
    plot(filtered_output, 'b', 'LineWidth', 1); % Dados filtrados (vermelho)
    hold off
    
    % Configura��o do gr�fico
    grid on
    legend('Dados de entrada', 'Dados filtrados');
    xlabel('Amostras');
    ylabel('Valor');
    title('Dados com e sem filtro (M�dia M�vel)');
end
