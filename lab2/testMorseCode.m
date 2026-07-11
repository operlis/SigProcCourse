% testMorseCode.m
% Test script for TO DO 02.01.5 - Morse code audio signal
% Tests MorseCode(x) for x='S' and x='O', builds SOS, saves WAV files, plots graphs.
clear;
close all;
clc;

% --- Parameters (must match internals of MorseCode.m) ---
nSampleRateHz  = 44100;
dotDurationSec = 0.1;

% Inter-letter gap: 3 units of silence (ITU-R M.1677)
nLetterGapSamples = int16(zeros(1, round(3 * dotDurationSec * nSampleRateHz)));

% --- Create letter signals using MorseCode(x) ---
vSignalS = MorseCode('S');
vSignalO = MorseCode('O');

% --- Assemble SOS: S + [3-unit gap] + O + [3-unit gap] + S ---
nTrailingSilence = int16(zeros(1, round(0.3 * nSampleRateHz)));  % 300ms trailing silence
vSignalSOS = [vSignalS, nLetterGapSamples, vSignalO, nLetterGapSamples, vSignalS, nTrailingSilence];

% --- Save WAV files ---
saveAudioToWav(vSignalS,   nSampleRateHz, 'Morse_S.wav');
saveAudioToWav(vSignalO,   nSampleRateHz, 'Morse_O.wav');
saveAudioToWav(vSignalSOS, nSampleRateHz, 'Morse_SOS.wav');

% --- Time vectors ---
tS   = (0:length(vSignalS)-1)   / nSampleRateHz;
tO   = (0:length(vSignalO)-1)   / nSampleRateHz;
tSOS = (0:length(vSignalSOS)-1) / nSampleRateHz;

% =============================================================
% Figure 1: S and O - Zoom-in to clearly see sine waves
% =============================================================
figure('Name', 'Morse Code - S and O Timing Comparison', 'NumberTitle', 'off');

subplot(2,1,1);
% Show only first 0.55 sec: sees all 3 dots of S with gaps clearly
plot(tS, double(vSignalS), 'b');
grid on;
xlabel('Time [sec]');
ylabel('Amplitude [int16]');
title('Letter S in Morse Code ( . . . ) - Three Dots');
xlim([0, tS(end)]);
ylim([-16000 16000]);

subplot(2,1,2);
% Show only first 1.2 sec: sees all 3 dashes of O with gaps clearly
plot(tO, double(vSignalO), 'm');
grid on;
xlabel('Time [sec]');
ylabel('Amplitude [int16]');
title('Letter O in Morse Code ( - - - ) - Three Dashes');
xlim([0, tO(end)]);
ylim([-16000 16000]);

sgtitle('Morse Code Letters S and O - ITU-R M.1677 Timing');

% =============================================================
% Figure 2: Full SOS waveform
% =============================================================
figure('Name', 'Morse Code - SOS Full Signal', 'NumberTitle', 'off');
plot(tSOS, double(vSignalSOS), 'b');
grid on;
xlabel('Time [sec]');
ylabel('Amplitude [int16]');
title('Morse Code SOS Signal  ( . . .   - - -   . . . )');
xlim([0, tSOS(end)]);

% =============================================================
% Figure 3: Single dot zoom-in - shows actual 700Hz sine wave
% =============================================================
figure('Name', 'Morse Code - Single Dot Zoom', 'NumberTitle', 'off');

% Show exactly one dot: 100ms of signal from the very beginning
dotEndSec = dotDurationSec;   % 0.10 sec = one dot
dotIdx = tS <= dotEndSec;
plot(tS(dotIdx), double(vSignalS(dotIdx)), 'b', 'LineWidth', 1.2);
grid on;
xlabel('Time [sec]');
ylabel('Amplitude [int16]');
title(sprintf('Single Dot (100ms) - Sine Wave at %d Hz', 700));
xlim([0, dotEndSec]);
ylim([-16000 16000]);