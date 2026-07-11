% validateGoertzelAmplitude_04_03_1.m
% TO DO 04.03.1
% Create sinusoidal signal at 200 Hz and evaluate its amplitude
% using the goertzel function
clear; close all; clc;
% =========================================================================
% Parameters
% =========================================================================
fHz         = 200;
A           = 300;                 % some reasonable amplitude
nNumSamples = 10000;
FsHz        = 10000;
% =========================================================================
% Create signal and evaluate amplitude by Goertzel
% =========================================================================
Sig10000 = createAdcLikeSine_04_02_1(fHz, A, nNumSamples);
A200 = evaluateAmplitudeAt200HzGoertzel_04_03_1(Sig10000);
fprintf('True Amplitude = %d, Goertzel Estimated Amplitude at 200 Hz = %.4f\n', A, A200);
% =========================================================================
% Plot spectrum around 200 Hz using goertzel over a frequency range
% (as shown in the lecture: freq_indices computed for a vector of f)
% =========================================================================
vFreqHz = 0:1000;                                  % frequency range to scan
vFreqIdx = round(vFreqHz / FsHz * nNumSamples) + 1;
Sig = double(Sig10000) - mean(double(Sig10000));
vDftData = goertzel(Sig, vFreqIdx);
% ==== rearranged to One-Sided Power Spectrum, as noted in the lecture ====
vAmp = 2 * abs(vDftData) / nNumSamples;
vPower_dB = 10*log10(vAmp.^2 + 1e-6);

figure('Name','04.03.1 Goertzel One-Sided Power Spectrum');
plot(vFreqHz, vPower_dB, 'b', 'LineWidth', 1.2);
grid on;
xlabel('Frequency [Hz]');
ylabel('Power [dB]');
title(sprintf('Goertzel-Based Power Spectrum, A200 = %.1f', A200));
xline(200, '--r', '200 Hz');