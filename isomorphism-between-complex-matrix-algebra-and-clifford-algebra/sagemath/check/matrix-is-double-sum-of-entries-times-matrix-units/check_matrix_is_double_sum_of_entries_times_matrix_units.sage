# 対象ラベル: claim_matrix_is_double_sum_of_entries_times_matrix_units
# 有限集合 X（ここでは {1,…,M} の部分集合全体 P_M、M=1,2,3）で添字づけた整数行列 F について、
# F = Σ_x 1·(Σ_y F_{x,y}·E_{x,y}) を厳密計算（ZZ）で確かめる。証明の準備の一つ目から三つ目も成分で確かめる。
from itertools import combinations

def power_set(M):
    base = list(range(1, M + 1))
    return [frozenset(c) for r in range(M + 1) for c in combinations(base, r)]

def delta(a, b):                   # def_kronecker_delta
    return ZZ(1) if a == b else ZZ(0)

def E(X, x, y):                    # def_matrix_unit: (E_{x,y})_{u,v} = δ_{x,u}·δ_{y,v}
    n = len(X)
    return matrix(ZZ, n, n, lambda u, v: delta(X[x], X[u]) * delta(X[y], X[v]))

for M in range(1, 4):
    X = power_set(M)
    n = len(X)
    set_random_seed(20261112 + M)
    for trial in range(3):
        F = random_matrix(ZZ, n, n, x=-5, y=6)
        inner = lambda x: sum((F[x, y] * E(X, x, y) for y in range(n)), zero_matrix(ZZ, n))
        total = sum((1 * inner(x) for x in range(n)), zero_matrix(ZZ, n))
        assert total == F                                                       # 主張
        for p in range(n):
            for q in range(n):
                for x in range(n):
                    for y in range(n):                                          # 準備の一つ目
                        assert F[x, y] * E(X, x, y)[p, q] == delta(X[q], X[y]) * (F[x, y] * delta(X[x], X[p]))
                    assert sum(delta(X[q], X[y]) * (F[x, y] * delta(X[x], X[p])) for y in range(n)) == F[x, q] * delta(X[x], X[p])   # 準備の二つ目
                    assert 1 * (F[x, q] * delta(X[x], X[p])) == delta(X[p], X[x]) * F[x, q]                                        # 準備の三つ目
                assert sum(delta(X[p], X[x]) * F[x, q] for x in range(n)) == F[p, q]
        # 否定コントロール: 成分の添字を入れ替えた和は転置になり、対称でない F では F と一致しない
        swapped = sum((sum((F[y, x] * E(X, x, y) for y in range(n)), zero_matrix(ZZ, n)) for x in range(n)), zero_matrix(ZZ, n))
        assert swapped == F.transpose()
        if F != F.transpose():
            assert swapped != F
    print("M=%d: PASS" % M)
print("ALL PASS")
