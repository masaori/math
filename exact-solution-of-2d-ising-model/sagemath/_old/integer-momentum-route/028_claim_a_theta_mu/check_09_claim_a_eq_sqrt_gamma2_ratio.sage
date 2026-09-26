# ---------------------------------------------------------
# SageMath: Claim本体 a(theta_mu) = sqrt(gamma_2(theta)/gamma_2(-theta))
# 対象: parts/008_.../028_claim_a_theta_mu.typ Claim
# 式ペア: a(theta_mu) = sqrt_cc(gamma_2(theta_mu)/gamma_2(-theta_mu))
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

# ---------------------------------------------------------
# 数値検証 (sqrt_cc は数値関数なので手動ループ)
# ---------------------------------------------------------
print("\n--- Numerical Verification: Claim: a(theta_mu) = sqrt(gamma_2/gamma_2(-)) ---")

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

        # 式1: a(theta_mu) = sqrt_cc(alpha式) — 先に代入してから sqrt_cc
        v1 = sqrt_cc(CC(a_inner.subs(subs_dict)))

        # 式2: sqrt_cc(gamma_2(theta)/gamma_2(-theta)) — 先に代入してから sqrt_cc
        g2_ratio = CC(
            gamma_2(th).subs({K1: val_K1, K2: val_K2})
            / gamma_2(-th).subs({K1: val_K1, K2: val_K2})
        )
        v2 = sqrt_cc(g2_ratio)

        err = abs(v1 - v2)
        if err > tol:
            print(f"  MISMATCH at mu={mu}: |a - sqrt(g2/g2-)| = {err}")
            print(f"    a(theta_mu) = {v1}")
            print(f"    sqrt(g2/g2-) = {v2}")
            all_ok = False

if all_ok:
    print("RESULT: PASS")
else:
    print("RESULT: FAIL")
