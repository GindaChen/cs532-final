function compare_methods(A, x, y, wdefault, lambda)
    figure();
    
% LASSO    
    [wlasso, iter_lasso] = lasso(A, y, wdefault, lambda);
    error_lasso = norm(A * wlasso - y).^2/length(x);
    z = A * wlasso;
    
    subplot(4,1,1)
    title("Lasso lambda=" + num2str(lambda) + ...
        ", iterations=" + num2str(iter_lasso) + ...
          ", error=" + num2str(error_lasso)...
          );
    hold on; plot(x, y, ':'); plot(x, z, '-'); hold off;
    
    subplot(4,1,2);
    title("Lasso weight");
    hold on; stem(wlasso); hold off;
    
    
% Ridge
    [wridge, iter_ridge] = ridge(A, y, wdefault, lambda);
    error_ridge = norm(A * wridge - y).^2/length(x);
    z = A * wridge;
    
    subplot(4,1,3)
    title("Ridge lambda=" + num2str(lambda) + ...
        ", iterations=" + num2str(iter_ridge) + ...
        ", error=" + num2str(error_ridge));
    hold on; plot(x, y, ':'); plot(x, z, '-'); hold off;
    
    subplot(4,1,4);
    title("Ridge weight");
    hold on; stem(wridge); hold off;
end