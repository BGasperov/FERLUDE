clear
hold off
format long

% [x, t] = meshgrid(-2:0.025:6, 0:50:2000);
% MG = Moving_Gaussian(x, t);
% mesh(x,t,MG)
% return

%problem = 'Gaussian ring';
%problem = 'Moving Gaussian';
%problem = 'Adversarial Gaussian ring';
problem = 'Numeric Fitness World';

if strcmp(problem, 'Gaussian ring')
    G = 200;
    SZ = 100;
elseif strcmp(problem, 'Moving Gaussian')
    G = 2000;
    SZ = 3;
elseif strcmp(problem, 'Adversarial Gaussian ring')
    G = 500;
    SZ = 100;
elseif strcmp(problem, 'Numeric Fitness World')
    G = 1000;
    SZ = 1;
end

Nexp = 40;
N = 128;
Nk = 1; %ceil(N/10);
S_meta_0 = 1e-2; %1e-5;
S_fixed = S_meta_0;
beta = 1e-4;
methods = {'Fixed', 'SA1', 'SA2', 'SA3', 'SR1', 'SR2', 'SR3', 'Lu'};
s1p = zeros(1,G);
s2p = zeros(1,G);
s3p = zeros(1,G);
colors = [.9 .9 .9; 1 .9 .9; .9 1 .9; .9 .9 1; 1 1 .8; 1 .8 1; .8 1 1; .8 .8 .8];
main_color = ['k', 'r', 'g', 'b', 'y', 'm', 'c', 'k'];
ave = zeros(size(methods,2), G);
stdev = zeros(size(methods,2), G);

for meth=8:8
    method = methods{meth};
    m = zeros(Nexp,G);

    for exper=1:Nexp
        sigma = S_meta_0;
        x = sigma * randn(N,SZ);
        s1 = sigma * randn(N,1);
        s2 = sigma * randn(N,1);
        s3 = sigma * randn(N,1);
        s_meta = S_meta_0;
        fitness = zeros(N,1);
        best = x(1,:);

        for t=1:G
            %t
            % Eval.
            for i=1:N
                if strcmp(problem, 'Gaussian ring')
                    fitness(i) = Gaussian_ring(x(i,:));
                elseif strcmp(problem, 'Moving Gaussian')
                    fitness(i) = Moving_Gaussian(x(i,:), t);
                elseif strcmp(problem, 'Adversarial Gaussian ring')
                    fitness(i) = Adversarial_Gaussian_ring(x(i,:), best);
                elseif strcmp(problem, 'Numeric Fitness World')
                    fitness(i) = Numeric_fitness_world(x(i,:));                    
                end
            end
            fitness;
            % Selection
            [kbest_f,kI] = maxk( fitness, Nk);
            elite = x(kI,:);
            [best_f,I] = max( fitness);
            m(exper,t) = best_f;
            best = x(I,:);
            x(1:Nk,:) = x(kI,:);
            s1(1:Nk) = s1(kI);
            s2(1:Nk) = s2(kI);
            s3(1:Nk) = s3(kI);
            for i=Nk+1:N
                ch = ceil(Nk*rand);
                if strcmp(method,'Fixed')
                    x(i,:) = x(ch,:) + S_fixed*randn(1,SZ); % fixed mutation
                elseif strcmp(method,'Lu')
                    x(i,:) = x(ch,:) + s1(ch) + sqrt(beta)*randn(1,SZ);
                else
                    x(i,:) = x(ch,:) + s1(ch)*randn(1,SZ); % mutation
                end
                
                if strcmp(method,'SA1')
                    % self-adaptive:
                    r = randn;
                    s1(i) = s1(ch) + s_meta*r;
                elseif strcmp(method,'SA2')
                    % 2nd order self-adaptive:
                    s1(i) = s1(ch) + s2(ch)*randn;
                    s2(i) = s2(ch) + s_meta*randn;
                elseif strcmp(method,'SA3')
                    % 3rd order self-adaptive:
                    s1(i) = s1(ch) + s2(ch)*randn;
                    s2(i) = s2(ch) + s3(ch)*randn;           
                    s3(i) = s3(ch) + s_meta*randn;
                elseif strcmp(method,'SR1')
                    % 1st order self-referential:
                    s1(i) = s1(ch) + s1(ch)*randn;
                elseif strcmp(method,'SR2')
                    % 2nd order self-referential:
                    s1(i) = s1(ch) + s2(ch)*randn;
                    s2(i) = s2(ch) + s2(ch)*randn;
                elseif strcmp(method,'SR3')
                    % 3rd order self-referential:
                    s1(i) = s1(ch) + s2(ch)*randn;
                    s2(i) = s2(ch) + s3(ch)*randn;
                    s3(i) = s3(ch) + s3(ch)*randn;
                elseif strcmp(method,'Lu')
                    % 3rd order self-adaptation:
                     s1(i) = s1(ch) + s2(ch) + sqrt(beta)*randn;
                     s2(i) = s2(ch) + sqrt(beta)*randn;

                     %s2(i) = s2(ch) + s3(ch) + sqrt(beta)*randn;
                     %s3(i) = s3(ch) + sqrt(beta)*randn;
                end
            end
            s1p(t) = mean(s1);
            s2p(t) = mean(s2);    
            s3p(t) = mean(s3);    
        end
         plot(m(exper,:), main_color(meth))
         hold on
%         plot( 1:G, 10*s1p, 'r')
%         plot( 1:G, 10*s2p, 'g')
%         plot( 1:G, 10*s3p, 'b')
%         %pause
%         %hold off
    end
    ave(meth,:) = mean(m);
    stdev(meth,:) = std(m);
      plot( 1:G, ave(meth,:), main_color(meth), 'LineWidth', 2)
      hold on
%      plot( 1:G, s1p, 'r')
%      plot( 1:G, s2p, 'g')
%      plot( 1:G, s3p, 'b')
end
legend(methods)

for meth=8:8
    curve1 = ave(meth,:) + stdev(meth,:)/sqrt(Nexp);
    curve2 = ave(meth,:) - stdev(meth,:)/sqrt(Nexp);
    x2 = [1:G, fliplr(1:G)];
    inBetween = [curve1, fliplr(curve2)];    
    s = patch(x2, [curve1  fliplr(curve2)], colors(meth,:), 'EdgeColor', colors(meth,:));
    alpha(s, .5)
    hold on
end
hold off


% Gaussian ring
function f = Gaussian_ring(x)
n = length(x);
sum = 0;
for i=1:n
   sum = sum + x(i)*x(i);
end
q = sqrt(sum) - 1;
f = exp(-5*q*q);
end

% Moving Gaussian
function f = Moving_Gaussian(x, t)
n = length(x);
if n~=3
   error('Moving_Gaussian: n~=3')
end
alfa = [1e-3, 1e-6, 1e-9];
sum = 0;
for i=1:3
   sum = sum + exp(-10*(x(i)-alfa(i)*(t^i))^2);
   %sum = sum + exp(-10*(x-alfa(i)*(t.^i)).^2); % vector form
end
f = sum/3;
end

% Adversarial Gaussian Ring:
function f = Adversarial_Gaussian_ring(x, m)
n = length(x);
sum = 0;
for i=1:n
   sum = sum + (x(i)-m(i))^2;
end
%sum = (x-m)*(x-m)'; % vector form
q = (sqrt(sum)-1)^2;
f = exp(-5*q);
end

% Numeric fitness world
function f = Numeric_fitness_world(x)
n = length(x);
if n~=1
   error('Numeric_fitness_world: n~=1')
end
f = x;
end
