function [x] = generate_x ( bigImage )
    height = size(bigImage, 1); % height or y
    width = size(bigImage, 2); % width or x
    matrixSize = 256;
    
    %condense image down to a 3d matrix of the red and green channels of
    %the image
    x.map = cell(matrixSize, 1);
    
    % assign arrays to every cell of cell array x
    x.map(:) = {[]};
    
    %1 for red, 2 for green, 3 for blue
    % used in i_spy too so changes are easier
    x.colorChannel = 1;
    
    % Using while because I might want to modify the incrementing variables
	for c=1:width
		for r=1:height
            %get color of current pixel
            color = bigImage(r,c,x.colorChannel) + 1;

            %Add the point to the cell matrix
            x.map{color} = [x.map{color}; [r c]];
%             x.map{color} = [x.map{color}; sub2ind(size(bigImage), r, c, x.colorChannel)];
            
        end
    end
    
    %Convert x from a cell array into a table
        %This speeds up loading data back from the file when processing
        %the images. If allowed, I would have modified the save call
        %call in grade_i_spy.m to disable compression('-v6')
%     x = struct('map', x.map, 'colorChannel', x.colorChannel);
    
end
