# ---------------------------------------------------------
# SageMath: 主張 c_plus_value_c_sandwich_and_double_limit_of_log_Z の各部分を、値を独立に作って確かめる。
#   (1) c_+(M) = Λ^{(1/2)}_M（c_plus_equals_Lambda_half_integer）。c_+(M) は W を F^{(+)} ∩ R^{2^M} の正規直交実基底
#       (e_k + e_{k̄})/√2 へ制限した実対称行列の最大固有値として作り、Λ^{(1/2)}_M は def_Lambda_delta_M のとおり
#       θ̃_μ = 2π(μ − 1/2)/M の γ の和から作る（V^{(+)} の固有値 Λ̌_ε を経由しない）。
#   (2) Λ^{(1/2)}_M ≤ c(M) ≤ 2Λ^{(1/2)}_M（c_between_Lambda_half_and_twice_Lambda_half）。c(M) は W の最大固有値。
#   (3) 2 重極限（onsager_exact_solution）。
#       N → ∞ の側: |(1/(MN)) log tr(W^N) − (1/M) log c(M)| ≤ (log 2)/N を N = 1, …, 64 で確かめる
#         （Z = tr(W^N) は Z_equals_trace_of_W。(W/c)^N は行列の積で作る）。
#       M → ∞ の側: (2) と log の単調性から |(1/M) log c(M) − (1/M) log Λ^{(1/2)}_M| ≤ (log 2)/M を有限の M で確かめ、
#         (1/M) log Λ^{(1/2)}_M が M = 4, 16, …, 4096 で (1/2) log(2 sinh 2K_2) + (1/4π)∫_0^{2π} γ(θ) dθ に近づくことを見る。
#   否定コントロール: (1) の右辺を Λ^{(0)}_M（δ = 0）にしたもの、(3) の積分の係数を 1/(2π) にしたものが、
#                     それぞれ成り立たないこと。(2) の上界を 0.99Λ にしたものが破れることは下界の鋭さの確認で、
#                     上からの評価の否定コントロールは c_between_Lambda_half_and_twice_Lambda_half の検算が持つ。
# 対象ラベル: c_plus_value_c_sandwich_and_double_limit_of_log_Z
# 対象: structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts
#       ブロック column_limit_and_closed_form_claim_c_plus_sandwich_and_double_limit
# 帰属: W は行列の指数関数から作るので成分が超越数になり、c(M), c_+(M) は上限（実数の完備性）、
#       Λ^{(1/2)}_M は実数の指数関数と arccosh の値、log は実対数、極限値は Riemann 積分である
#       （ℝ 脱出: 指数評価・完備性・実対数・極限・積分）。倍精度（CDF・RDF）で計算し、積分は数値積分で作る。
# ---------------------------------------------------------
import os
_dir = os.getcwd()   # このディレクトリで実行する（overview.md の「実行方法」）
__file__ = os.path.join(_dir, "../053_claim_even_sector_closing/_prelude.sage")
load(__file__)

REL = 1e-12


def flip_index(M, k):
    return (2 ** M - 1) - k


def even_sector_basis(M):
    d = 2 ** M
    cols = []
    for k in range(d):
        kb = flip_index(M, k)
        if k < kb:
            v = vector(RDF, d)
            v[k] = 1 / sqrt(RDF(2)); v[kb] = 1 / sqrt(RDF(2))
            cols.append(v)
    return matrix(RDF, cols).transpose()


def top_eig(A):
    return max([RDF(CDF(z).real()) for z in A.eigenvalues()])


def to_real(A):
    return matrix(RDF, [[A[i, j].real() for j in range(A.ncols())] for i in range(A.nrows())])


def onsager_limit(P, coef):
    f = lambda t: RDF(arccosh(g1(RDF(t), P)))
    val = numerical_integral(f, 0, float(2 * pi), max_points=20000)[0]
    return RDF(log(2 * P['s2']) / 2 + coef * RDF(val))


