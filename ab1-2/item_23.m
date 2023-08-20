clc;
clear;
close all;
syms s;

rng(1)

% Par�metros do sistema discreto
numerator1_d = [0.0261, -0.0166, -0.0252, 0.0175];
denominator1_d = [1, -2.7057, 2.4484, -0.7410];

numerator2_d = [0.0059, 0.0118, 0.0059];
denominator2_d = [1, -1.8817, 0.9053];

% Tempo de amostragem
T = 0.1;

% N�mero de passos de simula��o
num_steps = 100;

% Gerar valores uniformemente distribu�dos no intervalo [0, 1]
u_uniform = rand(1, num_steps);
% Ajustar os valores para o intervalo [-1, 1] com m�dia zero
u_uniform = 2 * u_uniform - 1;

% Plot da entrada uniforme gerada
figure;
stem(u_uniform, 'k', 'Marker', 'o', 'MarkerEdgeColor', 'r', 'MarkerSize', 5);
title('Entrada Caracterizada por Distribui��o Uniforme');
xlabel('Tempo (Passo de Simula��o)');
ylabel('Valor da Entrada');
grid on;

y_uniform1 = zeros(1, num_steps);
y_uniform2 = zeros(1, num_steps);

% Simula��o usando equa��o a diferen�a
for k = 5:num_steps
    y_uniform1(k) = numerator1_d(1) * u_uniform(k-1) + numerator1_d(2) * u_uniform(k-2) + ...
                    numerator1_d(3) * u_uniform(k-3) + numerator1_d(4) * u_uniform(k-4) ...
                    - denominator1_d(2) * y_uniform1(k-1) - denominator1_d(3) * y_uniform1(k-2) - denominator1_d(4) * y_uniform1(k-3);
                
    y_uniform2(k) = numerator2_d(1) * u_uniform(k-1) + numerator2_d(2) * u_uniform(k-2) + ...
                    numerator2_d(3) * u_uniform(k-3) - denominator2_d(2) * y_uniform2(k-1) - denominator2_d(3) * y_uniform2(k-2);
end

% Vetor de sa�da simulada com entrada uniforme
y_uniform = y_uniform1; % Use y_uniform1 or y_uniform2 as needed

% Ordem m�xima do modelo
max_order = 5;

% N�mero de dados
num_data = length(y_uniform);

for order = 1:max_order
    % Matriz de regressores
    X = zeros(num_data - max_order, order);

    for k = 1:order
        X(:, k) = y_uniform(k:num_data - max_order + k - 1);
    end

    % Dados de sa�da correspondentes
    y_output = y_uniform(max_order + 1:end);

    % Calcular coeficientes usando EMQ
    theta = X' * X\ X' * y_output';

    % Valores estimados do modelo
    y_estimated = X * theta;
    
    % Equa��o a diferen�a
    diff_eq = 'y(k) = ';
    for i = 1:order
        if i == 1
            diff_eq = [diff_eq num2str(theta(i)) ' * u(k-' num2str(i-1) ')'];
        else
            diff_eq = [diff_eq ' + ' num2str(theta(i)) ' * u(k-' num2str(i-1) ')'];
        end
    end
    
    % C�lculo dos res�duos
    residuals = y_output' - y_estimated;
  
    % C�lculo do valor m�dio dos res�duos
    mean_residual = mean(residuals);

    % Display coefficients and difference equation
    disp(['Ordem do Modelo: ' num2str(order)]);
    disp(['Coeficientes Estimados: ' num2str(theta')]);
    disp(['Equa��o a Diferen�a: ' diff_eq]);
    disp(['Valor M�dio dos Res�duos: ' num2str(mean_residual)]);
    
    % Plot dos resultados
    t = T * (max_order:num_data - 1);

    figure;
    scatter(t, y_output, 40, 'k');
    hold on;
    plot(t, y_estimated, 'r', 'LineWidth', 1.5);
    hold off;
    title(['Modelagem por EMQ - Ordem do Modelo: ' num2str(order)]);
    ylabel('Sa�da');
    xlabel('Tempo (s)');
    legend('Sa�da Real (Pontos)', 'Modelo Estimado', 'Location', 'Best');
    grid on;
    
    figure;
    subplot(2, 1, 1);
    stem(t, residuals, 'k', 'Marker', 'o', 'MarkerEdgeColor', 'r', 'MarkerSize', 5);
    title(['Res�duos - Ordem do Modelo: ' num2str(order)]);
    ylabel('Res�duos');
    xlabel('Tempo (s)');
    grid on;

    subplot(2, 1, 2);
    plot(t, mean_residual * ones(size(t)), 'r--', 'LineWidth', 1.5);
    title(['Valor M�dio dos Res�duos - Ordem do Modelo: ' num2str(order)]);
    ylabel('Valor M�dio dos Res�duos');
    xlabel('Tempo (s)');
    grid on;
end