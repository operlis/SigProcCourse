% plotAMSignalWaterfall_05_01_5.m
% TO DO 05.01.5 (continued)
% Human friendly waterfall graph (frequency domain) of the AM signal.
% Reads the AM WAV file created above.

clear; close all; clc;

digitSequence = '123';
m  = 0.8;
sFileNameAM = sprintf('AMSignal_DTMF_%s_m%.2f.wav', digitSequence, m);
[vAMSignal, sampleRate] = audioread(sFileNameAM);
vAMSignal = vAMSignal(:,1)';

fc = 5000;

% Same STFT parameters family as 05.01.3/05.01.4 (large window --> good
% frequency resolution), needed here to separate carrier from sidebands
[S, F, T] = spectrogram(vAMSignal, hann(2048), 1920, 8192, sampleRate);
A = abs(S);

figure;
waterfall(T, F, A);
set(gca, 'XDir', 'reverse');
view(-75,30);
xlim([0, T(end)]);
ylim([fc-2000, fc+2000]);   % zoom around the carrier to see sidebands clearly
zlim([0, max(A(:))]);
colormap(parula);           % R2020a-safe colormap (turbo not available)
colorbar;
xlabel('Time [sec]');
ylabel('Frequency [Hz]');
zlabel('Magnitude');
title(sprintf('Waterfall - AM Signal (DTMF 1-2-3, Fc=%d Hz, m=%.2f)', fc, m), 'FontSize', 12);
grid on;