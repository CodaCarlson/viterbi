function [ output_bits ] = perform_traceback( branch_winners, path_metrics, input_for_next_state )
num_steps = size(branch_winners, 2);

output_bits = zeros(1, num_steps);
[~, curr_state_idx] = min(path_metrics);
% N iterations
for step_idx=num_steps:-1:1
    prev_state_idx = branch_winners(curr_state_idx, step_idx);
    output_bits(step_idx) = input_for_next_state(prev_state_idx, curr_state_idx);
    curr_state_idx = prev_state_idx;
end
end
