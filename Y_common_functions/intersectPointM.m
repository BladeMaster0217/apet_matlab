function [points] = intersectPointM(rayVector, rayPoint, planeNormal, planePoint)
%INTERSECT Find the intersection between a line and a plane

pdiff = rayPoint - planePoint;
prod1 = dot(pdiff, planeNormal);
prod2 = dot(rayVector, planeNormal);
prod3 = prod1 ./ prod2;
 
points = rayPoint - rayVector .* repmat(prod3,3,1);