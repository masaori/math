# 対象ラベル: claim_critical_point_rational_partition_interval
#
# 固定した x_c = sqrt(2)-1 と複数の N について、本文の候補集合、最大元、
# 両端の不等式を AA と QQ の厳密計算で検査する。


def main():
    xc = AA(2).sqrt() - 1
    for N in [1, 2, 3, 4, 5, 7, 10, 16, 31, 64, 127]:
        candidates = [j for j in range(N + 1) if AA(QQ(j) / QQ(N)) <= xc]
        assert 0 in candidates
        assert N not in candidates
        k = max(candidates)
        assert k + 1 <= N
        assert AA(QQ(k) / QQ(N)) <= xc
        assert xc < AA(QQ(k + 1) / QQ(N))
        assert all(j <= k for j in candidates)
    print("臨界点を挟む有理等分区間: 候補集合と最大元を厳密検査して通過", flush=True)


main()
