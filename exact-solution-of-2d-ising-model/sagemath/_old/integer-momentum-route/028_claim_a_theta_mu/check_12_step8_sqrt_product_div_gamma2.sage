# ---------------------------------------------------------
# SageMath: Step 8 sqrt(gamma_2*gamma_2(-))/gamma_2(-) = cases(+/- sqrt(gamma_2/gamma_2(-)))
# 対象: parts/008_.../028_claim_a_theta_mu.typ Part A Step 8
# 式ペア: sqrt(g2*g2-)/g2- = cases(+/- sqrt(g2/g2-)) based on arg(g2-)
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

# ---------------------------------------------------------
# 数値検証 (sqrt_cc, arg_02pi は数値関数なので手動ループ)
# ---------------------------------------------------------
print("\n--- Numerical Verification: Step 8: sqrt(g2*g2-)/g2- = cases(+/- sqrt(g2/g2-)) ---")

test_params = DEFAULT_TEST_PARAMS
M_val = DEFAULT_M_VAL
tol = DEFAULT_TOLERANCE

all_ok = True

for params in test_params:
    val_K1 = params['K1']
    val_K2 = params['K2']
    print(f"Parameters: K1={val_K1}, K2={val_K2}, M={M_val}")

    mu_list = [m for m in range(-M_val, M_val + 1) if m != 0]

    for mu in mu_list:
        th = (2 * pi * mu) / M_val
        subs_dict = {K1: val_K1, K2: val_K2}

        g2_plus = CC(gamma_2(th).subs(subs_dict))
        g2_minus = CC(gamma_2(-th).subs(subs_dict))

        arg_g2_minus = arg_02pi(g2_minus)

        # 式1: sqrt(g2*g2-) / g2-
        v1 = sqrt_cc(g2_plus * g2_minus) / g2_minus

        # 式2: cases based on arg(g2-)
        sqrt_ratio = sqrt_cc(g2_plus / g2_minus)
        if (0 <= arg_g2_minus <= RR(pi/2)) or (RR(3*pi/2) < arg_g2_minus < RR(2*pi)):
            v2 = sqrt_ratio
        else:  # pi/2 < arg <= 3pi/2
            v2 = -sqrt_ratio

        err = abs(v1 - v2)
        if err > tol:
            print(f"  MISMATCH at mu={mu}: |lhs - rhs| = {err}")
            print(f"    sqrt(g2*g2-)/g2- = {v1}")
            print(f"    cases_expr = {v2}")
            print(f"    arg(g2-) = {arg_g2_minus}")
            all_ok = False

if all_ok:
    print("RESULT: PASS")
else:
    print("RESULT: FAIL")
