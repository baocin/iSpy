function [r,c] = i_spy ( object_im, big_im, x )

Ro = size(object_im, 1); % height or y resolution of small image
Co = size(object_im, 2); % width or x resolution of small image 

Rb = size(big_im, 1); % height or y resolution of big image
Cb = size(big_im, 2); % width or x resolution of big image

o_im = int16(object_im); % convert the small image to an integer matrix
b_im = int16(big_im);    % convert the big image to an integer matrix

colSkip = 0;
rowSkip = 0;
 
% disp(Rb - (Ro-1) - rowSkip)
% disp(Cb - (Co-1) - colSkip)
for r = 1 : Rb - (Ro-1)
    for c = 1 : Cb - (Co-1)
        if ((r + rowSkip + Ro - 1) > (Rb - (Ro - 1)))
            continue
        end
        if ((c + colSkip + Co - 1) > (Cb - (Co - 1)))
            continue
        end
%         disp(r)
%         disp(c)
        
        cropped_big_image = b_im((r + rowSkip):r+(rowSkip)+(Ro-1), (c + colSkip):c+(colSkip)+(Co-1), : );
        
        diff_val = cropped_big_image - o_im;
        
        if ( sum ( abs ( diff_val(:)) ) == 0 )
            return;
        else 
            % Image doesn't match so skip Ro(width of small image) columns
%             colSkip = colSkip + Co;
            % and skip Co(height of small image) rows
%             rowSkip = rowSkip + Ro;
        end
    end
end
