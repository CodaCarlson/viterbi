GENERATORS = [[1 0 1]' [1 1 1]'];

code_rate = 1/2;
NUM_BITS = 10;

% Generate some random bits
full_bits = randn(1, NUM_BITS) > 0;
fprintf('Input Bits:\t');
disp(full_bits);

fprintf('====================================================\n')
encoded_bits = encode(full_bits, GENERATORS);
fprintf('Encoded Bits:\t');
disp(encoded_bits);

fprintf('----------------------------------------------------\n')

% Brute Force Decode
output_bits = brute_force_decode(encoded_bits, GENERATORS);
fprintf('Brute Force:\t');
disp(output_bits);

% Recursive Decode
output_bits = recursive_decode(encoded_bits, GENERATORS);
fprintf('Recursive:\t');
disp(output_bits);

% Viterbi Decode
output_bits = hard_decode(encoded_bits, GENERATORS);
fprintf('Viterbi:\t');
disp(output_bits);
fprintf('====================================================\n')

code_rate = 1/size(GENERATORS, 2);
ebn0_db = 2;
ebn0 = 10^(ebn0_db/10);
noise_variance = 1/(code_rate*2*ebn0);
noise = randn(size(encoded_bits))*sqrt(noise_variance(1));
rx_bits = convert_to_hard_bits(convert_to_soft_bits(encoded_bits) + noise);

fprintf('Encoded w/ Errs:');
disp(rx_bits);

fprintf('----------------------------------------------------\n')

% Brute Force Decode
output_bits = brute_force_decode(rx_bits, GENERATORS);
fprintf('Brute Force:\t');
disp(output_bits);

% Recursive Decode
output_bits = recursive_decode(rx_bits, GENERATORS);
fprintf('Recursive:\t');
disp(output_bits);

% Viterbi Decode
output_bits = hard_decode(rx_bits, GENERATORS);
fprintf('Viterbi:\t');
disp(output_bits);
