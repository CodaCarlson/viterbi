function [ input_bits ] = recursive_decode( code_bits, generators )
    %% Compute Some Constants
    K = size(generators, 1);
    n = size(generators, 2);    % Number of output bits = 1/r
    num_states = 2^(K-1);
    
    %% Build Some Tables
    [dont_care, next_state_table] = get_input_for_next_state(K);
    outputs = get_outputs(generators);

    [input_bits, dont_care] = ...
        recursive_decode_helper(code_bits, 1, next_state_table, outputs);
end

function [input_bits, metric ] = recursive_decode_helper(code_bits, ...
                                                 current_state,     ...
                                                 next_state_table,  ...
                                                 outputs)
    if length(code_bits) == 0
        input_bits = [];
        metric = 0;
        return
    end

    code_bits_per_transition = size(outputs, 3);
    code_bits_this_transition = code_bits(1:code_bits_per_transition);
    remaining_code_bits = code_bits(code_bits_per_transition + 1:end);
    
    % T(n-2) + 1/code_rate
    [input_bits_0, metric_0] = ...
        recursive_decode_helper(remaining_code_bits, ...
                                next_state_table(current_state, 1) + 1, ...
                                next_state_table, ...
                                outputs);
    metric_0 = metric_0 + hamming_distance(code_bits_this_transition, ...
                                           squeeze(outputs(current_state, 1, :))');

    % T(n-2) + 1/code_rate
    [input_bits_1, metric_1] = ...
        recursive_decode_helper(remaining_code_bits, ...
                                next_state_table(current_state, 2) + 1, ...
                                next_state_table, ...
                                outputs);
    metric_1 = metric_1 + hamming_distance(code_bits_this_transition, ...
                                           squeeze(outputs(current_state, 2, :))');
    if metric_1 < metric_0
        input_bits = [1 input_bits_1];
        metric = metric_1;
    else
        input_bits = [0 input_bits_0];
        metric = metric_0;
    end

    % 2*T(N-1) + 2
    % O(2^N)
end


function [ dist ] = hamming_distance(bits1, bits2)
    dist = sum(xor(bits1, bits2));
end
