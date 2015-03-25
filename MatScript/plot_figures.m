% -------------------------------------------------------------------------
% Plot ideal solar radiation and real radiation
% -------------------------------------------------------------------------
% One Week
figure('Position', [100, 100, 600, 400]);
plot(ideal_solar(1:168), 'g.-');
hold on;
plot(real_solar(1:168), 'r.-');
title({'Comparision of Ideal and Real PV Value',' (1991-01-01~1991-01-07)'});
ylabel('Energy (Wh)');
xlabel('Hour');
legend('ideal PV', 'real PV', 'Location', 'southoutside','Orientation','horizontal');
% One Year
figure('Position', [100, 100, 600, 400]);
plot(ideal_solar, 'g.');
hold on;
plot(real_solar, 'r.');
title({'Comparision of Ideal and Real PV Value',' (1991-01-01~1991-12-31)'});
ylabel('Energy (Wh)');
xlabel('Hour');
legend('ideal PV', 'real PV', 'Location', 'southoutside','Orientation','horizontal');

% -------------------------------------------------------------------------
% Plot Different Models
% -------------------------------------------------------------------------
% 3 Scenarios
figure('Position', [100, 100, 600, 400]);
plot(cumsum(sp3_2), 'g.');
hold on;
plot(cumsum(sp8_2), 'r.');
title({'Comparision of 3 Scenarios and 8 Scenarios'});
ylabel('Cumulative Sum of Year-long Energy (Wh)');
xlabel('Hours');
legend('3S', '8S', 'Location', 'southoutside','Orientation','horizontal');

figure('Position', [100, 100, 600, 400]);
plot(cumsum(sp3_2), 'g.');
hold on;
plot(cumsum(sp3_3), 'r.');
title({'Comparision of 3 Scenarios with Repeating Second Stage or Not'});
ylabel('Cumulative Sum of Year-long Energy (Wh)');
xlabel('Hours');
legend('Repeat', 'Non-Repeat', 'Location', 'southoutside','Orientation','horizontal');
% plot difference
plot((sp3_2-sp3_3));

% plot with look day ahead
figure('Position', [100, 100, 600, 400]);
plot(cumsum(sp3_24), 'g.');
hold on;
plot(cumsum(sp3_2), 'r.');
title({'Comparision 1-hour Ahead and 24-hour Ahead in 3 scenarios'});
ylabel('Cumulative Sum of Year-long Energy (Wh)');
xlabel('Hours');
legend('24-hour Ahead', '1-hour Ahead', 'Location', 'southoutside','Orientation','horizontal');

plot((sp3_24-sp3_2));