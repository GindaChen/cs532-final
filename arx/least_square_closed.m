function [w] = least_square_closed( A, b, lambda )

m, n = size(A);
if m > n
    T = A' * A;
    I = eye(T);
    w = (T + lambda * I) \ A' * b;
else
    T = A * A';
    I = eye(T);
    w = A' * (T + lambda * I) \ b;
end

    
end