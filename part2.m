%% Part2 
temperature = csvread("data/McGuireAFB.data.csv");


%% Function Pointer
% arrayfun(), funm()




%% LASSO



%% Ridge Regression




%% Method in Paper

%% Result shown in paper
% x = 1:365*5;
x = 1:length(temperature);
y = temperature(x);
w = [ 52.6; 9.95e-5; -20.4; -8.31; -0.197; 0.211; 0.992 ];

T_yr = 365.25;


model = @(d) w(1) + w(2) * d ...
 + w(3) * cos(2 *pi * d / T_yr) ...
 + w(4) * sin(2 *pi * d / T_yr) ...
 + w(5) * cos(w(7) * 2 *pi * d / (T_yr * 10.7)) ...
 + w(6) * sin(w(7) * 2 *pi * d / (T_yr * 10.7));

z = model(x);

z = w(1) + w(2) * x ...
 + w(3) * cos(2 *pi * x / T_yr) ...
 + w(4) * sin(2 *pi * x / T_yr) ...
 + w(5) * cos(w(7) * 2 *pi * x / (T_yr * 10.7)) ...
 + w(6) * sin(w(7) * 2 *pi * x / (T_yr * 10.7));

error = norm(y - z);

% Graph Plot and comparison
figure();
hold on; 
plot(x, y(x), ':') ; 
plot(x, z, '-', 'color', 'red', 'LineWidth', 2); 
title("Method in Paper: error = " + num2str(error, 3))
hold off;
