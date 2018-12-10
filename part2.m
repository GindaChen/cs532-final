%% Part2 

% --- WARN ---
% Make sure the two matrix have same dimension
%       assert(size(y) == size(z))
%       y - z
% You should take guard on the dimension of y and z
% Once the matrix become big, it is hard to calculate
% and it is also hard to stop the process...

%% 1. Data Preperation
temperature = csvread("data/McGuireAFB.data.csv");
dates = csvread("data/McGuireAFB.time.csv"); % The date seemed to be a little wierd...

%% 2. Compare LASSO vs Ridge

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

A        = [ sin(x./t) cos(x ./ t) ones(size(x))];
wdefault = [ ones(length(t) * 2,1) * 2000; 10;];


%% 3. Without Linear term



%% 4. With Linear 
% 4.1 Naive linear term

% 4.2 Regularization of linear term
A        = [ sin(x./t) cos(x ./ t) ones(size(x)) x];
wdefault = [ ones(length(t) * 2,1) * 2000; 10; 10;  ];


%% 5. Weight of Linear Term





