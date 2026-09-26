# ---------------------------------------------------------
# SageMath: ord の値域 1 ≤ ord(μ) ≤ 2^{M_col}（証明の「値域」の中間目標の式変形）
# 対象ラベル: row_configuration_numbering_bijective
# 対象: 001_partition_function_2d_ising.ts の同ブロック「中間目標: 値域」
# 式: 0 ≤ Σ b_m(μ) 2^{M-m} ≤ Σ 2^{M-m} = Σ_{t=0}^{M-1} 2^t = 2^M - 1
# 帰属: すべて ZZ。厳密計算。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/row_configurations.sage"))

ok_all = True
for M_col in range(1, 13):
    upper_chain = [sum(ZZ(2) ** (M_col - m) for m in range(1, M_col + 1)),
                   sum(ZZ(2) ** t for t in range(0, M_col)),
                   ZZ(2) ** M_col - 1]
    ok = all(x == upper_chain[0] for x in upper_chain)
    for mu in row_configurations(M_col):
        s = sum(b_digit(mu, m) * ZZ(2) ** (M_col - m) for m in range(1, M_col + 1))
        ok = ok and (0 <= s <= upper_chain[0])
        o = ord_number(mu)
        ok = ok and (o in ZZ) and (1 <= o <= ZZ(2) ** M_col) and (o == 1 + s)
    print(f"  M_col={M_col}: |𝔐|={2**M_col}, 値域の不等式と上端の等式鎖 -> {'PASS' if ok else 'FAIL'}")
    ok_all = ok_all and ok
exact_result(ok_all)
