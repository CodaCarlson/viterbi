function [ soft_bits ] = convert_to_soft_bits(hard_bits)
    soft_bits = hard_bits*2 - 1;
end