ok_all = True
w1 = RDF(0); w2 = 0; wN = 0; wM = 0
neg1_min = None; neg2_ok = True
for M in EIG_M:
    O = SpinOps(M)
    for p in EIG_PARAMS:
        K1 = RDF(p['K1']); K2 = RDF(p['K2'])
        P = coeffs(K1, K2)
        Wr = to_real(W_op(O, K1, K2))
        cM = top_eig(Wr)
        Bp = even_sector_basis(M)
        cp = top_eig(Bp.transpose() * Wr * Bp)
        Lh = Lambda_delta_M(O, P, RDF(1) / 2)
        L0 = Lambda_delta_M(O, P, RDF(0))
        # (1)
        w1 = max(w1, abs(cp - Lh) / Lh)
        d0 = abs(cp - L0) / cp
        neg1_min = d0 if neg1_min is None else min(neg1_min, d0)
        # (2)
        if not (Lh <= cM * (1 + REL) and cM <= 2 * Lh * (1 + REL)):
            w2 += 1
        if cM <= 0.99 * Lh:
            neg2_ok = False
        # (3) M→∞ の側の有限 M での評価
        if abs(log(cM) / M - log(Lh) / M) > log(2) / M * (1 + 1e-9):
            wM += 1
        # (3) N→∞ の側
        Wn = Wr / cM
        Pw = identity_matrix(RDF, O.d)
        for N in range(1, 65):
            Pw = Pw * Wn
            logZ = RDF(N * log(cM) + log(Pw.trace()))
            if abs(logZ / (M * N) - log(cM) / M) > log(2) / N * (1 + 1e-9):
                wN += 1

print(f"(1) |c_+(M) − Λ^(1/2)_M|/Λ の最大 {float(w1):.2e}")
print(f"(2) Λ^(1/2)_M ≤ c(M) ≤ 2Λ^(1/2)_M の違反件数 {w2}")
print(f"(3) |(1/(MN))log Z − (1/M)log c(M)| ≤ log2/N の違反件数 {wN}、|(1/M)log c(M) − (1/M)log Λ^(1/2)_M| ≤ log2/M の違反件数 {wM}")
ok_all = ok_all and w1 <= 1e-10 and w2 == 0 and wN == 0 and wM == 0

w_lim = RDF(0); neg3_ok = True
for p in [EIG_PARAMS[1], EIG_PARAMS[3], EIG_PARAMS[4]]:
    P = coeffs(p['K1'], p['K2'])
    target = onsager_limit(P, 1 / (4 * pi))
    wrong = onsager_limit(P, 1 / (2 * pi))
    row = []
    for M in [4, 16, 64, 256, 1024, 4096]:
        row.append((M, log_Lambda_delta_over_M(M, P, RDF(1) / 2) - target))
    print(f"    {param_label(p)}  極限値 = {float(target):.10f}  " +
          "  ".join(f"M={M}: {float(d):+.2e}" for (M, d) in row))
    w_lim = max(w_lim, abs(row[-1][1]))
    if abs(log_Lambda_delta_over_M(4096, P, RDF(1) / 2) - wrong) <= 1e-3:
        neg3_ok = False
print(f"(3) M=4096 での |(1/M)log Λ^(1/2)_M − 極限値| の最大 {float(w_lim):.2e}")
ok_all = ok_all and w_lim <= 1e-3

print(f"否定コントロール: |c_+ − Λ^(0)_M|/c_+ の最小 {float(neg1_min):.2e}（1e-10 より大きいこと）、"
      f"下界の鋭さ（c <= 0.99Λ が全て破れる）{neg2_ok}、係数 1/(2π) の極限値から全て外れる {neg3_ok}")
# Λ^(0)_M と Λ^(1/2)_M は低温側で指数的に近づくので、(1) の残差（1e-15 程度）より十分大きい 1e-10 で見分ける
neg_ok = neg1_min > 1e-10 and neg2_ok and neg3_ok
print("RESULT: PASS" if (ok_all and neg_ok) else "RESULT: FAIL")
