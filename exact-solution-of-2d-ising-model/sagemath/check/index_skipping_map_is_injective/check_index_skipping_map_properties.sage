# 対象ラベル: index_skipping_map_is_injective
# m = 1,…,9、全ての k ∈ {1,…,m+1} で、各証明の場合分けの鎖を一行ずつ確かめる。
# 帰属: ZZ（添字は整数）。浮動小数点と RR / CC への脱出はない。添字は本文と同じ 1 始まりで書く。
N = 10


def delta(m, k, j):
    """def_index_skipping_map: δ^m_k(j) := j (j < k)、j + 1 (j ≥ k)。"""
    assert 1 <= j <= m and 1 <= k <= m + 1
    return ZZ(j) if j < k else ZZ(j + 1)


steps = 0
neg = 0
for m in range(1, N):
    for k in range(1, m + 2):
        dom = range(1, m + 1)
        for j in dom:                                   # 定義の読み方（{1,…,m+1}∖{k} の j 番目）と一致
            assert delta(m, k, j) == [x for x in range(1, m + 2) if x != k][j - 1]
        # index_skipping_map_is_injective: 4 つの場合の鎖
        for j in dom:
            for jp in dom:
                eq = delta(m, k, j) == delta(m, k, jp)
                if j < k and jp < k:
                    if eq:
                        assert j == delta(m, k, j); steps += 1
                        assert delta(m, k, j) == delta(m, k, jp); steps += 1
                        assert delta(m, k, jp) == jp; steps += 1
                elif j >= k and jp >= k:
                    if eq:
                        assert j == (j + 1) - 1; steps += 1
                        assert (j + 1) - 1 == delta(m, k, j) - 1; steps += 1
                        assert delta(m, k, j) - 1 == delta(m, k, jp) - 1; steps += 1
                        assert delta(m, k, jp) - 1 == (jp + 1) - 1; steps += 1
                        assert (jp + 1) - 1 == jp; steps += 1
                else:
                    a, b = (j, jp) if j < k else (jp, j)       # a < k ≤ b
                    assert delta(m, k, a) == a; steps += 1
                    assert a < k; steps += 1
                    assert k <= b; steps += 1
                    assert b < b + 1; steps += 1
                    assert b + 1 == delta(m, k, b); steps += 1
                    assert not eq                               # この場合は起こらない
                if eq:
                    assert j == jp
        # 否定コントロール: j ≥ k で j + 1 の代わりに j − 1 を取る写像は、2 ≤ k ≤ m のとき
        # δ'(k − 1) = δ'(k) = k − 1 となり単射でない
        if 2 <= k <= m:
            vals = [j if j < k else j - 1 for j in dom]
            assert len(set(vals)) < len(vals)
            neg += 1

print(f"δ の単射性の 4 つの場合の鎖を m = 1,…,{N-1}、全ての k で確かめた（{steps} 段）")
print(f"negative controls (j ≥ k で j − 1 を取る写像は単射でない): {neg}")
print("RESULT: PASS")
