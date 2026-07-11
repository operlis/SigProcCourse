% testSpeechSpectrogram_02_02_2.m
% TO DO 02.02.2
% Plot spectrogram using a speech signal recorded from a microphone

clear;
close all;
clc;

% =========================================================================
% Load recorded speech signal
% Replace file name with your actual WAV file name
% =========================================================================
[speechSignal, nSampleRateHz] = audioread('OneOneTwoThree.wav');

% =========================================================================
% Normalize signal for processing
% =========================================================================
speechSignal = speechSignal ./ max(abs(speechSignal));

% =========================================================================
% Remove leading and trailing silence
% Threshold can be adjusted if needed
% =========================================================================
silenceThreshold = 0.02;
activeIndices = find(abs(speechSignal) > silenceThreshold);

if ~isempty(activeIndices)
    startIndex = activeIndices(1);
    endIndex   = activeIndices(end);
    speechSignal = speechSignal(startIndex:endIndex);
end

% Time axis after trimming
vTimeSec = (0:length(speechSignal)-1) / nSampleRateHz;

% =========================================================================
% Spectrogram parameters for speech
% Window length is chosen to balance time and frequency resolution
% =========================================================================

nWindowSamples  = 2048;
nOverlapSamples = 1800;
nFFTSamples     = 4096;

% =========================================================================
% Plot waveform and spectrogram in one figure
% =========================================================================
figure;

subplot(2,1,1);
plot(vTimeSec, speechSignal, 'b');
grid on;
xlabel('Time [sec]');
ylabel('Normalized Amplitude');
title('Recorded Speech Signal - "אחת אחת שתיים שלוש"');
xlim([0 vTimeSec(end)]);

subplot(2,1,2);
spectrogram(speechSignal, hann(nWindowSamples), nOverlapSamples, nFFTSamples, nSampleRateHz, 'yaxis');
ylim([0 4]);
xlabel('Time [sec]');
ylabel('Frequency [kHz]');
title('Speech Spectrogram');

sgtitle('Recorded Speech and Spectrogram');