%% Part2: Main Activity

% --- WARN ---
% Make sure the two matrix have same dimension
%       assert(size(y) == size(z))
%       y - z
% You should take guard on the dimension of y and z
% Once the matrix become big, it is hard to calculate
% and it is also hard to stop the process...

%% 1. Data Preperation
temperature = csvread("matlabdata/McGuireAFB.data.csv");
dates = csvread("matlabdata/McGuireAFB.time.csv"); % The date seemed to be a little wierd...

%% 2. Compare LASSO vs Ridge

x = 1:length(temperature); % x: the x range
x = x';
y = temperature(x);        % y: the corresponding temperature
T_yr = 365.25;             % T_yr: a year

c = (T_yr/(2*pi));         % c: constant term
t = c * [ 
     0.50  % Undergrad Final Exam Cycle
     1.00  % Seasonal Cycle
     4.00  % US President Election]
    10.78  % Solar Cycle
    18.60  % Moon Declination angle changing cycle
]';
u = x./t;                  % u: the spanned 
o = ones(size(x));

A        = [ sin(u) cos(u) o ];
A = A ./ max(A); % Regularization

% Naively Use LASSO and Ridge regression and see the outcome

reg_params = [0.1 1 10]; % the set of lambdas used for training
wdefault = [ ones(length(t) * 2,1) * 2; 10; ];
for lambda = reg_params
    compare_methods(A, x, y, wdefault, lambda);
end


%% 3. LASSO: Without Linear term



%% 4. LASSO: With Linear term
x = 1:length(temperature);
x = x';
y = temperature(x);
T_yr = 365.25;
c = (T_yr/(2*pi));
t = c * [ 
     0.50  % Undergrad Final Exam Cycle
     1.00  % Seasonal Cycle
     4.00  % US President Election]
    10.78  % Solar Cycle
    18.60  % Moon Declination angle changing cycle
]';

% 4.1 Naive linear term
u = x./t;
o = ones(size(x));
A        = [ sin(u) cos(u) o x];
wdefault = [ ones(length(t) * 2,1) * 2000; 10; 10;  ];


% 4.2 Regularization of linear term
u = x./t;
o = ones(size(x));
A        = [ sin(u) cos(u) o x];
A = A ./ max(A); % Regularize each column
wdefault = [ ones(length(t) * 2,1) * 2000; 10; 10;  ];


%% 5. Weight of Linear Term





