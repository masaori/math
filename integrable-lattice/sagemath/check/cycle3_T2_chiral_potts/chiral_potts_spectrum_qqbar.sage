# cycle 3 / T2 Solve: 本命「カイラル Potts」の有限 N スペクトル ∈ ℚ̄ を直接実証。
# ℤ_3 カイラル Potts(クロック)量子鎖, 超可積分点の係数 (1-ω^{-a})^{-1} ∈ ℚ(ω)。
# H = -Σ_j Σ_{a=1}^{2} (1-ω^{-a})^{-1} ( X_j^a + λ Z_j^a Z_{j+1}^{-a} ),  周期境界, λ 有理。
# 係数は円分体 ℚ(ω)⊂ℚ̄ ⇒ H は ℚ̄ 上の行列 ⇒ 有限 N スペクトル ∈ ℚ̄(決定可能, ℝ不使用)。
# カイラル Potts は YBE 可積分だが極限(相関・スペクトル全体)が未解決の本命母集団。

n=3
w=QQbar.zeta(3)        # 1 の原始3乗根 ∈ ℚ̄
Z=matrix(QQbar,[[1,0,0],[0,w,0],[0,0,w^2]])
X=matrix(QQbar,[[0,0,1],[1,0,0],[0,1,0]])   # シフト, X^3=I, ZX=wXZ
I3=identity_matrix(QQbar,3)

def emb(op,i,N):
    m=[op if k==i else I3 for k in range(N)]
    M=m[0]
    for k in range(1,N): M=M.tensor_product(m[k])
    return M

def H_chiral_potts(N, lam):
    dim=3^n if False else 3^N
    H=matrix(QQbar,dim,dim)
    coef={a:(1-w^(-a))^(-1) for a in [1,2]}
    Zi={(i):emb(Z,i,N) for i in range(N)}
    Xi={(i):emb(X,i,N) for i in range(N)}
    for j in range(N):
        jp=(j+1)%N
        for a in [1,2]:
            Xa = Xi[j]^a
            ZZa = Zi[j]^a * (Zi[jp]^(n-a))   # Z_j^a Z_{j+1}^{-a} = Z_j^a Z_{j+1}^{n-a}
            H += -coef[a]*(Xa + lam*ZZa)
    return H

print("="*70)
print("ℤ_3 カイラル Potts(超可積分点)鎖の有限 N スペクトル ∈ ℚ̄")
print("="*70)

for lam in [QQ(1), QQ(1)/2]:
    print(f"\n#### λ={lam} (有理)")
    for N in [2,3]:
        H=H_chiral_potts(N,lam)
        evs=H.eigenvalues()       # QQbar
        all_alg=all(ev in QQbar for ev in evs)
        allreal=all(ev.imag()==0 for ev in evs)
        degs=sorted(set(QQbar(ev).minpoly().degree() for ev in evs))
        print(f"  N={N}: dim={3^N}, 全固有値∈QQbar={all_alg}, 全実={allreal}, "
              f"固有値の最小多項式次数={degs}")
        if N==2:
            # 非自明(次数≥2)の witness を例示
            wit=[QQbar(ev).minpoly() for ev in evs if QQbar(ev).minpoly().degree()>=2]
            if wit: print(f"     witness 例(次数≥2): {wit[0]}")

print("\n"+"="*70)
print("結論: 本命 カイラル Potts(超可積分 ℤ_3)でも有限 N スペクトルは ℚ̄(最小多項式 witness)・")
print(" 決定可能・ℝ不使用。極限(相関/スペクトル全体)は未解決のまま=ℝ脱出側に隔離。")
print(" ⇒ 『有限 N=可算決定可能 / 極限=未解決』分離が本命模型で直接成立(T2 足場)。")
print("="*70)
