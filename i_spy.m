function [r,c] = i_spy ( small_image, big_image, x )
% small_image = imresize(small_image, 0.5, 'nearest');
% big_image = x;

Ro = size(small_image, 1); % height or y resolution of small image
Co = size(small_image, 2); % width or x resolution of small image 

Rb = size(big_image, 1); % height or y resolution of big image
Cb = size(big_image, 2); % width or x resolution of big imagex

s_im = int16(small_image); % convert the small image to an integer matrix
b_im = int16(big_image);    % convert the big image to an integer matrix

%Loop through big image
r = 1;
while r <= Rb - (Ro-1)
    c = 1;
   while c <= Cb - (Co-1)
       % isequal is more efficient than subtracting the cropped image with
      % the small image since it stops as soon as a value isn't equal
        if isequal(s_im(1,1), b_im(r, c))
%             if isequal(s_im(1,1:5), b_im(r,c:c+4))
                if isequal(s_im, b_im(r:r+(Ro-1), c:c+(Co-1), :))
                    return;
                end
%             end
        end
       c = c+1;
   end
   r = r+1;
end

