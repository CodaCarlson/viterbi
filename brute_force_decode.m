function [ output_bits ] = brute_force_decode( input_bits, generators )
    code_rate = 1/size(generators, 2);
    N = length(input_bits)*code_rate;
    best_dist = inf;
    % For every possibe N-bit sequence, s
    % 2^N-1 iterations
    for i=0:2^N-1
        seq = dec2bin(i, N) == '1';
        % encode sequence s as c
        code_bits = encode(seq, generators);
        this_dist = hamming_distance(code_bits, input_bits);
        % if hamming distance from input to c < d
        if this_dist < best_dist
            best_dist = this_dist;
            % output_bits = s
            output_bits = seq;
        end
    end
end

function [ dist ] = hamming_distance(bits1, bits2)
    dist = sum(xor(bits1, bits2));
end
