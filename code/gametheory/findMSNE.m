clear
format compact
N = 7;
V = zeros(1, N);
M = 21;
payoff = zeros(2^N, N);

for i = 0:2^N-1
    votes = 0;
    for j = 0:N-1
        votes = votes + bitand(bitshift(i,-j), 1);
    end
    %votes
    k = max(votes, 1);
    for j = 1:k
        payoff(i+1, j) = N/k;
    end
end
%payoff

for j = 0 : M^N - 1
    if j == M^(N-1) || j == M^(N-2) || j == M^(N-3) || j == M^(N-4)
        j
        disp([' -------------------------'])
    end
    for i = 1:N
        x = j;
        for k = 2:i
            x = x/M;
        end
        %p(i) = mod(floor(x), M) / (M-1);
        p(N+1-i) = mod(floor(x), M) / (M-1);
    end
    d = 1/(M-1);
    %p
    
    if p(1) > 0
        break
    end
    % if p(3) > 0.8
    %     break
    % end
    % if p(4) > 1.0
    %     continue
    % end
    % if p ~= [0 0 0.8 0.9 0.1]
    %     continue
    % end
    % if p == [0 0 0.8 0.9 0.2]
    %     break
    % end

    larger = zeros(1,N);
    smaller = zeros(1,N);
    V = calc_V( N, p, payoff);
    for i = 1:N
        pp = p;
        if pp(i) + d > 1
            pp(i) = 1;
        else
            pp(i) = pp(i) + d;
        end
        %pp
        Vp = calc_V( N, pp, payoff);
        if Vp(i) > V(i)
            larger(i) = 1;
            break
        elseif Vp(i) < V(i)
            larger(i) = -1;
        end

        pp = p;
        if pp(i) - d < 0
            pp(i) = 0;
        else
            pp(i) = pp(i) - d;
        end
        %pp
        Vp = calc_V( N, pp, payoff);
        if Vp(i) > V(i)
            smaller(i) = 1;
            break
        elseif Vp(i) < V(i)
            smaller(i) = -1;
        end
    end
    %larger
    %smaller
    if all(larger <= 0) && all(smaller <= 0)
        %disp('MSNE at '), 
        disp(p)
        %pd = [p larger smaller]
        %larger
        %smaller
        %disp(', sum '), disp(sum(p))
    end
end

function V = calc_V( N, p, payoff)
    V = zeros(1, N);

    for i = 1:N
        sum = 0;
        for k = 0:2^N-1
            %k
            prod = payoff(k+1,i);
            for l = 1:N               
                if mod(k,2^l) < 2^(l-1)
                    prod = prod*(1-p(l));
                else
                    prod = prod*p(l);
                end
            end
            sum = sum + prod;
        end
        V(i) = sum;
    end
end
