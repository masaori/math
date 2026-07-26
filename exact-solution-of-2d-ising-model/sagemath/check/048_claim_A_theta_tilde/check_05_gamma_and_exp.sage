# ---------------------------------------------------------
# SageMath: gamma(theta~_mu) = arccosh(gamma_1(theta~_mu)) と lambda_pm = e^{pm gamma}
# 対象: structured-latex def_gamma_theta_tilde_mu, lambda_eq_exp_gamma_theta_tilde
#   (1) cosh(gamma(theta~)) = gamma_1(theta~)
#   (2) sinh(gamma(theta~)) = |gamma_2(theta~)|
#   (3) lambda_+ = e^{+gamma(theta~)}, lambda_- = e^{-gamma(theta~)}
#   (4) gamma(theta~) > 0（半整数運動量では gamma_1 > 1 なので厳密に正）
#       対比: 整数運動量では臨界点で gamma(theta_M) = 0 になりうる
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== gamma(theta~) = arccosh(gamma_1) と lambda_pm = e^{pm gamma} ===")
all_ok = True
for (K1, K2) in K_CASES:
    P = coeffs(K1, K2)
    w = {'cosh': 0.0, 'sinh': 0.0, 'lp': 0.0, 'lm': 0.0}
    gmin = None
    for M in M_CASES:
        for mu in range(1, M + 1):
            t = th_tilde(M, mu)
            u = g1(t, P)
            r = RDF(abs(g2(t, P)))
            gam = RDF(arccosh(u))
            w['cosh'] = max(w['cosh'], abs(RDF(cosh(gam)) - u))
            w['sinh'] = max(w['sinh'], abs(RDF(sinh(gam)) - r))
            w['lp'] = max(w['lp'], abs(RDF(exp(gam)) - (u + r)))
            w['lm'] = max(w['lm'], abs(RDF(exp(-gam)) - (u - r)))
            gmin = gam if gmin is None else min(gmin, gam)
    worst = max(w.values())
    ok = worst <= 1e-8 and gmin > 1e-9
    all_ok = ok and all_ok
    print(f"  {case_label(K1, K2)}: cosh {w['cosh']:.1e}, sinh {w['sinh']:.1e}, "
          f"lambda_+ {w['lp']:.1e}, lambda_- {w['lm']:.1e}, min gamma(theta~) = {float(gmin):.3e} "
          f"-> {'PASS' if ok else 'FAIL'}")

print("=== 対比: 整数運動量 theta_M = 2pi での gamma（臨界点では 0 になる） ===")
for (K1, K2) in K_CASES:
    P = coeffs(K1, K2)
    u = g1(th_int(4, 4), P)
    gam = RDF(arccosh(u)) if u >= 1 else RDF(0)
    print(f"  {case_label(K1, K2)}: gamma_1(2pi) = {float(u):.12f}, gamma(2pi) = {float(gam):.3e}")

print("RESULT: PASS" if all_ok else "RESULT: FAIL")
if not all_ok:
    import sys
    sys.exit(1)
