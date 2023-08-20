clc;
clear;
close all;
syms s;
% Definir as funções de transferência G(s)
numerator1 = [0.5, 2, 2];
denominator1 = [1, 3, 4, 2];

numerator2 = [2.5];
denominator2 = [1, 1, 2.5];

% Criar as funções de transferência
G1 = tf(numerator1, denominator1);
G2 = tf(numerator2, denominator2);

% Coletar e exibir a resposta dos sistemas a uma entrada degrau
figure;
subplot(2, 1, 1);
t = 0:0.01:10;
u = ones(size(t));
[y1, ~] = lsim(G1, u, t);
plot(t, y1, 'k', 'LineWidth', 2);
hold on;
plot(t, u, 'r--', 'LineWidth', 1.5);
title('Resposta ao degrau - Sistema 1');
legend('Resposta do Sistema', 'Sinal de Referência');
grid on;
hold off;

subplot(2, 1, 2);
[y2, ~] = lsim(G2, u, t);
plot(t, y2, 'k', 'LineWidth', 2);
hold on;
plot(t, u, 'r--', 'LineWidth', 1.5);
title('Resposta ao degrau - Sistema 2');
legend('Resposta do Sistema', 'Sinal de Referência');
grid on;
hold off;

% Analisar a resposta em função dos polos e zeros
poles1 = pole(G1);
zeros1 = zero(G1);
poles2 = pole(G2);
zeros2 = zero(G2);

disp('Polos do Sistema 1:');
disp(poles1);
disp('Zeros do Sistema 1:');
disp(zeros1);

disp('Polos do Sistema 2:');
disp(poles2);
disp('Zeros do Sistema 2:');
disp(zeros2);

% Obter a função de transferência discreta usando o método de Tustin
T = 0.1;
G1_d = c2d(G1, T, 'tustin');
G2_d = c2d(G2, T, 'tustin');

% Mostrar as funções de transferência discretas
disp('Função de Transferência Discreta - Sistema 1:');
disp(G1_d);
disp('Função de Transferência Discreta - Sistema 2:');
disp(G2_d);

% Simular o sistema discreto para uma entrada degrau e comparar com a resposta contínua
t_d = 0:T:10;
u_d = ones(size(t_d));

[y1_d, ~] = lsim(G1_d, u_d, t_d);
[y2_d, ~] = lsim(G2_d, u_d, t_d);

figure;
subplot(2, 1, 1);
plot(t, y1, 'k', t_d, y1_d, 'r--', 'LineWidth', 2);
hold on;
plot(t, u, 'k:', 'LineWidth', 1.5);
title('Comparação da Resposta ao degrau - Sistema 1');
legend('Resposta Contínua', 'Resposta Discreta', 'Sinal de Referência');
grid on;
hold off;

subplot(2, 1, 2);
plot(t, y2, 'k', t_d, y2_d, 'r--', 'LineWidth', 2);
hold on;
plot(t, u, 'k:', 'LineWidth', 1.5);
title('Comparação da Resposta ao degrau - Sistema 2');
legend('Resposta Contínua', 'Resposta Discreta', 'Sinal de Referência');
grid on;
hold off;
