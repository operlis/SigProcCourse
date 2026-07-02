% recognizeOneManual_04_01_1.m
% TO DO 04.01.1
% Recognize the sub-phrase "One" in the recorded phrase
% by using manually written Normalized Correlation code

clear; close all; clc;

% =========================================================================
% Load recorded phrase and fragment
% =========================================================================

[vPhrase, nFs_phrase] = audioread('OneTwo.wav', 'native');
[vOne,    nFs_one   ] = audioread('One.wav',    'native');

% Keep mono only if needed
if size(vPhrase, 2) > 1
    vPhrase = vPhrase(:,1);
end

if size(vOne, 2) > 1
    vOne = vOne(:,1);
end

if nFs_phrase ~= nFs_one
    error('Sample rates of OneTwo.wav and One.wav must be equal.');
end

vPhrase = double(vPhrase(:));
vOne    = double(vOne(:));

nPhraseLength = length(vPhrase);
nOneLength    = length(vOne);
nNumLags      = nPhraseLength - nOneLength + 1;

vNCC = zeros(nNumLags, 1);

% =========================================================================
% Calculate NCC for all possible lags
% =========================================================================

for p = 1:nNumLags
    vWindow = vPhrase(p : p + nOneLength - 1);
    vNCC(p) = calcNCC_Manual_04_01(vWindow, vOne);
end

% =========================================================================
% Find best match and possible detections
% =========================================================================

[nBestNCC, nBestIdx] = max(vNCC);

nThreshold = 0.90;
vDetectedIdx = find(vNCC >= nThreshold);

fprintf('Best match index      : %d samples\\n', nBestIdx);
fprintf('Best match time       : %.4f sec\\n', (nBestIdx-1)/nFs_phrase);
fprintf('Maximum NCC value     : %.5f\\n', nBestNCC);
fprintf('Number of NCC values above threshold %.2f : %d\\n', nThreshold, length(vDetectedIdx));

% =========================================================================
% Plot NCC versus lag
% =========================================================================

vLagTimeSec = (0:nNumLags-1) / nFs_phrase;

figure;
subplot(2,1,1);
vPhraseTimeSec = (0:nPhraseLength-1) / nFs_phrase;
plot(vPhraseTimeSec, vPhrase);
grid on;
xlabel('Time [sec]');
ylabel('Amplitude [int16]');
title('Recorded Phrase - OneTwo.wav');

subplot(2,1,2);
plot(vLagTimeSec, vNCC, 'b');
hold on;
yline(nThreshold, 'r--', 'Threshold');
plot((nBestIdx-1)/nFs_phrase, nBestNCC, 'ko', 'MarkerFaceColor', 'k');
grid on;
xlabel('Lag Time [sec]');
ylabel('NCC');
title('Manual Normalized Correlation - Detection of "One"');


% =========================================================================
% Save results for comparison script
% =========================================================================

save('NCC_manual_04_01.mat', ...
     'vNCC', ...
     'vLagTimeSec', ...
     'nBestNCC', ...
     'nBestIdx', ...
     'nThreshold', ...
     'nFs_phrase');