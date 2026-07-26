# ---------------------------------------------------------
# SageMath: 008 章が (-) 専用である理由
#   [H_2, hatZ^{(-)}_mu] = -2 hatY_mu           （成立）
#   [H_2, hatZ^{(+)}_mu] = -2 hatY_mu + 4 e^{-i theta_mu} Y_1  （右辺が -2 hatY ではない）
# 対象: structured-latex why_008_applies_only_to_minus_sector
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

MISMATCH_FLOOR = 1e-3
print("=== [H_2, hatZ^{(pm)}] の比較 ===")
all_ok = True
for M in EVEN_CASES_M:
    O = SpinOps(M)
    w_minus = 0.0          # (-) 側: -2 hatY との残差（0 であるべき）
    w_plus_formula = 0.0   # (+) 側: 主張の明示式との残差（0 であるべき）
    w_plus_naive = None    # (+) 側: -2 hatY との残差（0 でないはず）
    for mu in O.mu_range():
        t = O.theta(mu)
        Yh = O.Yhat(mu)
        Zm = O.Zhat(mu, -1); Zp = O.Zhat(mu, +1)
        w_minus = max(w_minus, opnorm(comm(O.H2, Zm) + 2 * Yh))
        rhs = -2 * Yh + 4 * eiph(-t) * O.Y[1]
        w_plus_formula = max(w_plus_formula, opnorm(comm(O.H2, Zp) - rhs))
        r = opnorm(comm(O.H2, Zp) + 2 * Yh)
        w_plus_naive = r if w_plus_naive is None else min(w_plus_naive, r)
    # hatZ^{(+)} = hatZ^{(-)} - 2 e^{-i theta} Z_1
    w_decomp = 0.0
    for mu in O.mu_range():
        t = O.theta(mu)
        w_decomp = max(w_decomp, opnorm(O.Zhat(mu, +1) - (O.Zhat(mu, -1) - 2 * eiph(-t) * O.Z[1])))
    ok = (max(w_minus, w_plus_formula, w_decomp) <= TOL) and (w_plus_naive >= MISMATCH_FLOOR)
    print(f"  M={M}: (-) 側 {w_minus:.2e}（成立）, (+) 側 明示式 {w_plus_formula:.2e}（成立）, "
          f"分解 {w_decomp:.2e}, (+) 側を -2hatY と比べた最小残差 {w_plus_naive:.2e}（不成立）"
          f"  -> {'PASS' if ok else 'FAIL'}")
    all_ok = ok and all_ok

print("RESULT: PASS" if all_ok else "RESULT: FAIL")
