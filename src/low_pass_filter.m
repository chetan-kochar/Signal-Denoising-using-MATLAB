load("sample_signal.mat");

N = length(signal_pure);

% Moving Average
filtered_MA = movmean(signal_noisy, 5);
MSE_MA = mean((filtered_MA - signal_pure).^2);

% Low-Pass Filter

cutoff_freq = 60;  % Allow frequencies up to 60 Hz

filtered_LP = lowpass(signal_noisy, cutoff_freq, fs);
MSE_LP = mean((filtered_LP - signal_pure).^2);

% Display Results
fprintf('FILTERING COMPARISON\n');
fprintf('Noisy Signal MSE:        %.4f\n', mean((signal_noisy - signal_pure).^2));
fprintf('Moving Average MSE:      %.4f\n', MSE_MA);
fprintf('Low-Pass Filter MSE:     %.4f\n', MSE_LP);
fprintf('Improvement over MA:     %.2f%%\n', (MSE_LP - MSE_MA)/MSE_MA * 100);

% code to see the improvement
SNR_noisy = 10*log10(var(signal_pure) / var(signal_noisy - signal_pure));
SNR_MA = 10*log10(var(signal_pure) / var(filtered_MA - signal_pure));
SNR_LP = 10*log10(var(signal_pure) / var(filtered_LP - signal_pure));

fprintf('\n=== SNR COMPARISON ===\n');
fprintf('Noisy Signal SNR:    %.2f dB\n', SNR_noisy);
fprintf('Moving Average SNR:  %.2f dB (Improvement: %.2f dB)\n', SNR_MA, SNR_MA - SNR_noisy);
fprintf('Low-Pass Filter SNR: %.2f dB (Improvement: %.2f dB)\n', SNR_LP, SNR_LP - SNR_noisy);

% TIME DOMAIN COMPARISON
figure();

subplot(4,1,1)
plot(t, signal_pure, 'b-', 'LineWidth', 1.5)
title('Original Clean Signal (Reference)')
ylabel('Amplitude'); grid on; xlim([0 0.5]); ylim([-3 3])

subplot(4,1,2)
plot(t, signal_noisy, 'r-', 'LineWidth', 1)
title(sprintf('Noisy Signal (MSE: %.4f)', mean((signal_noisy - signal_pure).^2)))
ylabel('Amplitude'); grid on; xlim([0 0.5]); ylim([-3 3])

subplot(4,1,3)
plot(t, filtered_MA, 'g-', 'LineWidth', 1.5)
hold on
plot(t, signal_pure, 'b--', 'LineWidth', 1)
hold off
title(sprintf('Moving Average (Window=5, MSE: %.4f)', MSE_MA))
ylabel('Amplitude'); grid on; xlim([0 0.5]); ylim([-3 3])
legend('Filtered', 'Clean', 'Location', 'best')

subplot(4,1,4)
plot(t, filtered_LP, 'm-', 'LineWidth', 1.5)
hold on
plot(t, signal_pure, 'b--', 'LineWidth', 1)
hold off
title(sprintf('Low-Pass Filter (Cutoff=60Hz, MSE: %.4f)', MSE_LP))
xlabel('Time (s)'); ylabel('Amplitude'); grid on; xlim([0 0.5]); ylim([-3 3])
legend('Filtered', 'Clean', 'Location', 'best')

% FREQUENCY DOMAIN COMPARISON
y_pure = fft(signal_pure);
y_noisy = fft(signal_noisy);
y_MA = fft(filtered_MA);
y_LP = fft(filtered_LP);

freq_bins = (0:N/2-1)*(fs/N);

mag_pure = abs(y_pure(1:N/2))/N;
mag_noisy = abs(y_noisy(1:N/2))/N;
mag_MA = abs(y_MA(1:N/2))/N;
mag_LP = abs(y_LP(1:N/2))/N;

figure();

subplot(4,1,1)
stem(freq_bins, mag_pure, 'b', 'LineWidth', 1.5)
title('Clean Signal - Frequency Spectrum')
ylabel('Magnitude'); grid on; xlim([0 80]); ylim([0 0.6])

subplot(4,1,2)
stem(freq_bins, mag_noisy, 'r', 'LineWidth', 1.5)
title('Noisy Signal - Frequency Spectrum')
ylabel('Magnitude'); grid on; xlim([0 80]); ylim([0 0.6])

subplot(4,1,3)
stem(freq_bins, mag_MA, 'g', 'LineWidth', 1.5)
hold on
stem(freq_bins, mag_pure, 'b', 'LineWidth', 0.8)
hold off
title('Moving Average - Frequency Spectrum (Notice 50Hz loss!)')
ylabel('Magnitude'); grid on; xlim([0 80]); ylim([0 0.6])
legend('Filtered', 'Original', 'Location', 'best')

subplot(4,1,4)
stem(freq_bins, mag_LP, 'm', 'LineWidth', 1.5)
hold on
stem(freq_bins, mag_pure, 'b', 'LineWidth', 0.8)
hold off
title('Low-Pass Filter - Frequency Spectrum (50Hz preserved!)')
xlabel('Frequency (Hz)'); ylabel('Magnitude'); grid on; xlim([0 80]); ylim([0 0.6])
legend('Filtered', 'Original', 'Location', 'best')