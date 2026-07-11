% plotMessageSignalSpectrogram_05_01_3.m
% TO DO 05.01.3
% Human friendly spectrogram of the Message Signal (DTMF sequence 1-2-3)
% Reads the WAV file already created and validated in TO DO 05.01.1
% Spectrogram parameters reused from Lab 2 (plotSpectrograms_02_02_1.m,
% Figure 4 - DTMF phone number), since they already proved effective
% for isolating DTMF tone pairs.

clear; close all; clc;

% =========================================================================
% Load Message Signal from saved WAV file (created in 05.01.1)
% =========================================================================
digitSequence = '123';
sFileName = sprintf('MessageSignal_DTMF_%s.wav', digitSequence);
[vMessageSignal, sampleRate] = audioread(sFileName);
vMessageSignal = vMessageSignal(:,1)';   % row vector, same convention as Lab 2

% =========================================================================
% Spectrogram - parameters reused from Lab 2 DTMF spectrogram
% (hann window, overlap, nfft already proven to isolate DTMF tone pairs)
% =========================================================================
figure;

[S, F, T, P] = spectrogram(vMessageSignal, hann(2048), 1920, 8192, sampleRate, 'yaxis');

imagesc(T, F, 10*log10(abs(P)));
axis xy;
colormap('parula');
colorbar;
ylim([600, 1700]);   % covers all standard DTMF frequencies (low+high groups)
xlabel('Time [sec]');
ylabel('Frequency [Hz]');
title('Spectrogram - Message Signal (DTMF Sequence: 1-2-3)', 'FontSize', 12);