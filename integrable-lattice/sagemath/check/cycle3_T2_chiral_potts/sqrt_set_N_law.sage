# cycle 5 / T2: カイラル Potts の √集合(2次因子の判別式=Onsager フェルミオン準位の√中身)の N 依存則。
# 高速化: H を CyclotomicField(3) 上で構成 → charpoly を ℚ 上で因数分解(QQbar 回避) → N=4,5 も。

K.<om>=CyclotomicField(3)   # om = 原始3乗根
Z=matrix(K,[[1,0,0],[0,om,0],[0,0,om^2]])
X=matrix(K,[[0,0,1],[1,0,0],[0,1,0]])
I3=identity_matrix(K,3)
def emb(op,i,N):
    m=[op if k==i else I3 for k in range(N)]
    M=m[0]
    for k in range(1,N): M=M.tensor_product(m[k])
    return M
def H_cp(N,lam):
    H=matrix(K,3^N,3^N); coef={a:(1-om^(-a))^(-1) for a in [1,2]}
    Zi={i:emb(Z,i,N) for i in range(N)}; Xi={i:emb(X,i,N) for i in range(N)}
    for j in range(N):
        jp=(j+1)%N
        for a in [1,2]:
            H += -coef[a]*(Xi[j]^a + lam*Zi[j]^a*Zi[jp]^(n-a))
    return H
n=3

def sqrt_set(N,lam):
    H=H_cp(N,lam)
    cp=H.charpoly()
    # charpoly は ℚ[x] に落ちるはず(スペクトル実・ℤ_3 対称)。coerce 試行。
    try:
        cpQ=cp.change_ring(QQ)
    except Exception:
        return None,None,"charpoly が ℚ 上でない"
    fac=cpQ.factor()
    degs=sorted(set(g.degree() for g,m in fac))
    discs=set()
    for g,m in fac:
        if g.degree()==2:
            c=g.list()  # [c0,c1,c2]
            b,cc,a2=c[1],c[0],c[2]
            discs.add(QQ((b^2-4*a2*cc)/a2^2))
    return degs, sorted(discs), fac

print("="*70)
print("カイラル Potts √集合(2次因子判別式)の N 依存")
print("="*70)
for lam in [QQ(1), QQ(1)/2]:
    print(f"\n#### λ={lam}")
    for N in [2,3,4,5]:
        degs,discs,fac=sqrt_set(N,lam)
        if degs is None:
            print(f"  N={N}: {fac}"); continue
        # 判別式を 平方因子を除いた squarefree 部で表示(√の本質)
        sqf=sorted(set(QQ(d).squarefree_part() for d in discs))
        print(f"  N={N}: dim={3^N}, 因子次数={degs}, 判別式集合={discs}")
        print(f"        √中身(squarefree 部)={sqf}")

print("\n"+"="*70)
print("読み: √中身(squarefree)の集合が N でどう増えるか = Onsager フェルミオン準位の")
print(" 量子化運動量に対応。集合が安定/規則増加なら極限分散への外挿候補。")
print(" 全て有限 N で ℚ̄ 決定可能。")
print("="*70)
