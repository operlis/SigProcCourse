function vSignalInt16 = MorseCode(x)
% MorseCode.m
% TO DO 02.01.5 - Create Morse code audio signal according to ITU-R M.1677 timing rules
%
% Input:
%   x  - character: 'S' or 'O'
%        'S' = ... (three dots)
%        'O' = --- (three dashes)
%
% Output:
%   vSignalInt16 - Morse code audio signal as int16 vector
%
% ITU-R M.1677 Timing Rules:
%   dot  duration  = 1 unit
%   dash duration  = 3 units
%   gap between symbols within letter = 1 unit (silence)
%   gap between letters               = 3 units (silence)
%   gap between words                 = 7 units (silence)

    % --- Internal signal parameters ---
    nSampleRateHz  = 44100;   % sample rate Hz
    nToneFreqHz    = 700;     % standard Morse practice tone Hz
    nAmplitude     = 14000;   % amplitude (int16, headroom below 32767)
    dotDurationSec = 0.1;    % dot = 80 ms -> comfortable listening speed (~15 WPM)

    % --- Morse code definitions (S and O only, per assignment) ---
    switch upper(x)
        case 'S'
            sCode = '...';   % three dots
        case 'O'
            sCode = '---';   % three dashes
        otherwise
            error('MorseCode: unsupported character ''%s''. Only S and O are supported.', x);
    end

    % --- Timing units in samples (ITU-R M.1677) ---
    nDotSamples     = round(dotDurationSec * nSampleRateHz);   % 1 unit
    nDashSamples    = 3 * nDotSamples;                         % 3 units
    nIntraLetterGap = nDotSamples;                             % 1 unit gap between symbols

    % --- Build binary on/off envelope ---
    vEnvelope = [];

    for iSymbol = 1:length(sCode)
        if sCode(iSymbol) == '.'
            vEnvelope = [vEnvelope, ones(1, nDotSamples)];
        else  % '-'
            vEnvelope = [vEnvelope, ones(1, nDashSamples)];
        end

        % Add intra-letter silence gap between symbols (not after last symbol)
        if iSymbol < length(sCode)
            vEnvelope = [vEnvelope, zeros(1, nIntraLetterGap)];
        end
    end

    % --- Time vector ---
    t = (0:length(vEnvelope)-1) / nSampleRateHz;

    % --- Generate gated sine wave ---
    vTone    = nAmplitude * sin(2 * pi * nToneFreqHz * t);
    vSignal  = vTone .* vEnvelope;

    % --- Convert to int16 ---
    vSignalInt16 = int16(vSignal);
end