% recognizeOneMatlab_04_01_2.m
% TO DO 04.01.2
% Recognize the sub-phrase "One" in the recorded phrase
% by using MATLAB function normxcorr2

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

% =========================================================================
% Calculate normalized cross-correlation by using MATLAB function
% =========================================================================

vNCC = normxcorr2(vOne, vPhrase);

[nBestNCC, nBestIdx] = max(vNCC);

% Convert correlation index to phrase start index
nStartIdx = nBestIdx - length(vOne) + 1;
nStartIdx = max(nStartIdx, 1);

nBestTimeSec = (nStartIdx - 1) / nFs_phrase;

% Threshold for possible detections
nThreshold = 0.90;
vDetectedIdx = find(vNCC >= nThreshold);
vDetectedStartIdx = vDetectedIdx - length(vOne) + 1;
vDetectedStartIdx = vDetectedStartIdx(vDetectedStartIdx >= 1);
vDetectedTimeSec  = (vDetectedStartIdx - 1) / nFs_phrase;

fprintf('Best match index      : %d samples\n', nStartIdx);
fprintf('Best match time       : %.4f sec\n', nBestTimeSec);
fprintf('Maximum NCC value     : %.5f\n', nBestNCC);
fprintf('Number of NCC values above threshold %.2f : %d\n', nThreshold, length(vDetectedStartIdx));

% =========================================================================
% Plot recorded phrase and NCC result
% =========================================================================

figure;

subplot(2,1,1);
vPhraseTimeSec = (0:length(vPhrase)-1) / nFs_phrase;
plot(vPhraseTimeSec, vPhrase);
grid on;
xlabel('Time [sec]');
ylabel('Amplitude [int16]');
title('Recorded Phrase - OneTwo.wav');

subplot(2,1,2);
vNCCTimeSec = (0:length(vNCC)-1) / nFs_phrase;
plot(vNCCTimeSec, vNCC, 'b');
hold on;
yline(nThreshold, 'r--', 'Threshold');
plot((nBestIdx-1)/nFs_phrase, nBestNCC, 'ko', 'MarkerFaceColor', 'k');
grid on;
xlabel('Correlation Time [sec]');
ylabel('NCC');
title('MATLAB normxcorr2 - Detection of "One"');

% =========================================================================
% Save results for comparison script
% =========================================================================

save('NCC_matlab_04_01.mat', ...
     'vNCC', ...
     'vNCCTimeSec', ...
     'nBestNCC', ...
     'nBestIdx', ...
     'nThreshold', ...
     'nFs_phrase');