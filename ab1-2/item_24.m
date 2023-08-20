clc;
clear;
close all;
syms s;

rng(1)

% Parâmetros do sistema discreto
n1 = [0.0261, -0.0166, -0.0252, 0.0175];
d1 = [1, -2.7057, 2.4484, -0.7410];

n2 = [0.0059, 0.0118, 0.0059];
d2 = [1, -1.8817, 0.9053];

% Tempo de amostragem
T = 0.1;

% Número de passos de simulação
num_steps = 100;

% Gerar valores uniformemente distribuídos no intervalo [0, 1]
u = rand(1, num_steps);
% Ajustar os valores para o intervalo [-1, 1] com média zero
u = 2 * u - 1;

y_1 = zeros(1, num_steps);
y_2 = zeros(1, num_steps);

% Simulação usando equação a diferença
for k = 5:num_steps
    y_1(k) = n1(1) * u(k-1) + n1(2) * u(k-2) + ...
                    n1(3) * u(k-3) + n1(4) * u(k-4) ...
                    - d1(2) * y_1(k-1) - d1(3) * y_1(k-2) - d1(4) * y_1(k-3);
                
    y_2(k) = n2(1) * u(k-1) + n2(2) * u(k-2) + ...
                    n2(3) * u(k-3) - d2(2) * y_2(k-1) - d2(3) * y_2(k-2);
                
end

% Vetor de saída simulada
y = y_1; % Use y_1 or y_2

max_order = 3; % Ordem fixa do modelo
num_repetitions = 100; % Número de repetições

% Número de dados
num_data = length(y);% Tamanho do vetor
std_deviation = 0.05; % Desvio padrão
mean_value = 0; % Média

m_values = zeros(1, num_repetitions); % Vetor para armazenar valores de m_value
s_deviations = zeros(1, num_repetitions); % Vetor para armazenar valores de s_deviation

for rep = 1:num_repetitions
    
    y_gaussian_dinamic = std_deviation * randn(1, num_data) + mean_value;
    y_gaussian_static  = std_deviation * randn(1, 1) + mean_value;
    
    noise = y_gaussian_static;
    
    out = y + noise;
    
    % Matriz de regressores
    X = zeros(num_data - max_order, max_order);

    for k = 1:max_order
        X(:, k) = out(k:num_data - max_order + k - 1);
    end

    % Dados de saída correspondentes
    y_output = out(max_order + 1:end);

    % Calcular coeficientes usando EMQ
    theta = X' * X\ X' * y_output';

    % Valores estimados do modelo
    y_estimated = X * theta;

    % Cálculo do valor médio dos resíduos
    % Cálculo da média
    m_value = mean(theta);

    % Cálculo do desvio padrão
    s_deviation = std(theta);

    % Armazenar valores em vetores
    m_values(rep) = m_value;
    s_deviations(rep) = s_deviation;

    % Display coefficients and difference equation
    disp(['Repetição: ' num2str(rep)]);
    disp(['Média: ' num2str(m_value,'%.2f')]);
    disp(['Desvio Padrão: ' num2str(s_deviation, '%.2f')]);
end

% Exibir gráfico dos valores de m_value e s_deviation
figure;
subplot(2, 1, 1);
plot(m_values, '-o', 'MarkerFaceColor', 'k');
title('Valores de Média');
xlabel('Repetição');
ylabel('Média');
hold on;
mean_m_values = mean(m_values);
plot([1, num_repetitions], [mean_m_values, mean_m_values], 'k--', 'LineWidth', 2);
grid on;
hold off;

subplot(2, 1, 2);
plot(s_deviations, '-o', 'MarkerFaceColor', 'k');
title('Valores de Desvio Padrão');
xlabel('Repetição');
ylabel('Desvio Padrão');
hold on;
mean_s_deviations = mean(s_deviations);
plot([1, num_repetitions], [mean_s_deviations, mean_s_deviations], 'k--', 'LineWidth', 2);
grid on;
hold off;

disp(['Média Geral: ' num2str(mean_m_values,'%.2f')]);
disp(['Desvio Padrão Geral: ' num2str(mean_s_deviations, '%.2f')]);