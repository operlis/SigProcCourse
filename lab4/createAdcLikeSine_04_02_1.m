function Sig10000 = createAdcLikeSine_04_02_1(fHz, A, nNumSamples)
% createAdcLikeSine_04_02_1
% TO DO 04.02.1
% Create a sinusoidal signal as if it was digitized by ADC
% using a timer operating at 0.1 ms
%
% Inputs:
%   fHz         - Signal frequency [Hz]
%   A           - Signal amplitude
%   nNumSamples - Number of samples
%
% Output:
%   Sig10000    - Unsigned integer signal in the range 0..1023

    % =========================================================================
    % Constants
    % =========================================================================
    TsSec      = 0.0001;   % 0.1 ms timer
    nAdcMin    = 0;
    nAdcMax    = 1023;
    nAdcOffset = 511.5;

    % =========================================================================
    % Time axis
    % =========================================================================
    vTimeSec = (0:nNumSamples-1) * TsSec;

    % =========================================================================
    % Create sinusoidal signal around ADC midpoint
    % =========================================================================
    vSig = A * sin(2 * pi * fHz * vTimeSec) + nAdcOffset;

    % =========================================================================
    % Clip to ADC range and convert to unsigned integer
    % =========================================================================
    vSig = round(vSig);
    vSig(vSig < nAdcMin) = nAdcMin;
    vSig(vSig > nAdcMax) = nAdcMax;

    Sig10000 = uint16(vSig);
end