# =========================================================================
# check_05: V_plus_is_positive_definite / constant_c_value_even_sector
#
#  (a) S_1^{(+)} = i K_1 H_1^{(+)} と S_2 = i K_2^* H_2 が実対称（iH_is_real_symmetric の (+) 側）
#  (b) V^{(+)} = (2 s_2)^{M/2} exp(S_1^{(+)}/2) exp(S_2) exp(S_1^{(+)}/2)
#  (c) V^{(+)} はエルミートかつ固有値がすべて正（＝正定値）、候補逆行列はエルミート、
#      tr(V^{(+)}) > 0、tr((V^{(+)})^{-1}) > 0
#      （候補逆行列の全固有値正値性はここでは検査しない）
#  (d) U := E F について U S_1^{(+)} U^{-1} = -S_1^{(+)}、U S_2 U^{-1} = -S_2
#      （sign_flip_conjugation の (+) 側。009 章の証明は (-) 側でも同じ U を使う）
#  (e) tau := tr(exp(S_1^{(+)}) exp(S_2)) について tr(exp(-S_1^{(+)}) exp(-S_2)) = tau
#  (f) tr(V^{(+)}) / tr((V^{(+)})^{-1}) = (2 s_2)^M
#  (g) c := tr(V^{(+)}) / tr(V^') = (2 sinh 2K_2)^{M/2}（本章の結論）
# =========================================================================
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== check_05: V^{(+)} の正定値性と定数 c の決定 ===")

ok_all = True
w_sym1 = 0
w_sym2 = 0
w_form = 0
w_herm = 0
w_U1 = 0
w_U2 = 0
w_tau = 0
w_ratio = 0
w_c = 0
min_ev = None
min_trV = None
min_trVinv = None
rows = []

for M in EIG_M:
    O = SpinOps(M)
    Id = identity_matrix(CDF, O.d)
    for p in EIG_PARAMS:
        P = coeffs(p['K1'], p['K2'])
        K1 = RDF(p['K1']); K2 = RDF(p['K2'])
        S1 = S1_plus(O, K1)
        S2 = S2_op(O, K2)
        # (a)
        w_sym1 = max(w_sym1, real_symmetric_residual(S1))
        w_sym2 = max(w_sym2, real_symmetric_residual(S2))
        # (b)
        Vp, Vpi = V_plus(O, K1, K2)
        pref = CDF((2 * P['s2']) ** (RDF(M) / 2))
        B = matrix(CDF, (S1 / 2).exp())
        A = matrix(CDF, S2.exp())
        w_form = max(w_form, opnorm(Vp - pref * B * A * B) / opnorm(Vp))
        # (c)
        w_herm = max(w_herm, herm_residual(Vp))
        w_herm = max(w_herm, herm_residual(Vpi))
        for z in Vp.eigenvalues():
            r = RDF(CDF(z).real())
            min_ev = r if min_ev is None else min(min_ev, r)
        trV = RDF(Vp.trace().real())
        trVi = RDF(Vpi.trace().real())
        min_trV = trV if min_trV is None else min(min_trV, trV)
        min_trVinv = trVi if min_trVinv is None else min(min_trVinv, trVi)
        # (d)
        U = U_signflip(O)
        Ui = U.inverse()
        w_U1 = max(w_U1, opnorm(U * S1 * Ui + S1))
        w_U2 = max(w_U2, opnorm(U * S2 * Ui + S2))
        # (e)
        tau = (matrix(CDF, S1.exp()) * A).trace()
        tau2 = (matrix(CDF, (-S1).exp()) * matrix(CDF, (-S2).exp())).trace()
        w_tau = max(w_tau, abs(tau - tau2) / abs(tau))
        # (f)
        ratio = trV / trVi
        pred_ratio = RDF((2 * P['s2']) ** RDF(M))
        w_ratio = max(w_ratio, abs(ratio - pred_ratio) / pred_ratio)
        # (g)
        ns = n_check_all(O, P)
        Vpr, _, _ = Vprime_check(O, P, ns)
        c = trV / RDF(Vpr.trace().real())
        c_pred = RDF((2 * P['s2']) ** (RDF(M) / 2))
        w_c = max(w_c, abs(c - c_pred) / c_pred)
        # c I = (V^')^{-1} V^{(+)} との整合も見る
        w_c = max(w_c, opnorm(Vp - CDF(c_pred) * Vpr) / opnorm(Vp))
        rows.append((M, param_label(p), c, c_pred))

ok_all &= report("S_1^{(+)} = i K_1 H_1^{(+)} は実対称", w_sym1, TOL)
ok_all &= report("S_2 = i K_2^* H_2 は実対称", w_sym2, TOL)
ok_all &= report("V^{(+)} = (2 s_2)^{M/2} exp(S_1/2) exp(S_2) exp(S_1/2)（相対差）", w_form, TOL)
ok_all &= report("V^{(+)}, (V^{(+)})^{-1} はエルミート", w_herm, TOL)
print(f"  V^{{(+)}} の固有値の全体最小 = {float(min_ev):.3e}  ->  "
      f"{'PASS（正定値）' if min_ev > 0 else 'FAIL'}")
print(f"  tr(V^{{(+)}}) の全体最小 = {float(min_trV):.3e}、"
      f"tr((V^{{(+)}})^{{-1}}) の全体最小 = {float(min_trVinv):.3e}  ->  "
      f"{'PASS（ともに正）' if min(min_trV, min_trVinv) > 0 else 'FAIL'}")
ok_all &= (min_ev > 0 and min_trV > 0 and min_trVinv > 0)
ok_all &= report("U S_1^{(+)} U^{-1} = -S_1^{(+)}", w_U1, TOL)
ok_all &= report("U S_2 U^{-1} = -S_2", w_U2, TOL)
ok_all &= report("tr(exp(-S_1)exp(-S_2)) = tr(exp(S_1)exp(S_2))（相対差）", w_tau, TOL)
ok_all &= report("tr(V^{(+)})/tr((V^{(+)})^{-1}) = (2 s_2)^M（相対差）", w_ratio, TOL)
ok_all &= report("c = (2 sinh 2K_2)^{M/2} と V^{(+)} = c V^'（相対差）", w_c, TOL)

print()
print("  c の実測値:")
for M, lab, c, c_pred in rows[:8]:
    print(f"    M={M} {lab}: c = {float(c):.10g}, (2 sinh 2K_2)^(M/2) = {float(c_pred):.10g}")

print("check_05:", "PASS" if ok_all else "FAIL")
