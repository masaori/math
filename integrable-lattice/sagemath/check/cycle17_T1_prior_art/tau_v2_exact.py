def laplacian_torus(L):
    n=L*L
    idx=lambda i,j:(i%L)*L+(j%L)
    M=[[0]*n for _ in range(n)]
    for i in range(L):
        for j in range(L):
            u=idx(i,j)
            for (a,b) in ((i+1,j),(i-1,j),(i,j+1),(i,j-1)):
                v=idx(a,b); M[u][v]-=1; M[u][u]+=1
    return M
def bareiss(M):
    n=len(M); M=[row[:] for row in M]; sign=1; prev=1
    for k in range(n-1):
        if M[k][k]==0:
            for r in range(k+1,n):
                if M[r][k]!=0:
                    M[k],M[r]=M[r],M[k]; sign=-sign; break
            else: return 0
        for i in range(k+1,n):
            for j in range(k+1,n):
                M[i][j]=(M[i][j]*M[k][k]-M[i][k]*M[k][j])//prev
        prev=M[k][k]
    return sign*M[n-1][n-1]
def v2(x):
    c=0
    while x%2==0: x//=2; c+=1
    return c
import math
for L in [3,5,7,9,11,13]:
    M=laplacian_torus(L)
    red=[row[1:] for row in M[1:]]
    t=bareiss(red)
    q,r=divmod(t,L*L); a=math.isqrt(q) if r==0 else None
    print(L,'v2(tau)=',v2(t),'2(L-1)=',2*(L-1),'| tau/L^2 int?',r==0,'square?',(a*a==q if a is not None else None))
