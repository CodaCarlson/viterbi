function [ output_bits ] = hard_decode( input_bits, generators )
%% Compute Some Constants
K = size(generators, 1);
n = size(generators, 2);    % Number of output bits = 1/r
num_states = 2^(K-1);

%% Build Some Tables
[input_for_next_state, dont_care] = get_input_for_next_state(K);
outputs = get_outputs(generators);

%% Compute Path Metrics and Remove Loser Branches
num_steps = ceil(length(input_bits)/n);

% initialize path metrics
path_metrics = inf(num_states, 1);
path_metrics(1) = 0;
next_path_metrics = zeros(num_states, 1);

% pre-allocate branch winners
branch_winners = zeros(num_states, num_steps);
for step_idx=1:num_steps
   code_bits = input_bits((step_idx-1)*n+1:step_idx*n);
   
    for next_state_idx = 1:num_states
        min_path = -1;
        min_path_dist = inf;
        for state_idx = 1:num_states
            input_bit = input_for_next_state(state_idx, next_state_idx);
            if input_bit == -1 
                continue;
            end
            output_bits = outputs(state_idx, input_bit + 1, :);
            output_bits = reshape(output_bits, 1, n);
            path_dist = hamming_distance(code_bits, output_bits) + path_metrics(state_idx);
            if path_dist < min_path_dist
                min_path = state_idx;
                min_path_dist = path_dist;
            end
        end
        branch_winners(next_state_idx, step_idx) = min_path;
        next_path_metrics(next_state_idx) = min_path_dist;  
    end
    path_metrics = next_path_metrics;
end

%% Do the traceback
output_bits = perform_traceback(branch_winners, path_metrics, input_for_next_state);

end

function [ dist ] = hamming_distance(bits1, bits2)
    dist = sum(xor(bits1, bits2));
end
