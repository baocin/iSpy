function [r,c] = i_spy ( smallImage, bigImage, x )
    % small_image = imresize(small_image, 0.5, 'nearest');
    % big_image = x;

    sHeight = size(smallImage, 1); % height or y resolution of small image
    sWidth = size(smallImage, 2);  % width or x resolution of small image 

    bHeight = size(bigImage, 1);  % height or y resolution of big image
    bWidth = size(bigImage, 2);   % width or x resolution of big imagex

    sMatrix = int16(smallImage);  % convert the small image to an integer matrix
    bMatrix = int16(bigImage);    % convert the big image to an integer matrix

    % defaults
    r = 0;
    c = 0;
    
%     smallColorKey = sum(smallImage(1,1,:));
%     smallColorKey = uint32(0.2 * smallImage(1,1,1) + 0.7 * smallImage(1,1,2) + 0.07 * smallImage(1,1,3)) + sum(smallImage(1,1,:));
    smallColorKeySum = sum(smallImage(1,1,:));
    if ( 5 < sHeight )
        smallColorKeySum = smallColorKeySum + sum(smallImage(5,c,:));
    end
    if ( 5 < sWidth )
        smallColorKeySum = smallColorKeySum + sum(smallImage(r, 5, :)); 
    end
    smallColorKey = colorKeySum;
                
    for chunkNum=1:size(x,2)
%         disp(chunkNum)
%         disp(x(chunkNum))
        
        % if this chunk hash map has the color of the first pixel of the
        % small image
        if (isKey(x(chunkNum).map, smallColorKey))
            
            % loop through hashmap's list of points
            indexList = x(chunkNum).map(smallColorKey);
            for mapIndex=1:size(indexList,2)-1
%                 disp(x(chunkNum).pixels(indexList(mapIndex)))
%                 disp(mapIndex)
                coordX = x(chunkNum).pixels(indexList(mapIndex)).x;
                coordY = x(chunkNum).pixels(indexList(mapIndex)).y;
%                 fprintf('%d %d\n', coordX, coordY)
                 if isequal(sMatrix(1, 1:6), bMatrix(coordX, coordY:coordY+5))
%                      disp('kdsf')
%                     fprintf('%d %d\n', coordX, coordY)
                     if isequal(sMatrix, bMatrix(coordX:coordX+(sHeight-1), coordY:coordY+(sWidth-1), :))
                         r = coordX;
                         c = coordY;
                         return;
                     end
                 end
            end
        end
    end

%     return;
% %     smallImagePixel = mod(pixelColor * (pixelColor + 3), x.cellArraySize);
% %     if (smallImagePixel == 0) smallImagePixel = 1; end
% %     pixelList = x.map(smallImagePixel);
% 
% %     pixel = smallImage(1,1,:);
% %     colorToString = arrayfun(@(x) num2str(x), pixel, 'UniformOutput', false);
% %     colorKey = strcat(colorToString{1,1,:});
% %     smallColorKey = str2num(colorKey);
%     
% 
%     
% %     smallColorKey = 31 * (sum(smallImage(1,1,:)+1));
%     
% %     % Loop through all pixels that contain the color 
% %     % of the small image's first pixel
% % x
% % %     disp(size(pixelList,1))
% % %     disp(size(pixelList,2))
% % 
% %     for i=1:size(pixelList,2);
% %         disp(pixelList{1,i});
% %         if size(pixelList{i}(2)) < 2
% %            continue; 
% %         end
% %         r = pixelList{1,i}(1);
% %         c = pixelList{1,i}(2);
% %         disp(r)
% %         disp(c)
% %         return;
% %         if r <= Rb - (Ro-1) && c <= Cb - (Co-1)
% % %             if isequal(s_im(1,1), b_im(r, c))
% %                 if isequal(sMatrix, bMatrix(r:r+(Ro-1), c:c+(Co-1), :))    
% %                     return;
% %                 end
% % %             end
% %         end
% %     end
% % 
% % end
% 
% % disp(size(x.map(smallColorKey))
% smallColorKey = sum(smallImage(1,1,:));
% disp(x.map(smallColorKey))
% pixelList = x.map(smallColorKey);
% 
% for pixelIndex=1:pixelList
%     pixel = x.pixels(pixelIndex);
%     disp(pixel)
%     r = pixel{1}(1);
%     c = pixel{1}(2);
%     disp(r)
%     disp(c)
%     if r <= bHeight - (sHeight-1) && c <= bWidth - (sWidth-1)
%         if isequal(sMatrix, bMatrix(r:r+(sHeight-1), c:c+(sWidth-1), :))    
%             return;
%         end
%     end
% end

% smallImageFirstPixel = sMatrix(1,1);
% %Loop through big image
% r = 1;
% while r <= bHeight - (sHeight-1)
%     c = 1;
%    while c <= bWidth - (sWidth-1)
%         if isequal(smallImageFirstPixel, bMatrix(r, c))
%             if isequal(sMatrix(1, 1:6), bMatrix(r, c:c+5))
%                 if isequal(sMatrix, bMatrix(r:r+(sHeight-1), c:c+(sWidth-1), :)) 
%                     return;
%                 end
%             end
%         end
%        c = c+1;
%    end
%    r = r+1;
% end
