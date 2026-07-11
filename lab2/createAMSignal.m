% createAMSignal.m
% TO DO 02.01.2 - AM Signal

% --- Signal Parameters ---
nSampleRateHz = 44100;  % Sampling rate [Hz]
nDurationSec  = 2;      % Signal duration [sec]
nFc           = 440;    % Carrier frequency [Hz] - musical note A4
nFs           = 60;     % Modulating signal frequency [Hz]
nAc           = 32766;  % Carrier amplitude (= 32767-1, headroom for int16)
nAs           = nAc;    % Modulating signal amplitude

% --- Time vector ---
t = (0 : 1/nSampleRateHz : nDurationSec - 1/nSampleRateHz);

% --- Carrier and modulating signals ---
vCarrier    = nAc .* sin(2*pi*nFc.*t);
vModulating = nAs .* sin(2*pi*nFs.*t);

% --- Three modulation factors (all <= 1 to avoid overmodulation) ---
% Condition: m * nAs <= nAc  ,  m <= 1 (since nAs = nAc)
% m=0.25: weak modulation   - envelope barely moves
% m=0.5 : medium modulation - clear effect, common in practice
% m=1.0 : full modulation   - envelope just touches zero, maximum without distortion
vM      = [0.25, 0.5, 1.0];
cTitles = {'m = 0.25 (Partial Modulation)', ...
           'm = 0.5  (Partial Modulation)', ...
           'm = 1.0  (Full Modulation - envelope touches zero)'};
figure;
for i = 1:length(vM)
    m = vM(i);

    % Xam(t) = (Ac + m * Xsignal(t)) * Xcarrier(t)
    vAm = (nAc + m .* vModulating) .* vCarrier;

    % Normalize to int16 before saving
    vAmNorm = int16(vAm ./ max(abs(vAm)) .* 32766);

    % Save to WAV
    sFilename = sprintf('AM_m%.2f.wav', m);
    saveAudioToWav(vAmNorm, nSampleRateHz, sFilename);

    % --- Plot ---
    subplot(3, 1, i);
    plot(t, double(vAmNorm));
    hold on;
    % Overlay the envelope to clearly show modulation depth
    vEnvPos = (nAc + m .* vModulating) ./ max(abs(nAc + m .* vModulating)) .* 32766;
    plot(t,  vEnvPos, 'r--', 'LineWidth', 1.5);
    plot(t, -vEnvPos, 'r--', 'LineWidth', 1.5);
    hold off;
    title(cTitles{i});
    xlabel('Time [sec]');
    ylabel('Amplitude [int16]');
    legend('AM signal', 'Envelope', 'Location', 'northeast');
    grid on;
    xlim([0 0.1]);
end

sgtitle('AM Signal - Fc=440Hz, Fs=60Hz');