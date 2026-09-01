"""頂点単純な閉じた非後退辺列の循環総回転数を全列挙で厳密観察する。

対象:
- claim_vertex_simple_cycle_turning_by_seam_parity
- claim_plane_simple_polygon_cyclic_turning
一辺 L=2,3,4 のトーラスで、通過の頂点が相異なる（接触対数零の）閉じた
非後退辺列を、頂点の相異なりで刈り込む深さ優先探索で全列挙し、
循環総回転数 t∘(γ) と切断線偶奇 (h(γ) mod 2, v(γ) mod 2) を突き合わせる。

検査する離散 Whitney の言明:
- 切断線偶奇が (0,0) の頂点単純閉路は t∘(γ) ∈ {+4, -4}
- 切断線偶奇が (0,0) 以外の頂点単純閉路は t∘(γ) = 0

すべて整数の加法と有限集合の数え上げであり、浮動小数点は使わない。
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


def direction(edge):
    kind, _, _, d = edge
    return {("h", 0): 0, ("v", 0): 1, ("h", 1): 2, ("v", 1): 3}[(kind, d)]


def step_turning(edge, successor):
    turn = (direction(successor) - direction(edge)) % 4
    assert turn in (0, 1, 3)
    return {0: ZZ(0), 1: ZZ(1), 3: ZZ(-1)}[turn]


def directed_winding(edge, L):
    kind, i, j, d = edge
    sign = ZZ(1 - 2 * d)
    return (ZZ(kind == "h" and j == L - 1) * sign,
            ZZ(kind == "v" and i == L - 1) * sign)


def check_candidate(L, walk):
    """1 本の頂点単純閉路について候補の言明を検査する。"""
    m = len(walk)
    turning = sum(step_turning(walk[r], walk[(r + 1) % m]) for r in range(m))
    winding_h = ZZ(sum(directed_winding(edge, L)[0] for edge in walk))
    winding_v = ZZ(sum(directed_winding(edge, L)[1] for edge in walk))
    total_h = winding_h % 2
    total_v = winding_v % 2
    if (total_h, total_v) == (0, 0):
        assert (winding_h, winding_v) == (ZZ(0), ZZ(0)), (L, walk, winding_h, winding_v)
        assert turning in (ZZ(4), ZZ(-4)), (L, walk, turning)
        return ("trivial", turning)
    assert turning == ZZ(0), (L, walk, turning)
    return ("nontrivial", turning)


trivial_total = 0
nontrivial_total = 0
walk_total = 0

for L in (2, 3, 4):
    oriented = edges(L)
    successor_lists = {
        edge: [other for other in oriented
               if endpoints(L, edge)[1] == endpoints(L, other)[0]
               and other != reversal(edge)]
        for edge in oriented
    }
    for start in oriented:
        source_of_start = endpoints(L, start)[0]
        # 深さ優先探索。walk の通過の頂点（各辺の終点）を相異なるまま延ばす。
        # 閉じるのは、最後の辺の終点が始辺の始点で、かつ始辺への一歩が
        # 非後退（reversal でない）のとき。
        stack = [([start], frozenset([endpoints(L, start)[1]]))]
        while stack:
            walk, visited = stack.pop()
            last = walk[-1]
            if endpoints(L, last)[1] == source_of_start and start != reversal(last):
                walk_total += 1
                kind_of_walk, _ = check_candidate(L, walk)
                if kind_of_walk == "trivial":
                    trivial_total += 1
                else:
                    nontrivial_total += 1
                continue
            for nxt in successor_lists[last]:
                tgt = endpoints(L, nxt)[1]
                if tgt in visited:
                    continue
                stack.append((walk + [nxt], visited | frozenset([tgt])))

assert walk_total == trivial_total + nontrivial_total
assert trivial_total > 0
assert nontrivial_total > 0

print("PASS: vertex-simple closed nonbacktracking walks (rooted) =", walk_total)
print("PASS: seam parity (0,0) with t = +-4 :", trivial_total)
print("PASS: seam parity != (0,0) with t = 0 :", nontrivial_total)
print("PASS: L = 2, 3, 4")
