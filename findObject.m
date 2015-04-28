clc;
% draw circle
% absmAfter = abs(mAfter);
% imshow(absmAfter);
%Hough circlefinding
% [centers, radii, metric] = imfindcircles(abs(mAfter),[90 110]);
% centerStrong = centers(1,:);
% radiiStrong = radii(1);
% metricStrong = metric(1);
% viscircles([152 120], 90, 'EdgeColor','r');

%circle fitting

[xfit,yfit,Rfit] = circfit(xs,ys);
% figure(3)
% plot(xs,ys,'b.')
hold on
rectangle('position',[xfit-Rfit,yfit-Rfit,Rfit*2,Rfit*2],...
    'curvature',[1,1],'linestyle','-','edgecolor','r');
title(sprintf('Best fit: R = %0.1f; Ctr = (%0.1f,%0.1f)',...
    Rfit,xfit,yfit));
plot(xfit,yfit,'g.')
xlim([xfit-Rfit-2,xfit+Rfit+2])
ylim([yfit-Rfit-2,yfit+Rfit+2])
axis equal