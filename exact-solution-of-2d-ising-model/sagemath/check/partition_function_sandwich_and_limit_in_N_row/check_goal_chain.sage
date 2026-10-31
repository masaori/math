# ---------------------------------------------------------
# SageMath: 主張 partition_function_sandwich_and_limit_in_N_row の各部分を、値を独立に作って確かめる。
#   前提: W = V_1^{1/2} V_2 V_1^{1/2} は実対称（W_is_real_symmetric_positive_definite）、
#         c(M) = sup{x^T W x | ||x|| = 1} > 0（def_rayleigh_sup）。c(M) は W の最大固有値として数値で作り、
#         乱数の単位ベクトル x で x^T W x <= c(M) となることを独立に見る。
#   (1) c(M)^N <= Z(K_1,K_2) <= 2^M c(M)^N（partition_function_sandwich）。
#       Z は def_partition_function_2d_ising のスピン配置についての直接和（Z_direct）で作る。
#       あわせて Z = tr(W^N)（Z_equals_trace_of_W）も確かめる。
#   (2) | (1/(M N)) log Z - (1/M) log c(M) | <= log 2 / N（limit_of_log_Z_in_N_row の証明の最後の不等式）
#       を N = 1, ..., 1000 で確かめ、誤差が N とともに 0 へ近づくことを見る。
#       M·N <= 9 の格子では log Z を直接和の Z から作る。N が大きいと Z が倍精度で溢れるので、
#       log Z = N log c + log tr((W/c)^N) と作る（Z = tr(W^N) は Z_equals_trace_of_W。
#       (W/c)^N は行列の積で直接計算し、W の固有値分解は使わない）。
#   否定コントロール: (1) の上界の 2^M を 1 にしたもの（Z <= c^N）、下界の c を 1.05 c にしたもの、
#                     (2) の極限値を (1/M) log(2c) にしたものが、それぞれ成り立たないこと。
# 対象ラベル: partition_function_sandwich_and_limit_in_N_row
# 対象: structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts
#       ブロック row_limit_and_max_eigenvalue_claim_sandwich_and_limit_in_N_row
# 帰属: W は行列の指数関数から作るので成分が超越数になり、c(M) は上限（実数の完備性）で定まり、
#       log は実対数なので、厳密計算できない（ℝ 脱出: 指数評価・完備性・実対数）。
#       倍精度（CDF・RDF）で計算し、不等式は相対 1e-9 の余裕で判定する。
# ---------------------------------------------------------
import os
_dir = os.getcwd()   # このディレクトリで実行する（overview.md の「実行方法」）
__file__ = os.path.join(_dir, "../044_claim_max_eigenvalue/_prelude.sage")
load(__file__)

set_random_seed(20261031)
REL = 1e-9
K_C = RDF(asinh(1) / 2)   # sinh 2K_c = 1
CASES = [(2, 0.4, 0.8), (2, 0.7, 0.3), (3, 0.4, 0.8), (3, 0.7, 0.3), (3, 0.25, 1.1),
         (3, K_C, K_C), (4, 0.4, 0.8), (4, 0.7, 0.3)]

ok_all = True
w_sym = 0; min_c = None; w_rq = None; w_tr = 0
min_low_gap = None; min_up_gap = None
neg_up = True; neg_low = True; neg_lim = True
max_err_ratio = 0; last_err = 0

for (M, K1v, K2v) in CASES:
    O = SpinOps(M)
    Wc = W_matrix(O, K1v, K2v)
    Wr = to_real(Wc)
    # 前提: 実成分（虚部が小さい）と対称性、c(M) > 0
    imag = max(abs(CDF(Wc[i, j]).imag()) for i in range(O.d) for j in range(O.d))
    w_sym = max(w_sym, imag / Wr.norm(), (Wr - Wr.transpose()).norm() / Wr.norm())
    evs = [RDF(CDF(z).real()) for z in Wr.eigenvalues()]
    c = max(evs)
    min_c = c if min_c is None else min(min_c, c)
    for _ in range(50):
        x = vector(RDF, [RDF.random_element(-1, 1) for _ in range(O.d)])
        x = x / x.norm()
        r = (x * Wr * x - c) / c
        w_rq = r if w_rq is None else max(w_rq, r)
    # (1): Z は直接和。M*N <= 9 の格子だけ
    for N in range(1, 10 // M + 1):
        if M * N > 9:
            continue
        Z = Z_direct(N, M, K1v, K2v)
        trWN = RDF(sum(w ** N for w in evs))
        w_tr = max(w_tr, abs(Z - trWN) / Z)
        low = c ** N; up = 2 ** M * c ** N
        g1 = (Z - low) / Z; g2 = (up - Z) / Z
        min_low_gap = g1 if min_low_gap is None else min(min_low_gap, g1)
        min_up_gap = g2 if min_up_gap is None else min(min_up_gap, g2)
        if not (g1 >= -REL and g2 >= -REL):
            ok_all = False
        # 否定コントロール
        if Z <= c ** N * (1 + REL):
            neg_up = False   # Z <= c^N が成り立ってしまった
    # 下界の c を 1.05c にした否定コントロールは N が大きいところで破れる（対数空間で判定）
    N_big = 1000
    logZ_big = RDF(N_big * log(c) + log(((Wr / c) ** N_big).trace()))
    if N_big * log(RDF(1.05) * c) <= logZ_big:
        neg_low = False
    # (2)
    target = RDF(log(c) / M)
    Wn = Wr / c
    P = identity_matrix(RDF, O.d)
    N_list = list(range(1, 51)) + [100, 200, 500, 1000]
    for N in range(1, max(N_list) + 1):
        P = P * Wn
        if N not in N_list:
            continue
        if M * N <= 9:
            logZ = RDF(log(Z_direct(N, M, K1v, K2v)))
        else:
            logZ = RDF(N * log(c) + log(P.trace()))
        err = abs(logZ / (M * N) - target)
        bound = RDF(log(2) / N)
        max_err_ratio = max(max_err_ratio, err / bound)
        if err > bound * (1 + REL):
            ok_all = False
        if N == 1000:
            last_err = max(last_err, err)
            wrong = RDF(log(2 * c) / M)
            if abs(logZ / (M * N) - wrong) <= bound:
                neg_lim = False

if w_sym > 1e-12 or min_c <= 0 or w_rq > REL or w_tr > 1e-10:
    ok_all = False
if last_err > 1e-3:
    ok_all = False
neg_ok = neg_up and neg_low and neg_lim

print(f"前提: 虚部・非対称部分の相対量の最大 {float(w_sym):.2e}、c(M) の最小値 {float(min_c):.4f}、"
      f"(x^T W x - c)/c の最大 {float(w_rq):.2e}")
print(f"(1) |Z - tr(W^N)|/Z の最大 {float(w_tr):.2e}、(Z - c^N)/Z の最小 {float(min_low_gap):.3e}、"
      f"(2^M c^N - Z)/Z の最小 {float(min_up_gap):.3e}")
print(f"(2) 誤差/(log2/N) の最大 {float(max_err_ratio):.4f}、N=1000 の誤差の最大 {float(last_err):.2e}")
print(f"否定コントロール: Z<=c^N が全て破れる {neg_up}、(1.05c)^1000<=Z が全て破れる {neg_low}、"
      f"極限値 (1/M)log(2c) が全て外れる {neg_lim}")
print("RESULT: PASS" if (ok_all and neg_ok) else "RESULT: FAIL")
