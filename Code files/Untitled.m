STACKS = struct();
STACKS.ALL = cell(1,10);

STACKS.ALL{1}=wONE;
STACKS.ALL{2}=wTWO;
STACKS.ALL{3}=wTHREE;
STACKS.ALL{4}=wFOUR;
STACKS.ALL{5}=wFIVE;
STACKS.ALL{6}=wSIX;
STACKS.ALL{7}=wSEVEN;
STACKS.ALL{8}=wEIGHT;
STACKS.ALL{9}=wNINE;
STACKS.ALL{10}=wTEN;


rheoThreshold=[];
rheoAmplitude=[];
%rheoFWHM=[];
maxFiringRate=[];

for a=1:size(STACKS.ALL,2)
    rheoThreshold =[rheoThreshold STACKS.ALL{a}.Conditions{2,3}.rheoThreshold];
    rheoAmplitude = [rheoAmplitude STACKS.ALL{a}.Conditions{2,3}.rheoAmplitude];
    maxFiringRate = [maxFiringRate max(cell2mat(STACKS.ALL{a}.Conditions{2,3}.firingRate))];
end

rheoIdx = [];
for a=1:size(STACKS.ALL,2)
    rheoIdx = [rheoIdx STACKS.ALL{a}.Conditions{2,1}.rheoIdx];
end


RheoForm = nan(1600,size(STACKS.ALL,2));
for a=1:size(STACKS.ALL,2)
    RheoForm(:,a)=STACKS.ALL{a}.Conditions{2,1}.unprunedData(:,1,[rheoIdx(a)]);
end


RheoForm = nan(1600,size(STACKS.ALL,2));
for a=1:size(STACKS.ALL,2)
    RheoForm(:,a)=STACKS.ALL{a}.Conditions{2,1}.unprunedData(:,1,[rheoIdx(a)]);
end

RheoF=RheoForm;
for i = 2:10
RheoF(:,i)=RheoF(:,i)+(50*(i-1));
end