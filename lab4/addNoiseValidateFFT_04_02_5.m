function out = addNoiseValidateFFT_04_02_5(Sig10000, vNoiseSTD)
% addNoiseValidateFFT_04_02_5
% TO DO 04.02.5
% Add noise to the Sig array and evaluate which noise level
% makes amplitude evaluation by FFT unreliable.
%
% Input:
%   Sig10000   - ADC-like signal array (uint16)
%   vNoiseSTD  - Vector of noise standard deviations
%
% Output:
%   out - Struct with fields:
%         .STD
%         .EstimatedA200
%         .SNRdB
%         .FreqAxisHz
%         .PowerSpectraDB

    FsHz = 10000;

    Sig10000 = double(Sig10000(:));
    N        = length(Sig10000);
    nCases   = length(vNoiseSTD);

    out.STD           = vNoiseSTD(:);
    out.EstimatedA200 = zeros(nCases, 1);
    out.SNRdB         = zeros(nCases, 1);
    out.FreqAxisHz    = FsHz * (0:floor(N/2)) / N;
    out.PowerSpectraDB = zeros(length(out.FreqAxisHz), nCases);

    SigClean   = Sig10000;
    SigCleanAC = SigClean - mean(SigClean);
    signalPower = mean(SigCleanAC.^2);

    for k = 1:nCases
        nStd = vNoiseSTD(k);

        noise = nStd * randn(size(SigClean));
        SigNoisy = SigClean + noise;

        SigNoisy = round(SigNoisy);
        SigNoisy(SigNoisy < 0)    = 0;
        SigNoisy(SigNoisy > 1023) = 1023;

        out.EstimatedA200(k) = evaluateAmplitudeAt200HzFFT_04_02_3(uint16(SigNoisy));

        noiseOnly = SigNoisy - SigClean;
        noisePower = mean(noiseOnly.^2);
        out.SNRdB(k) = 10 * log10(signalPower / noisePower);

        SigNoisyAC = SigNoisy - mean(SigNoisy);
        X = fft(SigNoisyAC);

        P2 = (abs(X).^2) / N;
        P1 = P2(1:floor(N/2)+1);

        if length(P1) > 2
            P1(2:end-1) = 2 * P1(2:end-1);
        end

        out.PowerSpectraDB(:, k) = 10 * log10(P1 + eps);
    end
end