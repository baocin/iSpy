function [r,c] = i_spy ( object_im, big_im, x )

Ro = size(object_im, 1); % height or y resolution of small image
Co = size(object_im, 2); % width or x resolution of small image 

Rb = size(big_im, 1); % height or y resolution of big image
Cb = size(big_im, 2); % width or x resolution of big image

o_im = int16(object_im); % convert the small image to an integer matrix
b_im = int16(big_im);    % convert the big image to an integer matrix

%Loop through big image
for r = 1 : Rb - (Ro-1)
    for c = 1 : Cb - (Co-1)
        row = r:r+(Ro-1);
        col = c:c+(Co-1);
        
        cropped_big_image = b_im(row, col, : );
        
        result = isequal(o_im, cropped_big_image);
        if (result)
            return;
        end
    end
end
