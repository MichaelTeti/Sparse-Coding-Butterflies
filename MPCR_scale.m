function x=MPCR_scale(x)

 

 

originalMinValue = (min(min(x)));

originalMaxValue = (max(max(x)));

desiredMin = -1;

desiredMax = 1;

desiredRange = desiredMax - desiredMin;

x = desiredRange * ((x) - originalMinValue) / (originalMaxValue - originalMinValue) + desiredMin;

 

 

end
