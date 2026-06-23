# D 検証: 六頂点模型(可積分, 熱力学極限の相関は未解決母集団)の
# Massieu 自由エントロピー Φ_N = log Z_N ∈ Λ(素因数分解ベクトル)の構造観察。
#
# 立場(lambda-statement-program / 09):
#  - 整数 Boltzmann 重み(a,b,c)∈ℤ で 六頂点転送行列 T は整数行列。
#  - N×L トーラスの分配関数 Z_{N,L}=Tr T^N ∈ ℤ (数え上げの整数)。
#  - Φ_N = log Z_N は素因数分解の指数ベクトル ∈ Λ。ℝ 不使用、決定可能。
#  - Z_N = Σ λ_i^N (固有値, ℚ̄) ⇒ Φ の N 依存は固有値で支配(D-U1)。
#
# 六頂点 R 行列(重み a,b,c)から L-operator を作り、モノドロミーの aux トレースで
# 転送行列 T(2^L×2^L) を構成する。

def L_ops(a,b,c):
    # L_{aux a, aux b} は site への 2x2 作用素
    L00 = matrix(QQ, [[a,0],[0,b]])
    L01 = matrix(QQ, [[0,0],[c,0]])
    L10 = matrix(QQ, [[0,c],[0,0]])
    L11 = matrix(QQ, [[b,0],[0,a]])
    return [[L00,L01],[L10,L11]]

def embed(op, i, L):
    I2 = identity_matrix(QQ,2)
    mats = [op if k==i else I2 for k in range(L)]
    M = mats[0]
    for k in range(1,L):
        M = M.tensor_product(mats[k])
    return M

def transfer_matrix(L, a, b, c):
    dim = 2^L
    Lo = L_ops(a,b,c)
    # aux 2x2 行列(成分は dim×dim 作用素)。初期 = aux 単位行列
    M = [[identity_matrix(QQ,dim), zero_matrix(QQ,dim)],
         [zero_matrix(QQ,dim), identity_matrix(QQ,dim)]]
    for i in range(L):
        Li = [[embed(Lo[0][0],i,L), embed(Lo[0][1],i,L)],
              [embed(Lo[1][0],i,L), embed(Lo[1][1],i,L)]]
        # M <- M * Li  (aux 行列積, 成分は作用素積)
        N00 = M[0][0]*Li[0][0] + M[0][1]*Li[1][0]
        N01 = M[0][0]*Li[0][1] + M[0][1]*Li[1][1]
        N10 = M[1][0]*Li[0][0] + M[1][1]*Li[1][0]
        N11 = M[1][0]*Li[0][1] + M[1][1]*Li[1][1]
        M = [[N00,N01],[N10,N11]]
    T = M[0][0] + M[1][1]   # aux トレース
    return T

def lam(v):
    # Λ 表記: 素因数分解の指数ベクトル
    if v == 0: return "log 0 (未定義)"
    f = factor(v)
    return " + ".join(f"{e}*l_{p}" for p,e in f) if v!=1 else "0"

print("="*70)
print("六頂点 Z_{N,L}=Tr T^N ∈ ℤ と Massieu Φ_N=log Z_N ∈ Λ")
print("="*70)

for (a,b,c) in [(1,1,1),(2,1,1),(1,1,2)]:
    print(f"\n#### 整数重み (a,b,c)=({a},{b},{c})")
    for L in [2,3]:
        T = transfer_matrix(L,a,b,c)
        # 固有値(ℚ̄)
        evs = T.eigenvalues(extend=True)
        all_alg = all(ev in QQbar for ev in evs)
        print(f"  L={L}: T は {2^L}×{2^L} 整数行列, 全固有値∈QQbar={all_alg}")
        for N in range(1,7):
            Z = (T^N).trace()
            Zc = ZZ(Z)
            print(f"    N={N}: Z={Zc}, Φ_N=log Z ∈ Λ: {lam(Zc)}")

print("\n" + "="*70)
print("結論:")
print(" - 整数重みで Z_{N,L}=Tr T^N は正の整数 ⇒ Φ_N=log Z_N は素因数分解ベクトル∈Λ(厳密)。")
print(" - 等号・順序は素因数分解・整数比較で決定可能。ℝ 不使用。")
print(" - Z_N=Σλ_i^N(λ_i∈QQbar) なので Φ の N 依存は代数的固有値が支配(D-U1)。")
print(" - 六頂点の熱力学極限(相関の閉形式)は未解決母集団だが、有限 N の Φ は Λ で完全に閉じる。")
print("="*70)
