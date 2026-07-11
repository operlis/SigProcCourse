function nMaxAmplitude = findMaxAmplitude(audioData)
% findMaxAmplitude - Finds maximum amplitude in 16-bit integer audio array
%
% Parameters:
%   audioData      - int16 audio vector (from recordMonoAudio)
%
% Returns:
%   nMaxAmplitude  - Maximum amplitude value (positive scalar)

    nMaxAmplitude = max(abs(double(audioData)));
end
