# ---------------------------------------------------------
# SageMath: [ψ†_μ, ψ†_ν]_+ = 0 (δ^M_{μ+ν,0} ≠ 0 のケースの coefficient = 0)
# 対象: parts/008_.../031_claim_psiの反交換関係.typ Claim a)
#
# coefficient = c_μ c_ν * (-sqrt(γγ-)_μ sqrt(γγ-)_ν + γ_(-θ_μ) γ_(-θ_ν)) * 2M
# ν = -μ (ν+μ=0) のとき coefficient = 0 を数値検証
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

print("\n--- Numerical Verification: [ψ†_μ, ψ†_ν]_+ = 0 (with ν=-μ) ---")

test_params = DEFAULT_TEST_PARAMS
M_val = DEFAULT_M_VAL
tol = DEFAULT_TOLERANCE

all_ok = True

for params in test_params:
    val_K1 = params['K1']
    val_K2 = params['K2']
    print(f"Parameters: K1={val_K1}, K2={val_K2}, M={M_val}")

    mu_list = [m for m in range(-M_val, M_val + 1) if m != 0]
    fail_count = 0

    for mu in mu_list:
        th_mu = (2 * pi * mu) / M_val
        nu = -mu
        th_nu = (2 * pi * nu) / M_val

        subs_dict = {K1: val_K1, K2: val_K2}

        g2_mu_pos = CC(gamma_2(th_mu).subs(subs_dict))
        g2_mu_neg = CC(gamma_2(-th_mu).subs(subs_dict))
        g2_nu_pos = CC(gamma_2(th_nu).subs(subs_dict))
        g2_nu_neg = CC(gamma_2(-th_nu).subs(subs_dict))

        sqrt_mu = sqrt_cc(g2_mu_pos * g2_mu_neg)
        sqrt_nu = sqrt_cc(g2_nu_pos * g2_nu_neg)

        c_mu = 1 / (2 * CC(sqrt(M_val)) * g2_mu_neg)
        c_nu = 1 / (2 * CC(sqrt(M_val)) * g2_nu_neg)

        coeff = c_mu * c_nu * (-sqrt_mu * sqrt_nu + g2_mu_neg * g2_nu_neg) * 2 * M_val

        err = abs(coeff)
        if err > tol:
            if fail_count < 5:
                print(f"  MISMATCH at mu={mu}: |coeff| = {err}, coeff = {coeff}")
            fail_count += 1
            all_ok = False

    if fail_count > 5:
        print(f"  ... and {fail_count - 5} more mismatches")

if all_ok:
    print("RESULT: PASS")
else:
    print("RESULT: FAIL")
