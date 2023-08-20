clc;
clear;
close all;
syms s;

% Parâmetros do sistema contínuo
numerator1 = [0.5, 2, 2];
denominator1 = [1, 3, 4, 2];

numerator2 = [2.5];
denominator2 = [1, 1, 2.5];

% Tempo de amostragem
T = 0.1;

% Número de passos de simulação
num_steps = 100;

% Tempo de simulação
t = linspace(0, num_steps*T, num_steps);

% Funções de transferência contínuas
G1 = tf(numerator1, denominator1);
G2 = tf(numerator2, denominator2);

% Respostas ao degrau para entrada contínua
[y_step1, ~] = step(G1, t);
[y_step2, ~] = step(G2, t);

% Entradas uniformemente distribuídas no intervalo [-1, 1]
u_uniform = 2 * rand(1, num_steps) - 1;

% Respostas às entradas uniformes para entrada contínua
[y_uniform1, ~] = lsim(G1, u_uniform, t);
[y_uniform2, ~] = lsim(G2, u_uniform, t);

% Plot dos resultados
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

suptitle('Respostas dos Sistemas Contínuos');
