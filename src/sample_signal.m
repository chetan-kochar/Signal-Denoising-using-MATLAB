fs = 250; % sampling frequency
t = 0 : 1/fs : 2; % Sampling Time - 0s->2s

f1=5; a1=1;
f2=20; a2=0.7;
f3=50;  a3=0.3;

Pn = 0.5 ;% Noise power 

comp_signal1 = a1*sin(2*pi*f1*t);
comp_signal2 = a2*sin(2*pi*f2*t);
comp_signal3 = a3*sin(2*pi*f3*t);

signal_pure = comp_signal1 + comp_signal2 + comp_signal3;

noise = Pn*randn(size(t)); %Guassian Noise

signal_noisy = signal_pure + noise;

% SNR
power_pure = var(signal_pure);
power_noise = var(noise);
SNR = 10*log10(power_pure/power_noise);
fprintf("SNR = %.4f" , SNR);

figure;
subplot(2,1,1) %Pure signal
plot(t , signal_pure , "b-" , "LineWidth",1.5);
xlabel("Time")
ylabel("Amplitude")
title("Pure Signal")
grid on
xlim([0 0.5]);
ylim([-3 3]);

subplot(2,1,2) %Pure signal
plot(t , signal_pure , "b--" , "LineWidth",1);hold on
plot(t , signal_noisy , "r-" , "LineWidth",1.2);hold off
xlabel("Time")
ylabel("Amplitude")
title("Noisy Signal")
grid on
xlim([0 0.5]);
ylim([-3 3]);

legend("Pure","Noisy");

save('sample_signal.mat', 't', 'signal_pure','signal_noisy','fs')

figure;
subplot(4,1,1)
plot(t, comp_signal1, 'b-', 'LineWidth', 1.5)
title('Component 1: 5 Hz (Amplitude = 1.0)')
ylabel('Amplitude'); grid on; xlim([0 0.5])

subplot(4,1,2)
plot(t, comp_signal2, 'r-', 'LineWidth', 1.5)
title('Component 2: 20 Hz (Amplitude = 0.7)')
ylabel('Amplitude'); grid on; xlim([0 0.5])

subplot(4,1,3)
plot(t, comp_signal3, 'g-', 'LineWidth', 1.5)
title('Component 3: 50 Hz (Amplitude = 0.3)')
ylabel('Amplitude'); grid on; xlim([0 0.5])

subplot(4,1,4)
plot(t, signal_pure, 'y-', 'LineWidth', 2)
title('Combined Signal (Superposition)')
xlabel('Time (s)'); ylabel('Amplitude'); grid on; xlim([0 0.5])
