function filtered_output = movmean_filter(output, window_size)
    % Verifica se o tamanho da janela � v�lido
    if window_size < 1 || window_size > numel(output)
        error('O tamanho da janela � inv�lido!');
    end
    % Calcula a m�dia m�vel e preenche o vetor de sa�da filtrado
    filtered_output = movmean(output, window_size);
end