function [A200, P200] = evaluateAmplitudeAt200HzFFT_04_02_3(Sig10000)
    FsHz = 10000;
    N    = length(Sig10000);

    Sig = double(Sig10000);
    Sig = Sig - mean(Sig);

    X = fft(Sig);

    P2 = abs(X) / N;
    P1 = P2(1:floor(N/2)+1);
    if length(P1) > 2
        P1(2:end-1) = 2 * P1(2:end-1);
    end

    fAxisHz = FsHz * (0:floor(N/2)) / N;
    [~, idx200] = min(abs(fAxisHz - 200));

    A200 = P1(idx200);        % amplitude
    P200 = A200.^2;           % power = amplitude^2, as you correctly noted
end