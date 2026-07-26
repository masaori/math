# ---------------------------------------------------------
# SageMath: A(theta~_mu) の固有値・固有ベクトルと対角化
# 対象: structured-latex eigenvector_of_A_theta_tilde, diagonalization_check_P_D
#   (1) 特性多項式 lambda^2 - 2 gamma_1 lambda + (gamma_1^2 + gamma_2 gamma_2(-)) = 0 の解が
#       lambda_{pm} = gamma_1 pm sqrt(-gamma_2(theta~) gamma_2(-theta~)) = gamma_1 pm |gamma_2|
#   (2) v_{pm} = (mp |gamma_2|, gamma_2(-theta~)) が A v = lambda v を満たす
#   (3) checkP_mu（008 章の P_mu と同じ正規化 c = 1/(2 sqrt(M) gamma_2(-theta~))）について
#       det checkP_mu = -|gamma_2| / (2 M gamma_2(-theta~)) != 0 かつ A = checkP checkD checkP^{-1}
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== 固有値・固有ベクトル・対角化 ===")
all_ok = True
for (K1, K2) in K_CASES:
    P = coeffs(K1, K2)
    w = {'char': 0.0, 'sqrt': 0.0, 'eigp': 0.0, 'eigm': 0.0, 'detP': 0.0,
         'diag': 0.0, 'spec': 0.0}
    detP_min = None
    for M in M_CASES:
        for mu in range(1, M + 1):
            t = th_tilde(M, mu)
            a = g2(t, P)
            b = g2(-t, P)
            r = RDF(abs(a))
            u = g1(t, P)
            A = A_mat(t, P)

            s = sqrt_cc(clean_real(-a * b))         # = |gamma_2|
            w['sqrt'] = max(w['sqrt'], abs(s - r))
            lp = u + s
            lm = u - s

            # (1) 特性方程式
            for lam in (lp, lm):
                w['char'] = max(w['char'], abs(lam ** 2 - 2 * u * lam + (u ** 2 + a * b)))
            # 実際の固有値集合との一致
            ev = sorted([CDF(z) for z in A.eigenvalues()], key=lambda z: -z.real())
            w['spec'] = max(w['spec'], abs(ev[0] - lp), abs(ev[1] - lm))

            # (2) 固有ベクトル
            vp = vector(CDF, [-r, b])
            vm = vector(CDF, [r, b])
            w['eigp'] = max(w['eigp'], (A * vp - lp * vp).norm())
            w['eigm'] = max(w['eigm'], (A * vm - lm * vm).norm())

            # (3) checkP, checkD
            sm = RDF(M).sqrt()
            cP = matrix(CDF, [[-r / (2 * sm * b), r / (2 * sm * b)],
                              [1 / (2 * sm), 1 / (2 * sm)]])
            cD = matrix(CDF, [[lp, 0], [0, lm]])
            d = cP.det()
            w['detP'] = max(w['detP'], abs(d - (-r / (2 * M * b))))
            detP_min = abs(d) if detP_min is None else min(detP_min, abs(d))
            w['diag'] = max(w['diag'], (A - cP * cD * cP.inverse()).norm())

    worst = max(w.values())
    ok = worst <= 1e-9 and detP_min > 1e-9
    all_ok = ok and all_ok
    print(f"  {case_label(K1, K2)}: 特性式 {w['char']:.1e}, sqrt {w['sqrt']:.1e}, "
          f"固有ベクトル(+) {w['eigp']:.1e} (-) {w['eigm']:.1e}, 固有値集合 {w['spec']:.1e}, "
          f"det式 {w['detP']:.1e}, min|det checkP| {float(detP_min):.2e}, "
          f"対角化 {w['diag']:.1e} -> {'PASS' if ok else 'FAIL'}")

print("RESULT: PASS" if all_ok else "RESULT: FAIL")
if not all_ok:
    import sys
    sys.exit(1)
