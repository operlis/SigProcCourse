function A200 = evaluateAmplitudeAt200HzGoertzel_04_03_1(Sig10000)
% evaluateAmplitudeAt200HzGoertzel_04_03_1
% TO DO 04.03.1
% Evaluate the amplitude of the signal at 200 Hz
% by using MATLAB goertzel function
%
% Input:
%   Sig10000 - Input ADC-like signal, unsigned integer array
%
% Output:
%   A200     - Evaluated amplitude of the signal at 200 Hz
    % =========================================================================
    % Constants
    % =========================================================================
    FsHz    = 10000;              % Sampling frequency from 0.1 ms timer
    N       = length(Sig10000);
    fTarget = 200;                 % target frequency [Hz]
    % =========================================================================
    % Convert to double and remove DC
    % =========================================================================
    Sig = double(Sig10000);
    Sig = Sig - mean(Sig);
    % =========================================================================
    % Compute the frequency index for goertzel, as shown in the lecture:
    % freq_indices = round(f/Fs*N) + 1
    % =========================================================================
    freqIndex = round(fTarget / FsHz * N) + 1;
    % =========================================================================
    % Goertzel algorithm - evaluate DFT only at the target frequency
    % =========================================================================
    dftData = goertzel(Sig, freqIndex);
    % =========================================================================
    % Convert DFT magnitude to amplitude (normalize by N, one-sided x2)
    % =========================================================================
    A200 = 2 * abs(dftData) / N;
end