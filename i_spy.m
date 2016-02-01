function [r,c] = i_spy ( smallImage, bigImage, x )

    %Calculate the heights of the small and big images
    sHeight = size(smallImage, 1); % height or y resolution of small image
    sWidth = size(smallImage, 2);  % width or x resolution of small image 

    bHeight = size(bigImage, 1);  % height or y resolution of big image
    bWidth = size(bigImage, 2);   % width or x resolution of big imagex

    % get the color of the top left pixel in the small image
    topLeft = struct('row', 1, 'col', 1);
    center = struct('row', int16(sHeight/2), 'col', int16(sWidth/2));
    bottomLeft = struct('row', sHeight, 'col', sWidth);
            
    % Decide what approach to use depending on if x was loaded in correctly
    if (~ischar(x))  %x isn't '' so the pregenerated data is loaded
        %Use pregenerated data
        
        %Find the most unique color pixel in the small Image
        centerRow = smallImage(center.row, : , x.colorChannel);
        sizedFirstRow = cell2mat(arrayfun(@(a) size(x.map{a+1},1), centerRow, 'UniformOutput', false));
        [~, smCol] = find(sizedFirstRow == min(min(sizedFirstRow)));

        % remember to adjust the rows and columns read from this point
        adjust = [double(center.row) smCol(1)];
        
        %The color corresponding to the most uniquely colored pixel
        smallestColor = smallImage(center.row, smCol(1), x.colorChannel)+1;

        % x.map{color} is an array of pixels in the big image 
        % that match the color of a center pixel in the small image
          for index=1:size(x.map{smallestColor})
            % Get the pixel coordinates for the corresponding color
            % pixel
%             [r, c] = ind2sub(size(bigImage), x.map{smColor}(index));
              a = x.map{smallestColor}(index, :);
              r = a(1) - adjust(1) +1;
              c = a(2) - adjust(2) +1;
            
            %we know a center.row pixel matches
            % Check if small image would extend over big image if placed at
            % this pixel
            if (r>0 && c>0 && r+sHeight-1 < bHeight && c+sWidth < bWidth)            
                %Check top right pixel
                if isequal(smallImage(topLeft.row, topLeft.col), bigImage(r+topLeft.row-1, c+topLeft.col-1))
                    %check bottom left
                    if isequal(smallImage(bottomLeft.row, bottomLeft.col), bigImage(r+bottomLeft.row-1, c+bottomLeft.col-1))
                        %Check center pixel for match
                        if isequal(smallImage(center.row, center.col), bigImage(r+center.row-1, c+center.col-1))
                            %Check entire small image
                            if isequal(smallImage, bigImage(r:r+(sHeight-1), c:c+(sWidth-1), :))
                              return;
                            end

                        end
                    end
                end
            end
            
            
          end
        
          
          
        
    else
        % Naive Approach as Backup
        
        %Loop through big image
        for r=1:bHeight - (sHeight-1)
            for c=1:bWidth - (sWidth-1)
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
            end
        end
    end

