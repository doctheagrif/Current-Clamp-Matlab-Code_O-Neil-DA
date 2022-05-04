function [eStack] = plotPhase(eStack)

cellID = eStack.cellID; %Import Cell
numConditions = size(eStack.Conditions,2); %Determine # of Plots Condition
titleStringEmpty = ['Phase Plot; Cell' ' ' cellID ' ' 'Sweep #']; %Make Reusable Title Header

for a = 1:numConditions
    %extract data for each condition
    tempBuffer_V = eStack.Conditions{2,a}.data(:,1,:); %Voltage
    tempBuffer_dVdT = eStack.Conditions{2,a}.PhasePor; %dVdT
    %tempNumSweeps = eStack.Conditions{2,a}.numSweep; %Sweeps
    tempNumFrames = eStack.Conditions{2,a}.numFrames; %Frames
    keepIdx = ~eStack.Conditions{2,a}.noSpikesIdx; %Flip No Spikes Index for Keep Index
    plotIdx = find(keepIdx==1);
    Condition = eStack.Conditions{1,a};
    
    %design subplots
    if rem(numel(plotIdx),2)==0
        numX = numel(plotIdx)/2;
        numY = 2;
    elseif rem(numel(plotIdx),3)==0 
        numX = numel(plotIdx)/3;
        numY = 3;
    elseif rem(numel(plotIdx),5)==0
        numX=numel(plotIdx)/5;
        numY = 5;
    else
        numX = numel(plotIdx);
        numY = 1;
        
    end
    
    %make a plotting index
    plotIdx = find(keepIdx==1);
    
    %make each subplot
     %make major plot
    if numel(plotIdx)>0
        figure
        for b = 1:numel(plotIdx)
            subplot(numY,numX,b)
            plot(reshape(tempBuffer_V(:,1,plotIdx(b)),tempNumFrames,1),tempBuffer_dVdT(:,plotIdx(b)));
            titleString = strcat(Condition,{' '},titleStringEmpty,num2str(plotIdx(b)));
            title(titleString);
            xlabel('mV');
            ylabel('d(mV)/d(t)');
        end
    end

end

end

