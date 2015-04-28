function eventRecord(W, H,e,handles)

%% Parametres
nFrame = 10000;
n = 1; %n 
T =3300; %T us
t0 = e.t(1);

%Initialisation of circle fitting
Rfit = 84;
xfit = W/2;
yfit = H/2;
Rfitcf = 84;
xfitcf = W/2;
yfitcf = H/2;

%Initialisation of events
j = 1; %the jth event
m = zeros(H,W); %a map of events
mAfter = zeros(H,W); %a map of events after filter
% mAfterml = zeros(H,W);
jT =1;
peak_before = [xfit yfit Rfit];
%% run
% writerObj = VideoWriter('myvideo.avi');
% writerObj.FrameRate = 60;

% open(writerObj);

for frameIndex = 1:nFrame
    
    for i= 1:n %i ms

%         s_idx = 1;
        %record event
        while((e.t(j)-t0)<=T && j<length(e.t)) %within T us
            % only store n*T us events
            if(e.t(j)-e.t(1))>=33*T
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
                
                if (count>=2||...
                        ( (m((e.y(j)+1),(e.x(j)))~= 0 && m((e.y(j)+1),(e.x(j)+2))~= 0) || (m((e.y(j)+2),(e.x(j)+1))~= 0 && m((e.y(j)),(e.x(j)+1))~= 0)...
                        ||( m((e.y(j)),(e.x(j)))~= 0 && m((e.y(j)+2),(e.x(j)+2))~= 0 )||( m((e.y(j)+2),(e.x(j)))~= 0 && m((e.y(j)),(e.x(j)+2))~= 0)))
  
                    mAfter((e.y(j)+1),(e.x(j)+1)) = e.p(j);

                end
            end          
            j = j+1;   
        end
        t0 = e.t(j-1); 

%         mDensity = density(abs(mAfter))/9; 
        deltaR =15;
        [xfitpcf,yfitpcf,Rfitpcf] = lassos(1,mAfter, xfitcf, yfitcf, Rfitcf,deltaR);
        xfitcf = xfitpcf;
        yfitcf = yfitpcf;
        Rfitcf = Rfitpcf;

        [xfitp,yfitp,Rfitp] = lassos(1,mAfter, xfit, yfit, Rfit,deltaR);
        xfit = xfitp;
        yfit = yfitp;
        Rfit = Rfitp;

%% skeleton and Hough transform
%         se = strel('disk',10);
%         closeBW = imclose(abs(mAfter),se);
%         mSkel = skeletons(closeBW);
% %         branchpoints and ending points
%         B = bwmorph(mSkel, 'branchpoints');
%         E = bwmorph(mSkel, 'endpoints');
% 
%         [jep,iep] = find(E);
%         [jbp,ibp] = find(B);
%         
%         Dmask = false(size(mSkel));
%         if numel(iep)>3
%             for k = 1:numel(iep)
%                 D = bwdistgeodesic(mSkel,iep(k),jep(k));
%                 distanceToBranchPt = 30;
%                 Dmask(D < distanceToBranchPt) =true;
%             end 
%         end
%         skelD = mSkel - Dmask ;

%         axes(handles.axes5);
%         imagesc(mSkel);
%         hold on
%         plot(ibp,jbp,'r*');
%         plot(iep,jep,'b*');
%         hold off

% hough transform for circle
%         radii = 82:0.1:95;
         cas = 0;
         if ~isempty(peak_before)
                 radii = 84;
                 [peak,rDensity,lDensity,gDensity,mfitting] = houghLasso(radii, mAfter, 10, peak_before);
                 
                 %%%%% to be corrected
                 if rDensity <= 1 % gDensity small, no signal, we use circlefitting
%                     peak = [xfitp yfitp Rfitp]; 
                    peak = peak_before;
                    cas = 1;
                 elseif rDensity > 1 && lDensity <= 0.01 % gDensity large but no signal for current object , stay in last state
%                     peak = peak_before; 
                    cas = 2; 
                 elseif rDensity > 1 && lDensity > 0.01  % gDensity large and much signal for current object , hough transform
%                     hough transform
%                     xfit = peak(1);
%                     yfit = peak(2);
%                     Rfit = peak(3);
                    cas = 3;
                 end
                 
                 peak_before = peak; % Update state
         else
             
             peak_before = [xfitp yfitp Rfitp];
             gDensity = 0;
             lDensity = 0;
             cas = -1;   
         end
         gDensity
         lDensity
         rDensity
         cas
%          

%         Save polarity integration in hough     
%         if ~isempty(peak)
%         number_pos_events = 0;
%         number_neg_events = 0;
%         for mAfter_x = 1:304
%             for mAfter_y = 1:240
% %                 if abs(m(mAfter_y,mAfter_x))&&((mAfter_x-peak(1))^2+(mAfter_y-peak(2))^2)< (peak(3)-3)^2
%                 if abs(m(mAfter_y,mAfter_x))&&((mAfter_x-xfitp)^2+(mAfter_y-yfitp)^2)< (Rfitp-2)^2
%                     if m(mAfter_y,mAfter_x) == 1 
%                        number_pos_events = number_pos_events+1;
%                     elseif m(mAfter_y,mAfter_x) == -1 
%                        number_neg_events = number_neg_events+1;
%                     end
%                 end
%             end
%         end
%         
%         fidp = fopen('polarization_pos_circlefitting_5.txt','a');
%         fprintf(fidp,'%d\n',number_pos_events);
%         fclose(fidp);
%         fidn = fopen('polarization_neg_circlefitting_5.txt','a');
%         fprintf(fidn,'%d\n',number_neg_events);
%         fclose(fidn);
%         end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        axes(handles.axes1);
        drawdata(mAfter,W,H);
        colormap(gray); 
        if numel(peak)~=0
        
%             hold on;
           
%             [x, y] = circlepoints(peak(3));
            % Save rayon in hough transform
%             fidr = fopen('rayon15042015.txt','a');
%             fprintf(fidr,'%d\n',peak(3));
%             fclose(fidr);
%             plot(x+peak(1), y+peak(2), 'g-');
            drawcircle(peak(3),peak(1),peak(2),'g');
%             hold off;
        end
        
%         hold on
        axes(handles.axes7);
        drawdata(mfitting,W,H);
        colormap(gray); 
        drawcircle(Rfitpcf,xfitpcf,yfitpcf,'r');
%         hold off
        F(frameIndex) = getframe;
%         writeVideo(writerObj,F(frameIndex));
          
    end   
            
    
end
% close(writeObj);





