# ---------------------------------------------------------
# SageMath: Claim cases式 a(theta_mu) = +/- sqrt(gamma_2*gamma_2(-))/gamma_2(-)
# 対象: parts/008_.../028_claim_a_theta_mu.typ Claim (cases部分)
# 式ペア: a(theta_mu) = cases(+sqrt(g2*g2-)/g2- or -sqrt(g2*g2-)/g2-)
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

# ---------------------------------------------------------
# 数値検証 (sqrt_cc, arg_02pi は数値関数なので手動ループ)
# ---------------------------------------------------------
print("\n--- Numerical Verification: Claim cases: a = +/- sqrt(g2*g2-)/g2- ---")

test_params = DEFAULT_TEST_PARAMS
M_val = DEFAULT_M_VAL
tol = DEFAULT_TOLERANCE

all_ok = True

# a(theta_mu)の定義式の sqrt 内部 (シンボリック)
a_inner = (
    (1 - alpha_1 * exp(i*theta_mu)) / (1 - alpha_1 * exp(-i*theta_mu))
    * (1 - (1/alpha_2) * exp(i*theta_mu)) / (1 - (1/alpha_2) * exp(-i*theta_mu))
)

for params in test_params:
    val_K1 = params['K1']
    val_K2 = params['K2']
    print(f"Parameters: K1={val_K1}, K2={val_K2}, M={M_val}")

    mu_list = [m for m in range(-M_val, M_val + 1) if m != 0]

    for mu in mu_list:
        th = (2 * pi * mu) / M_val
        subs_dict = {K1: val_K1, K2: val_K2, theta_mu: th}

        # gamma_2 の数値計算
        g2_plus = CC(gamma_2(th).subs({K1: val_K1, K2: val_K2}))
        g2_minus = CC(gamma_2(-th).subs({K1: val_K1, K2: val_K2}))

        # arg^([0,2pi))(gamma_2(-theta))
        arg_g2_minus = arg_02pi(g2_minus)

        # sqrt_cc(gamma_2(theta) * gamma_2(-theta))
        sqrt_product = sqrt_cc(g2_plus * g2_minus)

        # cases に基づく式2の計算
        if (0 <= arg_g2_minus <= RR(pi/2)) or (RR(3*pi/2) < arg_g2_minus < RR(2*pi)):
            v2 = sqrt_product / g2_minus
        else:  # pi/2 < arg <= 3pi/2
            v2 = -sqrt_product / g2_minus

        # 式1: a(theta_mu) — 先に代入してから sqrt_cc
        v1 = sqrt_cc(CC(a_inner.subs(subs_dict)))

        err = abs(v1 - v2)
        if err > tol:
            print(f"  MISMATCH at mu={mu}: |a - cases_expr| = {err}")
            print(f"    a(theta_mu) = {v1}")
            print(f"    cases_expr = {v2}")
            print(f"    arg(g2-) = {arg_g2_minus}")
            all_ok = False

if all_ok:
    print("RESULT: PASS")
else:
    print("RESULT: FAIL")
