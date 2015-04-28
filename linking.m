function m_after = linking(m)
    i = 2; j=2;
    m_after = zeros(240,304);
    while(i<240 )
        while(j<304)
            %median filter
            if m(i,j)== 0 && ((m_after(i,j-1) && m_after(i,j+1))||(m_after(i-1,j) && m_after(i+1,j))||(m_after(i-1,j-1) && m_after(i+1,j+1))||(m_after(i+1,j-1) && m_after(i-1,j+1)))
                 m_after(i,j) = 1;
            elseif m(i,j)== 1 
                 m_after(i,j) = 1;
            end
            j=j+1;
        %median filter end
        end
        j = 2;
        i=i+1;
    end