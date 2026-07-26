# ---------------------------------------------------------
# SageMath: gamma_2(-theta~_mu) = -conj(gamma_2(theta~_mu)) とその帰結
# 対象: structured-latex relation_of_gamma_2_theta_tilde
#   (1) gamma_2(-theta~) = -conj(gamma_2(theta~))
#   (2) gamma_2(theta~) gamma_2(-theta~) = -|gamma_2(theta~)|^2 （負の実数）
#   (3) arg^{[0,2pi)}(gamma_2(theta~) gamma_2(-theta~)) = pi
#   (4) sqrt(-gamma_2(theta~) gamma_2(-theta~)) = |gamma_2(theta~)| （正の実数）
#   (5) sqrt(gamma_2(theta~) gamma_2(-theta~)) = i |gamma_2(theta~)|
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== gamma_2 の共役関係と根号 ===")
all_ok = True
for (K1, K2) in K_CASES:
    P = coeffs(K1, K2)
    w = {'conj': 0.0, 'prod': 0.0, 'arg': 0.0, 'sqrtneg': 0.0, 'sqrtpos': 0.0}
    for M in M_CASES:
        for mu in range(1, M + 1):
            t = th_tilde(M, mu)
            a = g2(t, P)
            b = g2(-t, P)
            r = abs(a)
            w['conj'] = max(w['conj'], abs(b + a.conjugate()))
            w['prod'] = max(w['prod'], abs(a * b + r ** 2))
            w['arg'] = max(w['arg'], abs(arg_02pi(clean_real(a * b)) - RDF(pi)))
            w['sqrtneg'] = max(w['sqrtneg'], abs(sqrt_cc(clean_real(-a * b)) - r))
            w['sqrtpos'] = max(w['sqrtpos'], abs(sqrt_cc(clean_real(a * b)) - CI * r))
    worst = max(w.values())
    ok = worst <= 1e-9
    all_ok = ok and all_ok
    print(f"  {case_label(K1, K2)}: conj {w['conj']:.1e}, 積 {w['prod']:.1e}, arg {w['arg']:.1e}, "
          f"sqrt(-prod) {w['sqrtneg']:.1e}, sqrt(prod) {w['sqrtpos']:.1e} -> {'PASS' if ok else 'FAIL'}")

print("RESULT: PASS" if all_ok else "RESULT: FAIL")
if not all_ok:
    import sys
    sys.exit(1)
