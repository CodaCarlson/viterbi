CS5114 Viterbi Project
======================
In the Summer of 2014 I took CS5114, Theory of Algorithms, at VT.  Our first
project was to analyze a Dynamic Programming algorithm, and I chose to look at the 
Viterbi algorithm for decoding Convolutional Codes.  This repository includes
the results of that project.

Contents
--------
This repository contains several MATLAB functions and a couple of scripts.
The scripts can be used to easily test the functionality of the various
convolutional decoder algorithms.

The first script, simple_test, will simply generate a random sequence of bits,
then use each of the decoders to decode it, and print out the result.  Every
decoder should output the original Input Bit sequence, without any errors.

Then the script will add a few random bit errors to the encoded bits to simulate
a lossy transmission, and attempt the decode again.  This time the decoders
should succeed by outputting the original bits without any errors, but every
once in a while they will fail

The second script, timing_test, will run the decoders on different lengths of
bits to measure their runtime, and then plot the results.  This serves to verify
my estimates of runtimes from the paper.

The repository also contains the paper and presentation that I made.
