function [K, theta, tau] = fo_Sundaresan_Krishnaswamy(time, output)
    y0 = abs(output(1));
    y_final = abs(output(end));

    % 35.5% e 85.3% dos valores finais
    y1 = y0 + 0.353 * y_final;
    y2 = y0 + 0.853 * y_final;

    % Encontrar os índices correspondentes a y1 e y2
    index_y1 = find(abs(output) >= y1, 1);
    index_y2 = find(abs(output) >= y2, 1);

    % Obter os valores correspondentes de y1 e y2 no vetor time
    t1 = time(index_y1);
    t2 = time(index_y2);

    % Parâmetros para o sistema de primeira ordem
    K = y_final / 1;
    tau = 0.67 * (t2 - t1);
    theta = (1.3 * t1) - (0.29 * t2);
    
    K = round(K, 2);
    tau = round(tau, 2);
    theta = round(theta, 2);
end
