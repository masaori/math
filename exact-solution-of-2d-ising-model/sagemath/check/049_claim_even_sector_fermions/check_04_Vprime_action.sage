# =========================================================================
# check_04: def_check_Vprime / action_of_T_check_Vprime_on_check_psi
#
#   X^  = sum_{mu=1}^{M} gamma(t~_mu) ( psi^dagger_mu psi_{1-mu} - I/2 )
#   V^' = exp(X^),  (V^')^{-1} = exp(-X^)
#   T_{(V^')}(psi^dagger_mu) = e^{+gamma(t~_mu)} psi^dagger_mu
#   T_{(V^')}(psi_mu)        = e^{-gamma(t~_mu)} psi_mu
#
#  併せて proof の中間段（Step 2 / Step 2'）を個別に確認する:
#   (a) [X^, psi^dagger_mu] = +gamma(t~_mu) psi^dagger_mu
#   (b) [X^, psi_mu]        = -gamma(t~_mu) psi_mu
#  また、和の範囲 mu = 1..M に重複も数え落としも無いことの傍証として、
#  範囲を {1..M-1} に減らす／{1..M+1} に増やすと (a) が壊れることを示す。
# =========================================================================
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== check_04: def_check_Vprime / action_of_T_check_Vprime_on_check_psi ===")


def X_over(O, P, mus):
    Id = identity_matrix(CDF, O.d)
    X = matrix(CDF, O.d, O.d, 0)
    for mu in mus:
        pdag, _ = psi_pair(O, mu, P)
        _, psi1m = psi_pair(O, 1 - mu, P)
        X = X + gamma_tilde(O.M, mu, P) * (pdag * psi1m - Id / 2)
    return matrix(CDF, X)


ok_all = True
w_inv = w_a = w_b = w_dag = w_psi = 0
worst_short = 0   # 和の範囲を狭めた場合の残差
worst_long = 0    # 和の範囲を広げた場合の残差

for M in FERMI_M:
    O = SpinOps(M)
    Id = identity_matrix(CDF, O.d)
    for p in FERMI_PARAMS:
        P = coeffs(p['K1'], p['K2'])
        Vpr, Vpri, X = Vprime_check(O, P)
        w_inv = max(w_inv, opnorm(Vpr * Vpri - Id))
        Xs = X_over(O, P, list(range(1, M)))        # {1..M-1}
        Xl = X_over(O, P, list(range(1, M + 2)))    # {1..M+1}
        for mu in list(range(1, M + 1)) + [0, -1]:
            pdag, psi = psi_pair(O, mu, P)
            gam = gamma_tilde(M, mu, P)
            w_a = max(w_a, opnorm(comm(X, pdag) - gam * pdag))
            w_b = max(w_b, opnorm(comm(X, psi) + gam * psi))
            w_dag = max(w_dag, opnorm(Vpr * pdag * Vpri - RDF(exp(gam)) * pdag))
            w_psi = max(w_psi, opnorm(Vpr * psi * Vpri - RDF(exp(-gam)) * psi))
            worst_short = max(worst_short, opnorm(comm(Xs, pdag) - gam * pdag))
            worst_long = max(worst_long, opnorm(comm(Xl, pdag) - gam * pdag))

ok_all &= report("V^' (V^')^{-1} = I", w_inv, TOL)
ok_all &= report("(a) [X^, psi^dagger_mu] = +gamma psi^dagger_mu", w_a, TOL)
ok_all &= report("(b) [X^, psi_mu]        = -gamma psi_mu", w_b, TOL)
ok_all &= report("T_{(V^')}(psi^dagger_mu) = e^{+gamma} psi^dagger_mu", w_dag, TOL)
ok_all &= report("T_{(V^')}(psi_mu)        = e^{-gamma} psi_mu", w_psi, TOL)
print(f"  和の範囲を {{1..M-1}} に狭めると (a) の残差 = {float(worst_short):.3e} "
      f"-> {'期待どおり不成立（数え落とし）' if worst_short > 1e-2 else '判定不能'}")
print(f"  和の範囲を {{1..M+1}} に広げると (a) の残差 = {float(worst_long):.3e} "
      f"-> {'期待どおり不成立（重複）' if worst_long > 1e-2 else '判定不能'}")
ok_all &= (worst_short > 1e-2 and worst_long > 1e-2)

print("check_04:", "PASS" if ok_all else "FAIL")
