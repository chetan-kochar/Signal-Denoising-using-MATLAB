load("sample_signal.mat");

N = length(signal_pure);

Y_pure = fft(signal_pure);
magnitude_pure = abs(Y_pure(1:N/2))/N;

Y_noisy = fft(signal_noisy);
magnitude_noisy = abs(Y_noisy(1:N/2))/N;

df = fs/N; %Frequency Resolution
freq_bins = (0:N/2-1)*df;

figure;
subplot(2,2,1)
plot(t,signal_pure ,"b","LineWidth",1.5)
xlabel('time')
ylabel('Amplitude')
title('Clean Signal')
grid on
xlim([0 0.5])

subplot(2,2,2)
stem(freq_bins,magnitude_pure ,"r","LineWidth",1.5)
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title('Frequency Spectrum - Clean Signal')
grid on
xlim([0 60])

subplot(2,2,3)
plot(t,signal_noisy ,"b","LineWidth",1.5)
xlabel('time')
ylabel('Amplitude')
title('Noisy Signal')
grid on
xlim([0 0.5])

subplot(2,2,4)
stem(freq_bins,magnitude_noisy ,"r","LineWidth",1.5)
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title('Frequency Spectrum - Noisy Signal')
grid on
xlim([0 60])