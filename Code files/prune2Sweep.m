function [eStack] = prune2Sweep(eStack)

numConditions = size(eStack.Conditions,2); %number of conditions

for a=1:numConditions %for all Conditions
    
    %Index
    numFrames=eStack.Conditions{2,a}.numFrames; %length of each run
    tempHolding = eStack.Conditions{2,a}.meta.DACEpoch.firstHolding; %holding time (frames)
    tempBaselines = eStack.Conditions{2,a}.meta.DACEpoch.lEpochInitDuration(1); %Baselines
    tempSweepLen = eStack.Conditions{2,a}.meta.DACEpoch.lEpochInitDuration(2); %Sweep Length
    EIndices = [tempHolding]; %first holding
    EIndices = [EIndices (EIndices+tempBaselines)]; %Beginning of Sweep
    EIndices = [EIndices (EIndices(2)+tempSweepLen)]; %End of Sweep
    EIndices = [EIndices (EIndices(3)+tempBaselines)]; %Plus Second Baseline
    EIndices = [EIndices (((numFrames-25)-EIndices(end))+EIndices(end))]; %Compile & extract unallocated
    
    %Prune
    eStack.Conditions{2,a}.unprunedData = eStack.Conditions{2,a}.data;
    eStack.Conditions{2,a}.FirstHolding = eStack.Conditions{2,a}.data(1:EIndices(1),:,:);
    eStack.Conditions{2,a}.Baseline_1 = eStack.Conditions{2,a}.data((EIndices(1)+1):EIndices(2),:,:);
    eStack.Conditions{2,a}.Baseline_2 = eStack.Conditions{2,a}.data((EIndices(3)+1):EIndices(4),:,:);
    eStack.Conditions{2,a}.UnAllocated = eStack.Conditions{2,a}.data((EIndices(4)+1):EIndices(5),:,:);
    eStack.Conditions{2,a}.LastHolding = eStack.Conditions{2,a}.data((EIndices(5)+1):end,:,:);
    eStack.Conditions{2,a}.data = eStack.Conditions{2,a}.data((EIndices(2)+1):EIndices(3),:,:);
   
    %Fix Frames
    eStack.Conditions{2,a}.unprunedFrames=eStack.Conditions{2,a}.numFrames;
    eStack.Conditions{2,a}.numFrames=size(eStack.Conditions{2,a}.data,1);
    eStack.Conditions{2,a}.EIndices=EIndices;
end
