function imcol=im2col(A, blocksize)

% Takes an image A and creates a matrix containing columns that are patches,
% with size blocksize, of the original image with 'sliding' method.


nrows = blocksize(1);
ncols = blocksize(2);

%// Get sizes for later usages
[m,n] = size(A);

%// Start indices for each block
start_ind = reshape(bsxfun(@plus,[1:m-nrows+1]',[0:n-ncols]*m),[],1); %//'

%// Row indices
lin_row = permute(bsxfun(@plus,start_ind,[0:nrows-1])',[1 3 2]);  %//'

%// Get linear indices based on row and col indices and get desired output
imcol = A(reshape(bsxfun(@plus,lin_row,[0:ncols-1]*m),nrows*ncols,[]));

return;
