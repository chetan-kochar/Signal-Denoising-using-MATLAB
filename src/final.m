
% Final analysis comparing all denoising methods
load("sample_signal.mat");
N = length(signal_pure);

% Parameters
MA_window_size = 5;
LP_cutoff_freq = 60;

%% Filtering methods
filtered_MA = movmean(signal_noisy, MA_window_size);
filtered_LP = lowpass(signal_noisy,LP_cutoff_freq, fs);

%% Performance Metrics

% MSE
MSE_noisy = mean((signal_noisy - signal_pure).^2);
MSE_MA = mean((filtered_MA - signal_pure).^2);
MSE_LP = mean((filtered_LP - signal_pure).^2);

% SNR for each method (in dB)
SNR_noisy = 10*log10(var(signal_pure) / var(signal_noisy - signal_pure));
SNR_MA = 10*log10(var(signal_pure) / var(filtered_MA - signal_pure));
SNR_LP = 10*log10(var(signal_pure) / var(filtered_LP - signal_pure));

%% Frequency Preservation Analysis
df = fs/N;
freq_bins = (0:N/2-1)*df;

Y_pure = fft(signal_pure);
Y_noisy = fft(signal_noisy);
Y_MA = fft(filtered_MA);
Y_LP = fft(filtered_LP);

mag_pure = abs(Y_pure(1:N/2))/N;
mag_noisy = abs(Y_noisy(1:N/2))/N;
mag_MA = abs(Y_MA(1:N/2))/N;
mag_LP = abs(Y_LP(1:N/2))/N;

% Magnitudes at our signal frequencies (5, 20, 50 Hz)
[~, idx_5Hz] = min(abs(freq_bins - 5));
[~, idx_20Hz] = min(abs(freq_bins - 20));
[~, idx_50Hz] = min(abs(freq_bins - 50));

fprintf('\nFREQUENCY COMPONENT PRESERVATION:\n');
fprintf('----------------------------------\n');
fprintf('         5Hz    20Hz   50Hz\n');
fprintf('Pure:   %.3f  %.3f  %.3f\n', mag_pure(idx_5Hz), mag_pure(idx_20Hz), mag_pure(idx_50Hz));
fprintf('MA:     %.3f  %.3f  %.3f\n', mag_MA(idx_5Hz), mag_MA(idx_20Hz), mag_MA(idx_50Hz));
fprintf('LP:     %.3f  %.3f  %.3f\n', mag_LP(idx_5Hz), mag_LP(idx_20Hz), mag_LP(idx_50Hz));
fprintf('----------------------------------\n\n');
fprintf('MA Loss:  %.1f%%   %.1f%%   %.1f%%\n', ...
    (1-mag_MA(idx_5Hz)/mag_pure(idx_5Hz))*(-100), ...
    (1-mag_MA(idx_20Hz)/mag_pure(idx_20Hz))*(-100), ...
    (1-mag_MA(idx_50Hz)/mag_pure(idx_50Hz))*(-100));
fprintf('LP Loss:  %.1f%%   %.1f%%   %.1f%%\n', ...
    (1-mag_LP(idx_5Hz)/mag_pure(idx_5Hz))*(-100), ...
    (1-mag_LP(idx_20Hz)/mag_pure(idx_20Hz))*(-100), ...
    (1-mag_LP(idx_50Hz)/mag_pure(idx_50Hz))*(-100));

%% VISUALIZATION 1: Time Domain Comparison
figure('Position', [100, 100, 1400, 600]);
subplot(1,2,1)
plot(t, signal_pure, 'b-', 'LineWidth', 2, 'DisplayName', 'Clean Signal');
hold on
plot(t, signal_noisy, 'r-', 'LineWidth', 0.5, 'DisplayName', 'Noisy Signal');
hold off
xlabel('Time (s)', 'FontSize', 12);
ylabel('Amplitude', 'FontSize', 12);
title('Time Domain Comparison', 'FontSize', 14);
legend('Location', 'best', 'FontSize', 11);
grid on;
xlim([0 0.5]);
ylim([-3 3]);

subplot(1,2,2)
plot(t, signal_pure, 'b-', 'LineWidth', 2, 'DisplayName', 'Clean Signal');
hold on
plot(t, filtered_MA, 'g-.', 'LineWidth', 1.5, 'DisplayName', 'Moving Average');
plot(t, filtered_LP, 'm--', 'LineWidth', 1.5, 'DisplayName', 'Low-Pass Filter');
hold off
xlabel('Time (s)', 'FontSize', 12);
ylabel('Amplitude', 'FontSize', 12);
title('Time Domain Comparison', 'FontSize', 14);
legend('Location', 'best', 'FontSize', 11);
grid on;
xlim([0 0.5]);
ylim([-3 3]);

%% VISUALIZATION 2: Frequency Domain
figure('Position', [100, 100, 1400, 600]);
stem(freq_bins, mag_pure, 'b', 'LineWidth', 2, 'DisplayName', 'Clean Signal');
hold on
stem(freq_bins, mag_MA, 'g', 'LineWidth', 1.5, 'DisplayName', 'Moving Average');
stem(freq_bins, mag_LP, 'm', 'LineWidth', 1.5, 'DisplayName', 'Low-Pass Filter');
hold off
xlabel('Frequency (Hz)', 'FontSize', 12);
ylabel('Magnitude', 'FontSize', 12);
title('Frequency Domain Comparison', 'FontSize', 14);
legend('Location', 'best', 'FontSize', 11);
grid on;
xlim([0 60]);
ylim([0 0.6]);

%% VISUALIZATION 3: Performance Metrics Bar Chart
figure('Position', [100, 100, 1000, 500]);
subplot(1,2,1)
methods = {'Noisy', 'Mov Avg', 'Low-Pass'};
mse_values = [MSE_noisy, MSE_MA, MSE_LP];
bar(mse_values, 'FaceColor', [0.2 0.6 0.8]);
set(gca, 'XTickLabel', methods);
ylabel('MSE', 'FontSize', 12);
title('Mean Squared Error', 'FontSize', 12);
grid on;
text(1:3, mse_values, num2str(mse_values', '%.4f'), ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');

subplot(1,2,2)
snr_values = [SNR_noisy, SNR_MA, SNR_LP];
bar(snr_values, 'FaceColor', [0.8 0.4 0.2]);
set(gca, 'XTickLabel', methods);
ylabel('SNR (dB)', 'FontSize', 12);
title('Signal-to-Noise Ratio', 'FontSize', 12);
grid on;
text(1:3, snr_values, num2str(snr_values', '%.2f'), ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');