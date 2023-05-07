function [x, iter, wynik] = gauss(A, b, x0, max_iter)
n = length(b);
x = x0;
iter = 0;
wynik = zeros(2,1);

for k = 1:max_iter
    for i = 1:n
        x(i) = (b(i) - A(i,1:i-1)*x(1:i-1) - A(i,i+1:n)*x(i+1:n)) / A(i,i);
        wynik(i,k) = x(i);
    end
    if k > 1
            if abs(wynik(i, k) - wynik(i, k-1) )< 1e-6
                break;
            end
    end
    iter = iter + 1;
end
end
