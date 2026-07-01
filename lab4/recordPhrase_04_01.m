% recordPhrase_04_01.m
% TO DO 04.01
% Record the phrase:
% "One One One Two Two Two One One One"
% Store the result in the WAV file "OneTwo.wav"
% Use MONO recording

clear; close all; clc;

% =========================================================================
% Recording parameters
% =========================================================================

nDurationSec  = 8;
nSampleRateHz = 44100;
sFileName     = 'OneTwo.wav';

% =========================================================================
% Record phrase and save to WAV
% =========================================================================

disp('Please say: One One One Two Two Two One One One');
disp('Try to keep similar volume and tempo for all words.');

audioData = recordMonoAudio(nDurationSec, nSampleRateHz);
saveAudioToWav(audioData, nSampleRateHz, sFileName);