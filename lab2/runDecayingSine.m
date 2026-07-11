% createDecayingSine.m - Creates, plays and plots decaying sine signal
% TO DO 02.01.1 - Sinusoid with Exponential Decay: x(t) = A * exp(-a*t) * sin(2*pi*f*t)
% Creates, plays and plots decaying sine signal


% --- Signal Parameters ---
nSampleRateHz = 44100;
nFreqHz       = 1000;% f
nAmplitude    = 32766; % A
nDecayRate    = 3; % a
nDurationSec  = 2;

% createDecayingSine returns int16 array: A * exp(-a*t) * sin(2*pi*f*t)
audioData = createDecayingSine(nFreqHz, nAmplitude, nDecayRate, nDurationSec, nSampleRateHz);

% Save to WAV file for external playback and verification
saveAudioToWav(audioData, nSampleRateHz, 'decayingSine.wav');

% --- Build time axis for plotting ---
vTime = (0 : length(audioData)-1) / nSampleRateHz;

% --- Plot the signal ---
figure;
plot(vTime, audioData);
title('Sinusoid with Exponential Decay - f = 1kHz, a=3');
xlabel('Time [sec]');
ylabel('Amplitude [int16]');
grid on;

