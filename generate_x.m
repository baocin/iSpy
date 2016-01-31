function [x] = generate_x ( bigImage )
%     height = size(bigImage, 1); % height or y
%     width = size(bigImage, 2); % width or x
    matrixSize = 256;
    
    %cell array to hold all the pixels of every red(row) and blue(column) color value
    x.a = cell(matrixSize);
    x.b = cell(matrixSize);
    
    % assign arrays to every cell of cell array x
    x.a(:) = {[]};
    x.b(:) = {[]};
    
    %Skip every other row and column
    aSlice = bigImage(1:2:end, 1:2:end, :);
    bSlice = bigImage(2:2:end, 2:2:end, :);
    height = size(bigImage, 1);
    width = size(bigImage, 2);
    
    for c=1:width
       for r=1:height
           %Add the point to the cell matrix
            red = bigImage(r,c,1) + 1;
            blue = bigImage(r,c,3) + 1;
            
           if mod(c,2) == 0
              %Add the point to the cell matrix
                x.b{red, blue} = [x{red, blue}; [r c]];
           else
               %Add the point to the cell matrix
                x.a{red, blue} = [x{red, blue}; [r c]];
           end
       end
    end
    
% 	c = 1;
% 	while (c < width)
% 		r = 1;
% 		while (r < height)
%             
%             red = bigImage(r,c,1) + 1;
%             blue = bigImage(r,c,3) + 1;
% 
%             % Hash the 2 by 2 square that has this current point 
%             
%             %Add the point to the cell matrix
%             x{red, blue} = [x{red, blue}; [r c]];
%             
% %               x{red, blue} = [x{red, blue} (r + (c-1)*size(bigImage))];
%             
% %             [a, b, c] = size(bigImage);
% %             x{red, blue} = [x{red, blue} sub2ind([a b], [r, c])];
%             
% 			%incrment row variable
% 			r = r+1;
% 		end
% 		%increment column variable
% 		c = c+1;
%     end
    
    %Convert x from a cell array into a table
        %This speeds up loading data back from the file when processing
        %the images. If allowed, I would have modified the save call
        %call in grade_i_spy.m to disable compression('-v6')
    x = cell2table(x);
    
end
