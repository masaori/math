# 対象ラベル: index_skipping_map_is_injective
# 同じ回に足した index_skipping_map_never_takes_skipped_index・index_skipping_map_reaches_every_other_index も確かめる。
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
        # index_skipping_map_never_takes_skipped_index
        for j in dom:
            if j < k:
                assert delta(m, k, j) == j; steps += 1        # def, j < k
                assert j < k; steps += 1                       # j < k
            else:
                assert delta(m, k, j) == j + 1; steps += 1    # def, j ≥ k
                assert j + 1 > j; steps += 1                   # 1 > 0
                assert j >= k; steps += 1                      # j ≥ k
            assert delta(m, k, j) != k
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
        # index_skipping_map_reaches_every_other_index
        for i in range(1, m + 2):
            if i == k:
                continue
            if i < k:
                j = i
                assert 1 <= j <= m
                assert delta(m, k, j) == delta(m, k, i); steps += 1
                assert delta(m, k, i) == i; steps += 1
            else:
                j = i - 1
                assert 1 <= j <= m and j >= k
                assert delta(m, k, j) == j + 1; steps += 1
                assert j + 1 == (i - 1) + 1; steps += 1
                assert (i - 1) + 1 == i; steps += 1
            assert delta(m, k, j) == i
        # 否定コントロール: 境界を 1 つずらした写像（j ≤ k なら j）は、k ≤ m のとき k を値に取る
        if k <= m:
            assert any((j if j <= k else j + 1) == k for j in dom)
            neg += 1

print(f"δ の 3 つの主張の各場合の鎖を m = 1,…,{N-1}、全ての k で確かめた（{steps} 段）")
print(f"negative controls (境界をずらした写像は k を値に取る): {neg}")
print("RESULT: PASS")
