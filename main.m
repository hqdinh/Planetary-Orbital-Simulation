% Huy Dinh - Planetary Orbital Simulation
% Project includes: 
% - main.m (this file)
% - initialConditions.m 
% - addBody.m
% - accretion.m
% - updateF.m
% - updatePVA.m 
clc; clear; close all;

%% simulation conditions
dt = 0.1;           % time step
N = 100000;         % repetition (total number of time steps)
n = 18;             % all planets' current popsitions (red) are plotted once every n
                    % the trail (blue) is plotted once every 2n
                    % this reduces the number of plots/sec while keeping 
                    % a high calculations/sec (for performance)
plot3D = 0;         % set this to 1 to plot 3D simulation, to 0 to plot 2D simulation
videoON = 0;        % set this to 1 if you want to record a video
videoName = 'PlanetarySimulation_1';
endVid = 1600;      % the video ends at endVid-th time step
xl = [-2000 2000];      yl = [-3000 3000];      zl = [-10 10]; % axes limits
resetPlot = 16000;  % all planets' traces are removed from current plot at resetPlot-th time step 
                    % but planets continue its current path
                    % set resetPlot = N to nullify this feature
tracePlot = plot([],[]); % a dummy plot created so that first delete() can execute

%% initiate an array of structs defined in addBody.m
% bodies holds every objects in the program
bodies = initialConditions();

%% Video specs
if videoON
    vidHandle = VideoWriter(videoName, 'MPEG-4');
    vidHandle.FrameRate = 30;
    vidHandle.Quality = 80;
    open(vidHandle);
end

%% Simulation
for rep=1:N    
    % every 100 time steps, calculate and print elapsed time of 100 reps 
    % to evaluate performance trend, uncomment "clear;" to nullify this feature
    if mod(rep, 100) == 1
        tic;
    elseif mod(rep, 100) == 0
        toc;
        % clear
    end
        
    %% check collision    
    for ii=1:length(bodies)-1
        for jj=ii+1:length(bodies)
            d = bodies(ii).p - bodies(jj).p;
            d = sqrt(d*d');
            R = bodies(ii).r + bodies(jj).r;
            if d < R
                bodies(ii) = accretion(bodies(ii), bodies(jj));
                bodies(jj) = [];
                ii = 1;
                break;
            end            
        end
    end    
    L = length(bodies); 
    
    %% PLOTTING    
    % rearrange all planets' coordinates in a 3xL matrix, and then plot its columns
    A = reshape([bodies.p], [3 L]); 
    drawnow;   
    
    % plot planets' positions once every 2n time step
    n = 6;
    if mod(rep,2*n)==1
        if plot3D
            plot3(A(1,:), A(2,:), A(3,:), 'b.', 'MarkerSize', 1);
        else
            plot(A(1,:), A(2,:), 'b.', 'MarkerSize', 1);
        end
        hold on;
        % axes limits are automatically set by matlab. Uncomment the line
        % below to fix those limits.
        xlim(xl);  ylim(yl);  zlim(zl);
        netForce = sum(reshape([bodies.f], [3 L]),2);
        xlabel('X');
        ylabel('Y');
        zlabel('Z');
        title(rep); % display the number of time step as the title
        grid on;
    end
    
    % once every n time steps, plot planets' positions as circles (to track
    % where they are in their paths). These circles will be deleted prior
    % to the next time their subsequent positions are plotted
    if mod(rep,n) == 1
        delete(tracePlot);
        if plot3D
            tracePlot = plot3(A(1,:), A(2,:), A(3,:), 'r.', 'MarkerSize', 17);
        else
            tracePlot = plot(A(1,:), A(2,:), 'r.', 'MarkerSize', 17);
        end
        
        if videoON && rep < endVid
            writeVideo(vidHandle, getframe(gcf));
        end
    end
        
    % clear the plot every resetPlot time steps to "reset" the plot, 
    if mod(rep,resetPlot) == 1
        hold off;
    end
       
    %% find net force acting on each body
    for ii=1:L-1
        for jj=(ii+1):L
            [bodies(ii).f, bodies(jj).f] = updateF(bodies(ii), bodies(jj));
        end
    end

    %% update position, velocity, and acceleration, and reset force
    for ii=1:L
        [bodies(ii).p, bodies(ii).v, bodies(ii).a] = updatePVA(bodies(ii), dt);
        bodies(ii).f = [0 0 0];
    end    
    
    % end the video at time step endVid
    if videoON && rep == endVid
        close(vidHandle);
    end
end
