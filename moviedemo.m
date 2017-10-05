% This script creates a movie of a traveling sine wave.
% The 5 movie-making steps are the critical components.
clear all; clc; close all;

% For our simple example, we'll need some points in the x-direction
x = linspace(0, 2*pi);

% Declare the number of timesteps. This determines the number of frames
% and, thus, the length of the movie (num_frames/framerate = duration)
t_steps = 120;

% STEP 1: Create the video object
vidHandle = VideoWriter('TravelingWave', 'MPEG-4');
vidHandle.FrameRate = 15;
vidHandle.Quality = 100;
open(vidHandle);
writeVideo(vidHandle, getframe(gcf));

close(vidHandle);