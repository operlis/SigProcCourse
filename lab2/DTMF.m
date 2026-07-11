function [audioSignal, sampleRate] = DTMF(n)
% DTMF(n) - Generate DTMF tone for key n
% Input:  n - character: '0'-'9', 'A'-'D', '*', '#'
% Output: audioSignal [int16 column vector], sampleRate [Hz]
% Usage:  [sig, fs] = DTMF('5');
%         sound(sig, fs)

sampleRate = 44100;        % Hz - standard audio quality
duration   = 0.1;          % seconds
nAmplitude = 32766;        % int16 max (same as previous tasks)

% DTMF frequency table: [Low group, High group]
% Low:  697, 770, 852, 941 Hz
% High: 1209, 1336, 1477, 1633 Hz
freqMap = containers.Map( ...
    {'1','2','3','A', ...
     '4','5','6','B', ...
     '7','8','9','C', ...
     '*','0','#','D'}, ...
    {[697,1209],[697,1336],[697,1477],[697,1633], ...
     [770,1209],[770,1336],[770,1477],[770,1633], ...
     [852,1209],[852,1336],[852,1477],[852,1633], ...
     [941,1209],[941,1336],[941,1477],[941,1633]} );

% Input validation
n = upper(char(n));
if ~isKey(freqMap, n)
    error('DTMF: Invalid key "%s". Valid keys: 0-9, A-D, *, #', n);
end

% Extract frequencies
freqs = freqMap(n);
Fl = freqs(1);   % Low frequency  [Hz]
Fh = freqs(2);   % High frequency [Hz]

% Time vector (column)
t = (0 : 1/sampleRate : duration - 1/sampleRate)';

% DTMF signal = sum of two equal-amplitude sinusoids
signal = sin(2*pi*Fl*t) + sin(2*pi*Fh*t);

% Normalize to ±1 then scale to int16
signal = signal / max(abs(signal));
audioSignal = int16(nAmplitude * signal);

end