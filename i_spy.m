function [r,c] = i_spy ( smallImage, bigImage, x )

    %Calculate the heights of the small and big images
    sHeight = size(smallImage, 1); % height or y resolution of small image
    sWidth = size(smallImage, 2);  % width or x resolution of small image 

    bHeight = size(bigImage, 1);  % height or y resolution of big image
    bWidth = size(bigImage, 2);   % width or x resolution of big imagex

    sMatrix = uint16(smallImage);  % convert the small image to an integer matrix
    bMatrix = uint16(bigImage);    % convert the big image to an integer matrix
    
    %Default (invalid) r and c values
    r = 0;
    c = 0;
    
    % get the color of the top left pixel in the small image
    topLeftColor = struct('red', smallImage(1,1,1)+1, 'blue', smallImage(1,1,2)+1);
    center = struct('row', int16(sHeight/2), 'col', int16(sWidth/2));
    bottomLeft = struct('row', sHeight, 'col', sWidth);
        
    % Decide what approach to use depending on if x was loaded in correctly
    if (~ischar(x))  %x isn't '' so the pregenerated data is loaded
        %Use pregenerated data
        
        %Convert x back from a table into a the original cell array
        x = table2cell(x);
        
        % x{smallRed, smallGreen} is the array of all pixels in the big image 
        % that match the color of first pixel of the small image
        for index=1:size(x{topLeftColor.red, topLeftColor.blue}, 1)
%             disp(x{topLeftColor.red, topLeftColor.blue}(index,:))
%             r = x{topLeftColor.red, topLeftColor.blue}{index,1}(1);
            r = x{topLeftColor.red, topLeftColor.blue}(index,1);
%             c = x{topLeftColor.red, topLeftColor.blue}{index,1}(2);
            c = x{topLeftColor.red, topLeftColor.blue}(index,2);
            
            %we know the topleft pixels match
            
            % Check if small image would extend over big image if placed at
            % this pixel
            if (r+sHeight-1) < bHeight && (c+sWidth-1) < bWidth
                
                %Check bottom right pixel for match
                if isequal(sMatrix(bottomLeft.row, bottomLeft.col), bMatrix(r+bottomLeft.row-1, c+bottomLeft.col-1))
                    
                    %Check center pixel for match
                    if isequal(sMatrix(center.row, center.col), bMatrix(r+center.row-1, c+center.col-1))
                        
                        %Check entire small image
                        if isequal(sMatrix, bMatrix(r:r+(sHeight-1), c:c+(sWidth-1), :))
                          return;
                        end
                    
                    end
                end
            end
        end
        
    else
        % Naive Approach as Backup
        
        %Loop through big image
        r = 1;
        while r <= bHeight - (sHeight-1)
            c = 1;
            while c <= bWidth - (sWidth-1)
                %Does this pixel match the the first pixel in the small image
                 if isequal(sMatrix(1,1), bMatrix(r, c))

                     %Check bottom right pixel for match
                    if isequal(sMatrix(bottomLeft.row, bottomLeft.col), bMatrix(r+bottomLeft.row-1, c+bottomLeft.col-1))
                        
                        %Check center pixels for match
                        if isequal(sMatrix(center.row, center.col+2), bMatrix(r+center.row-1, c+center.col-1+2))

                            %Check entire small image
                            if isequal(sMatrix, bMatrix(r:r+(sHeight-1), c:c+(sWidth-1), :))
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

