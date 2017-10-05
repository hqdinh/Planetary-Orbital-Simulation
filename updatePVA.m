% This kinetic update uses Semi explicit Euler approximation
function [p, v, a] = updatePVA(body, dt)        
    a = body.f / body.m;
    v = body.v + a*dt;
    p = body.p + v*dt;
end
