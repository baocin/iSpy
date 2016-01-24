function [x] = generate_x ( bigImage )
    height = size(bigImage, 1); % height or y
    width = size(bigImage, 2); % width or x
    matrixSize = 256;
    
    %condense image down to a 3d matrix of the red and green channels of
    %the image
    x = cell(matrixSize);
%     x(:) = {struct('x', 0, 'y', 0)};
    x(:) = {zeros(0)};
    
    % Using while because I might want to modify the incrementing variables
	c = 1;
	while (c < width)
		r = 1;
		while (r < height)
            red = bigImage(r,c,1) + 1;
            green = bigImage(r,c,3) + 1;
            
%             x{red, green}(end + 1) = struct('x', r, 'y', c);
%             disp(x{red, green})
            %Add the point to the cell matrix
             x{red, green}{end + 1} = [r c];
%             x{red, green}{end + 1} = [r c];
            
			%incrment row variable
			r = r+1;
		end
		%increment column variable
		c = c+1;
    end
    
    %Condense the matrix by deleting empty rows and columns
%     disp(cellfun(@isempty, x))
%     x(:, cellfun(@isempty, x)) = [];

%      emptyCheck = cellfun(@(x) x=={}, x);
%      disp(any(emptyCheck))
%      for x=1:size(emptyCheck,1)
%         for y=1:size(emptyCheck,2)
%            find(emptyCheck( 
%         end
%      end
%     disp(sum(emptyCheck, 1))
%     emptyRows = any(sum(emptyCheck, 1))
%     disp(emptyRows)
%     disp(find(cellfun(@isempty, x)))
%     emptyColumns = find(cellfun(@isempty, x));
%     for colIndex = emptyColumns(0) : emptyColumns
%         
%     end

% x(:,find(all(cellfun(@isempty,x),1))) = [];
% x(any(cellfun(@isempty,x),2),:) = [];
    

    %Convert x from a cell array into a table
        %This speeds up loading data back from the file when processing
        %the images. If allowed, I would have used the -v6 flag on the save
        %call in grade_i_spy.m to disable compression
    x = cell2table(x);
    
end
