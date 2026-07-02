% validateCreateAdcLikeSine_04_02_2.m
% TO DO 04.02.2
% Validate the sinusoidal signal creation function
% by using graphs and common sense
% Use at least 3 examples
% What will be the practical limit of frequencies from the point of EE ?

clear; close all; clc;

% =========================================================================
% Parameters
% =========================================================================
nNumSamples = 300;
vAmplitude  = [100, 300, 500, 600];

fLowHz  = 200;
fHighHz = 3000;

TsSec    = 0.0001;
vTimeSec = (0:nNumSamples-1) * TsSec;

% =========================================================================
% Figure 1 - Low frequency, different amplitudes
% =========================================================================
figure('Name','ADC-Like Sine: 200 Hz');

for k = 1:length(vAmplitude)
    A = vAmplitude(k);

    Sig10000 = createAdcLikeSine_04_02_1(fLowHz, A, nNumSamples);

    subplot(4,1,k);
    plot(vTimeSec, double(Sig10000), 'b', 'LineWidth', 1.0);
    grid on;
    xlabel('Time [sec]');
    ylabel('ADC Value');
    nSamplesPerCycle = 10000 / fLowHz;
    title(sprintf('f = %d Hz, A = %d, Samples/Cycle = %.2f', fLowHz, A, nSamplesPerCycle));
    % title(sprintf('f = %d Hz, A = %d', fLowHz, A));
    ylim([0 1023]);
end

sgtitle('Validation of ADC-Like Sinusoidal Signal at 200 Hz');

% =========================================================================
% Figure 2 - High frequency, same amplitudes
% =========================================================================
figure('Name','ADC-Like Sine: 3000 Hz');

for k = 1:length(vAmplitude)
    A = vAmplitude(k);

    Sig10000 = createAdcLikeSine_04_02_1(fHighHz, A, nNumSamples);

    subplot(4,1,k);
    plot(vTimeSec, double(Sig10000), 'r', 'LineWidth', 1.0);
    grid on;
    xlabel('Time [sec]');
    ylabel('ADC Value');
    nSamplesPerCycle = 10000 / fHighHz;
    title(sprintf('f = %d Hz, A = %d, Samples/Cycle = %.2f', fHighHz, A, nSamplesPerCycle));
    ylim([0 1023]);
end

sgtitle('Validation of ADC-Like Sinusoidal Signal at 3000 Hz');