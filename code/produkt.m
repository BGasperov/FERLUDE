clear
K = 10000;
r1 = randn(1,K);
r2 = randn(1,K);
r3 = randn(1,K);
r12 = r1.*r2;
p12 = (r1+1).*(r2+1);
p123 = (r1+1).*(r2+1).*(r3+1);
histogram(r1, 'Normalization', 'pdf', 'DisplayStyle', 'stairs', 'EdgeColor','k', 'BinEdges', -10:0.1:10)
hold on
pause(1)
histogram(r12, 'Normalization', 'pdf', 'DisplayStyle', 'stairs', 'EdgeColor','r', 'BinEdges', -10:0.1:10)
pause(1)
z=-10:0.1:10;
plot(z, besselk(0,z)/pi, 'm')
legend('normal', 'normal*normal', 'Bessel')
hold off
pause(5)

histogram(p12, 'Normalization', 'pdf', 'DisplayStyle', 'stairs','EdgeColor','m', 'BinEdges', -10:0.1:10)
hold on
pause(1)
histogram(p123, 'Normalization', 'pdf', 'DisplayStyle', 'stairs','EdgeColor','b', 'BinEdges', -10:0.1:10)
legend('(z+1)*(z+1)', '(z+1)*(z+1)*(z+1)')
hold off
mean(p12)
mean(p123)
pause(5)

N = 500;
y = zeros(K,N);
r = randn(K,N)+1;
d = 0;
for k=1:K
    y(k,1) = 1;
    for i=2:N
        %y = y*(1+randn)
        y(k,i) = y(k,i-1)*(1+randn);
        %y(k,i) = y(k,i-1)*(rand+0.5);   % uniform
        %y(k,i) = y(k,i-1)*random(pd);
    end
%     if max(abs(y(k,:))) > 100
%         d = d+1;
%         plot(y(k,:))
%         hold on
%     end
    if k < 1000
        plot(y(k,:))
        hold on
        pause(0.01)
    end
end
xlabel('number of steps')
hold off
% d
% d/K
pause(2)
plot(mean(y))
xlabel('number of steps')
legend('mean')
pause(5)

histogram(y(:,4), 'Normalization', 'pdf', 'DisplayStyle', 'stairs', 'BinEdges',  -10:0.01:10)
hold on
pause(1)
histogram(y(:,5), 'Normalization', 'pdf', 'DisplayStyle', 'stairs','BinEdges', -10:0.1:10)
pause(1)
histogram(y(:,6), 'Normalization', 'pdf', 'DisplayStyle', 'stairs','BinEdges', -10:0.1:10)
pause(1)
histogram(y(:,16), 'Normalization', 'pdf', 'DisplayStyle', 'stairs','BinEdges', -10:0.1:10)
legend('produkt 3', 'produkt 4', 'produkt 5', 'produkt 15')
hold off
