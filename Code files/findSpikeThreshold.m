function [EphysStack] = findSpikeThreshold(EphysStack,derivThresh)

d = EphysStack.d;

x = d(:,1,10);
y = [0; diff(x)];

Deltas = y-derivThresh;
Deltas(Deltas<0)=1000;
[derivVal,spikePos] = min(Deltas);

EphysStack.dVdT = y;
EphysStack.derivVal = derivVal;
EphysStack.spikePos = spikePos;

end
