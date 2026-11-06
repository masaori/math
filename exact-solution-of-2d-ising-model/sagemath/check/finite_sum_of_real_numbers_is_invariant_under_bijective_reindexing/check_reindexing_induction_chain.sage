# 対象ラベル: finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing
# m = 1,…,6、{1,…,m} の全ての置換 π と、各 m で 4 本の列 a（QQ の元）について、
# 証明の m = 1 の 3 行の鎖と、m → m+1 の段（m+1 = 2,…,6）の 7 行の鎖を一行ずつ確かめる。
# 帰属: 添字は ZZ、a_j は QQ（ℝ の元の代表として厳密な有理数を使う）。浮動小数点と RR / CC への脱出はない。
# 添字は本文と同じ 1 始まりで書く。
from itertools import permutations

N = 7


def delta(m, k, j):
    """def_index_skipping_map: δ^m_k(j) := j (j < k)、j + 1 (j ≥ k)。"""
    assert 1 <= j <= m and 1 <= k <= m + 1
    return ZZ(j) if j < k else ZZ(j + 1)


def fsum(m, r):
    """def_finite_sum_of_real_numbers: Σ_{j=1}^{1} r_j := r_1、Σ_{j=1}^{m+1} r_j := (Σ_{j=1}^{m} r_j) + r_{m+1}（左から足す）。"""
    s = r(1)
    for j in range(2, m + 1):
        s = s + r(j)
    return s


def sequences(m):
    """各 m で使う 4 本の列（1 始まりの dict）。値は QQ。"""
    out = []
    out.append({j: QQ(j) for j in range(1, m + 1)})
    out.append({j: QQ(j) ** 2 - QQ(3) / 2 for j in range(1, m + 1)})
    out.append({j: QQ((-1) ** j) / j for j in range(1, m + 1)})
    out.append({j: QQ(7 * j % 5) - QQ(2) / 3 for j in range(1, m + 1)})
    return out


steps = 0
cases = 0
neg = 0
# m = 1 の段
for a in sequences(1):
    pi = {1: ZZ(1)}
    assert pi[1] in [1]                                    # π(1) ∈ {1}
    lhs = fsum(1, lambda j: a[pi[j]])
    assert lhs == a[pi[1]]; steps += 1                      # def_finite_sum_of_real_numbers
    assert a[pi[1]] == a[1]; steps += 1                     # π(1) = 1
    assert a[1] == fsum(1, lambda j: a[j]); steps += 1      # 定義を右辺から左辺へ
    cases += 1

# m → m+1 の段（mm := m+1）
for mm in range(2, N):
    m = mm - 1
    for img in permutations(range(1, mm + 1)):
        pi = {p + 1: ZZ(img[p]) for p in range(mm)}
        k = [p for p in pi if pi[p] == m + 1][0]           # π は全射なので π(k) = m+1 の k
        tau = {j: pi[delta(m, k, j)] for j in range(1, m + 1)}  # def_bijection_composed_with_index_skipping_map
        assert sorted(tau.values()) == list(range(1, m + 1))   # τ は全単射（bijection_..._is_bijective）
        for a in sequences(mm):
            b = {j: a[pi[j]] for j in range(1, mm + 1)}     # b_j := a_{π(j)}
            rows = [
                fsum(mm, lambda j: a[pi[j]]),
                fsum(mm, lambda j: b[j]),                                   # b の置き方
                fsum(m, lambda j: b[delta(m, k, j)]) + b[k],                # moves_one_term_to_end
                fsum(m, lambda j: a[pi[delta(m, k, j)]]) + a[pi[k]],        # b の置き方
                fsum(m, lambda j: a[tau[j]]) + a[pi[k]],                    # τ の定義を右辺から左辺へ
                fsum(m, lambda j: a[tau[j]]) + a[m + 1],                    # π(k) = m+1
                fsum(m, lambda j: a[j]) + a[m + 1],                         # 帰納法の仮定
                fsum(mm, lambda j: a[j]),                                   # 定義を右辺から左辺へ
            ]
            for x, y in zip(rows, rows[1:]):
                assert x == y
                steps += 1
            # 帰納法の仮定そのもの（m 項の列 a_1..a_m と τ）を独立に確かめる
            assert fsum(m, lambda j: a[tau[j]]) == fsum(m, lambda j: a[j])
            cases += 1
            # 否定コントロール: π(k) ≠ m+1 の k' で末尾に a_{m+1} を置くと、a の値が相異なる列では等号が崩れる
            if len(set(a.values())) == mm:
                for kk in range(1, mm + 1):
                    if kk != k:
                        wrong = fsum(m, lambda j: a[pi[delta(m, kk, j)]]) + a[m + 1]
                        assert wrong != fsum(mm, lambda j: a[j])
                        neg += 1

print(f"{cases} 組（置換と列）で、m = 1 の 3 行と m → m+1 の 7 行の鎖を確かめた（{steps} 段）")
print(f"negative controls (π(k) ≠ m+1 の k を使うと等号が崩れる): {neg}")
print("RESULT: PASS")
