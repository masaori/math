from fractions import Fraction
import itertools, math

def v2(n):
    if n==0: return None
    k=0
    while n%2==0: n//=2; k+=1
    return k

# ---- 命題 T: spanning trees of C_L x C_L via integer reduced Laplacian determinant ----
def tau_torus(L):
    # vertices (a,b) in Z/L x Z/L ; Cayley graph with generators +-e1,+-e2 (multi-edges when L=2)
    n=L*L
    idx={}
    for a in range(L):
        for b in range(L):
            idx[(a,b)]=a*L+b
    Lap=[[0]*n for _ in range(n)]
    gens=[(1,0),(-1,0),(0,1),(0,-1)]
    for a in range(L):
        for b in range(L):
            i=idx[(a,b)]
            for (da,db) in gens:
                j=idx[((a+da)%L,(b+db)%L)]
                Lap[i][i]+=1
                Lap[i][j]-=1
    # reduced: delete last row/col, integer determinant via fraction-free Bareiss
    M=[[Fraction(Lap[i][j]) for j in range(n-1)] for i in range(n-1)]
    m=n-1
    det=Fraction(1)
    for c in range(m):
        piv=None
        for r in range(c,m):
            if M[r][c]!=0: piv=r; break
        if piv is None: return 0
        if piv!=c:
            M[c],M[piv]=M[piv],M[c]; det=-det
        det*=M[c][c]
        inv=M[c][c]
        for r in range(c+1,m):
            f=M[r][c]/inv
            if f!=0:
                for k in range(c,m):
                    M[r][k]-=f*M[c][k]
    assert det.denominator==1
    return abs(int(det))

print("== 命題 T: v2(tau(L)) vs 2(L-1) ==")
for L in range(2,16):
    t=tau_torus(L)
    print(L, "odd" if L%2 else "even", "v2=",v2(t), "2(L-1)=",2*(L-1), "match" if v2(t)==2*(L-1) else "")

def vp(n,p):
    if n==0: return None
    k=0
    while n%p==0: n//=p; k+=1
    return k

print("\n== 命題 W 適用例: ord_3(tau(3^n)) = 4*3^n-2n-4 ==")
for n in range(0,3):
    L=3**n; t=tau_torus(L)
    print("n=",n,"L=",L,"ord_3=",vp(t,3),"formula=",4*3**n-2*n-4)

print("\n== 命題 N: exceptional set of Skolem-Mahler-Lech type ==")
# T = [[0,1],[1,0]] : Tr(T^N)=0 for odd N -> infinitely many exceptions
def trace_pow(M,N):
    d=len(M)
    R=[[1 if i==j else 0 for j in range(d)] for i in range(d)]
    for _ in range(N):
        R=[[sum(R[i][k]*M[k][j] for k in range(d)) for j in range(d)] for i in range(d)]
    return sum(R[i][i] for i in range(d))
M=[[0,1],[1,0]]
print("T=[[0,1],[1,0]] Tr(T^N), N=1..10:",[trace_pow(M,N) for N in range(1,11)])
p=2
M2=[[0,1],[p,0]]
print("T=[[0,1],[2,0]] Tr(T^N), N=1..10:",[trace_pow(M2,N) for N in range(1,11)])
