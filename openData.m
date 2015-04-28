function s = openData
clc;
clear;

% Load file
file = fopen('eventRecord_28_04_15_18_10_08.txt');
event = fscanf(file, '%d');

i = 1;
j = 1;
while (i<=length(event))
   if(event(i)==1)
       e.p(j) = 1;
   elseif(event(i)==0)
       e.p(j) = -1; %e is one event
   end
   e.y(j) = event(i+1); 
   e.x(j) = event(i+2);
   e.t(j) = event(i+3);
   i = i+4;
   j = j+1;
end
W = 304;
H = 240;

s = struct('e',e,'W',W,'H',H);
end