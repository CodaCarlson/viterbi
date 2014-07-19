function [ output_bits ] = encode( input_bits, generators )
%
%   1  1  1
%   0  1  0
%   1  0  1
%   1  1  0
    K = size(generators, 1);
    n = size(generators, 2);
    % n = 1/constraint length (the number of out bits per in bit)
    
    input_bits = [zeros(1, K-1) input_bits];
    
    output_bits = zeros(n, length(input_bits) - K + 1);
    % N - K itertions
    for i=1:length(input_bits)-K+1;
        % n iterations
        for j=1:n
            % K iterations
            output_bits(j, i) = mod(sum(generators(:, j)'.*input_bits(i:i+K-1)), 2);
        end
    end 
    output_bits = output_bits(:)';

    % Complexity (N-K)*n*K
    % Generally K << N  =>  N*n*K
    % O(N)
    % O(n)
    % O(K)
end
