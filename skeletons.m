function mSkel = skeletons(m)
        
        HGaussian = fspecial('Gaussian',[5 5],1.5); % filtre gaussian
%         HAverage = fspecial('Average',[5 5]); % filtre gaussian
%         mBlur = imfilter(abs(m),HGaussian); % after filtre gaussian
        % gradian
%         Gx = [-1 0 1;-2 0 2; -1 0 1];
%         Gy = [-1 -2 -1;0 0 0; 1 2 1];
%         mdensity_Gx =  imfilter(mBlur,Gx);
%         mdensity_Gy = imfilter(mBlur,Gy);
%         mdensity_G = sqrt(mdensity_Gx.^2 + mdensity_Gy.^2);
        
        % dilation
        se1 = strel('line',5,0);
        se2 = strel('line',5,90);
        composition = imdilate(1,[se1 se2],'full');
        mdilate = imdilate(abs(m),composition);
        
        mBlur = imfilter(mdilate,HGaussian);
        mBlur2 = imfilter(mBlur,HGaussian);
        mClose = bwmorph(mBlur2,'close',Inf);
        mSkel = bwmorph(mClose,'thin',Inf);
end