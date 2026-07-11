% createMessageSignal_05_01_1.m
% TO DO 05.01.1
% Create "Message Signal": DTMF sequence of digits 1 2 3
% (with proper timing and intervals between digits).
% Uses existing functions: DTMF.m, saveAudioToWav.m (from Lab 2)

clear; close all; clc;

% =========================================================================
% Parameters
% =========================================================================
digitSequence   = '123';
sampleRate      = 44100;      % Hz - standard audio quality
silenceDuration = 0.1;        % seconds between digits (DTMF standard gap)

% Silence buffer (inter-digit gap per DTMF standard)
silenceSamples = int16(zeros(round(silenceDuration * sampleRate), 1));

% =========================================================================
% Build full "Message Signal" (DTMF sequence 1-2-3)
% =========================================================================
vMessageSignal = int16([]);
for i = 1:length(digitSequence)
    key = digitSequence(i)
    [sig, nFs] = DTMF(key);
    vMessageSignal = [vMessageSignal; sig; silenceSamples];
end

% =========================================================================
% Save Message Signal as WAV file
% =========================================================================
sFileName = sprintf('MessageSignal_DTMF_%s.wav', digitSequence);
saveAudioToWav(vMessageSignal, sampleRate, sFileName);

% =========================================================================
% Listen to created wave file (sanity check, per TO DO instruction)
% =========================================================================
[vCheck, nFsCheck] = audioread(sFileName);
sound(vCheck, nFsCheck);
pause(length(vCheck)/nFsCheck + 0.2); % +0.2s buffer safety margin

% =========================================================================
% Quick sanity-check figure: full Message Signal (visual validation)
% (Official "human friendly" graph is produced in TO DO 05.01.2)
% =========================================================================
t = (0 : length(vMessageSignal)-1) / sampleRate;
figure('Name', 'Message Signal - Full Sequence (Sanity Check)', 'NumberTitle', 'off');
plot(t, vMessageSignal);
title(sprintf('Message Signal - DTMF Sequence: %s', digitSequence));
xlabel('Time [sec]');
ylabel('Amplitude [int16]');
grid on;
