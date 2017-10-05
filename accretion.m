% this function takes parameters of 2 colliding bodies
% and returns 1 body with parameters such that conservation of mass and
% momentum is observed
function [body] = accretion(body1, body2)
    m = body1.m + body2.m;
    v = (body1.v * body1.m + body2.v * body2.m)/m;
    p = (body1.m*body1.p + body2.m*body2.p)/m;
    r = nthroot(body1.r^3 + body2.r^3, 3);
    name = strcat(body1.name, '+', body2.name);
    body = addBody(name, m, r, p, v);     
end