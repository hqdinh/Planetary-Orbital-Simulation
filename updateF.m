% updateF finds the gravitational forces between 2 bodies b1 b2
% and adds that force to whatever force that's already acting on each

function [f1, f2] = updateF(b1, b2)
    G = 20;
    R21 = b1.p - b2.p; % points from body 2 to 1 <=> force acting on 2
    R12 = - R21; % points from body 1 to 2 <=> force acting on 1
    R = sqrt(dot(R12,R12));
    F = G * b1.m * b2.m / R^2;
    
    % Calculate unit distance vectors
    r21 = R21/R;
    r12 = R12/R;
    
    % Calculate force vector and add it to existing force on each body
    f1 = b1.f + F*r12;
    f2 = b2.f + F*r21;

end