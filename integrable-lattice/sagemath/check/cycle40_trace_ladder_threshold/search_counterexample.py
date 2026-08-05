from itertools import product
from math import gcd

def matmul(A,B):
    n=len(A)
    return [[sum(A[i][k]*B[k][j] for k in range(n)) for j in range(n)] for i in range(n)]
def eye(n): return [[1 if i==j else 0 for j in range(n)] for i in range(n)]
def trace(A): return sum(A[i][i] for i in range(len(A)))
def vp(x,p):
    if x==0: return 10**6
    v=0
    while x%p==0: x//=p; v+=1
    return v

def minors_gcd(M,k):
    # gcd of all k x k minors
    n=len(M)
    from itertools import combinations
    g=0
    for rows in combinations(range(n),k):
        for cols in combinations(range(n),k):
            sub=[[M[i][j] for j in cols] for i in rows]
            g=gcd(g,det(sub))
    return g
def det(M):
    n=len(M)
    if n==1: return M[0][0]
    if n==2: return M[0][0]*M[1][1]-M[0][1]*M[1][0]
    s=0
    for j in range(n):
        sub=[[M[i][k] for k in range(n) if k!=j] for i in range(1,n)]
        s += ((-1)**j)*M[0][j]*det(sub)
    return s

def wstar(S,p,r):
    pw=[eye(r)]
    for i in range(2*r): pw.append(matmul(pw[-1],S))
    G=[[trace(pw[i+j]) for j in range(r)] for i in range(r)]
    if det(G)==0: return None
    d=[1]
    for k in range(1,r+1):
        d.append(minors_gcd(G,k))
    ed=[d[k]//d[k-1] for k in range(1,r+1)]
    return max(vp(e,p) for e in ed)

def tracePeriod(S,p,k,r,limit=4000):
    pw=[eye(r)]
    for i in range(limit+r+2): pw.append(matmul(pw[-1],S))
    mod=p**k
    for t in range(1,limit):
        ok=True
        for N in range(r):
            # Tr(S^N (S^t - I))
            v=trace(pw[N+t])-trace(pw[N])
            if v % mod != 0: ok=False; break
        if ok: return t
    return None

found=[]
for p in (2,3):
    for a,b,c,d0 in product(range(-4,5),repeat=4):
        S=[[a,b],[c,d0]]
        r=2
        try:
            w=wstar(S,p,r)
        except Exception: continue
        if w is None or w<1: continue
        ts={}
        bad=None
        for k in range(1,w+3):
            t=tracePeriod(S,p,k,r,limit=400)
            if t is None: ts=None; break
            ts[k]=t
        if not ts: continue
        for k in range(1,w+1):
            if (p*ts[k]) % ts[k+1] != 0:
                bad=(k,ts[k],ts[k+1]); break
        if bad:
            found.append((p,S,w,bad,dict(ts)))
            if len(found)>=6: break
    if len(found)>=6: break
for f in found: print(f)
print("count",len(found))
