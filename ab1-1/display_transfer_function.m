function display_transfer_function(K, tau1,tau2,theta, order)
    if order == 1
        disp('Equação do sistema identificada:');
        disp(['G(s) = ', num2str(K),'*e^(-',num2str(theta),'s)/', num2str(tau1),'s + 1']);
    else
        disp('Equação do sistema identificada:');
        disp(['G(s) = ', num2str(K),'*e^(-',num2str(theta),'s)/(', num2str(tau2),'s + 1)(',num2str(tau1),'s + 1)']);
    end
end