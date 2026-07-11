function audioData = createDecayingSine(nFreqHz, nAmplitude, nDecayRate, nDurationSec, nSampleRateHz)
% createDecayingSine - Creates sinusoid with exponentially decaying amplitude
%
% Signal: x(t) = A * exp(-a*t) * sin(2*pi*f*t)
%
% Parameters:
%   nFreqHz        - Frequency [Hz], e.g. 1000
%   nAmplitude     - Amplitude A, e.g. 32766
%   nDecayRate     - Decay rate a [1/sec], e.g. 3
%   nDurationSec   - Signal duration [sec]
%   nSampleRateHz  - Sample rate [Hz], e.g. 44100
%
% Returns:
%   audioData      - int16 audio vector

    vTime     = (0 : 1/nSampleRateHz : nDurationSec - 1/nSampleRateHz);
    audioData = int16(nAmplitude * exp(-nDecayRate * vTime) .* sin(2*pi*nFreqHz*vTime));
end

