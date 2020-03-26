function [point3s_moved] = move3(point3s,move_para3)
%MOVE3 Summary of this function goes here
%   Detailed explanation goes here
point3s_moved = point3s + repmat(move_para3,size(point3s,1),1);
end

