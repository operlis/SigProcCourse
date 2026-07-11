% createFMSignal.m
% TO DO 02.01.3 - FM Signal: Xfm(t) = Ac * cos(2*pi*Fc*t + beta*sin(2*pi*Fm*t))

% --- Signal Parameters ---
nSampleRateHz = 44100;  % Sampling rate [Hz]
nDurationSec  = 2;      % Signal duration [sec]
nFc           = 440;    % Carrier frequency [Hz] - musical note A4 (same as AM for comparison)
nFm           = 60;     % Modulating signal frequency [Hz]
nAc           = 32766;  % Carrier amplitude (= 32767-1, headroom for int16)

% --- Time vector ---
t = (0 : 1/nSampleRateHz : nDurationSec - 1/nSampleRateHz);

% --- Three modulation indices ---
% beta = 0.5 : narrow-band FM  - small frequency deviation, similar to unmodulated carrier
% beta = 2   : medium FM       - clearly audible tonal change, richer sound
% beta = 5   : wide-band FM    - large frequency deviation, many harmonics, "bright" sound
vBeta   = [0.5, 2, 5];
cTitles = {'beta = 0.5 (Narrow-band FM)', ...
           'beta = 2   (Medium FM)', ...
           'beta = 5   (Wide-band FM)'};

figure;

for i = 1:length(vBeta)
    beta = vBeta(i);

    % FM signal: Xfm(t) = Ac * cos(2*pi*Fc*t + beta*sin(2*pi*Fm*t))
    % Instantaneous frequency: fi(t) = Fc + beta*Fm*cos(2*pi*Fm*t)
    % Amplitude is CONSTANT = Ac (unlike AM where amplitude varies)
    vFm = nAc .* cos(2*pi*nFc.*t + beta.*sin(2*pi*nFm.*t));

    % Convert to int16 (no normalization needed - amplitude is already nAc)
    vFmInt16 = int16(vFm);

    % Save to WAV
    sFilename = sprintf('FM_beta%.1f.wav', beta);
    saveAudioToWav(vFmInt16, nSampleRateHz, sFilename);

    % --- Plot ---
    subplot(3, 1, i);
    plot(t, vFmInt16);
    title(cTitles{i});
    xlabel('Time [sec]');
    ylabel('Amplitude [int16]');
    grid on;
    xlim([0 0.15]); % Zoom in - at full scale FM variations are invisible
end

sgtitle('FM Signal - Fc=440Hz, Fm=60Hz');