# cycle 4 / T2: カイラル Potts(超可積分 ℤ_3)の有限 N スペクトルの代数構造を観察。
# 仮説(既知の超可積分構造): 準位 E = A ± Σ_k m_k √(α_k)(Onsager 代数/自由フェルミ)。
#  ⇒ 各固有値の最小多項式次数は 2 の冪、スペクトルは多重2次体に住む。
#  ⇒ 2次因子 x^2+bx+c の判別式 b^2-4c が「フェルミオン的」量(√の中身)。
# 有限 N データから極限の Onsager 構造の足跡を読む(T2: 有限 N→極限への橋)。

n=3
w=QQbar.zeta(3)
Z=matrix(QQbar,[[1,0,0],[0,w,0],[0,0,w^2]])
X=matrix(QQbar,[[0,0,1],[1,0,0],[0,1,0]])
I3=identity_matrix(QQbar,3)
def emb(op,i,N):
    m=[op if k==i else I3 for k in range(N)]
    M=m[0]
    for k in range(1,N): M=M.tensor_product(m[k])
    return M
def H_cp(N,lam):
    H=matrix(QQbar,3^N,3^N); coef={a:(1-w^(-a))^(-1) for a in [1,2]}
    Zi={i:emb(Z,i,N) for i in range(N)}; Xi={i:emb(X,i,N) for i in range(N)}
    for j in range(N):
        jp=(j+1)%N
        for a in [1,2]:
            H += -coef[a]*(Xi[j]^a + lam*Zi[j]^a*Zi[jp]^(n-a))
    return H

def is_pow2(m):
    return m>0 and (m & (m-1))==0

print("="*70)
print("カイラル Potts 有限 N スペクトルの Onsager/多重2次体 構造")
print("="*70)

for lam in [QQ(1), QQ(1)/2]:
    print(f"\n#### λ={lam}")
    for N in [2,3]:
        H=H_cp(N,lam)
        evs=H.eigenvalues()
        mps={}
        for ev in evs:
            mp=QQbar(ev).minpoly()
            mps[mp]=mps.get(mp,0)+1
        degs=sorted(set(p.degree() for p in mps))
        all_pow2=all(is_pow2(p.degree()) for p in mps)
        allreal=all(ev.imag()==0 for ev in evs)
        # 2次因子の判別式(√の中身)
        discs=set()
        for p in mps:
            if p.degree()==2:
                c=p.list()  # [c0,c1,1]
                b,cc=c[1],c[0]
                discs.add(QQ(b^2-4*cc))
        print(f"  N={N}: dim={3^N}, 最小多項式次数集合={degs}, 全2冪次数={all_pow2}, 全実={allreal}")
        print(f"        2次固有値の判別式(√の中身)集合={sorted(discs)}  (← Onsager フェルミオン量の候補)")

print("\n"+"="*70)
print("読み: 次数が 2 の冪・スペクトルが少数の √(判別式)で生成 ⇒ 超可積分の")
print(" Onsager/自由フェルミ構造の有限 N での足跡。√ の中身の集合が N で安定/規則的なら")
print(" 極限のフェルミオン準位への橋(T2)。有限 N は完全に ℚ̄ で決定可能。")
print("="*70)
