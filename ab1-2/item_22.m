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

% Inicializar vetores de entrada e saída
u_step = ones(1, num_steps);

% Gerar valores uniformemente distribuídos no intervalo [0, 1]
u_uniform = rand(1, num_steps);
% Ajustar os valores para o intervalo [-1, 1] com média zero
u_uniform = 2 * u_uniform - 1;

y_step1 = zeros(1, num_steps);
y_step2 = zeros(1, num_steps);

y_uniform1 = zeros(1, num_steps);
y_uniform2 = zeros(1, num_steps);

% Simulação usando equação a diferença
for k = 5:num_steps
    y_step1(k) = n1_d(1) * u_step(k-1) + n1_d(2) * u_step(k-2) + ...
                 n1_d(3) * u_step(k-3) + n1_d(4) * u_step(k-4) ...
                 - d1_d(2) * y_step1(k-1) - d1_d(3) * y_step1(k-2) - d1_d(4) * y_step1(k-3);
             
    y_step2(k) = n2_d(1) * u_step(k-1) + n2_d(2) * u_step(k-2) + ...
                 n2_d(3) * u_step(k-3) - d2_d(2) * y_step2(k-1) - d2_d(3) * y_step2(k-2);
             
    y_uniform1(k) = n1_d(1) * u_uniform(k-1) + n1_d(2) * u_uniform(k-2) + ...
                    n1_d(3) * u_uniform(k-3) + n1_d(4) * u_uniform(k-4) ...
                    - d1_d(2) * y_uniform1(k-1) - d1_d(3) * y_uniform1(k-2) - d1_d(4) * y_uniform1(k-3);
                
    y_uniform2(k) = n2_d(1) * u_uniform(k-1) + n2_d(2) * u_uniform(k-2) + ...
                    n2_d(3) * u_uniform(k-3) - d2_d(2) * y_uniform2(k-1) - d2_d(3) * y_uniform2(k-2);
end

% Plot dos resultados
t = T:T:num_steps*T;

figure;

subplot(2, 1, 1);
plot(t, y_step1, 'k', 'LineWidth', 2);
hold on;
plot(t, y_uniform1, 'r', 'LineWidth', 2);
hold off;
title('Resposta do Sistema 1');
xlabel('Tempo (s)');
ylabel('Saída');
legend('Entrada Degrau', 'Entrada Uniforme');
grid on;

subplot(2, 1, 2);
plot(t, y_step2, 'k', 'LineWidth', 2);
hold on;
plot(t, y_uniform2, 'r', 'LineWidth', 2);
hold off;
title('Resposta do Sistema 2');
xlabel('Tempo (s)');
ylabel('Saída');
legend('Entrada Degrau', 'Entrada Uniforme');
grid on;

suptitle('Respostas dos Sistemas Discretos');