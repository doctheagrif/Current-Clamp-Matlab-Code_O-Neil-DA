function [eStack] = loadEphys()

%Team DRG MBL 2021 Kaylee Wells Darik ONeil

eStack = struct();
[d,h,si] = abfload(uigetfile('*.abf'));
eStack.d=d;
eStack.h=h;
eStack.si=si;
eStack.numSweep = size(d,3);


end