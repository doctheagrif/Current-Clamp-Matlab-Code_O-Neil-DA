function [eStack] = findCurrentBySweep(eStack)

numConditions = size(eStack.Conditions,2);

for a = 1:numConditions
    eStack.Conditions{2,a}.holdingCurrent = eStack.Conditions{2,a}.meta.DACEpoch.fEpochInitLevel(1);
    startCurrent = eStack.Conditions{2,a}.meta.DACEpoch.fEpochInitLevel(2);
    deltaCurrent = eStack.Conditions{2,a}.meta.DACEpoch.fEpochLevelInc(2);
    numSweeps = eStack.Conditions{2,a}.numSweep;
    
    currentInjection = nan(1,numSweeps);
    
    for b = 1:numSweeps
        currentInjection(b)=startCurrent+(deltaCurrent*(b-1));
    end
    
    eStack.Conditions{2,a}.currentInjection = currentInjection;
    eStack.Conditions{2,a}.deltaCurrent = deltaCurrent;
end

 
    