% compareNCC_04_01_3.m
% TO DO 04.01.3
% Compare manual NCC and MATLAB normxcorr2 results
% Display both NCC curves in subplots for visual comparison

clear; close all; clc;

% =========================================================================
% Load saved NCC results
% =========================================================================

load('NCC_manual_04_01.mat');
vNCC_manual        = vNCC;
vLagTimeManualSec  = vLagTimeSec;
nBestManual        = nBestNCC;
nIdxManual         = nBestIdx;
nThresholdManual   = nThreshold;

load('NCC_matlab_04_01.mat');
vNCC_matlab        = vNCC;
vLagTimeMatlabSec  = vNCCTimeSec;
nBestMatlab        = nBestNCC;
nIdxMatlab         = nBestIdx;
nThresholdMatlab   = nThreshold;

% =========================================================================
% Plot comparison
% =========================================================================

figure;

subplot(2,1,1);
plot(vLagTimeManualSec, vNCC_manual, 'b');
hold on;
yline(nThresholdManual, 'r--', 'Threshold');
plot(vLagTimeManualSec(nIdxManual), nBestManual, 'ko', 'MarkerFaceColor', 'k');
grid on;
xlabel('Lag Time [sec]');
ylabel('NCC');
title('Manual Normalized Correlation');
xlim([0, vLagTimeManualSec(end)]);

subplot(2,1,2);
plot(vLagTimeMatlabSec, vNCC_matlab, 'b');
hold on;
yline(nThresholdMatlab, 'r--', 'Threshold');
plot(vLagTimeMatlabSec(nIdxMatlab), nBestMatlab, 'ko', 'MarkerFaceColor', 'k');
grid on;
xlabel('Correlation Time [sec]');
ylabel('NCC');
title('MATLAB normxcorr2');
xlim([0, vLagTimeMatlabSec(end)]);