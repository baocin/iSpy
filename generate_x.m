function [x] = generate_x ( bigImage )
    height = size(bigImage, 1); % height or y
    width = size(bigImage, 2); % width or x
    N = 1000;
    
    %Cut 
    numColumns = 2;
    chunkThresholds = (1);
    sizeEachColumn = uint32(width/numColumns);
    %cell for every chunk
    
    %hashmap for every chunk
    x = struct(...
       'map', containers.Map('KeyType', 'uint32', 'ValueType', 'any'), ...
       'pixels', struct('x', 0, 'y', 0));
    
    for c=1:numColumns
       chunkThresholds(end+1) = c * sizeEachColumn;
    end
%     chunkedImageMatrixThresholds{end+1} = width;
    
%     disp(x){end+1}
%     disp(size(chunkThresholds))
    
    
    for chunkIndex=2:numColumns
        display(chunkIndex, 'Chunk');
        x(chunkIndex) = struct(...
       'map', containers.Map('KeyType', 'uint32', 'ValueType', 'any'), ...
       'pixels', struct('x', 0, 'y', 0));
        
%         chunk = x(chunkIndex-1);
        chunkColumnStart = chunkThresholds(chunkIndex-1);
        chunkColumnEnd = chunkThresholds(chunkIndex);
%         chunkImage = bigImage(:, chunkStart:chunkEnd, :);
%         figure; imshow(chunkImage);
        
        pixelIndex = 1;
        c = chunkColumnStart;
        while (c < chunkColumnEnd && c < width)
%             disp(c)
           r = 1;
           while (r < height)
%                fprintf('%f',r)
%                colorKey = uint32(0.2 * bigImage(r,c,1) + 0.7 * bigImage(r,c,2) + 0.07 * bigImage(r,c,3));
                colorKey = sum(bigImage(r,c,:));
%                disp(x(chunkIndex-1));
               
                x(chunkIndex-1).pixels(pixelIndex).x = r;
                x(chunkIndex-1).pixels(pixelIndex).y = c;

%                 if isKey(x(chunkIndex-1).map, colorKey)
                if (x(chunkIndex-1).map.isKey(colorKey))
                    x(chunkIndex-1).map(colorKey) = [x(chunkIndex-1).map(colorKey) pixelIndex];
                else
                    x(chunkIndex-1).map(colorKey) = pixelIndex;
                end
                pixelIndex = pixelIndex + 1;

               r = r+1;
           end
%            disp(x)
           
           c = c+1;
        end
        
        
    end
    
    %Loop through big image
%     r = 1;
%     while r < height
%         c = 1;
%        while c < width
%             %Convert to grayscale
%             colorKey = uint32(0.2 * bigImage(r,c,1) + 0.7 * bigImage(r,c,2) + 0.07 * bigImage(r,c,3));
% 
%            x.pixels(index).x = r;
%            x.pixels(index).y = c;
%            
%            if isKey(x.map, colorKey)
%                x.map(colorKey) = [x.map(colorKey) index];
%            else
%                x.map(colorKey) = index;
%            end
%             index = index + 1;
%            
%            %increment column variable
%            c = c+1;
%        end
%        %incrment row variable
%        r = r+1;
%     end

r = 0;
c = 0;

end