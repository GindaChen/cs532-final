%% PART0:
% Temperature Data in McGuireAFB from 1955-2010

avetemp_data = csvread("./data/McGuireAFB.data.csv");



%% 1. Select a sin/cos function to approximate the trend
hold on
T = 365*2;
plot(avetemp(1:T), '-');

d = 1:T;
t = d - 120;
% TODO: (maybe) alter some of the frequency
y = 30 * sin( 2/ 365 * pi * t )  + 50;
plot(d, y);

% TODO: Calculate the squared error
err = norm(y - avetemp_data(1:T)')
title('Error') % TODO: 
hold off

%% 2. Select a sin and a cos 

hold on
T = 365 * 2;
plot(avetemp(1:T), '-');

d = 1:T;
t = d - 120;
% TODO: (maybe) alter some of the frequency
y = 20 * sin( 2/ 365 * pi * t ) +  10 * cos( 2/ 365 * pi * t ) +  55;
plot(d, y);
% TODO: Calculate the squared error
err = norm(y - avetemp_data(1:T)')
title('Error') % TODO: 

hold off


%% 3. FFT
% (Y1,Y2) 1, 3, 729

hold on
% T = 365 * 2;
% a = avetemp(1:T);
a = avetemp(:);
f = fft(a);
stem(log(abs(f)));
hold off



%% Part1: Basis Function and Basis Matrix

% ?? Explore 

% Lasso

% Ridge


%% Part2; Method in Paper
a = avetemp_data;
T = length(a);

x = [
    52.6
    9.95e-5
    -20.4
    -8.31
    -0.197
    0.211
    0.992
];
d = (1:T)';
y = x(1) + x(2) * d ...
         + x(3) * cos(2 *pi * d / 365.25) ...
         + x(4) * sin(2 *pi * d / 365.25) ...
         + x(5) * cos(x(7) * 2 *pi * d / (365.25 * 10.7)) ...
         + x(6) * sin(x(7) * 2 *pi * d / (365.25 * 10.7))
         
hold on
% plot(d,a);
figure()
plot(d,y);
hold off

hold on
figure()
y = 52.6 + 9.95e-5 * d + (-20.4) * cos(2 * 3.14  * d / 365.25) + (-8.31) * sin(2 * 3.14  * d / 365.25) + (-0.197) * cos(0.992 * 2 * 3.14  * d / (365.25 * 10.7)) + 0.211 * sin(0.992 * 2 * 3.14  * d / (365.25 * 10.7));
plot(d,y);
hold off

err = norm(y-a)


