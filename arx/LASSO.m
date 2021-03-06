function [w] = LASSO (A, b, w, lambda )
%   Minimize |Ax-b|_2^2 + lambda*|x|_1   (Lasso regression)
	MAX_ITER = 1e6;         % maximum number of iterations
	TOL = 1e-5;             % convergence tolerance	
    tau = 1/norm( A )^2;      % choose stepsize
	[~,n] = size( A );

	it = 1;
	for i = 1:MAX_ITER 
        
		z = w - tau*( A'*(A * w - b) ); % Landweber
		wold = w; % store old x
        w = sign(z) .* max( abs(z) - tau*lambda/2, 0 );  % ISTA
        
        plot(1:length(b), A*w)
        plot(1:length(b), b)
        error = norm(A * wold - b) ./ length(b);
        title(num2str(error, 3));
        hold off
        pause
        
		
		if norm(w-wold) < TOL
			break
        end
        hold on
        
        it = it + 1;
	end   
end
