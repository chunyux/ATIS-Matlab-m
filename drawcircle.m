function drawcircle(Rfit,xfit,yfit,color)

%         title(sprintf('R = %.2f , Origin = ( %.1f, %.1f), number of events = %d',Rfit,xfit,yfit,numberofevents));

        if(Rfit>0 && Rfit<204)
            hold on
%             rectangle('position',[xfit-Rfit,yfit-Rfit,Rfit*2,Rfit*2],...
%             'curvature',[1,1],'edgecolor',color);
%             plot(xfit,yfit,color);
            alpha=0:pi/50:2*pi;%½Ç¶È[0,2*pi]
            x=Rfit*cos(alpha)+xfit;
            y=Rfit*sin(alpha)+yfit;
            plot(x,y,color)
            hold off
            
        end
end