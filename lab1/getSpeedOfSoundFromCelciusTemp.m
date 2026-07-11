function speedOfSound = getSpeedOfSoundFromCelciusTemp(T)
%   Speed of sound in dry air as a function of temperature in Celsius
%   v = speedOfSound(T)
%   Valid only for 0 <= T <= 1000
%   Returns NaN for out-of-range input

    if T < 0 || T > 1000
        speedOfSound = NaN;
    else 
        speedOfSound = sqrt((T+273.15)*401.8);
    end
end
