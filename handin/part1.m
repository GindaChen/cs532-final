%% Part1 Warm-up and Basis Function

% Online version of the activity:
% https://beta.observablehq.com/@gindachen/local-warming

% Load Data
%    - date: record of date
%    - temperature: the corresponding temperature 
temperature = csvread('McGuireAFB.data.csv');
dates = csvread('McGuireAFB.time.csv'); % The date seemed to be a little wierd...


%% 1.1 Show the entire data (55 years)
figure(1)
plot(dates, temperature);
datetick('x', 'yyyy-mm-dd');
title('McGuire AFB Temperature 1955-2010');

%% 1.2 See data in different ranges of years (11, 5, 2)
figure(2)

subplot(3,1,1)   % [11 Years]
slice = 1:365*11; % Choose 1 ~ 365*11 days of the year
plot(dates(slice), temperature(slice));
datetick('x', 'yyyy-mm-dd');
title('McGuire AFB Temperature 1955-1966 (~11yrs)');


subplot(3,1,2)   % [5 Years]
slice = 1:365*5; % Choose 1 ~ 365*5 days of the year
plot(dates(slice), temperature(slice));
datetick('x', 'yyyy-mm-dd');
title('McGuire AFB Temperature 1955-1960 (~5yrs)');

subplot(3,1,3)   % [2 Years]
slice = 1:365*2; % Choose 1 ~ 365*2 days of the year
plot(dates(slice), temperature(slice));
datetick('x', 'yyyy-mm-dd');
title('McGuire AFB Temperature 1955-1957 (~2yrs)');

%% 1.3 Try to fit data by different functions

x = 1:365*2; 
y = temperature(x);

% 1. sin(x)

figure(3);

subplot(3,1,1);
X = 20; b = mean(y); phi = 120;
T = 365 / (2 * pi);

z = X * sin((x - phi)/T) + b;
error = norm(y - z')^2 / length(x);
hold on; plot(x,y, ':','LineWidth', 1);  plot(x,z, 'LineWidth',2); hold off;
title(['Fit data with sin(x)-liked function (error = ', num2str(error, 3), ')']);
D = '$$y = 38 sin(\frac{2 \pi}{365} (x - 120 )) )$$';
annotation(gcf,'textbox',[0,0,1,1],'string',D,'interpreter','latex');

% 2. sin(x) + cos(x)

subplot(3,1,2);

A1 = 17; A2 = 10;
phi1 = 140; phi2 = 160;
b = mean(y); 
T = 365 / (2 * pi);

z = A1 * sin((x - phi1)/T) + A2 * cos( (x - phi2)/T) + b;
error = norm(y - z')^2 / length(x);
hold on; plot(x,y, ':','LineWidth', 1);  plot(x,z, 'LineWidth',2); hold off;
title(['Fit data with sin(x)+cos(x)-liked function (error = ', num2str(error, 3), ')']);
D = '$$y = 38 sin(\frac{2 \pi}{365} (x - 120 )) )$$';
annotation(gcf,'textbox',[0,0,1,1],'string',D,'interpreter','latex');

% 3. sin(x) + sin(2x)

subplot(3,1,3);

A1 = 2; A2 = 23.7;
phi1 = 0; phi2 = 107;
b = 53; 
T1 = 60;
T2 = 5.5;

z1 = A1 * sin((x - phi1)/T);
z2 = A2 * sin((x - phi2)/T);
z =  z1 + z2 + b;
error = norm(y - z')^2 / length(x)

hold on; 
plot(x,y, ':','LineWidth', 1);  plot(x,z, 'LineWidth',2); 
hold off;
title(['Fit data with sin(x)+sin(x/2)-liked function (error = ', num2str(error, 3), ')']);
D = '$$y = 38 sin(\frac{2 \pi}{365} (x - 120 )) )$$';
annotation(gcf,'textbox',[0,0,1,1],'string',D,'interpreter','latex');


%% 1.4 How to build a Basis Function (Matrix)

% Online illustration of the activity
% https://beta.observablehq.com/@gindachen/local-warming

% Since we are using a combination of sin/cos to construct our 'data'
% We need an efficient way to construct this matrix `A`.
% This is called a basis matrix, which contains orthogonal bases
% as different columns.
% 
% Construct a series of 
% [ x1 sin(x1) sin(2*x1) cos(x1) cos(2*x1)]
% [ x2 sin(x2) sin(2*x2) cos(x2) cos(2*x2)]

x = (1:3)';                 %    x: x-parameter of the data
T_yr = 365.25;              % T_yr: represent a year      
t = [1, 2, 4] * T_yr;    %    T: cycles of the sin/cos function
one_column = ones(length(x), 1); % a vector column represent 1
% one_column = ones(size(x)); % Alternativel

X = [ sin(x * (1./ t))   cos(x * (1./ t)) one_column  x  ]; % 
X = X * (1 ./ max(X)); % Regularize (not strictly correct though...)

% Tada! This is the basis matrix
X

%% 1.5 Factor of Gobal Warming

x = (1:365*2)';

T_yr = 365.25;

% Add the factors you wish to the list
t = T_yr * [ 
     0.50  % Undergrad Final Exam Cycle
     1.00  % Seasonal Cycle
     4.00  % US President Election]
    10.78  % Solar Cycle
    18.60  % Moon Declination angle changing cycle
]';

X = [ ones(size(x)) x sin(x*t) cos(x*t)];

X = X * (1 ./ max(X)); 
