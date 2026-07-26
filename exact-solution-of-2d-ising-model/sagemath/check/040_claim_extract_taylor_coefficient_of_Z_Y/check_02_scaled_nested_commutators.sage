# ---------------------------------------------------------
# SageMath: 生成子をスケールした n 重交換子（cosh_sinh_coefficient_conversion）
#
#   (h1.z)  ad^n_{(i/2)K_1 H_1^{(pm)}} (hatZ_mu^{(pm)})
#             = { i K_1^n e^{-i theta} hatY_mu        (n 奇数)
#               {   K_1^n hatZ_mu^{(pm)}             (n 偶数)
#   (h1.y)  ad^n_{(i/2)K_1 H_1^{(pm)}} (hatY_mu)
#             = { -i K_1^n e^{i theta} hatZ_mu^{(pm)} (n 奇数)
#               {    K_1^n hatY_mu                    (n 偶数)
#   (h2.z-) ad^n_{i K_2^* H_2} (hatZ_mu^{(-)})
#             = { -i (2K_2^*)^n hatY_mu               (n 奇数)
#               {    (2K_2^*)^n hatZ_mu^{(-)}         (n 偶数)
#   (h2.y)  ad^n_{i K_2^* H_2} (hatY_mu)
#             = {  i (2K_2^*)^n hatZ_mu^{(-)}         (n 奇数)
#               {    (2K_2^*)^n hatY_mu               (n 偶数)
#
# 対象: structured-latex cosh_sinh_coefficient_conversion
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/spin_ops.sage'))

N_MAX = 8   # n = 0, 1, ..., N_MAX について検証する

print("=== 生成子スケール後の n 重交換子（n = 0..%d）===" % N_MAX)
all_ok = True
for M in SPIN_TEST_M:
    O = SpinOps(M)
    for params in SPIN_TEST_PARAMS:
        K1v = RDF(params['K1'])
        K2s = K_star(params['K2'])
        worst = {'h1.z': 0.0, 'h1.y': 0.0, 'h2.z-': 0.0, 'h2.y': 0.0}
        for sgn in [1, -1]:
            for mu in O.mu_range():
                t = O.theta(mu)
                Zh = O.Zhat(mu, sgn)
                Zm = O.Zhat(mu, -1)
                Yh = O.Yhat(mu)
                X1 = CDF(I) / 2 * K1v * O.H1(sgn)   # (i/2) K_1 H_1^{(pm)}
                X2 = CDF(I) * K2s * O.H2            # i K_2^* H_2
                for n in range(N_MAX + 1):
                    odd = (n % 2 == 1)
                    a1 = CDF(K1v) ** n
                    a2 = CDF(2 * K2s) ** n
                    rhs_h1z = (CDF(I) * a1 * eiph(-t) * Yh) if odd else (a1 * Zh)
                    rhs_h1y = (-CDF(I) * a1 * eiph(t) * Zh) if odd else (a1 * Yh)
                    rhs_h2z = (-CDF(I) * a2 * Yh) if odd else (a2 * Zm)
                    rhs_h2y = (CDF(I) * a2 * Zm) if odd else (a2 * Yh)
                    worst['h1.z'] = max(worst['h1.z'], opnorm(adpow(X1, Zh, n) - rhs_h1z))
                    worst['h1.y'] = max(worst['h1.y'], opnorm(adpow(X1, Yh, n) - rhs_h1y))
                    worst['h2.z-'] = max(worst['h2.z-'], opnorm(adpow(X2, Zm, n) - rhs_h2z))
                    worst['h2.y'] = max(worst['h2.y'], opnorm(adpow(X2, Yh, n) - rhs_h2y))
        print(f"M = {M}, K1 = {params['K1']}, K2 = {params['K2']} (K2* = {float(K2s):.6f}):")
        for key in ['h1.z', 'h1.y', 'h2.z-', 'h2.y']:
            all_ok = report(key, worst[key], tol=1e-8) and all_ok

print("RESULT: PASS" if all_ok else "RESULT: FAIL")
