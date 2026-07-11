% plotAmplitudeComparison.m

[audioOrig,   nSampleRate] = audioread('OneOneOneTwoThree.wav',         'native');
[audioNorm,   ~  ] = audioread('OneOneOneTwoThree_norm.wav',    'native');
[audioClip,   ~  ] = audioread('OneOneOneTwoThree_clipped.wav', 'native');

nSamples  = length(audioOrig);
vTimeSec  = (0 : nSamples-1) / nSampleRate;

nMaxInt16 = 32767;

figure;

subplot(3,1,1);
plot(vTimeSec, audioOrig);
yline( nMaxInt16, 'r--'); 
yline(-nMaxInt16, 'r--');
ylim([-nMaxInt16-1000, nMaxInt16+1000]);
xlim([0, 3.5]);
title('Original (quiet recording)');
xlabel('Time [sec]'); ylabel('Amplitude [int16]');
grid on;

subplot(3,1,2);
plot(vTimeSec, audioNorm);
yline( nMaxInt16, 'r--');
yline(-nMaxInt16, 'r--');
ylim([-nMaxInt16-1000, nMaxInt16+1000]);
xlim([0, 3.5]);
title('Normalized (x FACTOR)');
xlabel('Time [sec]'); ylabel('Amplitude [int16]');
grid on;

subplot(3,1,3);
plot(vTimeSec, audioClip);
yline( nMaxInt16, 'r--');
yline(-nMaxInt16, 'r--');
ylim([-nMaxInt16-1000, nMaxInt16+1000]);
xlim([0, 3.5]);
title('Clipped (x 2*FACTOR)');
xlabel('Time [sec]'); ylabel('Amplitude [int16]');
grid on;