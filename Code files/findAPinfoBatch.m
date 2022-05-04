function [eStack] = findAPinfoBatch(eStack)

numConditions = size(eStack.Conditions,2);

%First find the rheo amplitude
for a = 1:numConditions
    rheo_data = eStack.Conditions{2,a}.data(:,1,eStack.Conditions{2,a}.rheoIdx);
    numFrames=eStack.Conditions{2,a}.numFrames;
    sampInter=eStack.Conditions{2,a}.sampInter;
    %[pks,locs,w,p] = findpeaks(rheo_data,'MinPeakHeight',eStack.Conditions{2,a}.rheoThreshold);
    [pks,locs,w,p] = findpeaks(rheo_data,'MinPeakHeight',eStack.Conditions{2,a}.rheoAmp);
    
    if numel(pks)>=1
        eStack.Conditions{2,a}.rheoAmplitude = pks(1);
        eStack.Conditions{2,a}.rheoProminence=p(1);
        eStack.Conditions{2,a}.rheoFWHM = w(1)*(1/sampInter);
        eStack.Conditions{2,a}.rheoLocs = locs(1);
    else
        eStack.Conditions{2,a}.rheoAmplitude = NaN;
        eStack.Conditions{2,a}.rheoProminence = NaN;
        eStack.Conditions{2,a}.rheoFWHM = NaN;
        eStack.Conditions{2,a}.rheoLocs = NaN;
    end
    
    data = eStack.Conditions{2,a}.data;
    numSweeps = eStack.Conditions{2,a}.numSweep;
    eStack.Conditions{2,a}.numAPs = cell(1,numSweeps);
    eStack.Conditions{2,a}.ampAPs = cell(1,numSweeps);
    eStack.Conditions{2,a}.promAPs = cell(1,numSweeps);
    eStack.Conditions{2,a}.fwhmAPs = cell(1,numSweeps);
    eStack.Conditions{2,a}.locsAPs = cell(1,numSweeps);
    eStack.Conditions{2,a}.firingRate = cell(1,numSweeps);
    
    %make index
    IndexRelevant = [1:numSweeps].*(~eStack.Conditions{2,a}.noSpikesIdx);
    IndexRelevant(IndexRelevant==0)=[];
    eStack.Conditions{2,a}.IndexRelevant=IndexRelevant;
    rheoThreshold=eStack.Conditions{2,a}.rheoThreshold;
    for b = 1:numel(IndexRelevant)
        [pks,locs,w,p]=findpeaks(data(:,1,IndexRelevant(b)),'MinPeakHeight',0,'MinPeakProminence',30);
        eStack.Conditions{2,a}.ampAPs{IndexRelevant(b)}=pks;
        eStack.Conditions{2,a}.locsAPs{IndexRelevant(b)}=locs;
        eStack.Conditions{2,a}.promAPs{IndexRelevant(b)}=p;
        eStack.Conditions{2,a}.fwhmAPs{IndexRelevant(b)}=w*(1/sampInter)*1000; %milliseconds
        eStack.Conditions{2,a}.numAPs{IndexRelevant(b)} = numel(pks);
        eStack.Conditions{2,a}.firingRate{IndexRelevant(b)}=eStack.Conditions{2,a}.numAPs{IndexRelevant(b)}/((numFrames)*(1/sampInter));
    end
end
