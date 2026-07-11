% testDTMF.m - Test DTMF function and save results to WAV
% Uses: DTMF.m, saveAudioToWav.m 

phoneNumber     = '0544904617';  % Ofir's phone number.
sampleRate      = 44100;
silenceDuration = 0.1;           % seconds between digits

% Silence buffer (inter-digit gap per DTMF standard)
silenceSamples = int16(zeros(round(silenceDuration * sampleRate), 1));

% --- Build full dialed signal ---
fullSignal = int16([]);
for i = 1:length(phoneNumber)
    key = phoneNumber(i);
    [sig, fs] = DTMF(key);
    fullSignal = [fullSignal; sig; silenceSamples];
end

% --- Save using existing saveToWav function ---
fileName = sprintf('DTMF_%s.wav', phoneNumber);
saveAudioToWav(fullSignal, sampleRate, fileName);

% --- Plot full signal ---
t = (0 : length(fullSignal)-1) / sampleRate;

figure('Name', sprintf('DTMF Dial: %s', phoneNumber), 'NumberTitle', 'off');

subplot(2,1,1);
plot(t, fullSignal);
title(sprintf('DTMF Signal — Full number: %s', phoneNumber));
xlabel('Time [sec]');
ylabel('Amplitude [int16]');
grid on;

% --- Zoom: show first 1 digits clearly ---
subplot(2,1,2);
duration = 0.1;
oneTone = duration;  
zoomIdx = t <= oneTone;
plot(t(zoomIdx), fullSignal(zoomIdx));
title(sprintf('Zoom — First digit "%s" (Fl + Fh visible)', phoneNumber(1)));
xlabel('Time [sec]');
ylabel('Amplitude [int16]');
grid on;