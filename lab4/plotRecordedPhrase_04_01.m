% plotRecordedPhrase_04_01.m
% TO DO 04.01
% Plot recorded phrase "One Two" signal versus time
% Used for manual selection of the first "One" fragment

clear; close all; clc;

% =========================================================================
% Load recorded phrase
% =========================================================================

[audioData, nSampleRateHz] = audioread('OneTwo.wav', 'native');

% If stereo was accidentally recorded, keep only first channel
if size(audioData, 2) > 1
    audioData = audioData(:,1);
end

nSamples = length(audioData);
vTimeSec = (0:nSamples-1) / nSampleRateHz;

% =========================================================================
% Plot full signal and zoomed view
% =========================================================================

figure;

subplot(2,1,1);
plot(vTimeSec, audioData);
title('Recorded Phrase - Full Signal');
xlabel('Time [sec]');
ylabel('Amplitude [int16]');
grid on;
xlim([0, vTimeSec(end)]);

subplot(2,1,2);
plot(vTimeSec, audioData);
title('Recorded Phrase - Zoom for Manual Fragment Selection');
xlabel('Time [sec]');
ylabel('Amplitude [int16]');
grid on;
xlim([0, min(3, vTimeSec(end))]);