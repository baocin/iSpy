% % 0.  generate "x"
% % this section will be commented out during testing
% folder_name = 'data/'; 
% setN = 3;
% objectI0 = 1; 
% objectI1 = 10;
% 
% for i = 1:setN
%     
%     % load big image
%     fn = sprintf ( '%sset%d_big_im.png', ...
%         folder_name, i );
%     b_im = imread ( fn );
%     
%     
%     % generate "x" for the big image
%     x = generate_x ( b_im );
%     
%     
%     % save "x"
%     fn = sprintf ( '%sset%d_x.mat', folder_name, i )
%     save ( fn, 'x' );
% 
% end





% 1.  setup

% set info for the data to test
folder_name = 'data/'; 

setN = 3;
objectI0 = 1; 
objectI1 = 10;
distantT = 5;



% 2.  test each image
timeLimitSec = 60;


% start the timer
t = cputime;


pt = 0;

for i = 1:setN
    
    % load big image
    fn = sprintf ( '%sset%d_big_im.png', ...
        folder_name, i );
    b_im = imread ( fn );
    
    % load gt
    fn = sprintf ( '%sset%d_gt.csv', folder_name, i );
    gt = csvread ( fn );
    
    % load "x"
    fn = sprintf ( '%sset%d_x.mat', folder_name, i );
    if ( exist ( fn ) ~= 0 )
        load (fn);
    else
        x = '';
    end
    
    for j = objectI0:objectI1
        
        % load individual crop image
        fn = sprintf ( '%sset%d_object_im_%d.png', ...
            folder_name, i, j );
        o_im = imread ( fn );
    
        % run i_spy
        [r,c] = i_spy ( o_im, b_im, x );
        
        
        % evaluate -> change this
        error_dist = sqrt ...
            ( ( gt(j,1) - r ) ^ 2 + ...
            ( gt(j,2) - c ) ^ 2 );            
            
        if ( (cputime-t) >= timeLimitSec )
            fprintf ( 'final points = %d\n', pt );
            return;
        else
            if ( error_dist <= distantT )
                pt = pt + 1;
            end

            fprintf ( '%d,%d - alg(%d,%d) vs gt(%d,%d) - %f sec -> total pt [%d]\n', ...
                i, j, r, c, gt(j,1), gt(j,2), cputime-t, pt );
        end
    end
end

