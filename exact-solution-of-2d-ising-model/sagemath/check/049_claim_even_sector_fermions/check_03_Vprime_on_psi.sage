# ---------------------------------------------------------
# SageMath: checkV' と T_{(checkV')} の checkpsi への作用
#
# 対象: structured-latex action_of_T_check_Vprime_on_check_psi
#       （併せて def_check_Vprime）
#
# checkV' := exp(X),  X := sum_{mu=1}^{M} gamma(theta~_mu)(checkpsi_mu^dagger checkpsi_{1-mu} - 1/2)
#
# (a) 本文 Step 1 の交換子: [checkpsi_nu^dagger checkpsi_{1-nu}, checkpsi_mu^dagger]
#                            = delta^M_{(mu-nu, 0)} checkpsi_nu^dagger
# (b) 本文 Step 1' の交換子: [checkpsi_nu^dagger checkpsi_{1-nu}, checkpsi_mu]
#                            = -delta^M_{(nu+mu, 1)} checkpsi_{1-nu}
# (c) 本文 Step 2 / 2': [X, checkpsi_mu^dagger] = +gamma(theta~_mu) checkpsi_mu^dagger,
#                       [X, checkpsi_mu]        = -gamma(theta~_mu) checkpsi_mu
# (d) T_{(checkV')}(checkpsi_mu^dagger) = e^{+gamma(theta~_mu)} checkpsi_mu^dagger,
#     T_{(checkV')}(checkpsi_mu)        = e^{-gamma(theta~_mu)} checkpsi_mu
# (e) 和の範囲に例外が要らないこと: mu=1..M すべてで gamma(theta~_mu) > 0（項が落ちない）
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== (a)(b) 1 項ごとの交換子 ===")
term_ok = True
for M in EVEN_M:
    O = SpinOps(M)
    for params in EVEN_PARAMS:
        K1v, K2v = RDF(params['K1']), RDF(params['K2'])
        w = {'dag': 0.0, 'ann': 0.0}
        for nu in range(1, M + 1):
            pdn, _ = fermions(O, K1v, K2v, nu)
            _, pcn = fermions(O, K1v, K2v, 1 - nu)
            N = pdn * pcn
            for mu in range(1 - M, M + 1):
                pdm, pm = fermions(O, K1v, K2v, mu)
                w['dag'] = max(w['dag'],
                               opnorm(comm(N, pdm) - delta_M(mu - nu, 0, M) * pdn))
                w['ann'] = max(w['ann'],
                               opnorm(comm(N, pm) + delta_M(nu + mu, 1, M) * pcn))
        worst = max(w.values())
        ok = worst <= TOL
        print(f"  M={M}, K1={params['K1']}, K2={params['K2']}: "
              f"Step1 {w['dag']:.1e}, Step1' {w['ann']:.1e}  -> {'PASS' if ok else 'FAIL'}")
        term_ok = ok and term_ok

print("=== (c) [X, checkpsi^dagger] = +gamma checkpsi^dagger, [X, checkpsi] = -gamma checkpsi ===")
comm_ok = True
for M in EVEN_M:
    O = SpinOps(M)
    for params in EVEN_PARAMS:
        K1v, K2v = RDF(params['K1']), RDF(params['K2'])
        X = X_gen(O, K1v, K2v)
        w = {'dag': 0.0, 'ann': 0.0}
        for mu in range(1 - M, M + 1):
            pd, p = fermions(O, K1v, K2v, mu)
            g = gamma_tilde(K1v, K2v, M, mu)
            w['dag'] = max(w['dag'], opnorm(comm(X, pd) - g * pd))
            w['ann'] = max(w['ann'], opnorm(comm(X, p) + g * p))
        worst = max(w.values())
        ok = worst <= TOL
        print(f"  M={M}, K1={params['K1']}, K2={params['K2']}: "
              f"psi^dagger {w['dag']:.1e}, psi {w['ann']:.1e}  -> {'PASS' if ok else 'FAIL'}")
        comm_ok = ok and comm_ok

print("=== (d) T_{(checkV')} の作用 ===")
act_ok = True
for M in EVEN_M:
    O = SpinOps(M)
    for params in EVEN_PARAMS:
        K1v, K2v = RDF(params['K1']), RDF(params['K2'])
        Vq, Vqi = checkVprime(O, K1v, K2v)
        w = {'dag': 0.0, 'ann': 0.0}
        for mu in range(1 - M, M + 1):
            pd, p = fermions(O, K1v, K2v, mu)
            g = gamma_tilde(K1v, K2v, M, mu)
            w['dag'] = max(w['dag'], opnorm(Vq * pd * Vqi - CDF(exp(g)) * pd))
            w['ann'] = max(w['ann'], opnorm(Vq * p * Vqi - CDF(exp(-g)) * p))
        worst = max(w.values())
        ok = worst <= TOL
        print(f"  M={M}, K1={params['K1']}, K2={params['K2']}: "
              f"psi^dagger {w['dag']:.1e}, psi {w['ann']:.1e}  -> {'PASS' if ok else 'FAIL'}")
        act_ok = ok and act_ok

print("=== (e) 和の範囲に例外が不要（全 mu で gamma(theta~_mu) > 0）===")
pos_ok = True
for M in EVEN_M:
    for params in EVEN_PARAMS:
        K1v, K2v = RDF(params['K1']), RDF(params['K2'])
        gmin = min([gamma_tilde(K1v, K2v, M, mu) for mu in range(1, M + 1)])
        ok = gmin > 1e-6
        print(f"  M={M}, K1={params['K1']}, K2={params['K2']}: "
              f"min gamma(theta~_mu) = {float(gmin):.3e}  -> {'PASS' if ok else 'FAIL'}")
        pos_ok = ok and pos_ok

all_ok = term_ok and comm_ok and act_ok and pos_ok
print("RESULT: PASS" if all_ok else "RESULT: FAIL")
