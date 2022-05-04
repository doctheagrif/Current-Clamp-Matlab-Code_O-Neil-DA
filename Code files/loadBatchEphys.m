function [eStack] = loadBatchEphys(Conditions,Animal,cellStats)

%Team DRG MBL 2021 Kaylee Wells Darik ONeil
%Generate Data Structure
eStack  = struct();
%Segregrate Conditions
eStack.Conditions = cell(2,size(Conditions,2)); %1st row Conditions second row is sub-structures
eStack.Animal = Animal;
eStack.cellStats = cellStats;

%Now We Import the Data

filePath = uigetdir(matlabroot,'Select Folder Containing Patching Files for Cell'); %Grab path
idxFiles = dir(fullfile(filePath,'*.abf')); %grabs all axon binary format files in folder

for a = 1:length(idxFiles)
  filename = idxFiles(a).name;%filename
  fullFileName = fullfile(filePath, filename); %Full path for this File
  update = ['Now reading' ' ' num2str(a) ' ' 'of' ' ' num2str(length(idxFiles))];
  fprintf(1,'\n');  fprintf(1,'\n');
  fprintf(1, update); %alert us with updates
  fprintf(1,'\n');  fprintf(1,'\n');
  fprintf(1,Conditions{1,a});
   fprintf(1,'\n');  fprintf(1,'\n');
  
  %First we label Condition
  eStack.Conditions{1,a} = Conditions{1,a};
  
  %Now Let's load into temporary buffer
  [d,si,h] = abfload(fullFileName); %adapted from Matlab
  
  %Now we store in our structure
  eStack.Conditions{2,a} = struct();
  eStack.Conditions{2,a}.data = d; %This is data in the form acquisition frame x channels x sweeps
  eStack.Conditions{2,a}.sampInter = si; %Sampling Interval
  eStack.Conditions{2,a}.meta = h; %Metadata
  eStack.Conditions{2,a}.numSweep = size(d,3); %This is # sweeps
  eStack.Conditions{2,a}.numChan = size(d,2); %This is # channels
  eStack.Conditions{2,a}.numFrames =size(d,1); %This is # frames
end

 
end