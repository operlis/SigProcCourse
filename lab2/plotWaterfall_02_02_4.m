% plotWaterfall_02_02_4.m
% Plot 3D waterfall spectrogram for the microphone-recorded signal
% "One One One Two Three" — same signal used in TO DO 02.02.2

clear; close all; clc;

% =========================================================================
% Load recorded signal from WAV file
% =========================================================================
[vSpeech, nFs] = audioread('OneOneTwoThree.wav');

% audioread returns double in [-1,1] — scale to int16 range for consistency
vSpeech = vSpeech * 32766;

% =========================================================================
% FIGURE 1 - Full waterfall spectrogram of the recorded signal
% Window: hann(1024) — good balance between time and frequency resolution
% for speech signals. Overlap: 896 samples (87.5%) — smooth time evolution.
% nfft: 2048 — fine enough frequency resolution to distinguish formants.
% ylim [0-4000 Hz]: covers the main speech energy band (fundamental and
% first few formants). View angle [40 55]: azimuth shows the temporal
% structure of the five spoken words clearly; elevation reveals the
% amplitude envelope of each word.
% zlim: restricted to top 60 dB to suppress noise floor and highlight
% voiced speech segments.
% =========================================================================
figure;
[S, F, T] = spectrogram(vSpeech', hann(1024), 896, 2048, nFs);
Z = 10 * log10(abs(S) + eps);
waterfall(T, F, Z);
set(gca, 'XDir', 'reverse');
view(40, 55);
ylim([0, 4000]);
zlim([max(Z(:)) - 60, max(Z(:))]);
xlabel('Time [sec]');
ylabel('Frequency [Hz]');
zlabel('Power/Frequency [dB/Hz]');
title('Waterfall - Speech Recording: "אחת אחת שתיים שלוש"', 'FontSize', 12);
grid on;