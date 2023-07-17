%setup do ambiente
setup();

%Carregando o conjunto de dados
data = load('conjunto6.txt');
time = abs(data(:, 2));
output = data(:, 1);

%filtrando os dados (filtro de m�dia m�vel)
window_size = 10;
figure;
f_output = movmean_filter(output, window_size);

% Aplicar a fun��o so_Mollenkamp em time e f_output
[K_mollenkamp, theta_mollenkamp, tau1_mollenkamp, tau2_mollenkamp] = so_Mollenkamp(time, f_output);
num_mollenkamp = K_mollenkamp;
den_mollenkamp = [tau1_mollenkamp*tau2_mollenkamp, tau1_mollenkamp+tau2_mollenkamp, 1];
G_mollenkamp = tf(num_mollenkamp, den_mollenkamp, 'InputDelay', theta_mollenkamp);

% Aplicar a fun��o fo_Sundaresan_Krishnaswamy em time e f_output
[K_sundaresan, theta_sundaresan, tau_sundaresan] = fo_Sundaresan_Krishnaswamy(time, f_output);
num_sundaresan = K_sundaresan;
den_sundaresan = [tau_sundaresan, 1];
G_sundaresan = tf(num_sundaresan, den_sundaresan, 'InputDelay', theta_sundaresan);

% Aplicar a fun��o fo_Ziegler_Nichols em time e f_output
[K_ziegler, theta_ziegler, tau_ziegler] = fo_Ziegler_Nichols(time, f_output);
num_ziegler = K_ziegler;
den_ziegler = [tau_ziegler, 1];
G_ziegler = tf(num_ziegler, den_ziegler, 'InputDelay', theta_ziegler);

% Aplicar a fun��o fo_Smith em time e f_output
[K_smith, theta_smith, tau_smith] = fo_Smith(time, f_output);
num_smith = K_smith;
den_smith = [tau_smith, 1];
G_smith = tf(num_smith, den_smith, 'InputDelay', theta_smith);

% Aplicar a fun��o fo_Hagglund em time e f_output
[K_hagglund, theta_hagglund, tau_hagglund] = fo_Hagglund(time, f_output);
num_hagglund = K_hagglund;
den_hagglund = [tau_hagglund, 1];
G_hagglund = tf(num_hagglund, den_hagglund, 'InputDelay', theta_hagglund);

G_array = [G_mollenkamp, G_sundaresan, G_ziegler, G_smith, G_hagglund];
titles = {'M�todo de Mollenkamp', 'M�todo de Sundaresan Krishnaswamy', 'M�todo de Ziegler-Nichols', 'M�todo de Smith', 'M�todo de Hagglund'};

% Reta tangente ao ponto de m�xima flex�o 
figure;
plot_tangent_line(time, abs(f_output));

% ----------------- M�todo 1: Mollenkamp ----------------------
disp('------------------------------------------------------');
disp('M�todo de Mollenkamp:');
% Resposta do sistema para G(S) aproximada
figure;
title(titles{1});
plot_result(time, f_output, G_array(1));
display_transfer_function(K_mollenkamp, tau1_mollenkamp*tau2_mollenkamp, tau1_mollenkamp+tau2_mollenkamp, theta_mollenkamp, 2);

% Avalia��o da fun��o estimada
benchmark(time, f_output, G_mollenkamp);
% --------------------------------------------------------------

% ----------------- M�todo 2: Sundaresan Krishnaswamy ----------------------
disp('------------------------------------------------------');
disp('M�todo de Sundaresan Krishnaswamy:');
% Resposta do sistema para G(S) aproximada
figure;
title(titles{2});
plot_result(time, f_output, G_array(2));
display_transfer_function(K_sundaresan, tau_sundaresan, tau_sundaresan, theta_sundaresan, 1);

% Avalia��o da fun��o estimada
benchmark(time, f_output, G_sundaresan);
% --------------------------------------------------------------------------

% ----------------- M�todo 3: Ziegler-Nichols ----------------------
disp('------------------------------------------------------');
disp('M�todo de Ziegler-Nichols:');
% Resposta do sistema para G(S) aproximada
figure;
title(titles{3});
plot_result(time, f_output, G_array(3));
display_transfer_function(K_ziegler, tau_ziegler, tau_ziegler, theta_ziegler, 1);

% Avalia��o da fun��o estimada
benchmark(time, f_output, G_ziegler);
% --------------------------------------------------------------------

% ----------------- M�todo 4: Smith ----------------------
disp('------------------------------------------------------');
disp('M�todo de Smith:');
% Resposta do sistema para G(S) aproximada
figure;
title(titles{4});
plot_result(time, f_output, G_array(4));
display_transfer_function(K_smith, tau_smith, tau_smith, theta_smith, 1);

% Avalia��o da fun��o estimada
benchmark(time, f_output, G_smith);
% -------------------------------------------------------

% ----------------- M�todo 5: Hagglund ----------------------
disp('------------------------------------------------------');
disp('M�todo de Hagglund:');
% Resposta do sistema para G(S) aproximada
figure;
title(titles{5});
plot_result(time, f_output, G_array(5));
display_transfer_function(K_hagglund, tau_hagglund, tau_hagglund, theta_hagglund, 1);

% Avalia��o da fun��o estimada
benchmark(time, f_output, G_hagglund);
disp('------------------------------------------------------');
% ----------------------------------------------------------
