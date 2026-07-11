clear; close all; clc;

% =========================================================================
% Load signals from saved WAV files
% =========================================================================

[vDecay,    nFs_decay] = audioread('decayingSine.wav');
[vAM_025,   nFs_AM]    = audioread('AM_m0.25.wav');
[vAM_050,   ~]         = audioread('AM_m0.50.wav');
[vAM_100,   ~]         = audioread('AM_m1.00.wav');
[vFM_05,    nFs_FM]    = audioread('FM_beta0.5.wav');
[vFM_2,     ~]         = audioread('FM_beta2.0.wav');
[vFM_5,     ~]         = audioread('FM_beta5.0.wav');

% audioread returns double in [-1, 1] — scale to int16 range for consistency
vDecay   = vDecay   * 32766;
vAM_025  = vAM_025  * 32766;
vAM_050  = vAM_050  * 32766;
vAM_100  = vAM_100  * 32766;
vFM_05   = vFM_05   * 32766;
vFM_2    = vFM_2    * 32766;
vFM_5    = vFM_5    * 32766;

% Collect AM and FM into arrays for loop plotting
mAM = [vAM_025'; vAM_050'; vAM_100'];
mFM = [vFM_05';  vFM_2';   vFM_5' ];

cTitlesAM = {'AM  m=0.25 (Partial Modulation)', ...
             'AM  m=0.50 (Partial Modulation)', ...
             'AM  m=1.00 (Full Modulation)'};
cTitlesFM = {'FM  \beta=0.5 (Narrow-band)', ...
             'FM  \beta=2   (Medium)', ...
             'FM  \beta=5   (Wide-band)'};

nFc = 440; % carrier frequency - for yline marker on AM plots

% =========================================================================
% FIGURE 1 - Decaying Sine spectrogram
% =========================================================================
figure;
[S, F, T, P] = spectrogram(vDecay, 1024, 768, 2048, nFs_decay, 'yaxis');
imagesc(T, F, 10*log10(abs(P)));
axis xy;
colormap('parula');
colorbar;
ylim([800, 1200]);
xlabel('Time [sec]');
ylabel('Frequency [Hz]');
title('Spectrogram - Decaying Sine  (f=1kHz, a=3)', 'FontSize', 12);

% =========================================================================
% FIGURE 2 - AM spectrograms
% =========================================================================
figure;
for i = 1:3
    subplot(3,1,i);
    [S, F, T, P] = spectrogram(mAM(i,:), hann(4096), 3072, 8192, nFs_AM, 'yaxis');
    imagesc(T, F, 10*log10(abs(P)));
    axis xy;
    colormap('parula');
    colorbar;
    ylim([300, 550]);
    yline(nFc, 'w--', 'LineWidth', 1.5);
    xlabel('Time [sec]');
    ylabel('Frequency [Hz]');
    title(cTitlesAM{i}, 'FontSize', 11);
end
sgtitle('Spectrograms - AM Signal  (Fc=440Hz, Fs=60Hz)', 'FontSize', 13);

% =========================================================================
% FIGURE 3 - FM spectrograms
% =========================================================================
figure;
for i = 1:3
    subplot(3,1,i);
    [S, F, T, P] = spectrogram(mFM(i,:), 2048, 1536, 4096, nFs_FM, 'yaxis');
    imagesc(T, F, 10*log10(abs(P)));
    axis xy;
    colormap('parula');
    colorbar;
    ylim([0, 1500]);
    xlabel('Time [sec]');
    ylabel('Frequency [Hz]');
    title(cTitlesFM{i}, 'FontSize', 11);
end
sgtitle('Spectrograms - FM Signal  (Fc=440Hz, Fm=60Hz)', 'FontSize', 13);


% =========================================================================
% FIGURE 4 - DTMF spectrogram (02.01.4)
% Full phone-number sequence generated according to fixed DTMF timing
% =========================================================================

% --- Load DTMF WAV file containing the full phone number ---
[vDTMF_phone, nFs_DTMF] = audioread('DTMF_0544904617.wav');
vDTMF_phone = vDTMF_phone(:,1)';

figure;
[S, F, T, P] = spectrogram(vDTMF_phone, hann(512), 400, 1024, nFs_DTMF, 'yaxis');
imagesc(T, F, 10*log10(abs(P)));
axis xy;
colormap('parula');
colorbar;
ylim([600, 1700]);   % covers all standard DTMF frequencies
xlabel('Time [sec]');
ylabel('Frequency [Hz]');
title('Spectrogram - DTMF Phone Number Sequence', 'FontSize', 12);

% =========================================================================
% FIGURE 5 - Morse Code spectrogram (02.01.5)
% Use SOS signal to show on-off keyed single-tone structure
% =========================================================================

% --- Load Morse WAV file ---
[vSOS, nFs_Morse] = audioread('Morse_SOS.wav');
vSOS = vSOS(:,1)';

figure;
[S, F, T, P] = spectrogram(vSOS, hann(512), 400, 1024, nFs_Morse, 'yaxis');
imagesc(T, F, 10*log10(abs(P)));
axis xy;
colormap('parula');
colorbar;
ylim([500, 900]);    % focuses on the Morse tone region around 700 Hz
xlabel('Time [sec]');
ylabel('Frequency [Hz]');
title('Spectrogram - Morse Code SOS', 'FontSize', 12);