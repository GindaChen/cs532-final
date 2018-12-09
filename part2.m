%% Part2 
temperature = csvread("data/McGuireAFB.data.csv");
dates = csvread("data/McGuireAFB.time.csv"); % The date seemed to be a little wierd...

% --- WARN ---
% Make sure the two matrix have same dimension
%       assert(size(y) == size(z))
%       y - z
% You should take guard on the dimension of y and z
% Once the matrix become big, it is hard to calculate
% and it is also hard to stop the process...

%% LASSO

% %%%%
% 1. Data Process

x = 1:365*2; % x = 1:length(temperature);
x = x';
y = temperature(x);
T_yr = 365.25;

% %%%%
% 2. Construct data matrix
% - 2.1 <Method 1.>
t = (1 : 10) * (2 * pi / T_yr);
A = [ sin(x*t) cos(x*t) ones(size(x)) x ];
wdefault = [ ones(length(t) * 2,1) * 2000; 10; 10;  ];
% - 2.2 <Method 2. Fix const term to the average of the time series>
% t = (1:10) * (2 * pi / T_yr); % t = (1:100) * (T_yr / 10);
% y = temperature(x);
% y = y - y(1); %mean(y);
% A = [ sin(x*t) cos(x*t) x ];
% wdefault = [ ones(length(t) * 2,1) * 10; 0.01; ];

% %%%%
% 3. Apply LASSO Model
% - 3.1 (Optional) Rescale the matrix
r = max(A); % Scale of the matrix
A = A ./ r; % Regularize

% - 3.2 Apply LASSO Model
lambda = 10;
w = ista_solve(A, y, wdefault, lambda)

% - 3.3 Derive result time series and error
z = A * w
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




%% Ridge Regression




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
