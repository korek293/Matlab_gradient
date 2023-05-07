clc
clear all

A = [5 1; 1 7];
b = [18; -15];
x0 = [0; 0];
max_iter = 100;

%Pierwsza część wykresu porównawczego 
subplot(1,2,1);
[x, iter, solutions, czas_grad] = grad(A, b, x0, max_iter);
iter_gragrad=iter

%Druga część wykresu porównawczego
subplot(1,2,2);
gausin=tic;
[x, iter, wynik] = gauss(A, b, x0, max_iter)
gausout=toc(gausin);

iter_gaus=iter
for i = 1 : iter_gaus
    plot(wynik(1,1:i), wynik(2,1:i),'o-', 'MarkerFaceColor', 'y');
    pause(0.5);
end
title('Metoda Gaussa-Seidela')
xlabel('x_1')
ylabel('x_2')

%Wykres 3d
figure;
f = @(x1,x2) 0.5.*[x1;x2]'*A*[x1; x2] -b'*[x1; x2];
fsurf(f)
colorbar
yf=f(solutions(1,:), solutions(2,:));
hold on;
scatter3(solutions(1,:), solutions(2,:), yf(2, :), 'magenta', 'filled');
hold on;
plot3(solutions(1,:), solutions(2,:), yf(2, :), 'LineWidth', 2, 'Color', 'yellow');

%Wykres metody gradientów sprężonych
figure;
[x, iter, solutions] = grad(A, b, x0, max_iter);

czas_grad
gausout
