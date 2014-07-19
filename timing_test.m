GENERATORS = [[1 0 1]' [1 1 1]'];

n = 5:15;
NUM_BITS = max(n);

% Generate some random bits
full_bits = randn(1, NUM_BITS) > 0;

brute_force_time = zeros(size(n));
recursive_time  = zeros(size(n));
viterbi_time  = zeros(size(n));
for i = 1:length(n)
    fprintf('n = %d\n', n(i));
    disp('-----------');

    bits = full_bits(1:i);
    encoded_bits = encode(bits, GENERATORS);

    % Brute Force Decode
    tic;
    output_bits = brute_force_decode(encoded_bits, GENERATORS);
    brute_force_time(i) = toc;

    fprintf('Brute Force: %f s\n', brute_force_time(i));
    
    % Recursive Decode
    tic;
    output_bits = recursive_decode(encoded_bits, GENERATORS);
    recursive_time(i) = toc;

    fprintf('Recursive: %f s\n', recursive_time(i));

    % Viterbi Decode
    tic;
    output_bits = hard_decode(encoded_bits, GENERATORS);
    viterbi_time(i) = toc;

    fprintf('Viterbi: %f s\n', viterbi_time(i));
end

plot(n, viterbi_time, '-.', ...
     n, brute_force_time, 'b-o', ...
     n, recursive_time, 'r-x')
legend('Viterbi', 'Brute Force', 'Recursive');
xlabel('n');
ylabel('Runtime (s)');
