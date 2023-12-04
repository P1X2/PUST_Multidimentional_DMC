%% ZAD1

steps = 400;

u1(1:steps) = 0;
u2(1:steps) = 0;
u3(1:steps) = 0;
u4(1:steps) = 0;

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

fig1 = figure;
subplot(3, 1, 1)
plot(y1)
title("y_1")
xlabel('k')
ylabel('y_1')

subplot(3, 1, 2)
plot(y2)
title("y_2")
xlabel('k')
ylabel('y_2')


subplot(3, 1, 3)
plot(y3)
title("y_3")
xlabel('k')
ylabel('y_3')
