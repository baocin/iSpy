function [x] = generate_x ( bigImage )
    height = size(bigImage, 1); % height or y
    width = size(bigImage, 2); % width or x
    matrixSize = 256;
    
    %condense image down to a 3d matrix of the red and green channels of
    %the image
    x = cell(matrixSize);
    
    % assign arrays to every cell of cell array x
    x(:) = {[]};
    
    % Using while because I might want to modify the incrementing variables
	c = 1;
	while (c < width)
		r = 1;
		while (r < height)
            
            red = bigImage(r,c,1) + 1;
            blue = bigImage(r,c,3) + 1;

            %Add the point to the cell matrix
            %x{red, blue}{end + 1} = [r c];    %Slow
            
            %Using this saves ~8 MB from big image 2
             x{red, blue} = [x{red, blue}; [r c]];
            
%               x{red, blue} = [x{red, blue} (r + (c-1)*size(bigImage))];
            
%             [a, b, c] = size(bigImage);
%             x{red, blue} = [x{red, blue} sub2ind([a b], [r, c])];
            
			%incrment row variable
			r = r+1;
		end
		%increment column variable
		c = c+1;
    end
    
    %Convert x from a cell array into a table
        %This speeds up loading data back from the file when processing
        %the images. If allowed, I would have modified the save call
        %call in grade_i_spy.m to disable compression('-v6')
    x = cell2table(x);
    
end
