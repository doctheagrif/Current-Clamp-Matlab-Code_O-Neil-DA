function [eStack] = findSpikeThresholdBatch(eStack)
sThresh=eStack.sThresh;
cellID = eStack.cellID; %Import Cell
numConditions = size(eStack.Conditions,2); %Determine # of Plots Condition

for a = 1:numConditions %for all conditions
    tempBuffer_V=eStack.Conditions{2,a}.data(:,1,:);
    tempBuffer_dVdT = eStack.Conditions{2,a}.PhasePor; %dVdT
    tempNumSweeps = eStack.Conditions{2,a}.numSweep; %Sweeps
    
    threshBySweep = nan(1,tempNumSweeps); %Preallocate Thresholds
    threshLoc = nan(1,tempNumSweeps); %Locations to extract Values
    noSpikesIdx = ones(1,tempNumSweeps); %Index Bad Sweeps
    rheoAmps = nan(1,tempNumSweeps);
    for b = 1:tempNumSweeps
        sLoc = find(tempBuffer_dVdT(:,b)>=sThresh,1);
        if numel(sLoc)>0 & max(tempBuffer_V(:,1,b))>=0
            sVal = tempBuffer_V(sLoc,b);
            threshLoc(b)=sLoc;
            threshBySweep(b)=sVal;
            noSpikesIdx(b)=0;
            rheoAmps(b) = max(tempBuffer_V(:,b));
        else
            noSpikesIdx(b)=1;
        end
        
        
    %Export
    eStack.Conditions{2,a}.threshBySweep=threshBySweep;
    eStack.Conditions{2,a}.threshLoc = threshLoc;
    eStack.Conditions{2,a}.noSpikesIdx=noSpikesIdx;
    eStack.Conditions{2,a}.rheoAmps=rheoAmps;
    end
end

for a = 1:numConditions
    [M,I] = maxk(~(double(eStack.Conditions{2,a}.noSpikesIdx)),1);
    eStack.Conditions{2,a}.rheoIdx = I; %Find Index of First Spike
    eStack.Conditions{2,a}.rheoThreshold = eStack.Conditions{2,a}.threshBySweep(I);
    eStack.Conditions{2,a}.AvgRheo = mean(eStack.Conditions{2,a}.threshBySweep(~isnan(eStack.Conditions{2,a}.threshBySweep)));
    eStack.Conditions{2,a}.rheoAmp = eStack.Conditions{2,a}.rheoAmps(I);
end

end


        
        