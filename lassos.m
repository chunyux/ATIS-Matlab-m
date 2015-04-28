function [xfit_result,yfit_result,Rfit_result] = lassos(polarity, mAfter, xfitb, yfitb, Rfitb,deltaR)
sidx = 1; %number of events in 2*deltaR around Rfitb
neventsGlobal = 0;

% Global events situations
for xidx = 1:304
    for yidx = 1:240
        if(mAfter(yidx,xidx)~=0)
          neventsGlobal = neventsGlobal+1;
          
          if (abs(sqrt((xidx - xfitb)^2 + (yidx - yfitb).^2) - Rfitb)<=deltaR)
%           if (mAfter(yidx,xidx) == polarity && sqrt((xidx - xfitb)^2 + (yidx - yfitb).^2) >= Rfitb-deltaR)
            xs(sidx) = xidx;
            ys(sidx) = yidx;
            sidx = sidx +1;
%             if mAfter(yidx,xidx) == 1
%                 pevent = pevent+1;
%             elseif mAfter(yidx,xidx) == -1
%                 nevent = nevent+1;  
%             end
          end
          
%           if (sqrt((xidx - xfitb)^2 + (yidx - yfitb).^2) <= Rfitb-7)
%               if mAfter(yidx,xidx) == 1
%                   pevent = pevent+1;
%               elseif mAfter(yidx,xidx) == -1
%                   nevent = nevent+1;  
%               end
%           end
           
        end
    end
end

% set(handles.edit3,'String',neventsGlobal);
% set(handles.axes2,'Visible','on');
% hold on;
% plot(neventsGlobal);
% npevent = sum(sum(mAfter));

if sidx>2 
    
    [xfit_result,yfit_result,Rfit_result,u] = circfit(xs,ys); %circle fitting
%     d = circleWidth(xs,ys,xfit_result,yfit_result,Rfit_result,u,e);
%     set(handles.edit5,'String',d);
    
else
    xfit_result = xfitb;
    yfit_result = yfitb;
    Rfit_result = Rfitb;
end

if Rfit_result >100 || Rfit_result<50
    xfit_result = xfitb;
    yfit_result = yfitb;
    Rfit_result = Rfitb;
    
end
Rfit_result = 88;
% fileID = fopen('exp.txt','a');
% fprintf(fileID, '%d ',npevent);
% Rfit_result = Rfitb;

%     axes(handles.axes5);
%     hold on
%     if polarity == 1
%         plot(idx,Rfit_result,'r.');
%     elseif polarity == -1
%         plot(idx,Rfit_result,'g.');  
%     end
%     hold off

end
