function [x, iter, solutions, czas_grad] = grad(A, b, x0, max_iter)
n = length(b);
x = x0;
r = b - A*x;
p = r;
iter = 0;
solutions = x;

czas1= tic;

while norm(r) > 1e-6 && iter < max_iter
    alpha = (r'*r)/(p'*A*p);
    x = x + alpha*p;
    r_prev = r;
    r = r - alpha*A*p;
    beta = (r'*r)/(r_prev'*r_prev);
    p = r + beta*p;
    iter = iter + 1;
    solutions = [solutions x];
end

czas_grad=toc(czas1);

%tworzenie GIF
filename = 'wykres.gif';
n_frames = 10;

for i = 1:size(solutions,2)   
    [X,Y] = meshgrid(linspace(min(solutions(1,:))-1,max(solutions(1,:))+1,20), linspace(min(solutions(2,:))-1,max(solutions(2,:))+1,20));
    Z = arrayfun(@(x,y) norm(b-A*[x;y]), X, Y);
    contour(X,Y,Z, 20);
    hold on
    plot(solutions(1,1:i), solutions(2,1:i), 'o-', 'MarkerFaceColor', 'y')
        for ii = 1:i
            text(solutions(1,ii)+0.1, solutions(2,ii)+0.1, num2str(ii-1));
        end
    title('Metoda gradientów sprzężonych')
    xlabel('x_1')
    ylabel('x_2')
    legend('Płaszczyzna matematyczna', 'Punkty rozwiązań')
    colorbar
        
    frame = getframe(gcf);
    im = frame2im(frame);
    [imind, cm] = rgb2ind(im, 256);
    if i == 1
        imwrite(imind, cm, filename, 'gif', 'Loopcount', inf);
    else
        imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append');
    end
end