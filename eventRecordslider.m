function eventRecordslider(W, H,e,handles,j)
j
%% Parametres
nFrame = 400;
n = 10; %n results
T = 3000; %T us
deltaT = 60; %deltaT  us
t0 = e.t(j);

%Initialisation of circle fitting
Rfit = 85;
xfit = W/2;
yfit = H/2;

%Initialisation of events
j = j; %the jth event

m = zeros(H,W); %a map of events
mAfter = zeros(H,W); %a map of events after filter
% mAfterml = zeros(H,W);
jT =1;
xs = []; %coordinates(x) for circle fitting
ys = []; %coordinates(y) for circle fitting
% movDir = [0,0,0,0]; %[up left down right]
numIter = 2;
ntest = 1;
% DoE_global = 0;

%% run
   
for i= 1:10 %i ms

        s_idx = 1;
        movDir = [0,0,0,0];
        movB = zeros(H,W);
        %record event
        while((e.t(j)-t0)<=T && j<length(e.t)) %within T us
%            only store n*T us events
            if(e.t(j)-e.t(1))>=n*T
                m(e.y(jT)+1,e.x(jT)+1)=0;
                mAfter(e.y(jT)+1,e.x(jT)+1)=0;
                jT =jT+1;
            end
            
            yy = e.y(j)+1;
            xx = e.x(j)+1;
            m(yy,xx) = e.p(j); 

            % Filtering...champ markov 
            if (e.x(j)>0 && e.x(j)<(W-1) && e.y(j)>0  && e.y(j)<(H-1) )
                count = 0;
                for k = 0:2
                    for l = 0:2
                        if(m((e.y(j)+l),(e.x(j)+k))~= 0)
                            count = count+1;
                        end
                    end
                end
                
                if (count>=4||...
                        ( (m((e.y(j)+1),(e.x(j)))~= 0 && m((e.y(j)+1),(e.x(j)+2))~= 0) || (m((e.y(j)+2),(e.x(j)+1))~= 0 && m((e.y(j)),(e.x(j)+1))~= 0)...
                        ||( m((e.y(j)),(e.x(j)))~= 0 && m((e.y(j)+2),(e.x(j)+2))~= 0 )||( m((e.y(j)+2),(e.x(j)))~= 0 && m((e.y(j)),(e.x(j)+2))~= 0)))
  
                    mAfter((e.y(j)+1),(e.x(j)+1)) = e.p(j);

                end
            end          
            j = j+1;   
        end
        mAfter
        deltaR = 15;
        [xfitp,yfitp,Rfitp,epn(i)] = lassos(1, mAfter, xfit, yfit, Rfit,deltaR);
        [xfitn,yfitn,Rfitn,enn(i)] = lassos(-1,mAfter, xfit, yfit, Rfit,deltaR);
        
        set(handles.axes1,'Visible','on');
        drawdata(mAfter,W,H);
        drawcircle(Rfitp,xfitp,yfitp,epn(i),'w');
        hold on
        drawcircle(Rfitn,xfitn,yfitn,enn(i),'r');
        F = getframe;
        t0 = e.t(j-1);
end





