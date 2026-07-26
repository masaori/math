# =========================================================================
# check_03: commutation_V_plus_check_psi
#
#   T_{(V^{(+)})}(psi^dagger_mu) = e^{+gamma(t~_mu)} psi^dagger_mu
#   T_{(V^{(+)})}(psi_mu)        = e^{-gamma(t~_mu)} psi_mu
#
#  V^{(+)} は行列指数関数から直接構成する（交換子の級数展開に依存しない独立経路）。
#  併せて、証明で使う 2 つの前提を個別に確認する:
#   (a) (T(checkZ), T(checkY)) = (checkZ, checkY) A(t~_mu)   [T_V_plus_check_Z_Y]
#   (b) A(t~_mu) P^_mu = P^_mu D^_mu                          [diagonalization_check_P_D]
# =========================================================================
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== check_03: commutation_V_plus_check_psi ===")

ok_all = True
w_a = w_b = w_dag = w_psi = 0

for M in FERMI_M:
    O = SpinOps(M)
    for p in FERMI_PARAMS:
        P = coeffs(p['K1'], p['K2'])
        Vp, Vpi = V_plus(O, p['K1'], p['K2'])
        for mu in list(range(1, M + 1)) + [0, -1]:
            t = th_tilde(M, mu)
            Zc = checkZ(O, mu); Yc = checkY(O, mu)
            A = A_theta(t, P)
            # (a)
            TZ = Vp * Zc * Vpi
            TY = Vp * Yc * Vpi
            w_a = max(w_a,
                      opnorm(TZ - (A[0, 0] * Zc + A[1, 0] * Yc)),
                      opnorm(TY - (A[0, 1] * Zc + A[1, 1] * Yc)))
            # (b)
            Pm = Pcheck(M, mu, P)
            gam = gamma_tilde(M, mu, P)
            Dm = matrix(CDF, [[RDF(exp(gam)), 0], [0, RDF(exp(-gam))]])
            w_b = max(w_b, (A * Pm - Pm * Dm).norm(1))
            # 本命
            pdag, psi = psi_pair(O, mu, P)
            w_dag = max(w_dag, opnorm(Vp * pdag * Vpi - RDF(exp(gam)) * pdag))
            w_psi = max(w_psi, opnorm(Vp * psi * Vpi - RDF(exp(-gam)) * psi))

ok_all &= report("(a) (T(checkZ), T(checkY)) = (checkZ, checkY) A(t~_mu)", w_a, TOL)
ok_all &= report("(b) A(t~_mu) P^_mu = P^_mu D^_mu", w_b, TOL)
ok_all &= report("T_{(V^{(+)})}(psi^dagger_mu) = e^{+gamma} psi^dagger_mu", w_dag, TOL)
ok_all &= report("T_{(V^{(+)})}(psi_mu)        = e^{-gamma} psi_mu", w_psi, TOL)

print("check_03:", "PASS" if ok_all else "FAIL")
