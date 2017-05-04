function dist=distances(x)
% Calculates distances between points in matrix x
% Each row represents coordinates of one point
% The result is the matrix dist of distances NxN where N is the number of points
% The diagonal elements are equal max distances in a given row

np=size(x,1); % Number of points
nd=size(x,2); % Number of dimensions

dist=zeros(np,np);

for i=1:np-1
    for j=i+1:np
        for k=1:nd
            dist(j,i)=(x(i,k)-x(j,k))^2+dist(j,i);
        end
        dist(i,j)=dist(j,i);
    end
end

for i=1:np
    m=max(dist(:,i));  %Filling diagonal elements with maximum values
    dist(i,i)=m+1;
end

