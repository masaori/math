# ---------------------------------------------------------
# SageMath: ord : 𝔐 → {1,…,2^{M_col}} は全単射（主張の結論）
#   |𝔐| = 2^{M_col}、像が {1,…,2^{M_col}} 全体、値の重複なし。
#   さらに 2 進展開による逆写像 ord_inverse と互いに逆であることも確かめる。
# 対象ラベル: row_configuration_numbering_bijective
# 対象: 001_partition_function_2d_ising.ts の同ブロック statement と「中間目標: 全単射性」
# 帰属: ZZ。厳密計算。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/row_configurations.sage"))

ok_all = True
for M_col in range(1, 13):
    cfg = row_configurations(M_col)
    vals = [ord_number(mu) for mu in cfg]
    ok = (len(cfg) == ZZ(2) ** M_col)
    ok = ok and (len(set(vals)) == len(vals))
    ok = ok and (set(vals) == set(range(1, 2 ** M_col + 1)))
    ok = ok and all(ord_inverse(ord_number(mu), M_col) == mu for mu in cfg)
    ok = ok and all(ord_number(ord_inverse(k, M_col)) == k for k in range(1, 2 ** M_col + 1))
    print(f"  M_col={M_col}: |𝔐|={len(cfg)}, 像 = {{1..{2**M_col}}}, 重複なし, 逆写像と整合 -> {'PASS' if ok else 'FAIL'}")
    ok_all = ok_all and ok
exact_result(ok_all)
