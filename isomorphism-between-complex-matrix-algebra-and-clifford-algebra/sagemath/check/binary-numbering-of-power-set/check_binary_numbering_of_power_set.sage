# 対象ラベル: claim_binary_numbering_is_numbering_of_power_set
# e_M を def_binary_numbering_of_power_set の帰納的な式どおりに作り、
# M=0..8 で単射・全射と、証明の準備（ア）（イ）（ウ）と全射の場合分けの k を確かめる。
from itertools import combinations

def two_pow(M):
    return 1 if M == 0 else 2 * two_pow(M - 1)

def e(M, k):
    if M == 0:
        assert k == 1
        return frozenset()
    h = two_pow(M - 1)
    assert 1 <= k <= 2 * h
    return e(M - 1, k) if k <= h else e(M - 1, k - h) | frozenset([M])

def power_set(M):
    base = list(range(1, M + 1))
    return {frozenset(c) for r in range(M + 1) for c in combinations(base, r)}

for M in range(0, 9):
    n = two_pow(M)
    assert n == 2**M
    values = [e(M, k) for k in range(1, n + 1)]
    P = power_set(M)
    assert all(v in P for v in values)            # 値が P_M に入る
    assert len(set(values)) == n                  # 単射
    assert set(values) == P                       # 全射
    if M >= 1:
        h = two_pow(M - 1)
        for k in range(1, n + 1):
            if k <= h:
                assert M not in e(M, k)           # （ア）
            else:
                assert M in e(M, k)               # （イ）
                for t in range(1, M):             # （ウ）
                    assert (t in e(M, k)) == (t in e(M - 1, k - h))
        inv = {e(M - 1, j): j for j in range(1, h + 1)}
        for T in P:                               # 全射の場合分けの k
            Tp = frozenset(t for t in T if t <= M - 1)
            j = inv[Tp]
            k = j if M not in T else j + h
            assert 1 <= k <= n and e(M, k) == T
    print("M=%d: 2^M=%d PASS" % (M, n))
print("ALL PASS")
