% plotMessageSignal_05_01_2.m
% TO DO 05.01.2
% Human friendly graph of Message Signal (DTMF 1-2-3) in time domain
% One subplot per digit (1x3 layout) — direct comparison between digits
% Reads the WAV file already created and validated in TO DO 05.01.1

clear; close all; clc;

% =========================================================================
% Load Message Signal from saved WAV file (created in 05.01.1)
% =========================================================================
digitSequence = '123';
sFileName = sprintf('MessageSignal_DTMF_%s.wav', digitSequence);
[vMessageSignal, sampleRate] = audioread(sFileName);

% audioread returns double in [-1, 1] — scale back to int16 range
% for consistency with the original signal representation
vMessageSignal = int16(vMessageSignal * 32766);

% =========================================================================
% Timing parameters (must match generation parameters from 05.01.1)
% =========================================================================
digitDuration = 0.1;   % seconds per DTMF tone
gapDuration   = 0.1;   % seconds of silence between digits
blockDuration = digitDuration + gapDuration;

% =========================================================================
% Plot: 1x3 subplots, one digit per column
% =========================================================================
figure('Name', 'Message Signal - Per Digit View', 'NumberTitle', 'off');

for i = 1:length(digitSequence)
    subplot(1, 3, i);
    startIdx = round((i-1)*blockDuration*sampleRate) + 1;
    endIdx   = round((i-1)*blockDuration*sampleRate + digitDuration*sampleRate);
    tDigit   = (0 : endIdx-startIdx) / sampleRate;

    plot(tDigit, vMessageSignal(startIdx:endIdx));
    title(sprintf('Digit "%s"', digitSequence(i)));
    xlabel('Time [sec]');
    ylabel('Amplitude [int16]');
    ylim([-33000, 33000]);   % shared Y axis across subplots for fair comparison
    grid on;
end

sgtitle('Message Signal (DTMF 1-2-3) - Time Domain, Per-Digit View', 'FontSize', 13);