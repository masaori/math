# 対象ラベル: bijection_composed_with_index_skipping_map_is_bijective
# def_bijection_composed_with_index_skipping_map の値も確かめる（値が {1,…,m} に入る証明の鎖は
# sagemath/check/bijection_composed_with_index_skipping_map_stays_in_lower_indices/ が確かめる）。
# m = 1,…,5、{1,…,m+1} の全ての置換 π と、π(k) = m+1 の k で、各証明の鎖を一行ずつ確かめる。
# 帰属: ZZ（添字は整数）。浮動小数点と RR / CC への脱出はない。添字は本文と同じ 1 始まりで書く。
from itertools import permutations

N = 6


def delta(m, k, j):
    """def_index_skipping_map: δ^m_k(j) := j (j < k)、j + 1 (j ≥ k)。"""
    assert 1 <= j <= m and 1 <= k <= m + 1
    return ZZ(j) if j < k else ZZ(j + 1)


steps = 0
perms = 0
neg = 0
for m in range(1, N):
    for img in permutations(range(1, m + 2)):
        pi = {p + 1: ZZ(img[p]) for p in range(m + 1)}
        k = [p for p in pi if pi[p] == m + 1][0]
        perms += 1
        dom = range(1, m + 1)
        for j in dom:
            assert 1 <= pi[delta(m, k, j)] <= m                # τ^π_k の終域 {1,…,m}
        tau = {j: pi[delta(m, k, j)] for j in dom}           # def_bijection_composed_with_index_skipping_map
        # 単射性の鎖（τ(j) = τ(j') の組）
        for j in dom:
            for jp in dom:
                if tau[j] == tau[jp]:
                    assert pi[delta(m, k, j)] == tau[j]; steps += 1
                    assert tau[j] == tau[jp]; steps += 1
                    assert tau[jp] == pi[delta(m, k, jp)]; steps += 1
                    assert delta(m, k, j) == delta(m, k, jp)   # π の単射性
                    assert j == jp                             # index_skipping_map_is_injective
        # 全射性の鎖
        for i in dom:
            p = [q for q in pi if pi[q] == i][0]
            # 背理法「p = k と仮定すると i = π(p) = π(k) = m+1 となり i ≤ m に反する」の各行が使う事実
            assert pi[p] == i; steps += 1                      # i = π(p)            (π(p) = i)
            assert pi[k] == m + 1; steps += 1                  # π(k) = m+1          (k の取り方)
            assert i <= m < m + 1; steps += 1                  # i ≤ m なので i ≠ m+1 = π(k)
            assert p != k                                      # 結び: p ≠ k
            js = [j for j in dom if delta(m, k, j) == p]
            assert len(js) == 1
            j = js[0]
            assert tau[j] == pi[delta(m, k, j)]; steps += 1
            assert pi[delta(m, k, j)] == pi[p]; steps += 1
            assert pi[p] == i; steps += 1
        assert sorted(tau.values()) == list(dom)               # 主張そのもの（独立な経路）
        # 否定コントロール: π(k) ≠ m+1 の k を使うと、値が m+1 に届く j がある
        for kk in range(1, m + 2):
            if kk != k:
                assert any(pi[delta(m, kk, j)] == m + 1 for j in dom)
                neg += 1

print(f"{perms} 個の置換で、値の範囲・単射性・全射性の鎖を確かめた（{steps} 段）")
print(f"negative controls (π(k) ≠ m+1 では m+1 に届く): {neg}")
print("RESULT: PASS")
