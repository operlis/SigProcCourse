% plotMessageSignalWaterfall_05_01_4.m
% TO DO 05.01.4
% Human friendly waterfall graph (frequency domain) of the Message Signal
% (DTMF sequence 1-2-3). Reads the WAV file already created in 05.01.1.
% Spectrogram parameters (hann(2048), nfft=8192) reused from 05.01.3,
% where they proved to give sufficient frequency resolution to separate
% the Low/High DTMF tone groups.

clear; close all; clc;

% =========================================================================
% Load Message Signal from saved WAV file (created in 05.01.1)
% =========================================================================
digitSequence = '123';
sFileName = sprintf('MessageSignal_DTMF_%s.wav', digitSequence);
[vMessageSignal, sampleRate] = audioread(sFileName);
vMessageSignal = vMessageSignal(:,1)';

% =========================================================================
% Waterfall - frequency domain, same STFT parameters as 05.01.3
% =========================================================================
[S, F, T] = spectrogram(vMessageSignal, hann(2048), 1920, 8192, sampleRate);
A = abs(S);

figure;
waterfall(T, F, A);
set(gca, 'XDir', 'reverse');
view(-45, 60);
xlim([0, T(end)]);
ylim([600, 1700]);          % covers all standard DTMF frequencies
zlim([0, max(A(:))]);
colormap(turbo);
colorbar;
xlabel('Time [sec]');
ylabel('Frequency [Hz]');
zlabel('Magnitude');
title('Waterfall - Message Signal (DTMF Sequence: 1-2-3)', 'FontSize', 12);
grid on;