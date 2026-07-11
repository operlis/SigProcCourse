% createAMSignal_05_01_5.m
% TO DO 05.01.5
% Create AM signal from the Message Signal (DTMF sequence 1-2-3).
% Modulation index m <= 1 to avoid over-modulation (per lecture slide 14-16).
% Reads Message Signal WAV from 05.01.1.
% Compatible with MATLAB R2020a (no "turbo" colormap, no newer syntax).

clear; close all; clc;

% =========================================================================
% Load Message Signal from saved WAV file (created in 05.01.1)
% =========================================================================
digitSequence = '123';
sFileName = sprintf('MessageSignal_DTMF_%s.wav', digitSequence);
[vMessageSignal, sampleRate] = audioread(sFileName);
vMessageSignal = vMessageSignal(:,1)';   % row vector, normalized [-1, 1]

% =========================================================================
% AM Modulation parameters
% =========================================================================
Ac = 1;          % Carrier amplitude
m  = 0.8;         % Modulation index (m <= 1 --> avoids over-modulation, see slide 14-16)
fc = 5000;        % Carrier frequency [Hz] - kept low ("unrealistic") for compact,
                  % readable graphs, same approach the lecturer used (slide 21)

t = (0 : length(vMessageSignal)-1) / sampleRate;

% Normalize message signal to [-1, 1] (already the case from audioread,
% but explicit for clarity and safety)
vMessageNorm = vMessageSignal / max(abs(vMessageSignal));

% =========================================================================
% Build AM signal:  s(t) = Ac * (1 + m*x(t)) * cos(2*pi*fc*t)
% =========================================================================
vAMSignal = Ac * (1 + m * vMessageNorm) .* cos(2*pi*fc*t);

% =========================================================================
% Save AM signal as WAV file
% =========================================================================
vAMSignal_norm = vAMSignal / max(abs(vAMSignal));   % normalize before saving
sFileNameAM = sprintf('AMSignal_DTMF_%s_m%.2f.wav', digitSequence, m);
audiowrite(sFileNameAM, vAMSignal_norm, sampleRate);

% =========================================================================
% Sanity-check figure: AM signal envelope (time domain)
% Top: full view (all 3 digits) - overview of the AM envelope over time
% Bottom: zoomed view - individual carrier cycles visible vs. envelope
% =========================================================================
figure('Name', 'AM Signal - Envelope Check', 'NumberTitle', 'off');

% --- Top: full signal ---
subplot(2,1,1);
plot(t, vAMSignal);
hold on;
plot(t, Ac*(1+m*vMessageNorm), 'r--', 'LineWidth', 1);
plot(t, -Ac*(1+m*vMessageNorm), 'r--', 'LineWidth', 1);
hold off;
title(sprintf('AM Signal (m=%.2f, Fc=%d Hz) - Full View', m, fc));
xlabel('Time [sec]');
ylabel('Amplitude');
legend('AM signal', 'Envelope (\pm)', 'Location', 'northeast');
grid on;

% --- Bottom: zoomed view ---
subplot(2,1,2);
plot(t, vAMSignal);
hold on;
plot(t, Ac*(1+m*vMessageNorm), 'r--', 'LineWidth', 1.5);
plot(t, -Ac*(1+m*vMessageNorm), 'r--', 'LineWidth', 1.5);
hold off;
title('Zoom - Individual Carrier Cycles vs. Envelope');
xlabel('Time [sec]');
ylabel('Amplitude');
legend('AM signal', 'Envelope (\pm)', 'Location', 'northeast');
grid on;
xlim([0, 0.02]);   % ~100 carrier cycles at fc=5000Hz, still readable