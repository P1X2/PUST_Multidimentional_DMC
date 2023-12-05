%% Parametry reg. PID
k = 0.2; % +-0.25
Ti = 500; % 6
Td = 0.1; % idk 1 
Tp = 0.5; % const


r0 = k*(1+(Tp/(2*Ti))+(Td/Tp));
r1 = k*((Tp/(2*Ti))-((2*Td)/Tp)-1);
r2 = (k*Td)/Tp;


%% inicjalizacja potrzebnych macierzy

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


e1(1:steps_sym) = 0;
e2(1:steps_sym) = 0;
e3(1:steps_sym) = 0;

 

%% Pętla symulacji

version = 5;
% jak sa zjazdy na wykresach, to zmniejszyc wzmocnienie; vhyba ma tak
% dobrze dzialac, ale nie wiem na 10%
for k=12:steps_sym

    [y1(k), y2(k), y3(k)] = symulacja_obiektu1y_p4( ...
    u1(k-1), u1(k-2), u1(k-3), u1(k-4), ...
    u2(k-1), u2(k-2), u2(k-3), u2(k-4), ...
    u3(k-1), u3(k-2), u3(k-3), u3(k-4), ...
    u4(k-1), u4(k-2), u4(k-3), u4(k-4), ...
    y1(k-1), y1(k-2), y1(k-3), y1(k-4), ...
    y2(k-1), y2(k-2), y2(k-3), y2(k-4), ...
    y3(k-1), y3(k-2), y3(k-3), y3(k-4));

    e1(k) = yzad1(k) - y1(k);
    e2(k) = yzad2(k) - y2(k);
    e3(k) = yzad3(k) - y3(k);


    if version == 1     % e1 u1; e2 u2; e3 u34; 
        u1(k) = r2*e1(k-2) + r1*e1(k-1) + r0*e1(k) + u1(k-1);
        u2(k) = r2*e2(k-2) + r1*e2(k-1) + r0*e2(k) + u2(k-1);
        u3(k) = r2*e3(k-2) + r1*e3(k-1) + r0*e3(k) + u3(k-1);
        u4(k) = r2*e3(k-2) + r1*e3(k-1) + r0*e3(k) + u4(k-1);

    elseif version == 2  % % e1 u23; e2 u1; e3 u4; 
        u1(k) = r2*e2(k-2) + r1*e2(k-1) + r0*e2(k) + u1(k-1);
        u2(k) = r2*e1(k-2) + r1*e1(k-1) + r0*e1(k) + u2(k-1);
        u3(k) = r2*e1(k-2) + r1*e1(k-1) + r0*e1(k) + u3(k-1);
        u4(k) = r2*e3(k-2) + r1*e3(k-1) + r0*e3(k) + u4(k-1);

    elseif version == 3  % e1 u4; e2 u23; e3 u1; 
        u1(k) = r2*e3(k-2) + r1*e3(k-1) + r0*e3(k) + u1(k-1);
        u2(k) = r2*e2(k-2) + r1*e2(k-1) + r0*e2(k) + u2(k-1);
        u3(k) = r2*e2(k-2) + r1*e2(k-1) + r0*e2(k) + u3(k-1);
        u4(k) = r2*e1(k-2) + r1*e1(k-1) + r0*e1(k) + u4(k-1);

    elseif version == 4  % e1 u3; e2 u4; e3 u2;
        u1(k) = r2*e3(k-2) + r1*e3(k-1) + r0*e3(k) + u1(k-1);
        u2(k) = r2*e3(k-2) + r1*e3(k-1) + r0*e3(k) + u2(k-1);
        u3(k) = r2*e1(k-2) + r1*e1(k-1) + r0*e1(k) + u3(k-1);
        u4(k) = r2*e2(k-2) + r1*e2(k-1) + r0*e2(k) + u4(k-1);

    elseif version == 5  % e1 u23; e2 u4; e3 u1;
        u1(k) = r2*e3(k-2) + r1*e3(k-1) + r0*e3(k) + u1(k-1);
        u2(k) = r2*e1(k-2) + r1*e1(k-1) + r0*e1(k) + u2(k-1);
        u3(k) = r2*e1(k-2) + r1*e1(k-1) + r0*e1(k) + u3(k-1);
        u4(k) = r2*e2(k-2) + r1*e2(k-1) + r0*e2(k) + u4(k-1);


    end

end



error_sum = (sum(e1.^2) + sum(e2.^2) + sum(e3.^2));


fig=figure;

subplot(3,1,1);
hold on
stairs(y1, "DisplayName","y_1")
stairs(yzad1, "DisplayName","y1_z_a_d")
xlabel('k')
ylabel('y1')
legend('Location','northeast')
title("ERROR ="  + error_sum + newline + "y_1 error = " + sum(e1.^2));
hold off

subplot(3,1,2);
hold on
stairs(y2, "DisplayName","y_2")
stairs(yzad2, "DisplayName","y2_z_a_d")
xlabel('k')
ylabel('y2')
legend('Location','northeast')
title("y_2 error = " + sum(e2.^2));
hold off

subplot(3,1,3);
hold on
stairs(y3, "DisplayName","y_3")
stairs(yzad3, "DisplayName","y3_z_a_d")
xlabel('k')
ylabel('y3')
legend('Location','northeast')
title("y_3 error = " + sum(e3.^2));
hold off
