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
data = data_4;
erro_quadratico_medio = zeros(max_order, 1);

for na = 1:max_order
    sys = arx(data, [na, 1, 0]);
    y_estimado = sim(sys, data);
    
    erro_quadratico = mean((data(:,2) - y_estimado).^2);
    erro_quadratico_medio(na) = erro_quadratico;
    
    A = sys.A;
    B = sys.B;
    
    figure;
    compare(data, sys,'r');
    title(['ARX de Ordem ' num2str(na)]);
    grid on;
    legend('Resposta Real', 'Modelo Estimado');
    
    disp(['ARX de Ordem ' num2str(na)]);
    disp(['ARX A: ' num2str(A)]);
    disp(['ARX B: ' num2str(B)]);
end

% Exibir tabela de erros quadráticos médios
disp('Tabela de Erros Quadráticos Médios:');
disp('Ordem | Erro Quadrático Médio');
disp('-----------------------------');
for na = 1:max_order
    disp([num2str(na) ' | ' num2str(erro_quadratico_medio(na))]);
end