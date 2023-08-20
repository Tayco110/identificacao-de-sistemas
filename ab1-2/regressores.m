clc;
clear;
close all;
syms s;

%Dados do sistema
data_1 = load('dados_1.txt');
data_2 = load('dados_2.txt');
data_3 = load('dados_3.txt');
data_4 = load('dados_4.txt');
data_5 = load('dados_5.txt');
data_6 = load('dados_6.txt');

max_order = 5;
data = data_3;
tamanho_janela = 5;

for na = 1:max_order
    sys_1 = arx(data, [na, 1, 0]);
    [ymod] = compare(data, sys_1);
    num_segmentos = floor(length(ymod) / tamanho_janela);
    var_estimada = zeros(1, num_segmentos);
    
    for i = 1:num_segmentos
        inicio = (i - 1) * tamanho_janela + 1;
        fim = i * tamanho_janela;
    
        segmento = ymod(inicio:fim);
        var_estimada(i) = var(segmento);
    end
    
    figure;
    subplot(2, 1, 1);
    plot(1:num_segmentos, var_estimada, 'k.-');
    xlabel('Segmento de Dados');
    ylabel('Estimativa de Variância');
    title(['Estimativa de Variância ARX de Ordem ' num2str(na)]);
    grid on;
    
    subplot(2, 1, 2);
    scatter(data(:, 1), ymod, 'k.');
    xlabel('Tempo');
    ylabel('Valor do regressor')
    title(['Regressores ARX de Ordem ' num2str(na)]);
    grid on;
end

for na = 1:max_order
    sys_2 = armax(data,[na 1 1 0]);
    [ymod] = compare(data, sys_2);
    
    num_segmentos = floor(length(ymod) / tamanho_janela);
    var_estimada = zeros(1, num_segmentos);
    
    for i = 1:num_segmentos
        inicio = (i - 1) * tamanho_janela + 1;
        fim = i * tamanho_janela;
    
        segmento = ymod(inicio:fim);
        var_estimada(i) = var(segmento);
    end
    
    figure;
    subplot(2, 1, 1);
    plot(1:num_segmentos, var_estimada, 'k.-');
    xlabel('Segmento de Dados');
    ylabel('Estimativa de Variância');
    title(['Estimativa de Variância ARMAX de Ordem ' num2str(na)]);
    grid on;
    
    subplot(2, 1, 2);
    scatter(data(:, 1), ymod, 'k.');
    xlabel('Tempo');
    ylabel('Valor do regressor');
    title(['Regressores ARMAX de Ordem ' num2str(na)]);
    grid on;
end
