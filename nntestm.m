function p=nntestm(X,Y,nperm) 
% Calculates the p index for the mean nearest neighbour distance
% by random permutations
% X is an independent variable, Y is the dependent variable, data is in columns
% nperm is the specified number of permutations (default value is 2500)

% Check number of inputs

if nargin > 3
    error('myfuns:somefun2:TooManyInputs', ...
        'requires at most 1 optional input');
end

if nargin==2
    nperm=2500; % Default number of permutations
end

if size(X,2)>1 % More than one column in X
     if size(X,1)==1  % Only one row in X
         X=X';        % Swap rows and columns around
     end
end

if size(Y,2)>1 % More than one column in Y
     if size(Y,1)==1 % Only one row in Y
         Y=Y';       % Swap rows and columns around
     end
end

% Randomization test initialization

p=0;

% Merge X and Y into one matrix X1
X1=zeros(size(X,1),2);
X1(:,1)=X(:,1);
X1(:,2)=Y(:,1);


%-------------------

% Return mean nearest neighbour values in m1
d=distances(X1);
m1=mean(min(d)); 

% Permutations
for i=1:nperm
    Xtemp=permutation(X);
    X1(:,1)=Xtemp(:,1);
    d=distances(X1);
    m2=mean(min(d)); % Recalculation of the mean NN value
    
    if m2<=m1        % Comparison with the original statistic
        p=p+1;
    end
end

p=p/nperm; % p - index as the proportion of randomized scatterplots where 
% the new nearest-neigbour distance was less than or equal to the original one m1