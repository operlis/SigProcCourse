% evaluateNoiseImmunityGoertzel_04_03_2.m
% TO DO 04.03.2
% Add noise to the Sig array. Evaluate which level of noise
% makes amplitude evaluation by using Goertzel function unreliable
clear; close all; clc;
% =========================================================================
% Parameters
% =========================================================================
fHz         = 200;
A           = 300;
nNumSamples = 10000;
FsHz        = 10000;
vSigmaNoise = [50, 100, 250,500, 4000];
nCases      = length(vSigmaNoise);
vA200Est  = zeros(1, nCases);
vSNR_dB   = zeros(1, nCases);
vErrorPct = zeros(1, nCases);
% =========================================================================
% Evaluate amplitude, SNR and error for each noise level
% =========================================================================
fprintf('%12s %18s %14s %16s\n', 'Sigma', 'Estimated A200', 'SNR [dB]', 'Error [%]');
fprintf('---------------------------------------------------------------------\n');
figure('Name','04.03.2 Goertzel Power Spectrum vs Noise Sigma');
for k = 1:nCases
    sigma = vSigmaNoise(k);
    Sig10000 = createAdcLikeSine_04_02_1(fHz, A, nNumSamples);
    vNoise = sigma * randn(1, nNumSamples);
    SigNoisy = double(Sig10000) + vNoise;
    SigNoisy = round(SigNoisy);
    SigNoisy(SigNoisy < 0)    = 0;
    SigNoisy(SigNoisy > 1023) = 1023;
    SigNoisy = uint16(SigNoisy);
    % ==== Amplitude estimation using Goertzel ====
    vA200Est(k) = evaluateAmplitudeAt200HzGoertzel_04_03_1(SigNoisy);
    % ==== SNR calculation ====
    SigClean  = double(Sig10000) - mean(double(Sig10000));
    NoiseOnly = double(SigNoisy) - double(Sig10000);
    powerSignal = mean(SigClean.^2);
    powerNoise  = mean(NoiseOnly.^2);
    if powerNoise > 0
        vSNR_dB(k) = 10*log10(powerSignal / powerNoise);
    else
        vSNR_dB(k) = Inf;
    end
    % ==== Error relative to true amplitude A ====
    vErrorPct(k) = abs(vA200Est(k) - A) / A * 100;
    fprintf('%12d %18.4f %14.2f %16.2f\n', sigma, vA200Est(k), vSNR_dB(k), vErrorPct(k));
    % ==== Goertzel-based One-Sided Power Spectrum for visualization ====
    Sig = double(SigNoisy) - mean(double(SigNoisy));
    vFreqHz  = 1:1000;
    vFreqIdx = round(vFreqHz / FsHz * nNumSamples) + 1;
    vDftData = goertzel(Sig, vFreqIdx);
    vAmp     = 2 * abs(vDftData) / nNumSamples;
    vPower_dB = 10*log10(vAmp.^2 + 1e-6);
    subplot(nCases,1,k);
    plot(vFreqHz, vPower_dB, 'b', 'LineWidth', 1.0);
    grid on;
    xlim([1 1000]);
    xlabel('Frequency [Hz]');
    ylabel('Power [dB]');
    title(sprintf('\\sigma = %d, A200 = %.1f', sigma, vA200Est(k)));
    xline(200, '--r');
end
sgtitle('Goertzel One-Sided Power Spectrum, DC bin excluded');
% =========================================================================
% Summary table
% =========================================================================
fprintf('\nSummary Table\n');
fprintf('%12s %14s %16s\n', 'Sigma', 'SNR [dB]', 'Error [%]');
fprintf('-----------------------------------------\n');
for k = 1:nCases
    fprintf('%12d %14.2f %16.2f\n', vSigmaNoise(k), vSNR_dB(k), vErrorPct(k));
end