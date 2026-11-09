# 対象ラベル: bijection_composed_with_index_skipping_map_stays_in_lower_indices
# m = 1,…,5、{1,…,m+1} の全ての置換 π と π(k) = m+1 の k、全ての j ∈ {1,…,m} で、証明の各段を確かめる。
# 証明は背理法なので、「π(δ^m_k(j)) = m+1 と仮定すると」の鎖は仮定が成り立つ点が無い。
# そこで鎖の各行が使う事実（π(k) = m+1、π の値が m+1 になる添字は k だけ、δ^m_k(j) ≠ k）を
# それぞれ確かめ、結論 π(δ^m_k(j)) ≠ m+1 と π(δ^m_k(j)) ∈ {1,…,m+1}、主張を確かめる。
# 帰属: ZZ（添字は整数）。浮動小数点と RR / CC への脱出はない。添字は本文と同じ 1 始まりで書く。
from itertools import permutations, product

N = 6


def delta(m, k, j):
    """def_index_skipping_map: δ^m_k(j) := j (j < k)、j + 1 (j ≥ k)。"""
    assert 1 <= j <= m and 1 <= k <= m + 1
    return ZZ(j) if j < k else ZZ(j + 1)


steps = 0
perms = 0
neg_k = 0
neg_inj = 0
for m in range(1, N):
    big = range(1, m + 2)
    for img in permutations(big):
        pi = {p: ZZ(img[p - 1]) for p in big}
        perms += 1
        ks = [p for p in big if pi[p] == m + 1]
        assert len(ks) == 1
        k = ks[0]
        assert pi[k] == m + 1; steps += 1                         # π(k) = m+1（k の取り方）
        # 仮定 π(δ(j)) = m+1 から π(δ(j)) = π(k) を経て、π の単射性で δ(j) = k が出る。
        # π の単射性: π の値が π(k) になる添字は k だけ（j に依らないので j のループの外で 1 回）
        assert all(p == k for p in big if pi[p] == pi[k]); steps += 1
        for j in range(1, m + 1):
            d = delta(m, k, j)
            assert d != k; steps += 1                             # index_skipping_map_never_takes_skipped_index
            assert pi[d] != m + 1; steps += 1                     # よって π(δ(j)) ≠ m+1
            assert 1 <= pi[d] <= m + 1; steps += 1                # π の終域
            assert 1 <= pi[d] <= m                                # 主張
        # 否定コントロール: π(k') ≠ m+1 の k' で飛ばすと、値が m+1 に届く j がある
        for kk in big:
            if kk != k:
                assert any(pi[delta(m, kk, j)] == m + 1 for j in range(1, m + 1))
                neg_k += 1
    # 否定コントロール: 単射でない写像 f（f(k) = m+1）では、f(δ(j)) = m+1 となる j がありうる
    if m <= 3:
        for img in product(big, repeat=m + 1):
            f = {p: img[p - 1] for p in big}
            for k in big:
                if f[k] != m + 1:
                    continue
                if any(f[delta(m, k, j)] == m + 1 for j in range(1, m + 1)):
                    assert len(set(img)) < m + 1                  # そうなるのは単射でないときだけ
                    neg_inj += 1

print(f"{perms} 個の置換で、π(k) = m+1・単射性・δ(j) ≠ k・値の範囲を確かめた（{steps} 段）")
print(f"negative controls (π(k') ≠ m+1 では m+1 に届く): {neg_k}")
print(f"negative controls (単射でない f では m+1 に届く組がある): {neg_inj}")
assert neg_k > 0 and neg_inj > 0
print("RESULT: PASS")
