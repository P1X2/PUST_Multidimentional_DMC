clear all; 



%% 76
% 
% 
% to zrobione chyba, bo wszystkie poprzednie DMCki miały byc oszczędne XD nie chce mi sie tego robić, takze napiszce w sprawku, ze to samow wychodzi, i odplacie ten skrypt to sie ładnie wykres spreparuje  
%
%
%
load("strp_res_matrix.mat");

%% wyznaczanie macierzy s + horyzonty

nu = 4;
ny = 3;

D = 190; % horyzont dyn 
N = 40; % horyzont predykcji
Nu = 10; % horyzint sterowania


% "waznosc" danego wyjscia
psi1 = 1;
psi2 = 1;
psi3 = 1;

% lambda to lambda
lambda1 = 1;
lambda2 = 10;
lambda3 = 10;
lambda4 = 10;


%% MACIERZE |MIMO|; 
%% macierz M
CELL_M=cell(N,Nu);
pom1 = 0;
pom2 = 1;
for i=1:Nu
    for j=1:N
        if j - pom1 <= 0
            CELL_M{j, i}= zeros(ny, nu);
        else
            CELL_M{j, i}=s{pom2};
            pom2 = pom2 + 1;
        end  
    end
    pom1 = pom1+1;
    pom2 = 1;
end

M = [];
for i=1:Nu
    kol_matrix = [];
    for j=1:N
        kol_matrix = [kol_matrix; CELL_M{j,i}];
    end
    M = [M,kol_matrix];
end


%% macierz Mp
CELL_MP=cell(N, D-1);
po1 = 1; % pomocnicza1
po2 = 1; % pomocnicza2
for j=1:D-1
    for i=1:N

        if po1+1 >= D %   po pozycji D w macierszy s przyjmujemy ze s=s(D)
            po1 = D-1;
        end

        CELL_MP{i,j}=(s{po1+1}-s{po2});
        po1 = po1+1;
    end
    po2 = po2+1;
    po1 = j + 1;
end

Mp = [];
for j=1:D-1
    kol_matrix = [];
    for i=1:N
        kol_matrix = [kol_matrix; CELL_MP{i,j}];
    end
    Mp = [Mp,kol_matrix];
end


%% macierz PSI

CELL_PSI = cell(N, N);
PSI_cell = diag([psi1 psi2 psi3]);

for i=1:N %kol
    for j=1:N % wiersz
        if i == j
            CELL_PSI{j,i} = PSI_cell;
        else
            CELL_PSI{j,i} = zeros(ny, ny);
        end
    end
end

PSI = [];
for j=1:N
    kol_matrix = [];
    for i=1:N
        kol_matrix = [kol_matrix; CELL_PSI{i,j}];
    end
    PSI = [PSI,kol_matrix];
end




 
%% macierz LAMBDA
CELL_LAMBDA = cell(Nu, Nu);
LAMBDA_cell = diag([lambda1 lambda2 lambda3 lambda4]);

for i=1:Nu %kol
    for j=1:Nu % wiersz
        if i == j
            CELL_LAMBDA{j,i} = LAMBDA_cell;
        else
            CELL_LAMBDA{j,i} = zeros(nu, nu);
        end
    end
end

LAMBDA = [];
for j=1:Nu
    kol_matrix = [];
    for i=1:Nu
        kol_matrix = [kol_matrix; CELL_LAMBDA{i,j}];
    end
    LAMBDA = [LAMBDA,kol_matrix];
end


