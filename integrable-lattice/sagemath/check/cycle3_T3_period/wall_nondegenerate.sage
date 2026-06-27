# cycle 5 / T3: 非退化に限定した Wall 等式比較。
# 非退化 = charpoly に円分因子なし(固有値が1の冪根でない) かつ 分離的(重根なし)。
# ⇒ 退化(有限位数・unipotent でトレース定数)を除外して、可積分 vs 一般 で Wall 破れを比較。

def trace_seq_period(T,m,maxN=30000):
    R=Integers(m); Tm=T.change_ring(R)
    seenM={}; N=0; Pk=identity_matrix(R,T.nrows())
    while N<=maxN:
        Pk=Pk*Tm; N+=1
        key=tuple(Pk.list())
        if key in seenM:
            pre=seenM[key]; per=N-seenM[key]
            tr=[ZZ((Tm^j).trace())%m for j in range(1,pre+2*per+1)]
            for d in divisors(per):
                if all(tr[i]==tr[i+d] for i in range(pre,len(tr)-d-1)): return d
            return per
        seenM[key]=N
    return None

def wall_holds(T,p):
    p1=trace_seq_period(T,p); p2=trace_seq_period(T,p^2)
    if p1 is None or p2 is None: return None
    return (p2==p*p1),p1,p2

def nondegenerate(cp):
    if not cp.is_squarefree(): return False
    for g,_ in cp.factor():
        if g.is_cyclotomic(): return False
    return True

R.<x>=QQ[]
# --- 群1: 非退化 companion(d=2 Lucas/Pell, d=3) ---
print("="*70); print("群1: 非退化 一般 companion で Wall 破れ"); print("="*70)
fails1=[]; tested1=0
for a in range(0,9):
    for b in range(-4,5):
        if b==0: continue
        cp=x^2-a*x+b
        if not nondegenerate(cp): continue
        C=matrix(ZZ,[[0,-b],[1,a]])
        for p in [3,5,7,11,13,17,19,23]:
            if ZZ(b)%p==0: continue
            tested1+=1
            r=wall_holds(C,p)
            if r and r[0] is False: fails1.append((a,b,p,r[1],r[2]))
print(f"  非退化 d=2 検査数={tested1}, Wall 破れ={len(fails1)}")
for f in fails1[:14]: print(f"   破れ: x^2-{f[0]}x+{f[1]}, p={f[2]}: π(p,1)={f[3]}, π(p,2)={f[4]}")

# Pell の確認
C=matrix(ZZ,[[0,1],[1,2]])  # x^2-2x-1
print(f"\n  Pell x^2-2x-1 確認: p=13 -> {wall_holds(C,13)}; p=7 -> {wall_holds(C,7)}; p=29 -> {wall_holds(C,29)}")

# --- 群2: 非退化 可積分転送行列 ---
def L_ops(a,b,c):
    return [[matrix(ZZ,[[a,0],[0,b]]),matrix(ZZ,[[0,0],[c,0]])],
            [matrix(ZZ,[[0,c],[0,0]]),matrix(ZZ,[[b,0],[0,a]])]]
def embed(op,i,L):
    I2=identity_matrix(ZZ,2); m=[op if k==i else I2 for k in range(L)]
    M=m[0]
    for k in range(1,L): M=M.tensor_product(m[k])
    return M
def transfer_matrix(L,a,b,c):
    dim=2^L; Lo=L_ops(a,b,c)
    M=[[identity_matrix(ZZ,dim),zero_matrix(ZZ,dim)],[zero_matrix(ZZ,dim),identity_matrix(ZZ,dim)]]
    for i in range(L):
        Li=[[embed(Lo[r][s],i,L) for s in range(2)] for r in range(2)]
        M=[[M[0][0]*Li[0][0]+M[0][1]*Li[1][0], M[0][0]*Li[0][1]+M[0][1]*Li[1][1]],
           [M[1][0]*Li[0][0]+M[1][1]*Li[1][0], M[1][0]*Li[0][1]+M[1][1]*Li[1][1]]]
    return M[0][0]+M[1][1]

print("\n"+"="*70); print("群2: 非退化 可積分転送行列(六頂点) で Wall 破れ"); print("="*70)
fails2=[]; tested2=0
for (a,b,c,L) in [(1,1,2,2),(1,1,1,2),(2,1,1,2),(1,2,1,2),(1,1,3,2),(2,1,3,2),(1,1,2,3),(2,1,1,3)]:
    T=transfer_matrix(L,a,b,c); cp=T.charpoly(); dt=ZZ(T.det())
    nd = nondegenerate(cp.radical()) if not cp.is_squarefree() else nondegenerate(cp)
    # 転送行列は重根を持つことが多い→squarefree 部(相異固有値)で円分性のみ判定
    has_cyc = any(g.is_cyclotomic() for g,_ in cp.factor())
    for p in [3,5,7,11,13,17,19]:
        if dt%p==0: continue
        tested2+=1
        r=wall_holds(T,p)
        if r and r[0] is False: fails2.append((a,b,c,L,p,r[1],r[2], "cyc" if has_cyc else "noncyc"))
print(f"  検査数={tested2}, Wall 破れ={len(fails2)}")
for f in fails2[:20]: print(f"   破れ: {f}")

print("\n"+"="*70)
print("結論: 非退化に限定した比較。Pell(非退化)で破れがあれば『一般は非退化でも破れる』。")
print(" 可積分側に破れが無ければ可積分性の効果の証拠(ただし要・大規模化)。")
print("="*70)
