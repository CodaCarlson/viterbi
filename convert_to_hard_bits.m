function [ hard_bits ] = convert_to_hard_bits(soft_bits)
    hard_bits = soft_bits > 0;
end