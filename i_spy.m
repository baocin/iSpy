function [r,c] = i_spy ( smallImage, bigImage, x )

    %Calculate the heights of the small and big images
    sHeight = size(smallImage, 1); % height or y resolution of small image
    sWidth = size(smallImage, 2);  % width or x resolution of small image 

    bHeight = size(bigImage, 1);  % height or y resolution of big image
    bWidth = size(bigImage, 2);   % width or x resolution of big imagex

%     smallImage = uint32(smallImage);  % convert the small image to an integer matrix
%     bigImage = uint32(bigImage);    % convert the big image to an integer matrix
    
    % get the color of the top left pixel in the small image
    topLeft = struct('row', 1, 'col', 1);
    center = struct('row', int16(sHeight/2), 'col', int16(sWidth/2));
    bottomLeft = struct('row', sHeight, 'col', sWidth);
        
    % Decide what approach to use depending on if x was loaded in correctly
    if (~ischar(x))  %x isn't '' so the pregenerated data is loaded
        %Use pregenerated data
        
        %Convert x back from a table into a the original cell array
        x = table2cell(x);
        
        % Find the most unique color from the center row of the small image
        sm = 0;
        smColor = struct('red', smallImage(center.row, center.col+sm, 1) + 1, 'blue', smallImage(center.row, center.col+sm, 3)+1);
        for c=1:(center.col-1)
            testColor = struct('red', smallImage(center.row, center.col+c, 1) + 1, 'blue', smallImage(center.row, center.col+c, 3)+1);
           if (size(x{testColor.red, testColor.blue}, 1) < size(x{smColor.red, smColor.blue}, 1))
                sm = c; 
                smColor = testColor;
           end
        end
        deltaR = center.row;
        deltaC = center.col+sm;
        
        % x{smColor.red, smColor.blue} is an array of pixels in the big image 
        % that match the color of a center pixel in the small image
          for index=1:size(x{smColor.red, smColor.blue}, 1)

%              [r, c] = ind2sub(x{smColor.red, smColor.blue}(index), [1 2]);

            % Get the pixel coordinates for the corresponding color
            % pixel
             r = x{smColor.red, smColor.blue}(index,1);
             c = x{smColor.red, smColor.blue}(index,2);
              
              % Adjust the pixel coordinates to point back to the top left
              % corner
               r = double(r - deltaR) + 1;
               c = double(c - deltaC) + 1;

%             IND = x{topLeftColor.red, topLeftColor.blue}(index);
%             r = rem(IND - 1, size(bigImage,1))+1;
%             c = floor(IND/size(bigImage,1))+1;
       
            
            %we know the topleft pixels match
            
            % Check if small image would extend over big image if placed at
            % this pixel
            if (r+sHeight-1 < bHeight && c+sWidth < bWidth)            %Check bottom right pixel for match
                    if isequal(smallImage(bottomLeft.row, bottomLeft.col), bigImage(r+bottomLeft.row-1, c+bottomLeft.col-1))

                        %Check center pixel for match
    %                     if isequal(smallImage(center.row, center.col), bigImage(r+center.row-1, c+center.col-1))

                            %Check entire small image
                            if isequal(smallImage, bigImage(r:r+(sHeight-1), c:c+(sWidth-1), :))
                              return;
                            end

    %                     end
                    end
                
                %Check top left pixel for match
%                 if isequal(smallImage(topLeft.row, topLeft.col), bigImage(r, c))
                    
                    %Check bottom right pixel for match
                    if isequal(smallImage(bottomLeft.row, bottomLeft.col), bigImage(r+bottomLeft.row-1, c+bottomLeft.col-1))

                        %Check center pixel for match
    %                     if isequal(smallImage(center.row, center.col), bigImage(r+center.row-1, c+center.col-1))

                            %Check entire small image
                            if isequal(smallImage, bigImage(r:r+(sHeight-1), c:c+(sWidth-1), :))
                              return;
                            end

    %                     end
                    end
                end
%             end
            
            
          end
        
          
          
        
    else
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

