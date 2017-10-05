% function addStruct returns a struct. It takes arguments:
% a string name
% a number radius
% a 1x3 vector position that represents [px py pz]
% a 1x3 vector velocity that represents [vx vy vz]
% a 1x3 vector acceleration that represents [ax ay az]
% each body has a vector f (for force) associated, but this force has to be
% calculated later and separately

function [newStruct] = addBody(name, mass, radius, position, velocity)
    newStruct.name = name;
    newStruct.m = mass;
    newStruct.r = radius;
    newStruct.p = position;
    newStruct.v = velocity;
    newStruct.a = [0 0 0];
    newStruct.f = [0 0 0]; % no force acting on it yet
end


