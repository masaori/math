# ---------------------------------------------------------
# SageMath: Step 2 arg(gamma_2(theta)*gamma_2(-theta)) = pi
# 対象: parts/008_.../028_claim_a_theta_mu.typ Part A Step 2
# 式ペア: arg^([0,2pi))(gamma_2(theta_mu)*gamma_2(-theta_mu)) = pi
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

# ---------------------------------------------------------
# 数値検証 (arg_02pi は数値関数なので手動ループ)
# ---------------------------------------------------------
print("\n--- Numerical Verification: Step 2: arg(g2*g2-) = pi ---")

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
        product = g2_plus * g2_minus

        arg_val = arg_02pi(product)
        err = abs(arg_val - RR(pi))
        if err > tol:
            print(f"  MISMATCH at mu={mu}: arg(g2*g2-) = {arg_val}, expected pi")
            all_ok = False

if all_ok:
    print("RESULT: PASS")
else:
    print("RESULT: FAIL")
