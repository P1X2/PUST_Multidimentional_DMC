clear all;
load("strp_res_matrix.mat");

%% wyznaczanie macierzy s + horyzonty

D = 120; % horyzont dyn 
N = 20; % horyzont predykcji
Nu = 5; % horyzint sterowania
lambda = 20;


%%
% macierz M
M=cell(N,Nu);
pom1 = 0;
pom2 = 1;
for i=1:Nu
    for j=1:N
        if j - pom1 <= 0
            M{j, i}= zeros(3, 4);
        else
            M{j, i}=s{pom2};
            pom2 = pom2 + 1;
        end  
    end
    pom1 = pom1+1;
    pom2 = 1;
end


% macierz Mp
Mp=cell(N, D-1);
po1 = 1; % pomocnicza1
po2 = 1; % pomocnicza2
for j=1:D-1
    for i=1:N

        if po1+1 >= D %   po pozycji D w macierszy s przyjmujemy ze s=s(D)
            po1 = D-1;
        end

        Mp{i,j}=(s{po1+1}-s{po2});
        po1 = po1+1;
    end
    po2 = po2+1;
    po1 = j + 1;
end
% 
% 
% %%
% 
% % pętla symulacji 
% 
% steps_sym = 800; % steps_symulacji
% % Momenty skoków yzad
% k_step1 = 50; % k_step1 >= 12
% k_step2 = 200;
% k_step3 = 350;
% k_step4 = 450;
% k_step5 = 550;
% 
% % yzad
% yzad(1:k_step1-1) = 3.6; yzad(k_step1:k_step2) = 4;  % yzad z  przedziału  <3.6, 4.4> bo ograniczenia na u 
% yzad(k_step2-1:k_step3) = 3.8; yzad(k_step3:k_step4-1) = 4.2;
% yzad(k_step4:k_step5-1) = 3.7; yzad(k_step5:steps_sym) = 3.9;
% 
% % inicjalizacja 
% u(1:k_step1) = .3;
% y(1:k_step1) = 3.6;
% delta_up = zeros(D-1, 1);
% e(1:steps_sym) = 0;
% 
% 
% 
% K = (M'*M + lambda*eye(Nu))^(-1) * M';
% 
% %%
% 
% % Przyjęto: -inf < delta_u < inf
% 
% for k=14:steps_sym
%     disp(k);
%     y(k) = symulacja_obiektu1y_p1(u(k-10),u(k-11),y(k-1),y(k-2));
%     Y(1:N, 1) = y(k);        % wektor aktualnego wyjscia
% 
% %     % stała trajektoria zadana na horyzoncie predykcji
% %     Y_zad(1:N, 1) = yzad(k);
% 
%     % zmienna trajektoria zadana na horyzoncie predykcji
%     if k+N+1 > steps_sym
%         Y_zad(1:N, 1) = yzad(k);
%     else
%         Y_zad(1:N, 1) = (yzad(k+1:k+N))';
%     end
% 
% 
%     delta_u = K*(Y_zad - Y - Mp * delta_up);
% 
%     u_k = delta_u(1,1) + u(k-1);
% 
%     % ograniczenia na sygnał sterujący
%     if u_k > .7
%         u_k = .7;
%         delta_u(1,1) = .7 - u(k-1);
%     elseif u_k < .3
%         u_k = .3;
%         delta_u(1,1) = u(k-1) - .3;
% 
%     else
%         u_k = delta_u(1,1) + u(k-1);
%     end
% 
% 
%     delta_up = [delta_u(1,1); delta_up(1:D-2)];
%     u(k) = u_k;
%     e(k) = yzad(k)-y(k);
% 
% end
% 
% 
% error_sum = (sum(abs(e)))^2;
% 
% 
% %% Plots
% fig=figure;
% subplot(2,1,1);
% hold on
% stairs(y, "DisplayName","y")
% stairs(yzad, "DisplayName","y_z_a_d")
% xlabel('k')
% ylabel('y')
% legend('Location','northeast')
% title("D = "+ D + "; N = " + N + "; Nu = " + Nu + "; lambda = " + lambda + newline + 'Wyjście' + newline + "|error sum|^2 = " + error_sum);
% hold off
% 
% 
% 
% subplot(2,1,2);
% stairs(u, "DisplayName","u")
% xlabel('k')
% ylabel('u')
% legend('Location','southeast');
% title('Sterowanie');
% 
% 
% 
% 
% 
% 





