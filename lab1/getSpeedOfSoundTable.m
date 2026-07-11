function speedOfSoundTable = getSpeedOfSoundTable()
    Temp = 0:25:1000;
    SpeedOfSound = zeros(1,length(Temp));
    for index = 1:length(Temp)
        SpeedOfSound(index) = getSpeedOfSoundFromCelciusTemp(Temp(index));
    end
    speedOfSoundTable = [Temp ; SpeedOfSound];
end
