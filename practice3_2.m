[d,v]=drop(9.8,10,2)

function [dist,vel] = drop(g,v0,t)
vel = g*t + v0;
dist =0.5*g*t^2+v0*t;
end
