# ---------------------------------------------------------
# SageMath: S_1^{(pm)} = i K_1 H_1^{(pm)} と S_2 = i K_2^* H_2 が実対称であること
# 対象: structured-latex iH_is_real_symmetric
#   併せて sigma 表示 S_1 = K_1 sum sigma^z_m sigma^z_{m+1} -+ K_1 G,
#                   S_2 = K_2^* sum sigma^x_m も確認する。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== S_1^{(pm)}, S_2 の実対称性と sigma 表示 ===")
all_ok = True
for (M, K1v, K2v) in TEST_CASES:
    for sgn in [1, -1]:
        T = TransferSetup(M, K1v, K2v, sgn=sgn)
        O = T.O
        # 実対称性
        r1 = max(opnorm(T.S1 - T.S1.transpose()), opnorm(T.S1 - T.S1.conjugate()))
        r2 = max(opnorm(T.S2 - T.S2.transpose()), opnorm(T.S2 - T.S2.conjugate()))
        # sigma 表示
        bulk = matrix(CDF, T.d, T.d, 0)
        for m in range(1, M):
            bulk = bulk + O.SZ[m] * O.SZ[m + 1]
        G = O.SY[1]
        for k in range(2, M):
            G = G * O.SX[k]
        G = G * O.SY[M]
        rhs1 = T.K1 * bulk - sgn * T.K1 * G      # K_1 sum sz sz  -+ K_1 G （sgn=+1 で -G）
        r3 = opnorm(T.S1 - rhs1)
        rhs2 = T.K2s * sum([O.SX[m] for m in range(1, M + 1)], matrix(CDF, T.d, T.d, 0))
        r4 = opnorm(T.S2 - rhs2)
        label = f"M={M}, K1={K1v}, K2={K2v}, sgn={sgn:+d}"
        ok = max(r1, r2, r3, r4) <= TOL
        print(f"  {label}: 実対称 S1={r1:.2e} S2={r2:.2e} / sigma表示 S1={r3:.2e} S2={r4:.2e}"
              f"  -> {'PASS' if ok else 'FAIL'}")
        all_ok = ok and all_ok

print("RESULT: PASS" if all_ok else "RESULT: FAIL")
