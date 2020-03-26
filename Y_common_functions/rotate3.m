function [point3s_rotated] = rotate3(point3s,rotate_para3)
%ROTATE3 Summary of this function goes here
%   Detailed explanation goes here
t = rotate_para3(1);
Rx = [  1 0 0; ...
        0 cos(t) -sin(t);...
        0 sin(t) cos(t)];
t = rotate_para3(2);
Ry = [cos(t) 0 sin(t); ...
        0 1 0; ...
        -sin(t) 0 cos(t)];
t = rotate_para3(3);
Rz = [cos(t) sin(t) 0; 
      sin(t) -cos(t) 0; 
       0 0 1];

point3s_rotated =point3s * Rx*Ry*Rz;
end

