function [eStack] = find_dmVdTBatch(eStack)


for a = 1:size(eStack.Conditions,2) %for all conditions
    numSweep = eStack.Conditions{2,a}.numSweep; %find sweeps
    temporaryPhasePor = zeros(size(eStack.Conditions{2,a}.data,1),numSweep); %preallocate
    tempSweepData = eStack.Conditions{2,a}.data(:,1,:); %Select Only Voltage
    for b = 1:numSweep %for all sweeps
        temporaryPhasePor(:,b)=reshape([0;diff(tempSweepData(:,1,b))],[],1);
    end
    eStack.Conditions{2,a}.PhasePor = temporaryPhasePor;
end

end

        
        