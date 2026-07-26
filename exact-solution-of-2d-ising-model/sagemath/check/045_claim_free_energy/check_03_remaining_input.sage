# ---------------------------------------------------------
# SageMath: 残っている入力（偶セクターの固有値）の数値的な所在確認
#   V^{(-)} の固有値 = 整数運動量 2 pi mu / M の Λ_eps（本文で確立済み）
#   V^{(+)} の固有値 = 半整数運動量 2 pi (mu - 1/2) / M の Λ_eps（本文では未確立）
#   さらに、[H_2, hatZ^{(+)}] = -2 hatY が成り立たないこと（本文が (+) に使えない理由）
# 対象: structured-latex onsager_free_energy_expression
#   （remark_remaining_input_even_sector の内容の裏取り）
# ---------------------------------------------------------
import os
import itertools
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

MISMATCH_FLOOR = 1e-3

def predicted_spectrum(M, K1, K2, delta):
    g = gamma_fn(K1, K2)
    s2 = RDF(sinh(2 * RDF(K2)))
    pref = RDF((2 * s2) ** (RDF(M) / 2))
    ths = theta_family(M, delta)
    out = []
    for eps in itertools.product([0, 1], repeat=M):
        tot = sum(g(th) * (RDF(e) - RDF(1) / 2) for th, e in zip(ths, eps))
        out.append(RDF(pref * exp(tot)))
    return sorted(out)

print("=== V^{(pm)} の固有値がどちらの運動量族に対応するか ===")
all_ok = True
for (M, K1v, K2v) in [(2, 0.4, 0.8), (3, 0.4, 0.8), (3, 0.7, 0.3), (4, 0.4, 0.8)]:
    O = SpinOps(M)
    for sgn, name, delta_ok, delta_ng in [(-1, '(-)', 0, RDF(1)/2), (1, '(+)', RDF(1)/2, 0)]:
        V = V_sym(O, K1v, K2v, sgn)
        ev = sorted([RDF(CDF(z).real()) for z in V.eigenvalues()])
        p_ok = predicted_spectrum(M, K1v, K2v, delta_ok)
        p_ng = predicted_spectrum(M, K1v, K2v, delta_ng)
        r_ok = max(abs(a - b) / max(abs(b), 1e-30) for a, b in zip(ev, p_ok))
        r_ng = max(abs(a - b) / max(abs(b), 1e-30) for a, b in zip(ev, p_ng))
        lab_ok = '整数' if delta_ok == 0 else '半整数'
        ok = (r_ok <= 1e-8) and (r_ng >= MISMATCH_FLOOR)
        print(f"  M={M}, K1={K1v}, K2={K2v}, V^{name}: {lab_ok}運動量 rel={r_ok:.2e}, "
              f"もう一方 rel={r_ng:.2e}  -> {'PASS' if ok else 'FAIL'}")
        all_ok = ok and all_ok

print()
print("=== 本文が (+) に使えない理由: [H_2, hatZ^{(+)}] != -2 hatY ===")
for M in [3, 4]:
    O = SpinOps(M)
    worst_minus = 0.0
    worst_plus = None
    for mu in O.mu_range():
        Yh = O.Yhat(mu)
        rm = opnorm(comm(O.H2, O.Zhat(mu, -1)) + 2 * Yh)
        rp = opnorm(comm(O.H2, O.Zhat(mu, +1)) + 2 * Yh)
        worst_minus = max(worst_minus, rm)
        worst_plus = rp if worst_plus is None else min(worst_plus, rp)
    ok = (worst_minus <= 1e-9) and (worst_plus >= MISMATCH_FLOOR)
    print(f"  M={M}: (-) 側 最大残差={worst_minus:.2e}（成立）, "
          f"(+) 側 最小残差={worst_plus:.2e}（不成立）  -> {'PASS' if ok else 'FAIL'}")
    all_ok = ok and all_ok

print("RESULT: PASS" if all_ok else "RESULT: FAIL")
