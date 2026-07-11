function saveAudioToWav(audioData, nSampleRateHz, sFileName)
% saveAudioToWav - Saves 16-bit INTEGER audio array to WAV file
%
% Parameters:
%   audioData      - int16 audio vector (from RecordMonoAudio)
%   nSampleRateHz  - Sample rate [Hz]
%   sFileName      - Output filename, e.g. 'OneOneOneTwoThree.wav'

    audiowrite(sFileName, audioData, nSampleRateHz);
    fprintf('Saved: %s\n', sFileName);
end
