%% (Optional) Full LASSO

% %%%%
% 1. Data Process
% x = 1:365*2; % 
x = 1:length(temperature);
% x = 1:length(temperature);
x = x';
% x = x - 120;
y = temperature(x);
T_yr = 365.25;

% %%%%
% 2. Construct data matrix
% - 2.1 <Method 1.>
% t = (1 : 10) * (2 * pi / T_yr);
c = (T_yr/(2*pi));

t = c * [ 
     0.50  % Undergrad Final Exam Cycle
     1.00  % Seasonal Cycle
     4.00  % US President Election]
    10.78  % Solar Cycle
    18.60  % Moon Declination angle changing cycle
    88.00  % Volcanic Activity Periodicity
]';

% t = c * (1:10);

% A        = [ sin(x./t) cos(x ./ t) ones(size(x))];
% wdefault = [ ones(length(t) * 2,1) * 2000; 10;];

% - 2.2 <Method 2. Fix const term to the average of the time series>

A        = [ sin(x./t) cos(x ./ t) ones(size(x)) x];
wdefault = [ ones(length(t) * 2,1) * 2000; 10; 10;  ];


% %%%%
% 3. Apply LASSO Model
% - 3.1 (Optional) Rescale the matrix
r = max(A); % Scale of the matrix
A(:,end) = A(:,end) ./ length(x); % A = A ./ r; % Regularize
Aold = A;

% - 3.2 Apply LASSO Model for multiple lambdas
for lambda = [0.01, 1, 10] % [0.01 0.02 0.05 0.1 0.2 0.5 1 2 5 10 20]
    A = Aold;
    [w, it] = ista_solve(A, y, wdefault, lambda);
    lambda
    it 
    % - 3.3 Derive result time series and error
    z = A * w;
    error = norm(y - z) / length(x)

    % - 3.4 Plot result
    figure(); 

    subplot(2,1,1);
    stem(w);
    title("LASSO (\lambda = " + num2str(lambda, 2) +"): coefficient view ")

    subplot(2,1,2); hold on;
    plot(x, z);
    plot(x, y, ':');
    title("LASSO (\lambda = " + num2str(lambda, 2) +"): MSE = " + num2str(error, 3))
    hold off;
end




%% (Optional) Ridge Regression




%% Method used in Paper




%% Result shown in paper
% x = 1:365*5;
x = 1:length(temperature);
y = temperature(x);
w = [ 52.6; 9.95e-5; -20.4; -8.31; -0.197; 0.211; 0.992 ];

T_yr = 365.25;

model = @(d) (w(1) + w(2) * d ...
 + w(3) * cos(2 *pi * d / T_yr) ...
 + w(4) * sin(2 *pi * d / T_yr) ...
 + w(5) * cos(w(7) * 2 *pi * d / (T_yr * 10.7)) ...
 + w(6) * sin(w(7) * 2 *pi * d / (T_yr * 10.7)))';

z = model(x);

% Explicit Equation of the Model
% z = (w(1) + w(2) * x ...
%  + w(3) * cos(2 *pi * x / T_yr) ...
%  + w(4) * sin(2 *pi * x / T_yr) ...
%  + w(5) * cos(w(7) * 2 *pi * x / (T_yr * 10.7)) ...
%  + w(6) * sin(w(7) * 2 *pi * x / (T_yr * 10.7)))';

assert( all(size(y) == size(z)) );
error = norm(y - z) / length(x);

% Graph Plot and comparison
figure();
hold on; 
d = dates(x);
plot(d, y(x), ':') ; 
plot(d, z, '-', 'color', 'red', 'LineWidth', 2); 
title("Method in Paper: error = " + num2str(error, 3));
datetick('x', 'yyyy-mm-dd');
hold off;