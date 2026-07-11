% plotWaterfalls_02_02_3.m
% TO DO 02.02.3
% Plot 3D waterfall spectrograms for all signals from TO DO 02.01
% Same signals as plotSpectrograms_02_02_1.m — displayed as waterfall instead of imagesc

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

% =========================================================================
% FIGURE 1 - Decaying Sine waterfall
% Window and overlap kept identical to 02.02.1 for direct comparison.
% View angle [40 60]: azimuth=40 shows time evolution clearly,
% elevation=60 reveals the amplitude decay along the time axis.
% ylim [0-5000 Hz] shows full spectrum; the 1 kHz tone is clearly isolated
% as the only visible ridge in the plot.
% =========================================================================

figure;
[S, F, T] = spectrogram(vDecay, 1024, 768, 2048, nFs_decay);

waterfall(T, F, 10*log10(abs(S) + eps));
set(gca, 'XDir', 'reverse');
view(40, 60);
% colormap(parula(256));
ylim([0, 5000]);
xlabel('Time [sec]');
ylabel('Frequency [Hz]');
zlabel('Power/Frequency [dB/Hz]');
title('Waterfall - Decaying Sine  (f=1kHz, a=3)', 'FontSize', 12);
grid on;

% =========================================================================
% FIGURE 2 - AM waterfall spectrograms
% Three subplots share the same frequency axis [0-550 Hz] to show
% the carrier at 440 Hz and sidebands at 440±60 Hz in full context.
% View angle [45 40]: slightly elevated to see sideband structure clearly.
% ylim [0-550 Hz] shows full range up to carrier; sidebands at 440±60 Hz
% are visible in context of the full low-frequency region.
% =========================================================================

figure;
for i = 1:3
    subplot(1, 3, i);
    [S, F, T] = spectrogram(mAM(i,:), hann(2048), 1920, 8192, nFs_AM);
    SdB = 10*log10(abs(S) + eps); % not needed, removed dB in plot.
    A = abs(S);
    waterfall(T, F, A);
    view(-44.5,16)
    xlim([0, 0.15]);
    ylim([320, 540]);
    zlim([0, max(A(:))]);
    colormap(turbo);
    xlabel('Time [sec]');
    ylabel('Frequency [Hz]');
    zlabel('Magnitude');
    title(cTitlesAM{i}, 'FontSize', 11);
    grid on;
end
sgtitle('Waterfall Spectrograms - AM Signal  (Fc=440Hz, Fs=60Hz)', 'FontSize', 13);
%%
% =========================================================================
% FIGURE 3 - FM waterfall spectrograms
% The frequency range is focused around the carrier at 440 Hz so the
% time-varying instantaneous frequency can be seen clearly.
% As beta increases, the ridge around the carrier becomes wider and
% richer in side components, but remains centered around one carrier.
% =========================================================================
figure;
for i = 1:3
    subplot(1, 3, i);
    [S, F, T] = spectrogram(mFM(i,:), hann(4096), 4032, 8192, nFs_FM);
    A = abs(S); 
    waterfall(T, F, A);
    view(-44.5,16);
    xlim([0, 0.15]);
    ylim([200, 700]);
    zlim([0, max(A(:))]);
    colormap(turbo);
    xlabel('Time [sec]');
    ylabel('Frequency [Hz]');
    zlabel('Magnitude');
    title(cTitlesFM{i}, 'FontSize', 11);
    grid on;
end
sgtitle('Waterfall Spectrograms - FM Signal  (Fc=440Hz, Fm=60Hz)', 'FontSize', 13);
%%
% =========================================================================
% FIGURE 4 - DTMF waterfall
% The frequency range includes the full DTMF band so each digit shows
% two simultaneous tones, one from the low group and one from the high group.
% The reversed time axis helps display the digit sequence in reading order.
% =========================================================================

[vDTMF_phone, nFs_DTMF] = audioread('DTMF_0544904617.wav');
vDTMF_phone = vDTMF_phone(:,1)';
figure;
[S, F, T] = spectrogram(double(vDTMF_phone), hann(2048), 1920, 8192, nFs_DTMF);
A = abs(S);
waterfall(T, F, A);
set(gca, 'XDir', 'reverse');
view(-45, 60);
xlim([0, T(end)]);
ylim([650, 1700]);
zlim([0, max(A(:))]);
colormap(turbo);
colorbar;
xlabel('Time [sec]');
ylabel('Frequency [Hz]');
zlabel('Magnitude');
title('Waterfall - DTMF Phone Number Sequence', 'FontSize', 12);
grid on;

% =========================================================================
% FIGURE 5 - Morse Code waterfall (02.01.5)
% ylim [0-7500 Hz]: wide range to confirm the Morse tone at 700 Hz is the
% only spectral component, with no energy elsewhere in the spectrum.
% View angle [50 50]: balanced azimuth and elevation to clearly show
% both the on/off keying pattern (time axis) and the single-frequency
% ridge at 700 Hz (frequency axis).
% zlim [-40 20 dB]: limits dynamic range so the keyed tone stands out
% clearly and the gaps between dots and dashes are visible.
% =========================================================================

[vSOS, nFs_Morse] = audioread('Morse_SOS.wav');
vSOS = vSOS(:,1)';

figure;
[S, F, T] = spectrogram(vSOS, hann(512), 400, 1024, nFs_Morse);
waterfall(T, F, 10*log10(abs(S) + eps));
set(gca, 'XDir', 'reverse');
view(50, 50);
ylim([0, 7500]);
zlim([-40, 20]);
xlabel('Time [sec]');
ylabel('Frequency [Hz]');
zlabel('Power/Frequency [dB/Hz]');
title('Waterfall - Morse Code SOS', 'FontSize', 12);
grid on;