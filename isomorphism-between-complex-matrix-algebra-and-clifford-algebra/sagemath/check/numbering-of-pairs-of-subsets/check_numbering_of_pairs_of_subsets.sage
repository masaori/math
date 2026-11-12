# 対象ラベル: claim_numbering_of_pairs_of_subsets_is_numbering
# p_M(m) := (e_M(η(m)(1)), e_M(η(m)(2)))、η := η_{2^M,2} を定義の帰納的な式どおりに作り、
# M=0..4 で単射・全射と、全射の証明で置く m := η^{-1}(x) が p_M(m)=(S,T) を満たすことを確かめる。整数と有限集合だけの計算。
from itertools import combinations

def two_pow(M):                                   # def_binary_numbering_of_power_set の 2^M
    return 1 if M == 0 else 2 * two_pow(M - 1)

def int_pow(n, k):                                # def_power_of_nonnegative_integer
    return 1 if k == 0 else n * int_pow(n, k - 1)

def e(M, k):                                      # def_binary_numbering_of_power_set
    if M == 0:
        assert k == 1
        return frozenset()
    h = two_pow(M - 1)
    return e(M - 1, k) if k <= h else e(M - 1, k - h) | frozenset([M])

def eta(n, k, m):                                 # def_base_n_numbering_of_maps（写像を {s: 値} の辞書で表す）
    if k == 0:
        assert m == 1
        return {}
    q, rho = divmod(m - 1, int_pow(n, k - 1))
    a, r = q + 1, rho + 1
    assert 1 <= a <= n and 1 <= r <= int_pow(n, k - 1) and m == (a - 1) * int_pow(n, k - 1) + r
    x = dict(eta(n, k - 1, r))
    x[k] = a
    return x

def power_set(M):
    base = list(range(1, M + 1))
    return [frozenset(c) for r in range(M + 1) for c in combinations(base, r)]

for M in range(0, 5):
    n = two_pow(M)
    N = int_pow(n, 2)
    assert N >= 1 and N == n * (n * 1)
    p = {m: (e(M, eta(n, 2, m)[1]), e(M, eta(n, 2, m)[2])) for m in range(1, N + 1)}
    P = power_set(M)
    pairs = {(S, T) for S in P for T in P}
    assert all(v in pairs for v in p.values())                    # 値が P_M×P_M に入る
    assert len(set(p.values())) == N                              # 単射
    assert set(p.values()) == pairs                               # 全射
    e_inv = {e(M, k): k for k in range(1, n + 1)}
    eta_inv = {tuple(sorted(eta(n, 2, m).items())): m for m in range(1, N + 1)}
    for (S, T) in pairs:                                          # 全射の証明の m := η^{-1}(x)
        x = {1: e_inv[S], 2: e_inv[T]}
        m = eta_inv[tuple(sorted(x.items()))]
        assert p[m] == (S, T)
    # 否定の対照: e_M の代わりに単射でない写像（k ↦ e_M(1)）を使うと、M ≥ 1 では全射にならない
    if M >= 1:
        bad = {(e(M, 1), e(M, eta(n, 2, m)[2])) for m in range(1, N + 1)}
        assert bad != pairs
print("PASS numbering-of-pairs-of-subsets M=0..4")