%% K
 K = ((M'*PSI*M + LAMBDA)^(-1)) * (M' * PSI);

%% TRAJEKTORIA ZADANA

% pętla symulacji 
steps_sym = 3000; % steps_symulacji

% Momenty skoków yzad1
k_step1 = 20; 
k_step2 = 250;
k_step3 = 700;
k_step4 = 1600;
k_step5 = 2500;
% yzad1
yzad1(1:k_step1-1) = 0; yzad1(k_step1:k_step2) = 5; 
yzad1(k_step2-1:k_step3) = 3; yzad1(k_step3:k_step4-1) = 12;
yzad1(k_step4:k_step5-1) = 8; yzad1(k_step5:steps_sym) = 15;

%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%


% Momenty skoków yzad2
k_step1 = 500; 
k_step2 = 600;
k_step3 = 900;
k_step4 = 1700;
k_step5 = 2000;
% yzad2
yzad2(1:k_step1-1) = 0; yzad2(k_step1:k_step2) = 5; 
yzad2(k_step2-1:k_step3) = 3; yzad2(k_step3:k_step4-1) = 12;
yzad2(k_step4:k_step5-1) = 8; yzad2(k_step5:steps_sym) = 15;

%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%


% Momenty skoków yzad3
k_step1 = 120;
k_step2 = 380;
k_step3 = 650;
k_step4 = 1200;
k_step5 = 2300;
% yzad3
yzad3(1:k_step1-1) = 0; yzad3(k_step1:k_step2) = 5; 
yzad3(k_step2-1:k_step3) = 3; yzad3(k_step3:k_step4-1) = 12;
yzad3(k_step4:k_step5-1) = 8; yzad3(k_step5:steps_sym) = 15;


%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%


% inicjalizacja 
u1(1:k_step1) = 0;
u2(1:k_step1) = 0;
u3(1:k_step1) = 0;
u4(1:k_step1) = 0;

y1(1:k_step1) = 0;
y2(1:k_step1) = 0;
y3(1:k_step1) = 0;

delta_up = zeros((D-1)*nu, 1);

e1(1:steps_sym) = 0;
e2(1:steps_sym) = 0;
e3(1:steps_sym) = 0;






for k=14:steps_sym

        [y1(k), y2(k), y3(k)] = symulacja_obiektu1y_p4( ...
        u1(k-1), u1(k-2), u1(k-3), u1(k-4), ...
        u2(k-1), u2(k-2), u2(k-3), u2(k-4), ...
        u3(k-1), u3(k-2), u3(k-3), u3(k-4), ...
        u4(k-1), u4(k-2), u4(k-3), u4(k-4), ...
        y1(k-1), y1(k-2), y1(k-3), y1(k-4), ...
        y2(k-1), y2(k-2), y2(k-3), y2(k-4), ...
        y3(k-1), y3(k-2), y3(k-3), y3(k-4));

    % wektor aktualnego wyjscia
    for i=1:ny:N*ny
        Y(i, 1) = y1(k); 
        Y(i+1, 1) = y2(k);  
        Y(i+2, 1) = y3(k); 
    end
 
    % stała trajektoria zadana na horyzoncie predykcji
    for i=1:ny:N*ny
        Y_zad(i, 1) = yzad1(k); 
        Y_zad(i+1, 1) = yzad2(k);  
        Y_zad(i+2, 1) = yzad3(k); 
    end
 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     % zmienna trajektoria zadana na horyzoncie predykcji
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     if k+N+1 > steps_sym
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %         Y_zad(1:N, 1) = yzad(k);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     else
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %         Y_zad(1:N, 1) = (yzad(k+1:k+N))';
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     end


    delta_u = K*(Y_zad - Y - Mp * delta_up);
    DELTA_U = delta_u(1:nu);

    u1(k) = DELTA_U(1) + u1(k-1);
    u2(k) = DELTA_U(2) + u2(k-1);
    u3(k) = DELTA_U(3) + u3(k-1);
    u4(k) = DELTA_U(4) + u4(k-1);



% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     % ograniczenia na sygnał sterujący
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     if u_k > .7
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %         u_k = .7;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %         delta_u(1,1) = .7 - u(k-1);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     elseif u_k < .3
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %         u_k = .3;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %         delta_u(1,1) = u(k-1) - .3;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     else
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %         u_k = delta_u(1,1) + u(k-1);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %     end


    delta_up = [delta_u(1:4); delta_up(1:(D-1)*nu - 4)];

    e1(k) = yzad1(k)-y1(k);
    e2(k) = yzad2(k)-y2(k);
    e3(k) = yzad3(k)-y3(k);

end


sum_error = (sum(e1.^2)) + (sum(e2.^2)) + (sum(e3.^2));


%% Plots
fig=figure;

subplot(3,1,1);
hold on
stairs(yzad1, "DisplayName","y_1_z_a_d")
stairs(y1, "DisplayName","y_1a")
stairs(y1, '--', "DisplayName","y_1c")

xlabel('k')
ylabel('y1')
legend('Location','northeast')
title("ERROR ="  + sum_error + newline + "y_1 error = " + sum(e1.^2));
hold off

subplot(3,1,2);
hold on
stairs(yzad2, "DisplayName","y_2_z_a_d")
stairs(y2, "DisplayName","y_2a")
stairs(y2, '--', "DisplayName","y_2c")

xlabel('k')
ylabel('y2')
legend('Location','northeast')
title("y_2 error = " + sum(e2.^2));
hold off

subplot(3,1,3);
hold on
stairs(yzad3, "DisplayName","y_3_z_a_d")
stairs(y3, "DisplayName","y_3a")
stairs(y3, '--', "DisplayName","y_3c")

xlabel('k')
ylabel('y3')
legend('Location','northeast')
title("y_3 error = " + sum(e3.^2));
hold off

























% subplot(2,1,2);
% stairs(u, "DisplayName","u")
% xlabel('k')
% ylabel('u')
% legend('Location','southeast');
% title('Sterowanie');
% 










