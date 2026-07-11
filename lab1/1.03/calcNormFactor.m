function nFactor = calcNormFactor(audioData)
% calcNormFactor - Calculates normalization FACTOR for 16-bit audio
%
% Parameters:
%   audioData  - int16 audio vector (from recordMonoAudio)
%
% Returns:
%   nFactor    - Multiplication factor to reach maximum volume without clipping

    nMaxValue        = 32767 - 1;
    nSignalAmplitude = findMaxAmplitude(audioData);   
    nFactor          = nMaxValue / nSignalAmplitude;

    fprintf('Signal amplitude: %d\n', round(nSignalAmplitude));
    fprintf('FACTOR = %.4f\n', nFactor);
end