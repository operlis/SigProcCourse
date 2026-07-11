% recordPhrase.m - Records "OneOneOneTwoThree" and saves to WAV

nDurationSec  = 5;
nSampleRateHz = 44100;
sFileName     = 'OneOneOneTwoThree.wav';

audioData = recordMonoAudio(nDurationSec, nSampleRateHz);
saveAudioToWav(audioData, nSampleRateHz, sFileName);


%%

pause();
% normalizeAudio.m - Creates normalized WAV file using FACTOR

[audioData, nSampleRateHz] = audioread('OneOneOneTwoThree.wav', 'native');

nFactor           = calcNormFactor(audioData);
audioDataNorm     = int16(double(audioData) * nFactor);

saveAudioToWav(audioDataNorm,    nSampleRateHz, 'OneOneOneTwoThree_norm.wav');


% Task 01.03.6
audioDataDistort  = int16(double(audioData) * 2 * nFactor);   
saveAudioToWav(audioDataDistort, nSampleRateHz, 'OneOneOneTwoThree_clipped.wav');