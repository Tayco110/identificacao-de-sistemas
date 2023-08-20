clc;
clear;
close all;
syms s;

rng(1)

% Parâmetros do sistema discreto
n1_d = [0.0261, -0.0166, -0.0252, 0.0175];
d1_d = [1, -2.7057, 2.4484, -0.7410];

n2_d = [0.0059, 0.0118, 0.0059];
d2_d = [1, -1.8817, 0.9053];

% Tempo de amostragem
T = 0.1;

% Número de passos de simulação
num_steps = 100;

t = 0:T:(num_steps-1)*T;  % Vetor de tempos
u = sin(2 * pi * t); % Sinal de entrada(senoide)

% Plot da entrada uniforme gerada
figure;
plot(u, 'k', 'LineWidth', 1.5);
title('Sinal de entrada');
xlabel('Tempo (Passo de Simulação)');
ylabel('Valor da Entrada');
grid on;

y_1 = zeros(1, num_steps);
y_2 = zeros(1, num_steps);

% Simulação usando equação a diferença
for k = 5:num_steps
    y_1(k) = n1_d(1) * u(k-1) + n1_d(2) * u(k-2) + ...
             n1_d(3) * u(k-3) + n1_d(4) * u(k-4) ...
             - d1_d(2) * y_1(k-1) - d1_d(3) * y_1(k-2) - d1_d(4) * y_1(k-3);
                
    y_2(k) = n2_d(1) * u(k-1) + n2_d(2) * u(k-2) + ...
             n2_d(3) * u(k-3) - d2_d(2) * y_2(k-1) - d2_d(3) * y_2(k-2);
end

y = y_2;

num_repetitions = 100;
num_data = length(y);% Tamanho do vetor
std_deviation = 0.05;% Desvio padrão
mean_value = 0; %Média

for rep = 1:num_repetitions
    y_gaussian_dinamic = std_deviation * randn(1, num_data) + mean_value;
    y_gaussian_static  = std_deviation * randn(1, 1) + mean_value;
end    

% Ordem máxima do modelo
max_order = 5;
noise = y_gaussian_dinamic;
out = y + noise;
num_samples = length(out);

for order = 1:max_order
    disp(['Ordem do Modelo: ' num2str(order)]);
    % Matriz de regressores
    X = zeros(num_data - max_order, order);

    for k = 1:order
        X(:, k) = out(k:num_data - max_order + k - 1);
    end

    % Dados de saída correspondentes
    y_output = out(max_order + 1:end);

    % Calcular coeficientes usando EMQ
    theta = X' * X\ X' * y_output';
    %disp(['Coeficientes Estimados: ' num2str(theta')]);

    % Valores estimados do modelo
    y_estimated = X * theta;
    
    % Cálculo do somatório do erro quadrático
    se = sum((y_output' - y_estimated).^2);
    disp(['Somatório do Erro Quadrático: ' num2str(se)]);
    
    % Cálculo do coeficiente de correlação múltipla
    y_mean = mean(y_output);
    ss_total = sum((y_output' - y_mean).^2);
    ss_residual = sum((y_output' - y_estimated).^2);
    r_squared = 1 - ss_residual / ss_total;
    disp(['Coeficiente de Correlação Múltipla: ' num2str(r_squared)]);
    
    % Cálculo razão sinal-ruido
    signal_power = sum(y_estimated.^2);
    noise_power  = sum(noise.^2);
    snr_value = signal_power / noise_power;
    snr_value = 10 * log10(snr_value);
    disp(['Razão Sinal-Ruído (SNR): ' num2str(snr_value)]);
    
    t = T * (max_order:num_data - 1);
    figure;
    scatter(t, y_output, 40, 'k');
    hold on;
    plot(t, y_estimated, 'r', 'LineWidth', 1.5);
    hold off;
    title(['Modelagem por EMQ - Ordem do Modelo: ' num2str(order)]);
    ylabel('Saída');
    xlabel('Tempo (s)');
    legend('Saída Real', 'Modelo Estimado', 'Location', 'Best');
    grid on;
end

