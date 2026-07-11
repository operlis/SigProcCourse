% validateAmplitudeAt200HzFFT_04_02_4.m
% TO DO 04.02.4
% Validate that the FFT function works as expected
% Use at least 3 amplitudes of the sinusoidal signal

clear; close all; clc;

% =========================================================================
% Parameters
% =========================================================================
fHz         = 200;
nNumSamples = 10000;                  
vAmplitude  = [100, 300, 500, 600];

nCases = length(vAmplitude);
vA200  = zeros(1, nCases);

FsHz     = 10000;
vTimeSec = (0:nNumSamples-1) / FsHz;

% =========================================================================
% Evaluate amplitude at 200 Hz for several test cases
% =========================================================================
fprintf('Validation of FFT-based amplitude estimation at 200 Hz\n');
fprintf('------------------------------------------------------\n');
fprintf('%10s %18s\n', 'Input A', 'Estimated A at 200 Hz');
fprintf('------------------------------------------------------\n');

for k = 1:nCases
    A = vAmplitude(k);

    Sig10000 = createAdcLikeSine_04_02_1(fHz, A, nNumSamples);
    vA200(k) = evaluateAmplitudeAt200HzFFT_04_02_3(Sig10000);

    fprintf('%10d %18.4f\n', A, vA200(k));
end

fprintf('------------------------------------------------------\n');

% =========================================================================
% Plot comparison: input amplitude vs estimated amplitude
% =========================================================================
figure('Name','FFT Amplitude Validation at 200 Hz');

subplot(2,1,1);
plot(vAmplitude, vA200, 'bo-', 'LineWidth', 1.5, 'MarkerSize', 8);
grid on;
xlabel('Input Amplitude A');
ylabel('Estimated Amplitude at 200 Hz');
title('FFT-Based Estimated Amplitude at 200 Hz');

subplot(2,1,2);
plot(vAmplitude, vAmplitude, 'k--', 'LineWidth', 1.2); hold on;
plot(vAmplitude, vA200, 'ro-', 'LineWidth', 1.5, 'MarkerSize', 8);
grid on;
xlabel('Input Amplitude A');
ylabel('Amplitude');
legend('Ideal: Estimated = Input', 'Measured by FFT', 'Location', 'NorthWest');
title('Comparison Between Ideal and FFT-Based Amplitude');

% =========================================================================
% Plot one-sided amplitude spectrum for all amplitudes
% =========================================================================
figure('Name','One-Sided Amplitude Spectrum at 200 Hz');

for k = 1:nCases
    A = vAmplitude(k);

    Sig10000 = createAdcLikeSine_04_02_1(fHz, A, nNumSamples);

    Sig = double(Sig10000);
    Sig = Sig - mean(Sig);

    X  = fft(Sig);
    P2 = abs(X) / nNumSamples;

    P1 = P2(1:floor(nNumSamples/2)+1);
    if length(P1) > 2
        P1(2:end-1) = 2 * P1(2:end-1);
    end

    fAxisHz = FsHz * (0:floor(nNumSamples/2)) / nNumSamples;

    subplot(4,1,k);
    plot(fAxisHz, P1, 'b', 'LineWidth', 1.2);
    grid on;
    xlim([0 1000]);
    xlabel('Frequency [Hz]');
    ylabel('Amplitude');
    title(sprintf('One-Sided Amplitude Spectrum: f = %d Hz, A = %d', fHz, A));
    xline(200, '--r', '200 Hz', 'LineWidth', 1.0);
end

sgtitle('One-Sided Amplitude Spectrum for Different Input Amplitudes');