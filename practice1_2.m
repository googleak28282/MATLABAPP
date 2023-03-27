v=[10:2:51]
v2=v.*v
theta=[50:10:91]
sin2t=sind(theta).*sind(theta)
ans=v2'*sin2t/(2*9.8)