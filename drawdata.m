function drawdata(m,W,H)
        % play video
        surf(m);
        axis([0 W 0 H -1 1 -1 1])
        shading interp
        %axis off
        %grid off
        view([0 90]);
        colormap(gray);
        
%         hold on
%         if (arrowx>0 && abs(arrowx-xfit/304)>0 && arrowx<1 && arrowy>0 && abs(arrowx-yfit/240)>0 && arrowy<1)
%             fleche = annotation('arrow',[xfit/304,arrowx],[yfit/240,arrowy] );
%             pause(0.1);
%             delete(fleche);
%         end
%         hold off
end