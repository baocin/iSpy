function [x] = generate_x ( bigImage )
    height = size(bigImage, 1); % height or y
    width = size(bigImage, 2); % width or x
    
    %Cut 
    numChunks = 20;
    chunkThresholds = (1);
    sizeEachColumn = uint32(width/numChunks);
    %cell for every chunk
    
    %hashmap for every chunk
    x = struct(...
       'map', containers.Map('KeyType', 'uint32', 'ValueType', 'any'), ...
       'pixels', struct('x', 0, 'y', 0));
    
    for c=1:numChunks
       chunkThresholds(end+1) = c * sizeEachColumn;
    end
    
    for chunkIndex=2:numChunks
        fprintf('%d ', chunkIndex);
        x(chunkIndex) = struct(...
        'map', containers.Map('KeyType', 'uint32', 'ValueType', 'any'), ...
        'pixels', struct('x', 0, 'y', 0));

        chunkColumnStart = chunkThresholds(chunkIndex-1);
        chunkColumnEnd = chunkThresholds(chunkIndex);

        pixelIndex = 1;
        c = chunkColumnStart;
        while (c < chunkColumnEnd && c < width)
            r = 1;
            while (r < height)
                 
                 colorKeySum = sum(bigImage(r,c,:));
                 if ( (r+5) < height )
                    colorKeySum = colorKeySum + sum(bigImage(r+5,c,:));
                 end
                 if ( (c+5) < width )
                    colorKeySum = colorKeySum + sum(bigImage(r, c+5, :)); 
                 end
                colorKey = colorKeySum;
                
                x(chunkIndex-1).pixels(pixelIndex).x = r;
                x(chunkIndex-1).pixels(pixelIndex).y = c;

                if (x(chunkIndex-1).map.isKey(colorKey))
                    x(chunkIndex-1).map(colorKey) = [x(chunkIndex-1).map(colorKey) pixelIndex];
                else
                    x(chunkIndex-1).map(colorKey) = pixelIndex;
                end
                pixelIndex = pixelIndex + 1;

                %incrment row variable
                r = r+1;
            end
            %increment column variable
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

end