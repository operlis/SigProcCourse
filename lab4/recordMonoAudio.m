function audioData = recordMonoAudio(nDurationSec, nSampleRateHz)
% recordMonoAudio - Records mono audio from default PC microphone
%
% Parameters:
%   nDurationSec   - Recording duration [seconds]
%   nSampleRateHz  - Sample rate [Hz], e.g. 44100, 22050, 16000
%
% Returns:
%   audioData      - 16-bit INTEGER array (int16 vector)

    nBitsPerSample = 16;
    nChannels      = 1;   % mono

    recObj = audiorecorder(nSampleRateHz, nBitsPerSample, nChannels);
    
    disp('Be sure to ceonnect microphone or camera or came with microphone to PC.');
    disp('When ready, press ANY KEY and recording will be started.');
    pause();
    disp('Recording... Speak now!');
    recordblocking(recObj, nDurationSec);
    disp('Recording complete.');

    audioData = getaudiodata(recObj, 'int16');   % 16-bit integer array
end
