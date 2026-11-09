# 対象ラベル: index_skipping_map_reaches_every_other_index
# m = 1,…,9、全ての k ∈ {1,…,m+1}、k でない全ての i ∈ {1,…,m+1} で、証明が置く j と
# その所属の論証、二つの場合の鎖を一行ずつ確かめる。
# 帰属: ZZ（添字は整数）。浮動小数点と RR / CC への脱出はない。添字は本文と同じ 1 始まりで書く。
N = 10


def delta(m, k, j):
    """def_index_skipping_map: δ^m_k(j) := j (j < k)、j + 1 (j ≥ k)。"""
    assert 1 <= j <= m and 1 <= k <= m + 1
    return ZZ(j) if j < k else ZZ(j + 1)


steps = 0
cases = {"i < k": 0, "i > k": 0}
neg = 0
for m in range(1, N):
    for k in range(1, m + 2):
        for i in range(1, m + 2):
            i = ZZ(i)
            if i == k:
                continue
            if i < k:
                cases["i < k"] += 1
                j = i                                         # j := i
                assert 1 <= i; steps += 1                     # 1 ≤ i
                assert i < k <= m + 1; steps += 1             # i < k ≤ m+1
                assert i <= m; steps += 1                     # i ∈ Z から i ≤ m
                assert 1 <= j <= m                            # j ∈ {1,…,m}
                assert delta(m, k, j) == delta(m, k, i); steps += 1   # (j の置き方)
                assert delta(m, k, i) == i; steps += 1                # (def, i < k)
            else:
                assert i > k                                  # i ≠ k かつ i < k でない
                cases["i > k"] += 1
                j = i - 1                                     # j := i − 1
                assert i > k >= 1; steps += 1                 # i > k ≥ 1
                assert i - 1 >= 1; steps += 1                 # i ∈ Z から i − 1 ≥ 1
                assert i <= m + 1; steps += 1                 # i ≤ m+1
                assert i - 1 <= m; steps += 1                 # i − 1 ≤ m
                assert 1 <= j <= m                            # j ∈ {1,…,m}
                assert j >= k; steps += 1                     # i > k と i, k ∈ Z から i − 1 ≥ k
                assert delta(m, k, j) == j + 1; steps += 1             # (def, j ≥ k)
                assert j + 1 == (i - 1) + 1; steps += 1                # (j の置き方)
                assert (i - 1) + 1 == i; steps += 1                    # (−1 + 1 = 0)
            assert delta(m, k, j) == i                        # 主張
        # 独立な経路: 像全体が {1,…,m+1} \ {k} に一致する
        assert sorted(delta(m, k, j) for j in range(1, m + 1)) == [x for x in range(1, m + 2) if x != k]
        # 否定コントロール: 境界を 1 つずらした写像（j ≤ k なら j）は、k ≤ m のとき k+1 を値に取らない
        if k <= m:
            assert all((j if j <= k else j + 1) != k + 1 for j in range(1, m + 1))
            neg += 1

print(f"場合 i < k: {cases['i < k']} 件、場合 i > k: {cases['i > k']} 件（鎖と所属の段 {steps}）")
print(f"negative controls (境界をずらした写像は k+1 に届かない): {neg}")
print("RESULT: PASS")
