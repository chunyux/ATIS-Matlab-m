function [peak,rDensity,lDensity,gDensity,mfitting] = houghLasso(radii, mAfter, deltaR, peak_before)
        se = strel('disk',5);
        closeBW = imdilate(mAfter,se);
        closeBW = imclose(closeBW,se);
        mfitting = zeros(240,304);
        lDensity = 0;
        gDensity = 0;
        for xidx = 1:304
            for yidx = 1:240
                if (closeBW(yidx,xidx)~=0) 
                    gDensity = gDensity+1;
                    if (abs(sqrt((xidx - peak_before(1))^2 + (yidx - peak_before(2)).^2) - peak_before(3))<=deltaR)
                        lDensity = lDensity +1;
                        mfitting(yidx,xidx) = 1;
                    end
                end
            end
        end
        
        s_l = (3.1415926*(peak_before(3)+deltaR)^2-3.1415926*(peak_before(3)-deltaR)^2);
        s_g = (304*240) - (3.1415926*(peak_before(3)+deltaR)^2-3.1415926*(peak_before(3)-deltaR)^2);
        gDensity = (gDensity-lDensity)/s_g;
        lDensity = lDensity/s_l;
        if(gDensity~=0)
            rDensity = lDensity/gDensity;
%             if lDensity <= 1*gDensity 
%                 peak = peak_before;
    %             h = circle_hough(abs(mfitting), radii, 'same', 'normalise');
    %             peak = circle_houghpeaks(h, radii, 'nhoodxy', 15, 'nhoodr', 21, 'npeaks', 1);
%             else
                h = circle_hough(mfitting, radii, 'same', 'normalise');
                peak = circle_houghpeaks(h, radii, 'nhoodxy', 15, 'nhoodr', 21, 'npeaks', 1); 
    %             peak = circle_houghpeaks(h, radii, 'npeaks', 1); 
%             end
        else
           peak = peak_before; 
           rDensity = 0;
        end