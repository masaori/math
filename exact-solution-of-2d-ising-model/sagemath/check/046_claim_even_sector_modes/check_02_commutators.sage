# ---------------------------------------------------------
# SageMath: 半整数運動量モードの交換関係と反周期性
#   e^{-i M theta~_mu} = -1,  checkZ_{mu+M} = checkZ_mu,  theta~_{1-mu} = -theta~_mu
#   (A) [H_1^{(+)}, checkZ_mu] =  2 e^{-i theta~} checkY_mu
#   (B) [H_1^{(+)}, checkY_mu] = -2 e^{ i theta~} checkZ_mu
#   (C) [H_2,       checkZ_mu] = -2 checkY_mu
#   (D) [H_2,       checkY_mu] =  2 checkZ_mu
# 対象: structured-latex commutator_of_H_and_check_Z_Y
#   （def_half_integer_modes も併せて検証）
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== 反周期性と (A)-(D) ===")
all_ok = True
for M in EVEN_CASES_M:
    O = SpinOps(M)
    H1p = O.H1(+1)
    w = {'antiper': 0.0, 'period': 0.0, 'conj': 0.0, 'A': 0.0, 'B': 0.0, 'C': 0.0, 'D': 0.0}
    for mu in range(1, M + 1):
        t = th_tilde(M, mu)
        w['antiper'] = max(w['antiper'], abs(eiph(-M * t) + 1))
        w['period'] = max(w['period'], opnorm(checkZ(O, mu + M) - checkZ(O, mu)),
                          opnorm(checkY(O, mu + M) - checkY(O, mu)))
        w['conj'] = max(w['conj'], abs(th_tilde(M, 1 - mu) + t))
        cZ = checkZ(O, mu); cY = checkY(O, mu)
        w['A'] = max(w['A'], opnorm(comm(H1p, cZ) - 2 * eiph(-t) * cY))
        w['B'] = max(w['B'], opnorm(comm(H1p, cY) + 2 * eiph(t) * cZ))
        w['C'] = max(w['C'], opnorm(comm(O.H2, cZ) + 2 * cY))
        w['D'] = max(w['D'], opnorm(comm(O.H2, cY) - 2 * cZ))
    worst = max(w.values())
    ok = worst <= TOL
    print(f"  M={M}: 反周期性 {w['antiper']:.1e}, 添字周期 {w['period']:.1e}, 共役添字 {w['conj']:.1e}, "
          f"(A) {w['A']:.1e} (B) {w['B']:.1e} (C) {w['C']:.1e} (D) {w['D']:.1e}"
          f"  -> {'PASS' if ok else 'FAIL'}")
    all_ok = ok and all_ok

print("RESULT: PASS" if all_ok else "RESULT: FAIL")
