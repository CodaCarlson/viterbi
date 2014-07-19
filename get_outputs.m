function [ outputs ] = get_outputs( generators )
K = size(generators, 1);
n = size(generators, 2);    % Number of output bits = 1/r
num_states = 2^(K-1);

%% Create a table of the possible shift register states
states = zeros(num_states, K-1);
for i=1:num_states
   s = dec2bin(i-1, K-1);
   for j=1:K-1
      states(i,j) = str2double(s(j)); 
   end
end

%% Create a table of the output bits at each state transition
% The row represents the current state
% The column represenst the input bit
% output(row, col, :) is the the set of output bits for that transition
outputs = zeros(num_states, 2, n);
for state_idx = 1:num_states    % For every state
    state = states(state_idx, :);
    for next_bit = 0:1          % For every possible input bit
        for i=1:n               % Determine each of the output bits
            outputs(state_idx, next_bit+1, i) = mod(sum(generators(:,i)'.*[fliplr(state) next_bit]),2);
        end
    end
end
end
