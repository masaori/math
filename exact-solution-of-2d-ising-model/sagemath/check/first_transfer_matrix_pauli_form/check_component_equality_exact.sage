# ---------------------------------------------------------
# SageMath: 主張 V_1 = exp(K_1 Σ_m σ_m^z σ_{m+1}^z) を成分で（厳密計算）
#   左辺: <def_transfer_matrix> の成分定義 (V_1)_{ord(μ),ord(μ')} = δ_{μ=μ'} exp(K_1 d(μ))
#         （行・列番号 k から ord^{-1}(k) を 2 進展開で復元して書き込む）
#   右辺: exp(K_1 D)。D は整数固有値をもつ対角行列なので、スペクトル射影で厳密に計算する
#   併せて証明の成分の鎖
#     (exp(K_1D))_{ord(μ),ord(μ')} = (exp(K_1D))_{ν(ι(μ)),ν(ι(μ'))}
#       = [ν(ι(μ))=ν(ι(μ'))] exp(K_1 d(μ)) = [ord(μ)=ord(μ')] exp(K_1 d(μ)) = δ_{μ=μ'} exp(K_1 d(μ))
#   を全 (μ, μ') で確かめる。
# 対象ラベル: first_transfer_matrix_pauli_form
# 帰属: K_1 = log x（x ∈ QQ, x > 1）と選ぶと exp(K_1 n) = x^n ∈ QQ。等号はすべて QQ で判定する。
#       ℝ 脱出は K_1 の選び方の一点だけ（見かけだけの ℝ 脱出）。一般の K_1 は数値版で確かめる。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))
ok_all = True
for M_col in range(1, 7):
    D = bond_sum_D(M_col)
    for x in X_VALUES:
        V1 = V1_by_components(M_col, lambda n: x ** n, QQ)
        E = exp_by_spectral_projectors(D, lambda lam: x ** lam, QQ)
        ok = (V1 == E)
        for mu in row_configurations(M_col):
            for mup in row_configurations(M_col):
                o, op = ord_number(mu), ord_number(mup)
                n, npr = nu_number(iota(mu)), nu_number(iota(mup))
                chain = [E[o - 1, op - 1],
                         E[n - 1, npr - 1],
                         (x ** bond_count(mu)) if n == npr else 0,
                         (x ** bond_count(mu)) if o == op else 0,
                         (x ** bond_count(mu)) if mu == mup else 0,
                         V1[o - 1, op - 1]]
                ok = ok and all(c == chain[0] for c in chain)
        print(f"  M_col={M_col}, exp(K_1)={x}: V_1（成分定義） = exp(K_1 D)（厳密）と成分の 5 段 -> {'PASS' if ok else 'FAIL'}")
        ok_all = ok_all and ok
exact_result(ok_all)
