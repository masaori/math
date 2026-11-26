# 対象ラベル: finite_sum_of_complex_numbers_in_consecutive_pairs
# Σ_{j=1}^{2n} z_j = Σ_{k=1}^{n} (z_{2k-1} + z_{2k}) の証明の各行（n = 0 の 2 行、n = 1 の 3 行、n → n+1 の 7 行）を
# n = 1,…,7 で確かめる。有限和は def_finite_sum_of_complex_numbers のとおり左から順に足して組む。
# 帰属: QQ 上の多項式環（z_j は不定元）。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
N = 8
P = PolynomialRing(QQ, [f"z{j}" for j in range(1, 2 * N + 1)])
z = P.gens()   # z[j-1] が本文の z_j


def fsum(zs):
    """def_finite_sum_of_complex_numbers: Σ^{0} := 0_ℂ、Σ^{1} := z_1、Σ^{m+1} := (Σ^{m}) + z_{m+1}。"""
    if len(zs) == 0:
        return P(0)
    s = zs[0]
    for w in zs[1:]:
        s = s + w
    return s


def pairs(n):
    """右辺の項 z_{2k-1} + z_{2k}（k = 1,…,n）。"""
    return [z[2 * k - 2] + z[2 * k - 1] for k in range(1, n + 1)]


# n = 0
lines0 = [fsum([]), P(0), fsum(pairs(0))]
for t in range(len(lines0) - 1):
    assert lines0[t] == lines0[t + 1], (0, t)
# n = 1
lines1 = [fsum(list(z[:2])), fsum(list(z[:1])) + z[1], z[0] + z[1], fsum(pairs(1))]
for t in range(len(lines1) - 1):
    assert lines1[t] == lines1[t + 1], (1, t)
count = 2
for n in range(1, N):
    assert fsum(list(z[:2 * n])) == fsum(pairs(n))                       # 帰納法の仮定
    lines = [
        fsum(list(z[:2 * (n + 1)])),                                      # Σ^{2(n+1)}
        fsum(list(z[:2 * n + 2])),                                        # ℤ の分配律
        fsum(list(z[:2 * n + 1])) + z[2 * n + 1],                         # 帰納の式（m → 2n+1）
        (fsum(list(z[:2 * n])) + z[2 * n]) + z[2 * n + 1],                # 帰納の式（m → 2n）
        fsum(list(z[:2 * n])) + (z[2 * n] + z[2 * n + 1]),                # 和の結合律
        fsum(pairs(n)) + (z[2 * n] + z[2 * n + 1]),                       # 帰納法の仮定
        fsum(pairs(n)) + (z[2 * (n + 1) - 2] + z[2 * (n + 1) - 1]),       # ℤ の分配律
        fsum(pairs(n + 1)),                                               # 帰納の式（m → n）を右辺から左辺へ
    ]
    for t in range(len(lines) - 1):
        assert lines[t] == lines[t + 1], (n, t)
    # 比べる側: Sage の sum（独立な経路）
    assert sum(z[:2 * (n + 1)]) == sum(pairs(n + 1))
    # 対照: 最後の項 z_{2n+2} を落とした右辺とは一致しない
    assert fsum(list(z[:2 * (n + 1)])) != fsum(pairs(n)) + z[2 * n]
    count += 1
print(f"n = 0,…,{N} の {count} 通りで証明の各行を確かめた")
print("RESULT: PASS")
