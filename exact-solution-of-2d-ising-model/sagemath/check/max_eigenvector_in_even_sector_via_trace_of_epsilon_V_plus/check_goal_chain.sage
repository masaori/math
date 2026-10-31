# ---------------------------------------------------------
# SageMath: 主張 max_eigenvector_in_even_sector_via_trace_of_epsilon_V_plus の証明を、各行の値を独立に作って確かめる。
#   (1) tr(ε V^{(+)}) = (2 e^{-K_2} cosh K_1)^M + (2 e^{K_2} sinh K_1)^M ∈ R_{>0}            （trace_of_epsilon_V_plus）
#       V^{(+)} は def_V_plus の (V_1^{(+)})^{1/2} V_2 (V_1^{(+)})^{1/2} を行列の指数関数から作る。
#   (2) 1 行目: tr(ε V^{(+)}) > 0                                                              （(1)）
#       2 行目: η_{(1,…,1)} = +1。η は ε Q^_{(1,…,1)} = η Q^_{(1,…,1)} の比として独立に求め、
#               trace_of_epsilon_V_plus_via_check_eigenvalues の
#               tr(ε V^{(+)}) = η (2 sinh 2K_2)^{M/2} Π_μ 2 sinh(γ(θ~_μ)/2) と符号が一致することも見る。
#       3 行目: εQ^_{(1,…,1)} = Q^_{(1,…,1)}、すなわち im Q^_{(1,…,1)} ⊆ F^{(+)}。Q^_{(1,…,1)} の各列 y が ε y = y を満たす（‖εQ^ − Q^‖ が小さい）。
#       あわせて、V^{(+)} を数値対角化した最大固有値の固有ベクトル v が ε v = v を満たすことを独立に見る。
#   否定コントロール: ε=(0,1,…,1)（第 1 成分だけ 0）の Q^_ε は ε Q^_ε = −Q^_ε となり F^{(+)} に含まれないこと、
#                     (1) の右辺の和を差 (…)^M − (…)^M にしたものは一致しないこと。
# 対象ラベル: max_eigenvector_in_even_sector_via_trace_of_epsilon_V_plus
# 対象: structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts
#       ブロック eigenvector_of_max_eigenvalue_claim_trace_positive_implies_even_eigenvector
# 帰属: V^{(+)}・Q^_ε は行列の指数関数と、固有値が一般に無理数の作用素から作るので成分が超越数になり、
#       (1) の右辺は実数の指数関数と双曲線関数の値なので、厳密計算できない（ℝ 脱出: 指数評価）。
#       倍精度（CDF・RDF）で計算し、相対残差が 053 と同じ TOL = 1e-8 以下なら一致とみなす。
#       否定コントロールは相対残差が一致の判定幅の 10 倍（1e-7）を超えることを要求する。
# ---------------------------------------------------------
import os
_dir = os.getcwd()   # このディレクトリで実行する（overview.md の「実行方法」）
__file__ = os.path.join(_dir, "../053_claim_even_sector_closing/_prelude.sage")
load(__file__)

NEG_MIN = 10 * TOL

ok_all = True
w_tr = 0; min_tr = None; w_eta_trace = 0; w_eta = 0; w_inF = 0; w_vec = 0
neg_tr = None; neg_flip = None

for M in EIG_M:
    O = SpinOps(M)
    E = eps_op(O)
    Id = identity_matrix(CDF, O.d)
    ones = tuple([1] * M)
    flipped = tuple([0] + [1] * (M - 1))
    for p in EIG_PARAMS:
        K1 = RDF(p['K1']); K2 = RDF(p['K2'])
        P = coeffs(K1, K2)
        Vp, _ = V_plus(O, K1, K2)
        ns = n_check_all(O, P)
        # (1)
        t = CDF((E * Vp).trace())
        a = RDF(2 * exp(-K2) * cosh(K1)) ** M
        b = RDF(2 * exp(K2) * sinh(K1)) ** M
        pred = a + b
        w_tr = max(w_tr, abs(t.imag()) / pred, abs(RDF(t.real()) - pred) / pred)
        min_tr = RDF(t.real()) if min_tr is None else min(min_tr, RDF(t.real()))
        r = abs(RDF(t.real()) - (a - b)) / pred
        neg_tr = r if neg_tr is None else min(neg_tr, r)
        # (2) 2 行目: η_{(1,…,1)} を ε Q^ = η Q^ から求める
        Q1 = Q_check(O, ones, ns)
        eta = CDF((E * Q1).trace()) / CDF(Q1.trace())
        w_eta = max(w_eta, abs(eta - 1))
        pr = RDF((2 * P['s2']) ** (RDF(M) / 2))
        for mu in range(1, M + 1):
            pr = pr * 2 * sinh(gamma_tilde(M, mu, P) / 2)
        w_eta_trace = max(w_eta_trace, abs(t - eta * pr) / pr)
        # (2) 3 行目: εQ^_{(1,…,1)} = Q^_{(1,…,1)}
        w_inF = max(w_inF, opnorm(E * Q1 - Q1) / opnorm(Q1))
        # 独立: 数値対角化した最大固有値の固有ベクトル
        Vh = (Vp + Vp.conjugate_transpose()) / 2
        evals, evecs = Vh.change_ring(CDF).eigenmatrix_right()
        k = max(range(O.d), key=lambda i: evals[i, i].real())
        v = evecs.column(k)
        w_vec = max(w_vec, (E * v - v).norm() / v.norm())
        # 否定コントロール: 第 1 成分だけ 0 の ε
        Qf = Q_check(O, flipped, ns)
        r2 = opnorm(E * Qf - Qf) / opnorm(Qf)
        neg_flip = r2 if neg_flip is None else min(neg_flip, r2)

ok_all &= report("(1) tr(εV^{(+)}) = (2e^{−K_2}cosh K_1)^M + (2e^{K_2}sinh K_1)^M", w_tr, TOL)
print(f"  tr(εV^{{(+)}}) の全体最小値: {float(min_tr):.4e}  ->  {'PASS（正）' if min_tr > 0 else 'FAIL'}")
ok_all &= (min_tr > 0)
ok_all &= report("(2) 2 行目 η_{(1,…,1)} = +1（εQ^ = ηQ^ の比）", w_eta, TOL)
ok_all &= report("(2) 2 行目 tr(εV^{(+)}) = η (2 sinh 2K_2)^{M/2} Π 2 sinh(γ/2)", w_eta_trace, TOL)
ok_all &= report("(2) 3 行目 εQ^_{(1,…,1)} = Q^_{(1,…,1)}（im ⊆ F^{(+)}）", w_inF, TOL)
ok_all &= report("(独立) 数値対角化の最大固有ベクトル v で εv = v", w_vec, TOL)
print(f"  否定コントロール: 右辺を差にしたものとの相対差の最小 {float(neg_tr):.3e}  ->  {'PASS' if neg_tr > NEG_MIN else 'FAIL'}")
ok_all &= (neg_tr > NEG_MIN)
print(f"  否定コントロール: ε=(0,1,…,1) の ‖εQ^ − Q^‖/‖Q^‖ の最小 {float(neg_flip):.3e}  ->  {'PASS' if neg_flip > NEG_MIN else 'FAIL'}")
ok_all &= (neg_flip > NEG_MIN)
print("=== max_eigenvector_in_even_sector_via_trace_of_epsilon_V_plus: " + ("ALL PASS" if ok_all else "FAIL") + " ===")
