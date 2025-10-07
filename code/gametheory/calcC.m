%
% Calculates coefficients C_N(i,j)
%
N = 7;
C = zeros(1,N);
for i=1:N
    %i
    for j=1:N
        %j
        C(i,j) = calc_C(N,i,j);
    end
end
C

function C = calc_C( N, i, j)

    if i==1
        sum = N*(-1)^j;
    else
        sum = 0;
    end

    i
    j
    for l = i:j
        l
        sum = sum + N*(-1)^(j+l)*nchoosek(j,l)/l;
        N*(-1)^(j+l)*nchoosek(j,l)/l
    end

    C = sum;
end
