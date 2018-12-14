function [w, it] = lasso( A, b, w, lambda )

    MAX_ITER = 5e4;         % maximum number of iterations
    TOL      = 1e-6;        % convergence tolerance	
    tau      = 1/norm(A)^2; % choose stepsize
    [m,n] = size(A);
   
    it = 1;
%     figure();
	for i = 1:MAX_ITER               
		z = w - tau*(A'*(A*w-b));                        % Landweber
		wold = w;                                        % store old x
		w = sign(z) .* max( abs(z) - tau*lambda/2, 0 );  % ISTA
        
%         x = (1:m)';
%         subplot(2,1,1); 
%         title("LASSO weight: Iteration=" + num2str(it));
%         hold on; stem(wold); stem(w); hold off;
%         
%         
%         subplot(2,1,2); 
%         title("LASSO outcom: Iteration=" + num2str(it));
%         hold on; 
%         plot(x, b, ':'); plot(x, A*w); hold off;
%         
%         pause;
        
		if norm(w-wold) < TOL
			break
        end
        it = it + 1;
	end   
end
