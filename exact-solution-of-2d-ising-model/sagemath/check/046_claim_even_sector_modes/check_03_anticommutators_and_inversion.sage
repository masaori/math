# ---------------------------------------------------------
# SageMath: 反交換関係・復元公式・H の表示
#   [checkZ_mu, checkZ_nu]_+ = 2M delta^M_{mu+nu,1} I,  [checkZ, checkY]_+ = 0,
#   [checkY_mu, checkY_nu]_+ = 2M delta^M_{mu+nu,1} I
#   Z_j = (1/M) sum_mu checkZ_mu e^{i j theta~_mu}（Y_j も同様）
#   H_1^{(+)} = (1/M) sum_mu checkY_mu checkZ_{1-mu} e^{-i theta~_mu}
#   H_2       = (1/M) sum_mu checkZ_{1-mu} checkY_mu
#   さらに半整数運動量の指数和（antiperiodic_exp_sum）
# 対象: structured-latex H1_H2_via_check_Z_Y
#   （anticommutator_of_check_Z_Y / recover_Z_Y_from_check_Z_Y / antiperiodic_exp_sum も検証）
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== 反交換関係・復元・H の表示・指数和 ===")
all_ok = True
for M in EVEN_CASES_M:
    O = SpinOps(M)
    Id = identity_matrix(CDF, O.d)
    w = {'zz': 0.0, 'zy': 0.0, 'yy': 0.0, 'recZ': 0.0, 'recY': 0.0,
         'H1': 0.0, 'H2': 0.0, 'expsum': 0.0}
    # 反交換関係
    for mu in range(1, M + 1):
        for nu in range(1, M + 1):
            delta = 1 if (mu + nu - 1) % M == 0 else 0
            cZm = checkZ(O, mu); cZn = checkZ(O, nu)
            cYm = checkY(O, mu); cYn = checkY(O, nu)
            w['zz'] = max(w['zz'], opnorm(cZm * cZn + cZn * cZm - 2 * M * delta * Id))
            w['zy'] = max(w['zy'], opnorm(cZm * cYn + cYn * cZm))
            w['yy'] = max(w['yy'], opnorm(cYm * cYn + cYn * cYm - 2 * M * delta * Id))
    # 復元
    for j in range(1, M + 1):
        sZ = matrix(CDF, O.d, O.d, 0); sY = matrix(CDF, O.d, O.d, 0)
        for mu in range(1, M + 1):
            t = th_tilde(M, mu)
            sZ = sZ + checkZ(O, mu) * eiph(j * t)
            sY = sY + checkY(O, mu) * eiph(j * t)
        w['recZ'] = max(w['recZ'], opnorm(sZ / M - O.Z[j]))
        w['recY'] = max(w['recY'], opnorm(sY / M - O.Y[j]))
    # H の表示
    s1 = matrix(CDF, O.d, O.d, 0); s2 = matrix(CDF, O.d, O.d, 0)
    for mu in range(1, M + 1):
        t = th_tilde(M, mu)
        s1 = s1 + checkY(O, mu) * checkZ(O, 1 - mu) * eiph(-t)
        s2 = s2 + checkZ(O, 1 - mu) * checkY(O, mu)
    w['H1'] = opnorm(s1 / M - O.H1(+1))
    w['H2'] = opnorm(s2 / M - O.H2)
    # 指数和
    for k in range(-2 * M, 2 * M + 1):
        s = CDF(sum(eiph(k * th_tilde(M, mu)) for mu in range(1, M + 1)))
        if k % M == 0:
            target = CDF(M * (-1) ** (k // M))
        else:
            target = CDF(0)
        w['expsum'] = max(w['expsum'], abs(s - target))
    worst = max(w.values())
    ok = worst <= TOL
    print(f"  M={M}: [cZ,cZ]+ {w['zz']:.1e}, [cZ,cY]+ {w['zy']:.1e}, [cY,cY]+ {w['yy']:.1e}, "
          f"復元 Z {w['recZ']:.1e} / Y {w['recY']:.1e}, H1 {w['H1']:.1e}, H2 {w['H2']:.1e}, "
          f"指数和 {w['expsum']:.1e}  -> {'PASS' if ok else 'FAIL'}")
    all_ok = ok and all_ok

print("RESULT: PASS" if all_ok else "RESULT: FAIL")
