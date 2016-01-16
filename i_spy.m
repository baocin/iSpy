function [r,c] = i_spy ( object_im, big_im, x )

Ro = size(object_im, 1); % height or y resolution of small image
Co = size(object_im, 2); % width or x resolution of small image 

Rb = size(big_im, 1); % height or y resolution of big image
Cb = size(big_im, 2); % width or x resolution of big image

o_im = int16(object_im); % convert the small image to an integer matrix
b_im = int16(big_im);    % convert the big image to an integer matrix

for r = 1 : Rb - (Ro-1)
    for c = 1 : Cb - (Co-1)
        cropped_big_image = b_im(r:r+(Ro-1), c:c+(Co-1), : );
        
        diff_val = cropped_big_image - o_im;
        
        if ( sum ( abs ( diff_val(:)) ) == 0 )
            return;
        end
    end
end
