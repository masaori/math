# ---------------------------------------------------------
# SageMath: 主張 V^{(+)} = exp((i/2)K_1H_1^{(+)}) (2 sinh 2K_2)^{M_col/2} exp(iK_2^*H_2) exp((i/2)K_1H_1^{(+)})
#   の証明の式変形 4 行を、各行の値を独立に作って隣どうしを比べる。
#   0 行目: V^{(+)}（043 の V_plus。V_2 はパウリ行列表示）
#   1 行目: (V_1^{(+)})^{1/2} V_2 (V_1^{(+)})^{1/2}             (def_V_plus)
#   2 行目: exp((i/2)K_1H_1^{(+)}) V_2 exp((i/2)K_1H_1^{(+)})   (def_V1_plus_square_root)
#   3 行目: V_2 を (2 s_2)^{M_col/2} exp(iK_2^*H_2) に置き換えたもの  (V2_exponential_representation)
#   4 行目: s_2 を sinh 2K_2 に置き換えたもの  (def_indexed_hyperbolic_abbreviations)
#   V_2 は 1 行目では成分定義（<def_transfer_matrix>）から作り、パウリ行列表示とは独立に比べる。
#   否定コントロール: 4 行目で K_2^* の代わりに K_2 を使った右辺は 0 行目と一致しない。
# 対象ラベル: V_plus_exponential_form
# 対象: structured-latex/content/partition_function_projection_and_jordan_wigner.ts
#       ブロック projection_and_jordan_wigner_claim_V_plus_exponential_form
# 帰属: exp((i/2)K_1H_1^{(+)}), exp(iK_2^*H_2) は成分が超越数になり厳密計算できない（ℝ 脱出: 指数評価）。
#       倍精度複素数 CDF で計算し、相対残差（作用素ノルム）が 1e-9 以下なら一致とみなす。
#       否定コントロールは残差が 1e-3 を超えることを要求する。
# ---------------------------------------------------------
import os
_dir = os.getcwd()   # このディレクトリで実行する（overview.md の「実行方法」）
__file__ = os.path.join(_dir, "../044_claim_max_eigenvalue/_prelude.sage")
load(__file__)

TOL = 1e-9
NEG_MIN = 1e-3


def rel(lhs, rhs):
    return opnorm(lhs - rhs) / max(opnorm(lhs), opnorm(rhs), 1)


def mexp(A):
    return matrix(CDF, A.exp())


ok_all = True
worst = RDF(0)
for (M, K1v, K2v) in MAXEIG_CASES:
    O = SpinOps(M)
    K1 = RDF(K1v)
    K2 = RDF(K2v)
    K2s = K_star(K2)
    V2c = V2_component(M, K2)
    H1p = O.H1(+1)
    H2 = O.H2
    half_exp = mexp(CDF(I) / 2 * K1 * H1p)
    s2 = RDF(sinh(2 * K2))
    rows = [
        V_plus(O, K1, K2),
        V1_plus_half(O, K1) * V2c * V1_plus_half(O, K1),
        half_exp * V2c * half_exp,
        half_exp * (CDF((2 * s2) ** (RDF(M) / 2)) * mexp(CDF(I) * K2s * H2)) * half_exp,
        half_exp * (CDF((2 * RDF(sinh(2 * K2))) ** (RDF(M) / 2)) * mexp(CDF(I) * K2s * H2)) * half_exp,
    ]
    wrong = half_exp * (CDF((2 * RDF(sinh(2 * K2))) ** (RDF(M) / 2)) * mexp(CDF(I) * K2 * H2)) * half_exp
    res = [rel(rows[k], rows[k + 1]) for k in range(len(rows) - 1)]
    neg = rel(rows[0], wrong)
    worst = max([worst] + res)
    ok = all(r <= TOL for r in res) and neg > NEG_MIN
    print(f"  M={M}, K1={K1v}, K2={K2v}: 隣接行の相対残差 " + ", ".join(f"{r:.2e}" for r in res)
          + f"、否定コントロール {neg:.2e} -> {'PASS' if ok else 'FAIL'}")
    ok_all = ok_all and ok
print(f"WORST RELATIVE RESIDUAL: {worst:.3e}")
print("RESULT: PASS" if ok_all else "RESULT: FAIL")
if not ok_all:
    raise AssertionError("V_plus_exponential_form failed")
