# ℓ=2 の族 X(p,q)（1 頂点 bouquet: voltage (1,0) のループ p 本, (0,1) のループ q 本）の
# 塔 X_{2^n,2^n} の全域木数 κ_n を Kirchhoff の matrix-tree 定理で厳密に計算し、
# cycle20_T3_ell_equals_2.md 定理 Y′ (5.4) の閉形式と ord_2 を照合する。
from fractions import Fraction
import sys

def v2(x):
    assert x != 0
    k=0
    while x%2==0:
        x//=2; k+=1
    return k

def kappa(p,q,n):
    N=1<<n
    V=N*N
    idx=lambda a,b:(a%N)*N+(b%N)
    L=[[0]*V for _ in range(V)]
    for a in range(N):
        for b in range(N):
            i=idx(a,b)
            L[i][i]=2*p+2*q
            for (da,db,m) in ((1,0,p),(-1,0,p),(0,1,q),(0,-1,q)):
                L[i][idx(a+da,b+db)]-=m
    # 余因子: 最後の行・列を落とす
    M=[row[:V-1] for row in L[:V-1]]
    return bareiss(M)

def bareiss(M):
    n=len(M); prev=1; sign=1
    for k in range(n-1):
        if M[k][k]==0:
            for r in range(k+1,n):
                if M[r][k]!=0:
                    M[k],M[r]=M[r],M[k]; sign=-sign; break
            else:
                return 0
        for i in range(k+1,n):
            for j in range(k+1,n):
                M[i][j]=(M[i][j]*M[k][k]-M[i][k]*M[k][j])//prev
        prev=M[k][k]
    return sign*M[n-1][n-1]

def mu_of(p,q):
    g=__import__('math').gcd(p,q)
    return v2(g)

def closed_form(p,q,n):
    import math
    mu=mu_of(p,q); pp=p>>mu; qq=q>>mu
    if pp%2==1 and qq%2==1:
        lam0=v2(pp+qq)
        if lam0==1:
            return mu*(4**n-1)+2*n*2**n+4*2**n-6*n-1, "Aalpha"
        else:
            return mu*(4**n-1)+2*n*2**n+2*lam0*2**n-2*n-3*lam0+2, "Abeta(lam0=%d)"%lam0
    else:
        ce,co=(pp,qq) if pp%2==0 else (qq,pp)
        lam1=v2(ce); w=v2(ce//2+co) if (ce//2)%2==1 else 0
        if lam1>=2 or n==1:
            return mu*(4**n-1)+2*n*2**n+lam1*(2**n-1), "B(lam1=%d)%s"%(lam1,"[n=1 exception]" if (lam1==1 and n==1) else "")
        else:
            return mu*(4**n-1)+2*n*2**n+2*n-1+2*w, "Bsat(w=%d)"%w

pairs=[(1,1),(1,3),(1,2),(1,4),(3,5),(2,6),(3,4),(1,5),(5,7),(2,3),(4,6),(1,6)]
fail=0; done=0
print("p q n  case            ord2(kappa_n)  closed  match")
for (p,q) in pairs:
    for n in (1,2,3,4):
        k=kappa(p,q,n)
        got=v2(k)
        exp,tag=closed_form(p,q,n)
        ok = (got==exp)
        if not ok: fail+=1
        done+=1
        print("%d %d %d  %-16s %6d %6d  %s"%(p,q,n,tag,got,exp,"OK" if ok else "FAIL"))
        sys.stdout.flush()
print("checked=%d FAIL=%d"%(done,fail))
