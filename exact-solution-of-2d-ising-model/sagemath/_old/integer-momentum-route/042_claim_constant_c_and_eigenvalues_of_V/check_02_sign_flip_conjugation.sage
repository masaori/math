# ---------------------------------------------------------
# SageMath: 符号反転共役 U = (prod_{m odd} sigma^x_m)(prod_m sigma^z_m)
#   U S_1^{(pm)} U^{-1} = -S_1^{(pm)},  U S_2 U^{-1} = -S_2
#   したがって tr(exp(S_1)exp(S_2)) = tr(exp(-S_1)exp(-S_2))
# 対象: structured-latex sign_flip_conjugation
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== 符号反転共役 U と、それによるトレースの不変性 ===")
all_ok = True
for (M, K1v, K2v) in TEST_CASES:
    for sgn in [1, -1]:
        T = TransferSetup(M, K1v, K2v, sgn=sgn)
        U = T.U_signflip()
        Ui = U.inverse()
        r1 = opnorm(U * T.S1 * Ui + T.S1)
        r2 = opnorm(U * T.S2 * Ui + T.S2)
        # トレースの等式
        E1 = matrix(CDF, T.S1.exp()); E1m = matrix(CDF, (-T.S1).exp())
        E2 = matrix(CDF, T.S2.exp()); E2m = matrix(CDF, (-T.S2).exp())
        tau_p = CDF((E1 * E2).trace())
        tau_m = CDF((E1m * E2m).trace())
        r3 = abs(tau_p - tau_m)
        rel = r3 / max(abs(tau_p), 1)
        label = f"M={M}, K1={K1v}, K2={K2v}, sgn={sgn:+d}"
        ok = (max(r1, r2) <= TOL) and (rel <= 1e-9)
        print(f"  {label}: U S1 U^-1 + S1 = {r1:.2e}, U S2 U^-1 + S2 = {r2:.2e}, "
              f"|tau_+ - tau_-|/|tau_+| = {rel:.2e}  -> {'PASS' if ok else 'FAIL'}")
        all_ok = ok and all_ok

print("RESULT: PASS" if all_ok else "RESULT: FAIL")
