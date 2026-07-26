# ---------------------------------------------------------
# <matrix_multiplication_continuity>:
#   ‖A_N − A‖ → 0 ならば ‖A_N B − AB‖ → 0。
#
# 本文の証明は ‖A_N B − AB‖ = ‖(A_N−A)B‖ ≤ ‖A_N−A‖‖B‖（劣乗法性）である。
# 数値では次を確認する:
#   (1) 各 N について ‖A_N B − AB‖ ≤ ‖A_N − A‖·‖B‖ が成り立つ（評価そのもの）。
#   (2) ‖A_N−A‖ の減衰の仕方（1/N, 1/N^2, 2^{-N}）に応じて ‖A_N B − AB‖ も同じ率で 0 へ落ちる
#       （収束率を実測して記録する）。
#   (3) B = O のときは自明に 0、B ≠ O のときは比 ‖A_N B−AB‖/‖A_N−A‖ が
#       [0, ‖B‖] に収まる（評価が緩すぎないかの確認）。
#
# 反例を探す姿勢: A_N が収束しない（‖A_N−A‖ が 0 に落ちない）ときは
# 積側も落ちないこと（B が正則なら）を確認する。
#
# 対象: structured-latex matrix_multiplication_continuity
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/operators.sage'))
load(os.path.join(_dir, '_prelude.sage'))
import numpy as np

rep = CheckReport("matrix_multiplication_continuity: ‖A_N−A‖→0 ⟹ ‖A_N B−AB‖→0")

rates = [("1/N", lambda N: 1.0 / float(N)),
         ("1/N^2", lambda N: 1.0 / float(N) ** 2),
         ("2^{-N}", lambda N: 2.0 ** (-float(N)))]
Ns = [1, 2, 4, 8, 16, 32, 64]

targets = [("乱数 4x4", rand_mat(4, 15001, 1.0), rand_mat(4, 15002, 1.0), rand_mat(4, 15003, 1.0))]
targets.append(("B = O", rand_mat(4, 15011, 1.0), rand_mat(4, 15012, 1.0),
                np.zeros((4, 4), dtype=complex)))
targets.append(("B = 冪零 Jordan", rand_mat(4, 15021, 1.0), rand_mat(4, 15022, 1.0),
                np.diag(np.ones(3, dtype=complex), 1)))
# Ising 側: A = V_1（臨界点近傍）、B = hatZ^(-)_1、摂動 C = hatY_1
for p in OP_TEST_PARAMS:
    M = 3
    targets.append(("Ising V_1 / hatZ (M=3,K1=%g,K2=%g)" % (p['K1'], p['K2']),
                    V1_op(float(p['K1']), M), hatY_op(1, M), hatZ_op(1, M, '-')))

for name, A, C, B in targets:
    print("--- %s ---" % name)
    for rname, rate in rates:
        prev = None
        for N in Ns:
            AN = A + rate(N) * C
            dA = fro(AN - A)
            dP = fro(AN @ B - A @ B)
            rep.truth(le_ok(dP, dA * fro(B)),
                      "‖A_N B−AB‖ ≤ ‖A_N−A‖‖B‖ (%s, %s, N=%d)" % (name, rname, N))
            if fro(B) > 0 and dA > 0:
                rep.truth(0.0 <= dP / dA <= fro(B) * (1.0 + 1e-12),
                          "比 ∈ [0,‖B‖] (%s, %s, N=%d)" % (name, rname, N))
            prev = (dA, dP)
        print("   %-8s N=%d: ‖A_N−A‖=%.6e, ‖A_N B−AB‖=%.6e, 比=%s"
              % (rname, Ns[-1], prev[0], prev[1],
                 ("%.6f" % (prev[1] / prev[0])) if prev[0] > 0 else "-"))
        if fro(B) > 0:
            rep.truth(prev[1] <= prev[0] * fro(B) * (1.0 + 1e-12),
                      "N=%d でも評価が成立 (%s, %s)" % (Ns[-1], name, rname))

# 収束率の記録: ‖A_N−A‖ が 1/N のとき ‖A_N B−AB‖ も 1/N で落ちる
A = rand_mat(4, 15101, 1.0); C = rand_mat(4, 15102, 1.0); B = rand_mat(4, 15103, 1.0)
print("--- 収束率（‖A_N−A‖ = ‖C‖/N のとき）---")
for N in [1, 10, 100, 1000, 10000]:
    AN = A + C / float(N)
    print("   N=%6d: ‖A_N−A‖=%.6e  ‖A_N B−AB‖=%.6e  (N×) = %.6e"
          % (N, fro(AN - A), fro(AN @ B - A @ B), float(N) * fro(AN @ B - A @ B)))
    rep.truth(le_ok(fro(AN @ B - A @ B), fro(AN - A) * fro(B)), "収束率 N=%d" % N)
# N×‖A_N B−AB‖ が N に依らず一定（＝ 1 次で落ちる）
vals = [float(N) * fro((A + C / float(N)) @ B - A @ B) for N in [10, 100, 1000, 10000]]
rep.close(vals[0], vals[-1], "‖A_N B−AB‖ は 1/N の 1 次で落ちる（N×が一定）")

# 反例側: A_N が収束しない場合は積も収束しない（B が正則なとき）
B = rand_mat(4, 15201, 1.0)
Binv_ok = abs(np.linalg.det(B)) > 1e-6
D = rand_mat(4, 15202, 1.0)
worst = min(fro((A + D) @ B - A @ B) for _ in range(1))
rep.truth(Binv_ok and worst > 1e-3,
          "B 正則・A_N が A に収束しないなら積も収束しない（‖(A_N−A)B‖=%.3e）" % worst)

rep.finish()
