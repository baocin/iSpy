function [r,c] = i_spy ( smallImage, bigImage, x )
    %Convert x back from a table into a the original cell array
    x = table2cell(x);
    
    sHeight = size(smallImage, 1); % height or y resolution of small image
    sWidth = size(smallImage, 2);  % width or x resolution of small image 

    bHeight = size(bigImage, 1);  % height or y resolution of big image
    bWidth = size(bigImage, 2);   % width or x resolution of big imagex

    sMatrix = int16(smallImage);  % convert the small image to an integer matrix
    bMatrix = int16(bigImage);    % convert the big image to an integer matrix
    
    smallRed = smallImage(1,1,1) + 1;
    smallGreen = smallImage(1,1,3) + 1; 
    
    %Default (invalid) r and c values
    r = 0;
    c = 0;
    
    % Decide what approach to use depending on if x was loaded in correctly
    if (size(x) ~= 0)
        disp('Using pre-generated data')
        for index=1:size(x{smallRed, smallGreen}, 2)
             r = x{smallRed, smallGreen}{index}(1);
             c = x{smallRed, smallGreen}{index}(2);
%             
%             r = x{smallRed, smallGreen}(index).x;
%             c = x{smallRed, smallGreen}(index).y;
            
            %fprintf('%d %d\n', r, c)
            if isequal(sMatrix(1, 1:6), bMatrix(r, c:c+5))
                if isequal(sMatrix, bMatrix(r:r+(sHeight-1), c:c+(sWidth-1), :))
                  return;
                end
            end
        end
    else
        disp('Using naive approach')
        % Naive Approach as Backup
        smallImageFirstPixel = sMatrix(1,1);
        %Loop through big image
        r = 1;
        while r <= bHeight - (sHeight-1)
            c = 1;
            while c <= bWidth - (sWidth-1)
                 if isequal(smallImageFirstPixel, bMatrix(r, c))
                     if isequal(sMatrix(1, 1:6), bMatrix(r, c:c+5))
                         if isequal(sMatrix, bMatrix(r:r+(sHeight-1), c:c+(sWidth-1), :)) 
                             return;
                         end
                     end
                 end
                c = c+1;
            end
            r = r+1;
        end
    end

