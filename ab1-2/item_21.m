clc;
clear;
close all;
syms s;

% Par�metros do sistema cont�nuo
numerator1 = [0.5, 2, 2];
denominator1 = [1, 3, 4, 2];

numerator2 = [2.5];
denominator2 = [1, 1, 2.5];

% Tempo de amostragem
T = 0.1;

% N�mero de passos de simula��o
num_steps = 100;

% Tempo de simula��o
t = linspace(0, num_steps*T, num_steps);

% Fun��es de transfer�ncia cont�nuas
G1 = tf(numerator1, denominator1);
G2 = tf(numerator2, denominator2);

% Respostas ao degrau para entrada cont�nua
[y_step1, ~] = step(G1, t);
[y_step2, ~] = step(G2, t);

% Entradas uniformemente distribu�das no intervalo [-1, 1]
u_uniform = 2 * rand(1, num_steps) - 1;

% Respostas �s entradas uniformes para entrada cont�nua
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
ylabel('Sa�da');
legend('Entrada Degrau', 'Entrada Uniforme');
grid on;

subplot(2, 1, 2);
plot(t, y_step2, 'k', 'LineWidth', 2);
hold on;
plot(t, y_uniform2, 'r', 'LineWidth', 2);
hold off;
title('Resposta do Sistema 2');
xlabel('Tempo (s)');
ylabel('Sa�da');
legend('Entrada Degrau', 'Entrada Uniforme');
grid on;

suptitle('Respostas dos Sistemas Cont�nuos');
