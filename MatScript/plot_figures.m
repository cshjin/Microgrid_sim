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
