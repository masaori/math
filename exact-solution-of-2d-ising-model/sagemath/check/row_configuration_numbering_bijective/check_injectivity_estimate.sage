# ---------------------------------------------------------
# SageMath: 単射性の証明の評価式
#   ord(μ) - ord(μ') = 2^{M-k} + R,  |R| ≤ Σ_{l>k} |b_l(μ)-b_l(μ')| 2^{M-l} ≤ 2^{M-k} - 1 < 2^{M-k}
#   （k は μ(k) ≠ μ'(k) となる最小の添字、μ(k) = -1, μ'(k) = 1 の向きに取る）
# 対象ラベル: row_configuration_numbering_bijective
# 対象: 001_partition_function_2d_ising.ts の同ブロック「中間目標: 単射性」
# 帰属: ZZ。全ての組 (μ, μ') について厳密計算。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/row_configurations.sage"))

ok_all = True
for M_col in range(1, 8):
    cfg = row_configurations(M_col)
    n_pairs = 0
    ok = True
    for mu in cfg:
        for mup in cfg:
            if mu == mup:
                continue
            k = min(m for m in range(1, M_col + 1) if mu[m - 1] != mup[m - 1])
            if mu[k - 1] != -1:          # 向きを μ(k) = -1, μ'(k) = 1 にそろえる（証明の「入れ替えてよい」）
                continue
            n_pairs += 1
            d = [b_digit(mu, l) - b_digit(mup, l) for l in range(1, M_col + 1)]
            diff_chain = [ord_number(mu) - ord_number(mup),
                          sum(d[l - 1] * ZZ(2) ** (M_col - l) for l in range(1, M_col + 1)),
                          sum(d[l - 1] * ZZ(2) ** (M_col - l) for l in range(k, M_col + 1)),
                          ZZ(2) ** (M_col - k) + sum(d[l - 1] * ZZ(2) ** (M_col - l) for l in range(k + 1, M_col + 1))]
            ok = ok and all(x == diff_chain[0] for x in diff_chain)
            ok = ok and all(d[l - 1] == 0 for l in range(1, k)) and d[k - 1] == 1
            R = sum(d[l - 1] * ZZ(2) ** (M_col - l) for l in range(k + 1, M_col + 1))
            est = [abs(R),
                   sum(abs(d[l - 1]) * ZZ(2) ** (M_col - l) for l in range(k + 1, M_col + 1)),
                   sum(ZZ(2) ** (M_col - l) for l in range(k + 1, M_col + 1)),
                   sum(ZZ(2) ** t for t in range(0, M_col - k)),
                   ZZ(2) ** (M_col - k) - 1]
            ok = ok and est[0] <= est[1] <= est[2] and est[2] == est[3] == est[4] and est[4] < ZZ(2) ** (M_col - k)
            ok = ok and diff_chain[0] != 0
    print(f"  M_col={M_col}: 組 {n_pairs} 個で差の式変形・評価の鎖・差 ≠ 0 -> {'PASS' if ok else 'FAIL'}")
    ok_all = ok_all and ok
exact_result(ok_all)
