%% Part1 Warm-up and Basis Function

% Load Data
%    - date: record of date
%    - temperature: the corresponding temperature 
temperature = csvread("data/McGuireAFB.data.csv");
date = csvread("data/McGuireAFB.time.csv"); % The date seemed to be a little wierd...


%% 1.1 Show basic data property
figure(1)
plot(date, temperature);
datetick('x', 'yyyy-mm-dd');
title('McGuire AFB Temperature 1955-2010');

%%% ? How would you fit the graph?


%% 1.2 See data in different ranges
figure(2)

subplot(3,1,1)   % [11 Years]
slice = 1:365*11; % Choose 1 ~ 365*11 days of the year
plot(date(slice), temperature(slice));
datetick('x', 'yyyy-mm-dd');
title('McGuire AFB Temperature 1955-1966 (~11yrs)');


subplot(3,1,2)   % [5 Years]
slice = 1:365*5; % Choose 1 ~ 365*5 days of the year
plot(date(slice), temperature(slice));
datetick('x', 'yyyy-mm-dd');
title('McGuire AFB Temperature 1955-1960 (~5yrs)');

subplot(3,1,3)   % [2 Years]
slice = 1:365*2; % Choose 1 ~ 365*2 days of the year
plot(date(slice), temperature(slice));
datetick('x', 'yyyy-mm-dd');
title('McGuire AFB Temperature 1955-1957 (~2yrs)');

%% 1.3 Try to fit data by different functions

x = 1:365*2; 
y = temperature(x);
close;

% 1. sin(x)

figure(3);

subplot(3,1,1);
A = 20; b = mean(y); phi = 120;
T = 365 / (2 * pi);

z = A * sin((x - phi)/T) + b;
error = norm(y - z')^2 / length(x);
hold on; plot(x,y, ':','LineWidth', 1);  plot(x,z, 'LineWidth',2); hold off;
title("Fit data with sin(x)-liked function (error = " + num2str(error, 3) + ")");
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
title("Fit data with sin(x)+cos(x)-liked function (error = " + num2str(error, 3) + ")");
D = '$$y = 38 sin(\frac{2 \pi}{365} (x - 120 )) )$$';
annotation(gcf,'textbox',[0,0,1,1],'string',D,'interpreter','latex');

% 3. sin(x) + sin(2x)

subplot(3,1,3);

A1 = 10; A2 = 10;
phi1 = 100; phi2 = 160;
b = mean(y); 
T = 365 / (2 * pi);

z = A1 * sin((x - phi1)/T) + A2 * sin( 2 * (x - phi2)/T) + b;
error = norm(y - z')^2 / length(x);
hold on; plot(x,y, ':','LineWidth', 1);  plot(x,z, 'LineWidth',2); hold off;
title("Fit data with sin(x)+sin(2x)-liked function (error = " + num2str(error, 3) + ")");
D = '$$y = 38 sin(\frac{2 \pi}{365} (x - 120 )) )$$';
annotation(gcf,'textbox',[0,0,1,1],'string',D,'interpreter','latex');


%% 1.4 Factor of Gobal Warming





%% 1.5 How to build a Basis Function (Matrix)