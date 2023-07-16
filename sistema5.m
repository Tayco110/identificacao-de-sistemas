%setup do ambiente
setup();

%Carregando o conjunto de dados
data = load('conjunto5.txt');
time = data(:, 2);
output = data(:, 1);

%filtrando os dados (filtro de m�dia m�vel)
window_size = 5;
f_output = movmean_filter(output, window_size);

[K, theta, tau1, tau2] = so_Mollenkamp(time, f_output);


%Montando G(s) estimada(Smith)
num = K;
den = [tau1*tau2 tau1+tau2 1];
G = tf(num, den, 'InputDelay', theta);

%Resultado comparativo entre o modelo real e a fun��o estimada
plot_result(time, f_output, G);
display_transfer_function(K, tau1, tau2, theta, 2);

%Avalia��o da fun��o estimada
benchmark(time, f_output, G)