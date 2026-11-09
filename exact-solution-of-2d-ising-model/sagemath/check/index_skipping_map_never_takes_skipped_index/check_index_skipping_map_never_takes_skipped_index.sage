# 対象ラベル: index_skipping_map_never_takes_skipped_index
# m = 1,…,9、全ての k ∈ {1,…,m+1}、全ての j ∈ {1,…,m} で、証明の二つの場合の鎖を一行ずつ確かめる。
# 帰属: ZZ（添字は整数）。浮動小数点と RR / CC への脱出はない。添字は本文と同じ 1 始まりで書く。
N = 10


def delta(m, k, j):
    """def_index_skipping_map: δ^m_k(j) := j (j < k)、j + 1 (j ≥ k)。"""
    assert 1 <= j <= m and 1 <= k <= m + 1
    return ZZ(j) if j < k else ZZ(j + 1)


steps = 0
cases = {"j < k": 0, "j >= k": 0}
neg = 0
for m in range(1, N):
    for k in range(1, m + 2):
        for j in range(1, m + 1):
            j = ZZ(j)
            d = delta(m, k, j)
            assert d == [x for x in range(1, m + 2) if x != k][j - 1]   # 定義の読み方（{1,…,m+1}∖{k} の j 番目）と一致
            if j < k:
                cases["j < k"] += 1
                assert d == j; steps += 1                 # δ^m_k(j) = j        (def, j < k)
                assert j < k; steps += 1                  # j < k               (j < k)
                assert d < k                              # 鎖の両端: δ^m_k(j) < k
            else:
                cases["j >= k"] += 1
                assert d == j + 1; steps += 1             # δ^m_k(j) = j + 1    (def, j ≥ k)
                assert j + 1 > j; steps += 1              # j + 1 > j           (1 > 0)
                assert j >= k; steps += 1                 # j ≥ k               (j ≥ k)
                assert d > k                              # 鎖の両端: δ^m_k(j) > k
            assert d != k                                 # 主張
            assert 1 <= d <= m + 1                        # 終域 {1,…,m+1}
        # 否定コントロール: 境界を 1 つずらした写像（j ≤ k なら j、j > k なら j + 1）は、
        # k ≤ m のとき j = k で k を値に取る
        if k <= m:
            assert any((j if j <= k else j + 1) == k for j in range(1, m + 1))
            neg += 1

print(f"場合 j < k: {cases['j < k']} 件、場合 j ≥ k: {cases['j >= k']} 件（鎖の段 {steps}）")
print(f"negative controls (境界をずらした写像は k を値に取る): {neg}")
print("RESULT: PASS")
