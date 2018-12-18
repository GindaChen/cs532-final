function [w] = least_square( A, b, w, lambda )

MAX_ITER = 1e6;         % maximum number of iterations
TOL      = 1e-5;        % convergence tolerance	
tau      = 1/norm(A)^2; % choose stepsize
[~,n]    = size(A);

it = 1;
k = lambda * tau;
for i = 1:MAX_ITER               
    z = w - tau*(A'*(A*w-b));  % Gradient Decend
    wold = w;                  % (Store old w)
    w = z / (1 + k) ;          % Regularization
    if norm(w-wold) < TOL
        break
    end
    it = it + 1;
end   

end