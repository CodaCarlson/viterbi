function [ input_for_next_state, next_state ] = get_input_for_next_state( K )
num_states = 2^(K-1);

%% Create a table of the next state
% The row represents the current state
% The column represents the input bit
% next_state(row, col) is the state that we will be in after that state
next_state = zeros(num_states, 2);
for state=0:num_states-1
    for next_bit=0:1
        next_state(state+1, next_bit+1) = bitxor(bitshift(state,-1), bitshift(next_bit, K-2));
    end
end

%% Create a table of the inputs required to get to each state
% row = current state
% col = next state
% input_for_next_state(row, col) = bit that causes this transition
input_for_next_state = -1*ones(num_states, num_states);
for state=1:num_states
    for next_bit=0:1
        input_for_next_state(state, next_state(state, next_bit+1)+1) = next_bit;
    end
end
end
