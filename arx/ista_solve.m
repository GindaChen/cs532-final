function [w, it] = ista_solve( A, b, w, lambda )
%ista_solve: Iterative soft-thresholding!
%   this function solves the minimization problem
%   Minimize |Ax-b|_2^2 + lambda*|x|_1   (Lasso regression)
%   using iterative soft-thresholding.
	
	MAX_ITER = 1e6;         % maximum number of iterations
	TOL = 1e-5;             % convergence tolerance
	tau = 1/norm(A)^2;      % choose stepsize
	
	[~,n] = size(A);
   
    it = 1;
	for i = 1:MAX_ITER               
		z = w - tau*(A'*(A*w-b));                        % Landweber
		wold = w;                                        % store old x
		w = sign(z) .* max( abs(z) - tau*lambda/2, 0 );  % ISTA
		if norm(w-wold) < TOL
			break
        end
        it = it + 1;
	end   
end
