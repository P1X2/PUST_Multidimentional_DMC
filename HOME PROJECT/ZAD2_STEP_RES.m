%% ZAD2
clear all;

steps = 200;
step_responses = cell(3, 4);

s = zeros(1, steps);

for i=1:4

    if i==1
        u1(1:steps) = 1;
        u2(1:steps) = 0;
        u3(1:steps) = 0;
        u4(1:steps) = 0;
    elseif i == 2
        u1(1:steps) = 0;
        u2(1:steps) = 1;
        u3(1:steps) = 0;
        u4(1:steps) = 0;
    elseif i == 3
        u1(1:steps) = 0;
        u2(1:steps) = 0;
        u3(1:steps) = 1;
        u4(1:steps) = 0;
    else
        u1(1:steps) = 0;
        u2(1:steps) = 0;
        u3(1:steps) = 0;
        u4(1:steps) = 1;
    end
    
    y1(1:10) = 0;
    y2(1:10) = 0;
    y3(1:10) = 0;
    
    for k=10:steps
        [y1(k), y2(k), y3(k)] = symulacja_obiektu1y_p4( ...
            u1(k-1), u1(k-2), u1(k-3), u1(k-4), ...
            u2(k-1), u2(k-2), u2(k-3), u2(k-4), ...
            u3(k-1), u3(k-2), u3(k-3), u3(k-4), ...
            u4(k-1), u4(k-2), u4(k-3), u4(k-4), ...
            y1(k-1), y1(k-2), y1(k-3), y1(k-4), ...
            y2(k-1), y2(k-2), y2(k-3), y2(k-4), ...
            y3(k-1), y3(k-2), y3(k-3), y3(k-4));



    end
    
    step_responses{1, i} = y1;
    step_responses{2, i} = y2;
    step_responses{3, i} = y3;  
end

%% Zamiana na macierz s Pana Macieja


for j=1:steps

    s(j) = [ step_responses{1,1}(j) step_responses{1,2}(j) step_responses{1,3}(j) step_responses{1,4}(j);
        step_responses{2,1}(j) step_responses{2,2}(j) step_responses{2,3}(j) step_responses{2,4}(j);
        step_responses{3,1}(j) step_responses{3,2}(j) step_responses{3,3}(j) step_responses{3,4}(j)];
                
              
end



    %% FIGURES skok u1
    fig1 = figure;
    subplot(3, 1, 1)
    plot(step_responses{1,1})
    title("Skok u_1" + newline + "y_1")
    xlabel('k')
    ylabel('y_1')
    
    subplot(3, 1, 2)
    plot(step_responses{2,1})
    title("y_2")
    xlabel('k')
    ylabel('y_2')
    
    
    subplot(3, 1, 3)
    plot(step_responses{3,1})
    title("y_3")
    xlabel('k')
    ylabel('y_3')

    %% skok u2
    fig2 = figure;

    subplot(3, 1, 1)
    plot(step_responses{1,2})
    title("Skok u_2" + newline + "y_1")
    xlabel('k')
    ylabel('y_1')
    
    subplot(3, 1, 2)
    plot(step_responses{2,2})
    title("y_2")
    xlabel('k')
    ylabel('y_2')
    
    
    subplot(3, 1, 3)
    plot(step_responses{3,2})
    title("y_3")
    xlabel('k')
    ylabel('y_3')

        %% skok u3
    fig3 = figure;

    subplot(3, 1, 1)
    plot(step_responses{1,3})
    title("Skok u_3" + newline + "y_1")
    xlabel('k')
    ylabel('y_1')
    
    subplot(3, 1, 2)
    plot(step_responses{2,3})
    title("y_2")
    xlabel('k')
    ylabel('y_2')
    
    
    subplot(3, 1, 3)
    plot(step_responses{3,3})
    title("y_3")
    xlabel('k')
    ylabel('y_3')

        %% skok u4
    fig4 = figure;

    subplot(3, 1, 1)
    plot(step_responses{1,4})
    title("Skok u_4" + newline + "y_1")
    xlabel('k')
    ylabel('y_1')
    
    subplot(3, 1, 2)
    plot(step_responses{2,4})
    title("y_2")
    xlabel('k')
    ylabel('y_2')
    
    
    subplot(3, 1, 3)
    plot(step_responses{3,4})
    title("y_3")
    xlabel('k')
    ylabel('y_3')











