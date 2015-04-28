function m_after = density(m)
    i = 2; j=2;
    m_after = zeros(240,304);
    while(i<240 )
        while(j<304)
            %median filter
            m_after(i,j) = m(i,j)+ m(i,j-1) + m(i,j+1)+m(i-1,j) + m(i+1,j)+m(i-1,j-1) + m(i+1,j+1)+m(i+1,j-1) + m(i-1,j+1);
            j=j+1;
        %median filter end
        end
        j = 2;
        i=i+1;
    end