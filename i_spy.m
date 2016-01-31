function [r,c] = i_spy ( smallImage, bigImage, x )

    %Calculate the heights of the small and big images
    sHeight = size(smallImage, 1); % height or y resolution of small image
    sWidth = size(smallImage, 2);  % width or x resolution of small image 

    bHeight = size(bigImage, 1);  % height or y resolution of big image
    bWidth = size(bigImage, 2);   % width or x resolution of big imagex
    
    % get the color of the top left pixel in the small image
%     topLeft = struct('row', 1, 'col', 1);
%     center = struct('row', int16(sHeight/2), 'col', int16(sWidth/2));
%     bottomLeft = struct('row', sHeight, 'col', sWidth);
    
    condensedSmallImage = smallImage(1:2:end, 1:2:end, :);
        
    %default values 
    r = 1;
    c = 1;
    
    % Decide what approach to use depending on if x was loaded in correctly
    if (~ischar(x))  %x is loaded, Use pregenerated data
        
        %Convert x back from a table into a the original cell array
        x = table2cell(x);
        
        searchList = x{condensedSmallImage(1,1,1), condensedSmallImage(1,1,2)};
        disp(searchList);
        
        % x{smColor.red, smColor.blue} is an array of pixels in the big image 
        % that match the color of a center pixel in the small image
        for index=1:size(searchList)
            % Get the pixel coordinates for the corresponding color
            % pixel
            r = searchList(index,1);
            c = searchList(index,2);

            % Check if small image would extend over big image if placed at
            % this pixel
            if (r+sHeight-1 < bHeight && c+sWidth < bWidth)
                %Check entire small image
                if isequal(smallImage, bigImage(r:r+(sHeight-1), c:c+(sWidth-1), :))
                    return;
                end
            end
        
        end
          
        
    else   %|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
        
        % Naive Approach as Backup
        
        %Loop through big image
        r = 1;
        while r <= bHeight - (sHeight-1)
            c = 1;
            while c <= bWidth - (sWidth-1)
                %Does this pixel match the the first pixel in the small image
                 if isequal(smallImage(1,1), bigImage(r, c))

                     %Check bottom right pixel for match
                    if isequal(smallImage(bottomLeft.row, bottomLeft.col), bigImage(r+bottomLeft.row-1, c+bottomLeft.col-1))
                        
                        %Check center pixels for match
                        if isequal(smallImage(center.row, center.col+2), bigImage(r+center.row-1, c+center.col-1+2))

                            %Check entire small image
                            if isequal(smallImage, bigImage(r:r+(sHeight-1), c:c+(sWidth-1), :))
                              return;
                            end
                        end
                    end
                
                 end
                c = c+1;
            end
            r = r+1;
        end
    end

