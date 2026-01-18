# Signal-Denoising-using-MATLAB
Signal Denoising and Frequency Analysis using MATLAB  Scope:  Synthetic signal generation (5, 20, 50 Hz) | FFT interpretation | Moving average vs LPF vs notch | MSE vs SNR tradeoff
## Overview
This project explores fundamental signal processing techniques using MATLAB.
The goal was to understand how noise affects signals in both time and frequency
domains, and how different filtering techniques behave in practice.

I started with synthetic signals so that the exact frequency components were
known in advance, which made it easier to validate the results using FFT.

## What This Project Covers
- Generation of multi-frequency test signals
- FFT-based frequency analysis
- Comparison of moving average, low-pass, and notch filters
- Evaluation using MSE and SNR
- Understanding trade-offs between noise removal and signal fidelity

## Key Observations
- Lowest MSE does not always mean best filtering
- Moving average filtering can heavily distort frequency components
- Frequency-domain analysis is essential for validating filter behavior

## Tools Used
- MATLAB
- FFT
- Butterworth and notch filters
