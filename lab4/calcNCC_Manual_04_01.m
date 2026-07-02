function nNCC = calcNCC_Manual_04_01(vSigA, vSigB)
% calcNCC_Manual_04_01
% TO DO 04.01.1
% Calculate Normalized Correlation manually for two equal-length signals
% DC is removed before correlation calculation

    vSigA = double(vSigA(:));
    vSigB = double(vSigB(:));

    if length(vSigA) ~= length(vSigB)
        error('Signals must be of equal length.');
    end

    % Remove DC
    vSigA = vSigA - mean(vSigA);
    vSigB = vSigB - mean(vSigB);

    % Calculate numerator and denominator
    nNumerator   = sum(vSigA .* vSigB);
    nDenominator = sqrt(sum(vSigA.^2) * sum(vSigB.^2));

    if nDenominator == 0
        nNCC = 0;
    else
        nNCC = nNumerator / nDenominator;
    end
end