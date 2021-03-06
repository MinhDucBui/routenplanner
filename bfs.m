
function [d dt path pred] = bfs(A,u,target)

if ~exist('target','var'), target=0; end

if isstruct(A), rp=A.rp; ci=A.ci;
else [rp ci]=sparse_to_csr(A);
end

n=length(rp)-1;
d=-1*ones(n,1); dt=-1*ones(n,1); pred=zeros(1,n);
sq=zeros(n,1); sqt=0; sqh=0; % search queue and search queue tail/head

path = [];

% start bfs at u
sqt=sqt+1; sq(sqt)=u;
t=0;
d(u)=0; dt(u)=t; t=t+1; pred(u)=u;
while sqt-sqh>0
    sqh=sqh+1; v=sq(sqh); % pop v off the head of the queue
    for ri=rp(v):rp(v+1)-1
        w=ci(ri);
        if d(w)<0
            sqt=sqt+1; sq(sqt)=w;
            d(w)=d(v)+1; dt(w)=t; t=t+1; pred(w)=v;
            if w==target,
                return;
            end
        end
    end
end
end % end of bfs

function [rp ci ai ncol]=sparse_to_csr(A,varargin)
% SPARSE_TO_CSR Convert a sparse matrix into compressed row storage arrays
% 
% [rp ci ai] = sparse_to_csr(A) returns the row pointer (rp), column index
% (ci) and value index (ai) arrays of a compressed sparse representation of
% the matrix A.
%
% [rp ci ai] = sparse_to_csr(i,j,v,n) returns a csr representation of the
% index sets i,j,v with n rows.
%
% Example:
%   A=sparse(6,6); A(1,1)=5; A(1,5)=2; A(2,3)=-1; A(4,1)=1; A(5,6)=1; 
%   [rp ci ai]=sparse_to_csr(A)
%
% See also CSR_TO_SPARSE, SPARSE

% David F. Gleich
% Copyright, Stanford University, 2008-2009

% History
% 2008-04-07: Initial version
% 2008-04-24: Added triple array input
% 2009-05-01: Added ncol output
% 2009-05-15: Fixed triplet input

error(nargchk(1, 5, nargin, 'struct'))
retc = nargout>1; reta = nargout>2;

if nargin>1
    if nargin>4, ncol = varargin{4}; end
    nzi = A; nzj = varargin{1};
    if reta && length(varargin) > 2, nzv = varargin{2}; end    
    if nargin<4, n=max(nzi); else n=varargin{3}; end
    nz = length(A);
    if length(nzi) ~= length(nzj), error('gaimc:invalidInput',...
            'length of nzi (%i) not equal to length of nzj (%i)', nz, ...
            length(nzj)); 
    end
    if reta && length(varargin) < 3, error('gaimc:invalidInput',...
            'no value array passed for triplet input, see usage'); 
    end
    if ~isscalar(n), error('gaimc:invalidInput',...
            ['the 4th input to sparse_to_csr with triple input was not ' ...
             'a scalar']); 
    end
    if nargin < 5, ncol = max(nzj); 
    elseif ~isscalar(ncol), error('gaimc:invalidInput',...
            ['the 5th input to sparse_to_csr with triple input was not ' ...
             'a scalar']); 
    end
else
    n = size(A,1); nz = nnz(A); ncol = size(A,2);
    retc = nargout>1; reta = nargout>2;
    if reta,     [nzi nzj nzv] = find(A); 
    else         [nzi nzj] = find(A);
    end
end
if retc, ci = zeros(nz,1); end
if reta, ai = zeros(nz,1); end
rp = zeros(n+1,1);
for i=1:nz
    rp(nzi(i)+1)=rp(nzi(i)+1)+1;
end
rp=cumsum(rp);
if ~retc && ~reta, rp=rp+1; return; end
for i=1:nz
    if reta, ai(rp(nzi(i))+1)=nzv(i); end
    ci(rp(nzi(i))+1)=nzj(i);
    rp(nzi(i))=rp(nzi(i))+1;
end
for i=n:-1:1
    rp(i+1)=rp(i);
end
rp(1)=0;
rp=rp+1;
end
% Copyright (c) 2006-2015, David F. Gleich
% All rights reserved.
% 
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
% 
% * Redistributions of source code must retain the above copyright notice, this
%   list of conditions and the following disclaimer.
% 
% * Redistributions in binary form must reproduce the above copyright notice,
%   this list of conditions and the following disclaimer in the documentation
%   and/or other materials provided with the distribution.
% 
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
% DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
% FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
% DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
% SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
% CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
% OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
% OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

    