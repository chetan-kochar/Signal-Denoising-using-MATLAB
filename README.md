# Signal Denoising and Frequency Analysis using MATLAB

## Overview
This project focuses on understanding basic signal processing concepts by
working with synthetic signals in MATLAB. The aim was not just to apply
filters, but to understand *why* different filters behave differently
in both time and frequency domains.

The project starts with simple multi-frequency signals, adds noise in a
controlled manner, and then studies how various filtering techniques
affect signal quality.

## Objectives
- Understand time-domain vs frequency-domain representations
- Use FFT to analyze signal composition
- Compare different denoising techniques
- Study trade-offs between noise reduction and signal fidelity

## Signal Generation
A synthetic signal was created by combining three sinusoids:
- 5 Hz (low-frequency component)
- 20 Hz (mid-frequency component)
- 50 Hz (high-frequency component)

Gaussian white noise was added to simulate a noisy environment. Since the
exact frequencies were known beforehand, FFT analysis could be used to
directly validate the results.

## Frequency-Domain Analysis
Fast Fourier Transform (FFT) was used to:
- Identify frequency components present in the signal
- Verify signal composition
- Observe how filters modify frequency content

Key points learned:
- FFT output is complex because it encodes both magnitude and phase
- Only the first half of the FFT spectrum is required due to symmetry
- Normalization by the number of samples is required for correct amplitudes

## Filtering Techniques Studied

### 1. Moving Average Filter
A simple smoothing filter that replaces each point with the average of
its neighbors.

Observation:
- Reduced noise significantly
- Severely distorted higher-frequency components

Conclusion:
Low MSE does not guarantee good signal preservation.

### 2. Low-Pass Filter
Designed to allow frequencies below a cutoff while attenuating higher
frequencies.

Observation:
- Good balance between noise reduction and signal preservation
- High-frequency signal components were largely retained

Conclusion:
Low-pass filtering works well when signal bandwidth is known.

### 3. Notch Filter
Used to remove a very narrow frequency band centered around 50 Hz.

Observation:
- Effectively removed the targeted interference
- Minimal effect on other frequency components

Conclusion:
Notch filters are ideal when the interference frequency is known in advance.

## Performance Metrics
Filtering performance was evaluated using:
- Mean Squared Error (MSE)
- Signal-to-Noise Ratio (SNR)
- Frequency component preservation (via FFT)

This comparison highlighted that numerical metrics alone are not sufficient
and must always be validated using frequency-domain analysis.

## Tools Used
- MATLAB
- FFT
- Moving average filter
- Butterworth filters
- Notch filtering

## Key Takeaways
- Frequency-domain analysis is essential for understanding signal behavior
- No single filter works best in all scenarios
- Validation in both time and frequency domains is necessary
