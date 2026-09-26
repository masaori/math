# ---------------------------------------------------------
# SageMath: 分配関数の偶奇セクター分解
#   Z = tr( P^{(+)} (V^{(+)})^{N_row} ) + tr( P^{(-)} (V^{(-)})^{N_row} )
#   ここで V^{(pm)} = exp(i K_1 H_1^{(pm)} /2) V_2 exp(i K_1 H_1^{(pm)} /2)
#   併せて Step 3 の対称化 tr(P^pm (V^pm)^n) = tr(P^pm (V_1^{(pm)} V_2)^n) を確認する。
# 対象: structured-latex partition_function_sector_decomposition
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

print("=== 分配関数の偶奇セクター分解 ===")
all_ok = True
for (M, K1v, K2v) in BRIDGE_CASES:
    O = SpinOps(M)
    Id = identity_matrix(CDF, O.d)
    eps = epsilon_op(O)
    Pp, Pm = projectors(O)
    V1 = V1_pauli(O, K1v)
    V2 = V2_pauli(O, K2v)
    for N_row in [1, 2, 3]:
        lhs = CDF(((V1 * V2) ** N_row).trace())
        tot = CDF(0)
        r_sym = 0.0
        for sgn, P in [(1, Pp), (-1, Pm)]:
            Vs = V_sym(O, K1v, K2v, sgn)
            V1s = V1_pm(O, K1v, sgn)
            t1 = CDF((P * (Vs ** N_row)).trace())
            t2 = CDF((P * ((V1s * V2) ** N_row)).trace())
            r_sym = max(r_sym, abs(t1 - t2) / max(abs(t2), 1))
            tot = tot + t1
        # 4 項展開
        four = CDF(0)
        for sgn, sg in [(1, 1), (-1, -1)]:
            Vs = V_sym(O, K1v, K2v, sgn)
            four = four + CDF((Vs ** N_row).trace()) / 2 + sg * CDF((eps * (Vs ** N_row)).trace()) / 2
        r = abs(tot - lhs) / abs(lhs)
        r4 = abs(four - lhs) / abs(lhs)
        ok = max(r, r4, r_sym) <= 1e-9
        print(f"  M={M}, K1={K1v}, K2={K2v}, N_row={N_row}: "
              f"セクター和 rel={r:.2e}, 4項展開 rel={r4:.2e}, 対称化 rel={r_sym:.2e}"
              f"  -> {'PASS' if ok else 'FAIL'}")
        all_ok = ok and all_ok

print("RESULT: PASS" if all_ok else "RESULT: FAIL")
