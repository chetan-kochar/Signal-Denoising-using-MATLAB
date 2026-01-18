load("sample_signal.mat");

N = length(signal_pure);
%filtered_signal = zeros(N);


%for n = 3:N-2
    %filtered_signal(n) = mean(signal_noisy(n-2:n+2));
%end
% Handle the edges of the first and last two values
%filtered_signal(1:2) = mean(filtered_signal(3:5));
%filtered_signal(N-1:N) = mean(filtered_signal(N-4:N-2));

filtered_signal = movmean(signal_noisy ,3);

MSE_filtered = mean((filtered_signal - signal_pure).^2);
MSE_noisy = mean((signal_noisy - signal_pure).^2);
fprintf("MSE is %.4f\n",MSE_filtered)
fprintf("MSE of noisy signal %.4f",MSE_noisy)

figure(1);
subplot(3,1,1)
plot(t,signal_pure , "-b");
xlabel("Time"); ylabel("Amplitude");
title("Pure signal")
grid on;
xlim([0 0.5])

subplot(3,1,2)
plot(t,signal_noisy , "-r");
xlabel("Time"); ylabel("Amplitude");
title("Noisy signal")
grid on;
xlim([0 0.5])

subplot(3,1,3)
plot(t,filtered_signal, "-g");
xlabel("Time"); ylabel("Amplitude");
title("Filtered signal")
grid on;
xlim([0 0.5])

%Frequnecy domain analysis after filtering
Y_filtered = fft(filtered_signal);
mag_filter = (abs(Y_filtered(1:N/2)))/N;

Y_pure = fft(signal_pure);
mag_pure = (abs(Y_pure(1:N/2)))/N;

Y_noisy = fft(signal_noisy);
mag_noisy = (abs(Y_noisy(1:N/2)))/N;

freq_bins = (0:N/2-1)*(fs/N);

figure(2);
subplot(3,1,1)
stem(freq_bins, mag_pure, "-b");
xlabel("Frequency (Hz)"); ylabel("Magnitude");
title("Pure Signal")
grid on;xlim([0 60]);

subplot(3,1,2)
stem(freq_bins, mag_noisy, "-r");
xlabel("Frequency (Hz)"); ylabel("Magnitude");
title("Noisy Signal")
grid on;xlim([0 60]);

subplot(3,1,3)
stem(freq_bins, mag_filter, "-g");hold on;
stem(freq_bins, mag_pure, "b--");hold off;
xlabel("Frequency (Hz)"); ylabel("Magnitude");
title("Filtered Signal")
grid on;xlim([0 60]);
legend("Filtered" ,"Pure");