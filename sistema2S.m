%setup do ambiente
setup();

%Carregando o conjunto de dados
data = load('conjunto2.txt');
time = data(:, 2);
output = data(:, 1);

%filtrando os dados (filtro de média móvel)
window_size = 5;
f_output = movmean_filter(output, window_size);

%Estimando os parâmetros da função
[K, theta, tau] = fo_Smith(time, f_output);

%Montando G(s) estimada(Smith)
num = K;
den = [tau 1];
G = tf(-num, den, 'InputDelay', theta);

%Resultado comparativo entre o modelo real e a função estimada
plot_result(time, f_output, G);
display_transfer_function(K, tau, tau ,theta, 1);

%Avaliação da função estimada
benchmark(time, f_output, G)