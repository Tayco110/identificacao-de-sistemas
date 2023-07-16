function filtered_output = movmean_filter(output, window_size)
    % Verifica se o tamanho da janela é válido
    if window_size < 1 || window_size > numel(output)
        error('O tamanho da janela é inválido!');
    end
    % Calcula a média móvel e preenche o vetor de saída filtrado
    filtered_output = movmean(output, window_size);
end