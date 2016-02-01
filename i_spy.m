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
        
        %Convert x back from a table into a the original cell array
%         x.map = table2cell(x.map);
        
        % Find the most unique color from the first row of the small image
%          firstRow = smallImage(1, :, 1);
%          smSize = cell2mat(arrayfun(@(a) size(x.map{a}, 1), firstRow, 'UniformOutput', false));
%          smallestCol = min(smSize);
%          loc = smSize==min(smallestCol);
%          smColor = smallImage(1,loc,1);
         
         smColor = smallImage(1,1,x.colorChannel);
         pixelList = [];
         
         test{1} = [[1,1];[1,2];[2,2]];
         test{2} = [[1,1];[1,2];[3,2]];
         
         for i=1:min(size(smallImage,1), size(smallImage,2))
             % Get all pixels that have this color on the diagonal pixel
             % i,i of the small Image
             % subtract i from each value to normalize them back to the top
             % left starting corner
              tmp = x.map{smallImage(i, i, x.colorChannel)}(:,:)-i;
%                tmp = test{i}(:,:)-i;
%              disp(tmp);
             pixelList = [pixelList; tmp];
             [M F C] = mode(pixelList, 2);
             pixelList = C;
%              if size(x.map{smallImage(1, i, x.colorChannel)}) < size(x.map{smColor})
%                 smColor = smallImage(1, i, x.colorChannel);
%                 disp(size(smColor))
%              end
            r = C{1}(1);
            c = C{1}(2);
         end
         pixelList = pixelList(:,:) + 1;
         disp(pixelList)
         
         return;
%          disp(pixelList)
%          Pixels = unique(pixelList, 'rows');
%           [M F C] = mode(pixelList,2);
%          disp(size(uniquePixels));
%          disp(size(min(size(smallImage))));
         
%         disp(smallestCol)
%         disp(smColor)
%         disp(size(x{smColor}))
        
        
%        smColor = smallImage(1,1,1)+1;
%         for pixel=smallImage(1, :)
%            if (size(pixel) 
%         end
%         for c=1:(center.col-1)
%             testColor = struct('red', smallImage(center.row, center.col+c, 1) + 1, 'blue', smallImage(center.row, center.col+c, 3)+1);
%            if (size(x{testColor.red, testColor.blue}, 1) < size(x{smColor.red, smColor.blue}, 1))
%                 sm = c; 
%                 smColor = testColor;
%            end
%         end
%         deltaR = center.row;
        
        % x{smColor.red, smColor.blue} is an array of pixels in the big image 
        % that match the color of a center pixel in the small image
          for index=1:size(pixelList)%size(x.map{smColor},  x.colorChannel)
            % Get the pixel coordinates for the corresponding color
            % pixel
             % [r, c] = ind2sub(size(bigImage), x.map{smColor}(index));
%               a = x.map{smColor}(index, :);
%               r = a(1);
%               c = a(2);
            
             
            
            %we know the topleft pixels match
            
            % Check if small image would extend over big image if placed at
            % this pixel
            if (r+sHeight-1 < bHeight && c+sWidth < bWidth)            %Check bottom right pixel for match
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

