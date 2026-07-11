% extractOneFragment_04_01.m
% TO DO 04.01
% Manually extract the first appearance of "One" from the recorded phrase
% and store it in the WAV file "One.wav"

clear; close all; clc;

% =========================================================================
% Load the recorded phrase
% =========================================================================

[audioData, nSampleRateHz] = audioread('OneTwo.wav', 'native');

% If stereo was accidentally recorded, keep only first channel
if size(audioData, 2) > 1
    audioData = audioData(:,1);
end

nSamples  = length(audioData);
vTimeSec  = (0:nSamples-1) / nSampleRateHz;

% =========================================================================
% Plot the signal and select the first "One" manually
% =========================================================================

figure;
subplot(2,1,1);
plot(vTimeSec, audioData);
grid on;
xlabel('Time [sec]');
ylabel('Amplitude [int16]');
title('Recorded Phrase - Select the First One Fragment Manually');
xlim([0, vTimeSec(end)]);

% Manual selection by time in seconds
nStartTimeSec = 0.64;
nEndTimeSec   = 1.07;

xline(nStartTimeSec, 'r--', 'Start');
xline(nEndTimeSec,   'g--', 'End');

% =========================================================================
% Convert time to sample indices and extract the fragment
% =========================================================================

nStartIdx = max(1, floor(nStartTimeSec * nSampleRateHz) + 1);
nEndIdx   = min(nSamples, ceil(nEndTimeSec * nSampleRateHz));

audioOne = audioData(nStartIdx:nEndIdx);

% Plot extracted fragment for verification
subplot(2,1,2);
vTimeOneSec = (0:length(audioOne)-1) / nSampleRateHz;
plot(vTimeOneSec, audioOne);
grid on;
xlabel('Time [sec]');
ylabel('Amplitude [int16]');
title('Extracted First One Fragment');

% =========================================================================
% Save the fragment to WAV
% =========================================================================

saveAudioToWav(audioOne, nSampleRateHz, 'One.wav');
