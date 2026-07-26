# ---------------------------------------------------------
# SageMath: V^{(+)} と checkpsi の交換関係
#
# 対象: structured-latex commutation_V_plus_check_psi
#
# (a) T_{(V^{(+)})}(checkpsi_mu^dagger) = lambda_{+,mu} checkpsi_mu^dagger
#     T_{(V^{(+)})}(checkpsi_mu)        = lambda_{-,mu} checkpsi_mu
#     ここで lambda_{±,mu} = e^{±gamma(theta~_mu)}
# (b) 固有値が gamma_1 ± |gamma_2| と e^{±gamma} の両表示で一致すること
# (c) checkP_mu の列が A(theta~_mu) の固有ベクトルであること（A checkP = checkP checkD）
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== (b)(c) A(theta~_mu) checkP_mu = checkP_mu checkD_mu と固有値の 2 表示 ===")
mat_ok = True
for M in EVEN_M:
    for params in EVEN_PARAMS:
        K1v, K2v = RDF(params['K1']), RDF(params['K2'])
        w = {'diag': 0.0, 'eig': 0.0}
        for mu in range(1 - M, M + 1):
            t = th_tilde(M, mu)
            A = A_theta(K1v, K2v, t)
            P = checkP(K1v, K2v, M, mu)
            D = checkD(K1v, K2v, M, mu)
            w['diag'] = max(w['diag'], opnorm(A * P - P * D))
            g1 = gam1(K1v, K2v, t)
            r = RDF(abs(gam2(K1v, K2v, t)))
            g = gamma_tilde(K1v, K2v, M, mu)
            w['eig'] = max(w['eig'],
                           abs(RDF(exp(g)) - (g1 + r)),
                           abs(RDF(exp(-g)) - (g1 - r)))
        worst = max(w.values())
        ok = worst <= TOL
        print(f"  M={M}, K1={params['K1']}, K2={params['K2']}: "
              f"A P - P D = {w['diag']:.1e}, 固有値 2 表示の差 = {w['eig']:.1e}"
              f"  -> {'PASS' if ok else 'FAIL'}")
        mat_ok = ok and mat_ok

print("=== (a) T_{(V^{(+)})}(checkpsi^dagger) = e^{+gamma} checkpsi^dagger, "
      "T(checkpsi) = e^{-gamma} checkpsi ===")
act_ok = True
for M in EVEN_M:
    O = SpinOps(M)
    for params in EVEN_PARAMS:
        K1v, K2v = RDF(params['K1']), RDF(params['K2'])
        Vp, Vpi = V_plus(O, K1v, K2v)
        w = {'dag': 0.0, 'ann': 0.0}
        for mu in range(1 - M, M + 1):
            pd, p = fermions(O, K1v, K2v, mu)
            g = gamma_tilde(K1v, K2v, M, mu)
            w['dag'] = max(w['dag'], opnorm(Vp * pd * Vpi - CDF(exp(g)) * pd))
            w['ann'] = max(w['ann'], opnorm(Vp * p * Vpi - CDF(exp(-g)) * p))
        worst = max(w.values())
        ok = worst <= TOL
        print(f"  M={M}, K1={params['K1']}, K2={params['K2']}: "
              f"psi^dagger {w['dag']:.1e}, psi {w['ann']:.1e}"
              f"  -> {'PASS' if ok else 'FAIL'}")
        act_ok = ok and act_ok

all_ok = mat_ok and act_ok
print("RESULT: PASS" if all_ok else "RESULT: FAIL")
