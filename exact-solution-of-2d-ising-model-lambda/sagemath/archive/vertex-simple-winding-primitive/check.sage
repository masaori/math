"""頂点単純閉路の巻き付きベクトルが零または原始的であることを厳密検査する。

対象: claim_vertex_simple_winding_zero_or_primitive。
一辺 L=1,2,3,4 のトーラスで、通過の頂点が相異なる閉じた非後退辺列を
全列挙し、(w_h,w_v)=(0,0) または gcd(|w_h|,|w_v|)=1 を検査する。
すべて ZZ の加減乗除、最大公約数、有限列挙だけである。
"""


def edges(L):
    return [(kind, i, j, d) for kind in ("h", "v")
            for i in range(L) for j in range(L) for d in (0, 1)]


def reversal(edge):
    kind, i, j, d = edge
    return (kind, i, j, 1 - d)


def endpoints(L, edge):
    kind, i, j, d = edge
    boundary0 = (i, j)
    boundary1 = (i, (j + 1) % L) if kind == "h" else ((i + 1) % L, j)
    return (boundary0, boundary1) if d == 0 else (boundary1, boundary0)


def winding(L, walk):
    horizontal = sum(ZZ(1 - 2 * d) for kind, i, j, d in walk
                     if kind == "h" and j == L - 1)
    vertical = sum(ZZ(1 - 2 * d) for kind, i, j, d in walk
                   if kind == "v" and i == L - 1)
    return horizontal, vertical


walk_total = 0
zero_total = 0
primitive_total = 0

for L in (1, 2, 3, 4):
    oriented = edges(L)
    successor_lists = {
        edge: [other for other in oriented
               if endpoints(L, edge)[1] == endpoints(L, other)[0]
               and other != reversal(edge)]
        for edge in oriented
    }
    for start in oriented:
        source_of_start = endpoints(L, start)[0]
        stack = [([start], frozenset([endpoints(L, start)[1]]))]
        while stack:
            walk, visited = stack.pop()
            last = walk[-1]
            if endpoints(L, last)[1] == source_of_start and start != reversal(last):
                horizontal, vertical = winding(L, walk)
                walk_total += 1
                if (horizontal, vertical) == (0, 0):
                    zero_total += 1
                else:
                    assert gcd(abs(horizontal), abs(vertical)) == 1, (L, walk, horizontal, vertical)
                    primitive_total += 1
                continue
            for nxt in successor_lists[last]:
                target = endpoints(L, nxt)[1]
                if target in visited:
                    continue
                stack.append((walk + [nxt], visited | frozenset([target])))

assert walk_total == zero_total + primitive_total
assert zero_total > 0
assert primitive_total > 0
print("PASS: vertex-simple closed nonbacktracking walks (rooted) =", walk_total)
print("PASS: zero winding vectors =", zero_total)
print("PASS: primitive nonzero winding vectors =", primitive_total)
print("PASS: L = 1, 2, 3, 4")
