%% PART0:
% Temperature Data in McGuireAFB from 1955-2010

avetemp_data = csvread("./data/McGuireAFB.data.csv");
avetemp = avetemp_data;


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

%% Lasso

x = 2 * pi * d;
y = a;
d = (1:length(y))';
% (TODO): LASSO's data needs to be regularized 

% Afterwards Question ?
% Q1: Why linear? 
% A1: Try different polynomial term: x^n where n = 1/2, 1, 2, ...

% X1: Not regularized
% X1 = [ ones(L,1) d  d.^2 ...
%     cos(x/365)    sin(x/365) ...
%     cos(x/(365*10))  sin(x/(365*10)) ];

% X2: Regularized
% X2 = [ ones(L,1) d./L sqrt(d/L) ...
%     cos(x/365)    sin(x/365) ...
%     cos(x/(365*10))  sin(x/(365*10)) ];

% X3: Our new lasso matrix :)
% Q2: Will the constant coefficient affect the result of LASSO?
tic
L = length(a)
f = 365 * (1:3);
f = [ f 90 ];
N = length(f);
X3 = zeros(L, 2 + 2 * N);
X3(:,1) = ones(L,1);
X3(:,2) = d ./ L;

for i = 1:length(f)
    X3(:, 2 + 2*i - 1)  = cos(x/f(i));
    X3(:, 2 + 2*i)      = sin(x/f(i));
end
toc

% X4: To probe the lasso problem in X3
% Q2: Will the constant coefficient affect the result of LASSO?
% y = a;
% tic
% N = 10;
% X4 = zeros(L, 2 * N);
% for i = 1:N
%     X3(:, 2*i - 1) = cos(x/i);
%     X3(:, 2*i) = sin(x/i);
% end
% toc
% X = X4;
% size(X)
% 
% y = a - 

X = X3;

w = rand(N * 2 + 2,1);
tic
lambda = 0.1;
w = ista_solve(X, y ,w, lambda)
toc

z = X*w;

hold on
figure()
plot(d',z)
% plot(a,z)
hold off
figure()
stem(w)

err = norm(y - z)

% Ridge






%% Part2.1; Method in Paper

a = avetemp_data;
T = length(a);

%% Matlab Implementation
y = avetemp_data;
T = length(y);
d = (1:T)';
L = length(d);
% Initialize x
w = [ 60 0 20 20 0.01 0.01 ]'; 
% (TODO): we simplify the model to exclude the variate term of solar cycle

% y = x(1) + x(2) * d ...
%          + x(3) * cos(2 *pi * d / 365.25) ...
%          + x(4) * sin(2 *pi * d / 365.25) ...
%          + x(5) * cos(2 *pi * d / (365.25 * 10.7862)) ...
%          + x(6) * sin(2 *pi * d / (365.25 * 10.7862));

Tseason = 365.25;
Tsolar = 365.25 * 10.7862;
X = [ ones(L,1) d  cos(2 * pi * d / Tseason) sin(2 * pi * d / Tseason) cos(2 * pi * d / Tsolar) sin(2 * pi * d / Tsolar) ];

% Lease Square
w_ls = inv(X' * X) * X' * y;

z = X * w_ls

err = norm(z - y)



%% Result
d = (1:T)';
x = [ 52.6; 9.95e-5; -20.4; -8.31; -0.197; 0.211; 0.992 ];
% y = 52.6 + 9.95e-5 * d + (-20.4) * cos(2 * 3.14  * d / 365.25) + (-8.31) * sin(2 * 3.14  * d / 365.25) + (-0.197) * cos(0.992 * 2 * 3.14  * d / (365.25 * 10.7)) + 0.211 * sin(0.992 * 2 * 3.14  * d / (365.25 * 10.7));
y = x(1) + x(2) * d ...
         + x(3) * cos(2 *pi * d / 365.25) ...
         + x(4) * sin(2 *pi * d / 365.25) ...
         + x(5) * cos(x(7) * 2 *pi * d / (365.25 * 10.7)) ...
         + x(6) * sin(x(7) * 2 *pi * d / (365.25 * 10.7));
     


hold on
figure()
plot(d,a);;
plot(d,y);
hold off

err = norm(y-a)


%% 






