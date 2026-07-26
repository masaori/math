# ---------------------------------------------------------
# SageMath: det A(theta~_mu) = 1 と gamma_1(theta~_mu) > 1
# 対象: structured-latex det_A_theta_tilde, gamma1_gt_1_theta_tilde
#   (1) det A(theta~) = 1
#   (2) gamma_1(theta~)^2 + gamma_2(theta~) gamma_2(-theta~) = 1
#   (3) lambda_+ lambda_- = 1
#   (4) gamma_1(theta~) >= 1、さらに gamma_2 != 0 より gamma_1(theta~) > 1
#       （gamma_1^2 - 1 = |gamma_2|^2 > 0 を残差付きで確認する）
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== det A(theta~) = 1 と gamma_1(theta~) > 1 ===")
all_ok = True
for (K1, K2) in K_CASES:
    P = coeffs(K1, K2)
    w = {'det': 0.0, 'sum': 0.0, 'prod': 0.0, 'pyth': 0.0}
    g1_min_excess = None      # min (gamma_1 - 1)
    for M in M_CASES:
        for mu in range(1, M + 1):
            t = th_tilde(M, mu)
            a = g2(t, P)
            b = g2(-t, P)
            u = g1(t, P)
            r = RDF(abs(a))
            A = A_mat(t, P)
            w['det'] = max(w['det'], abs(A.det() - 1))
            w['sum'] = max(w['sum'], abs(u ** 2 + a * b - 1))
            w['prod'] = max(w['prod'], abs((u + r) * (u - r) - 1))
            w['pyth'] = max(w['pyth'], abs(u ** 2 - 1 - r ** 2))
            e = RDF(u - 1)
            g1_min_excess = e if g1_min_excess is None else min(g1_min_excess, e)
    worst = max(w.values())
    ok = worst <= 1e-8 and g1_min_excess > 1e-9
    all_ok = ok and all_ok
    print(f"  {case_label(K1, K2)}: det {w['det']:.1e}, gamma_1^2+gamma_2gamma_2(-) {w['sum']:.1e}, "
          f"lambda_+lambda_- {w['prod']:.1e}, gamma_1^2-1-|gamma_2|^2 {w['pyth']:.1e}, "
          f"min(gamma_1 - 1) = {float(g1_min_excess):.3e} -> {'PASS' if ok else 'FAIL'}")

print("RESULT: PASS" if all_ok else "RESULT: FAIL")
if not all_ok:
    import sys
    sys.exit(1)
