% validateNoiseEffectFFT_04_02_5.m
% TO DO 04.02.5
% Add noise to the Sig array.
% Evaluate which level of noise makes amplitude evaluation by using FFT unreliable.
% Use Power FFT Spectrum in a smart way.

clear; close all; clc;

% =========================================================================
% Parameters
% =========================================================================
fHz         = 200;
A           = 300;
nNumSamples = 10000;
vNoiseSTD   = [20, 80, 180, 350];

% =========================================================================
% Create clean signal
% =========================================================================
Sig10000 = createAdcLikeSine_04_02_1(fHz, A, nNumSamples);

% =========================================================================
% Add noise and evaluate FFT
% =========================================================================
out = addNoiseValidateFFT_04_02_5(Sig10000, vNoiseSTD);

% =========================================================================
% Print results to CMD
% =========================================================================
fprintf('\n');
fprintf('04.02.5 - FFT amplitude estimation with added Gaussian noise\n');
fprintf('========================================================================\n');
fprintf('%12s %18s %18s\n', 'Noise STD', 'SNR [dB]', 'Estimated A at 200 Hz');
fprintf('------------------------------------------------------------------------\n');

for k = 1:length(vNoiseSTD)
    fprintf('%12.2f %18.4f %18.4f\n', ...
        out.STD(k), out.SNRdB(k), out.EstimatedA200(k));
end

fprintf('========================================================================\n');

% =========================================================================
% Figure 1 - One-Sided Power Spectrum in dB
% =========================================================================
figure('Name','04.02.5 - FFT Power Spectrum');

for k = 1:length(vNoiseSTD)
    subplot(length(vNoiseSTD), 1, k);

    plot(out.FreqAxisHz, out.PowerSpectraDB(:,k), 'b', 'LineWidth', 1.0);
    grid on;
    xlim([0 1000]);

    xlabel('Frequency [Hz]');
    ylabel('Power [dB]');
    title(sprintf('STD = %.1f, Estimated A_{200} = %.2f', ...
        out.STD(k), out.EstimatedA200(k)));

    hold on;
    xline(200, '--r', '200 Hz', 'LineWidth', 1.0);
    hold off;
end

sgtitle('One-Sided Power Spectrum for Different Noise Levels');

% =========================================================================
% Figure 2 - SNR versus Noise STD
% =========================================================================
figure('Name','04.02.5 - SNR versus Noise STD');

plot(out.STD, out.SNRdB, 'mo-', 'LineWidth', 1.5, 'MarkerSize', 8);
grid on;
xlabel('Noise STD');
ylabel('SNR [dB]');
title('SNR as a Function of Noise Standard Deviation');