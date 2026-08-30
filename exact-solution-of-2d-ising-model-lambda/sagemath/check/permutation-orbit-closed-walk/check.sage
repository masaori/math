"""動く辺の軌道列が向き付き辺の相異なる閉じた非後退辺列になることを厳密検査する。

対象: claim_permutation_power_return / def_permutation_minimal_return /
def_permutation_orbit_sequence / claim_moved_orbit_closed_nonbacktracking。
一辺 L=2 のトーラスの向き付き辺のうち先頭六辺だけを置換し残りを固定する
（前 tick の kac-ward-determinant-term-nonzero と同じ標本）。
"""

load("sagemath/check/torus-kac-ward-even-subgraph-square/check.sage")


def in_next(L, edge, successor):
    return (endpoints(L, edge)[1] == endpoints(L, successor)[0]
            and successor != reversal(edge))


L = 2
oriented = edges(L)
N = len(oriented)

nonvacuous = 0
for image in Permutations(range(6)):
    sigma = list(image) + list(range(6, N))

    # 回帰の存在（claim_permutation_power_return）: すべての辺で 1 <= k <= N の回帰がある。
    returns = {}
    for i in range(N):
        j, k = i, 0
        while True:
            j, k = sigma[j], k + 1
            if j == i:
                break
            assert k <= N
        returns[i] = k
        assert 1 <= k <= N
        # 最小性（def_permutation_minimal_return）: k 未満の反復は戻らない。
        j = i
        for step in range(1, k):
            j = sigma[j]
            assert j != i

    # 仮定: すべての動く辺で行き先が非後退後続辺に属する。
    hypothesis = all(in_next(L, oriented[i], oriented[sigma[i]])
                     for i in range(N) if sigma[i] != i)
    moved = [i for i in range(N) if sigma[i] != i]
    if not (hypothesis and moved):
        continue
    nonvacuous += 1

    for e in moved:
        r = returns[e]
        orbit = [e]
        for _ in range(r - 1):
            orbit.append(sigma[orbit[-1]])
        # 第一: 各項は動く辺である。
        assert all(sigma[i] != i for i in orbit)
        # 第二: 閉じた非後退辺列である（隣接接続と閉じる接続）。
        for t in range(r - 1):
            assert in_next(L, oriented[orbit[t]], oriented[orbit[t + 1]])
        assert in_next(L, oriented[orbit[r - 1]], oriented[orbit[0]])
        assert sigma[orbit[r - 1]] == orbit[0]
        # 第三: r 個の項は相異なる。
        assert len(set(orbit)) == r

assert nonvacuous > 0
print("PASS: moved orbits are closed nonbacktracking walks with distinct edges "
      f"({nonvacuous} nonvacuous permutations)")
