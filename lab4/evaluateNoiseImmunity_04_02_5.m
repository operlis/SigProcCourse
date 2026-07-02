% evaluateNoiseImmunity_04_02_5.m
clear; close all; clc;
fHz         = 200;
A           = 300;
nNumSamples = 10000;
FsHz        = 10000;
vSigmaNoise = [50, 100, 250,500, 4000];%, 1000, 2000, 4000
nCases      = length(vSigmaNoise);
vA200Est = zeros(1, nCases);
vP200Est = zeros(1, nCases);
vSNR_dB   = zeros(1, nCases);
vErrorPct = zeros(1, nCases);
fprintf('%12s %18s %18s %14s %16s\n', 'Sigma', 'Estimated A200', 'Estimated P200', 'SNR [dB]', 'Error [%]');
fprintf('---------------------------------------------------------------------------\n');
figure('Name','04.02.5 Power Spectrum vs Noise Sigma');
for k = 1:nCases
    sigma = vSigmaNoise(k);
    Sig10000 = createAdcLikeSine_04_02_1(fHz, A, nNumSamples);
    vNoise = sigma * randn(1, nNumSamples);
    SigNoisy = double(Sig10000) + vNoise;
    SigNoisy = round(SigNoisy);
    SigNoisy(SigNoisy < 0)    = 0;
    SigNoisy(SigNoisy > 1023) = 1023;
    SigNoisy = uint16(SigNoisy);
    [vA200Est(k), vP200Est(k)] = evaluateAmplitudeAt200HzFFT_04_02_3(SigNoisy);

    % ==== SNR calculation ====
    SigClean = double(Sig10000) - mean(double(Sig10000));
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

    fprintf('%12d %18.4f %18.4f %14.2f %16.2f\n', ...
        sigma, vA200Est(k), vP200Est(k), vSNR_dB(k), vErrorPct(k));

    Sig = double(SigNoisy);
    Sig = Sig - mean(Sig);
    X  = fft(Sig);
    P2 = abs(X) / nNumSamples;
    P1 = P2(1:floor(nNumSamples/2)+1);
    P1(2:end-1) = 2 * P1(2:end-1);
    Power1_dB = 10*log10(P1.^2 + 1e-6);
    fAxisHz = FsHz * (0:floor(nNumSamples/2)) / nNumSamples;
    % ==== KEY FIX: drop the DC bin (index 1) entirely from the plot ====
    fAxisHz_noDC   = fAxisHz(2:end);
    Power1_dB_noDC = Power1_dB(2:end);
    subplot(nCases,1,k);
    plot(fAxisHz_noDC, Power1_dB_noDC, 'b', 'LineWidth', 1.0);
    grid on;
    xlim([1 1000]);          % start from 1 Hz, not 0
    xlabel('Frequency [Hz]');
    ylabel('Power [dB]');
    title(sprintf('\\sigma = %d, A200 = %.1f', sigma, vA200Est(k)));
    xline(200, '--r');
end
sgtitle('One-Sided Power Spectrum (dB), DC bin excluded');

% ==== Summary table ====
fprintf('\nSummary Table\n');
fprintf('%12s %14s %16s\n', 'Sigma', 'SNR [dB]', 'Error [%]');
fprintf('-----------------------------------------\n');
for k = 1:nCases
    fprintf('%12d %14.2f %16.2f\n', vSigmaNoise(k), vSNR_dB(k), vErrorPct(k));
end