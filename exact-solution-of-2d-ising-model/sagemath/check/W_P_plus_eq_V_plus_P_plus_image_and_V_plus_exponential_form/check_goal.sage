# ---------------------------------------------------------
# SageMath: ε の固有値 +1 の固有空間への射影と Jordan–Wigner 表示の章の章末の主張
#   (1) W P^{(+)} = V^{(+)} P^{(+)}
#   (2) F^{(+)} = {x ∈ C^{2^M} | εx = x} = im P^{(+)}
#   (3) V^{(+)} = exp((i/2)K_1H_1^{(+)}) (2 sinh 2K_2)^{M/2} exp(iK_2^*H_2) exp((i/2)K_1H_1^{(+)})
#   を、主張の両辺を独立に作って確かめる。
#   (1) W は V_1^{1/2} = exp((K_1/2) Σ σ^z_m σ^z_{m+1}) と成分定義の V_2 から、V^{(+)} は (3) の右辺から作る。
#       否定コントロール: P^{(+)} を外した W と V^{(+)} は一致しない。
#   (2) ε と P^{(+)} は成分が有理数なので QQ で厳密に計算する。im P^{(+)} と ker(ε - I) が
#       同じ部分空間であること（行空間として一致）を判定する。
#       否定コントロール: P^{(-)} = (I - ε)/2 の像は ker(ε - I) と一致しない。
#   (3) 0 行目 V^{(+)} = (V_1^{(+)})^{1/2} V_2 (V_1^{(+)})^{1/2}（V_2 は成分定義）と右辺を比べる。
#       否定コントロール: K_2^* の代わりに K_2 を使った右辺は一致しない。
# 対象ラベル: W_P_plus_eq_V_plus_P_plus_image_and_V_plus_exponential_form
# 対象: structured-latex/content/partition_function_projection_and_jordan_wigner.ts
#       ブロック projection_and_jordan_wigner_claim_W_P_plus_eq_V_plus_P_plus_image_and_V_plus_exponential_form
# 帰属: (2) は QQ で厳密。(1)(3) の行列の指数関数は成分が超越数になり厳密計算できない（ℝ 脱出: 指数評価）。
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


def epsilon_QQ(M):
    """ε = σ^x_1 ⋯ σ^x_M を QQ 上で厳密に作る（クロネッカー積、先頭因子が最上位）。"""
    sx = matrix(QQ, [[0, 1], [1, 0]])
    out = matrix(QQ, [[1]])
    for _ in range(M):
        out = out.tensor_product(sx)
    return out


ok_all = True
worst = RDF(0)
for (M, K1v, K2v) in MAXEIG_CASES:
    O = SpinOps(M)
    K1 = RDF(K1v)
    K2 = RDF(K2v)
    K2s = K_star(K2)
    P = projector_plus(O)
    V1h = matrix(CDF, (K1 / 2 * D_bonds(O)).exp())
    V2c = V2_component(M, K2)
    W = V1h * V2c * V1h
    half_exp = mexp(CDF(I) / 2 * K1 * O.H1(+1))
    rhs3 = half_exp * (CDF((2 * RDF(sinh(2 * K2))) ** (RDF(M) / 2)) * mexp(CDF(I) * K2s * O.H2)) * half_exp
    wrong3 = half_exp * (CDF((2 * RDF(sinh(2 * K2))) ** (RDF(M) / 2)) * mexp(CDF(I) * K2 * O.H2)) * half_exp
    Vp = V1_plus_half(O, K1) * V2c * V1_plus_half(O, K1)
    r1 = rel(W * P, rhs3 * P)
    n1 = rel(W, rhs3)
    r3 = rel(Vp, rhs3)
    n3 = rel(Vp, wrong3)
    # (2) QQ で厳密
    epsQ = epsilon_QQ(M)
    IdQ = identity_matrix(QQ, 2 ** M)
    PQ = (IdQ + epsQ) / 2
    PmQ = (IdQ - epsQ) / 2
    F_plus = (epsQ - IdQ).right_kernel()
    im_P = PQ.column_space()
    im_Pm = PmQ.column_space()
    ok2 = (im_P == F_plus) and (F_plus.dimension() == 2 ** (M - 1))
    neg2 = (im_Pm != F_plus)
    # P^{(+)} が QQ 版と CDF 版で一致すること（(1)(3) の P と (2) の P が同じ行列であること）
    rP = rel(P, matrix(CDF, PQ))
    worst = max(worst, r1, r3, rP)
    ok = r1 <= TOL and r3 <= TOL and rP <= TOL and n1 > NEG_MIN and n3 > NEG_MIN and ok2 and neg2
    print(f"  M={M}, K1={K1v}, K2={K2v}: (1) {r1:.2e}（否定 {n1:.2e}）、"
          f"(2) im P^(+) = F^(+): {ok2}（dim {F_plus.dimension()}、否定 {neg2}）、"
          f"(3) {r3:.2e}（否定 {n3:.2e}）、P の一致 {rP:.2e} -> {'PASS' if ok else 'FAIL'}")
    ok_all = ok_all and ok
print(f"WORST RELATIVE RESIDUAL: {worst:.3e}")
print("RESULT: PASS" if ok_all else "RESULT: FAIL")
if not ok_all:
    raise AssertionError("W_P_plus_eq_V_plus_P_plus_image_and_V_plus_exponential_form failed")
