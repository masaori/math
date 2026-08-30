"""台の辺が相異なる閉歩道では、同頂点の添字対の出辺交換が必ず非後退接続になることを厳密検査する。

一辺二のトーラス上の閉じた非後退辺列を長さ 8 まで全数列挙し、台の辺が相異なるものの
すべての同頂点添字対 (k, l) について、再接続 e_k -> e_{sigma(l)} と e_l -> e_{sigma(k)} が
始点終点の一致と反転回避（Next の二条件）を満たすことを検査する。
併せて、前節の反例の六辺が台の辺の相異性を満たさないことも検査する。
浮動小数点は使わない。
"""

L = 2
MAX_LENGTH = 8

oriented_edges = [(kind, i, j, d)
                  for kind in ("h", "v") for i in range(L) for j in range(L)
                  for d in (0, 1)]


def reversal(edge):
    kind, i, j, d = edge
    return (kind, i, j, 1 - d)


def base_edge(edge):
    kind, i, j, _ = edge
    return (kind, i, j)


def endpoints(edge):
    kind, i, j, d = edge
    boundary0 = (i, j)
    boundary1 = (i, (j + 1) % L) if kind == "h" else ((i + 1) % L, j)
    return (boundary0, boundary1) if d == 0 else (boundary1, boundary0)


def src(edge):
    return endpoints(edge)[0]


def tgt(edge):
    return endpoints(edge)[1]


def successors(edge):
    return [f for f in oriented_edges if src(f) == tgt(edge) and f != reversal(edge)]


closed_walks = []


def extend(walk):
    if 2 <= len(walk) and walk[0] in successors(walk[-1]):
        closed_walks.append(tuple(walk))
    if len(walk) == MAX_LENGTH:
        return
    for f in successors(walk[-1]):
        walk.append(f)
        extend(walk)
        walk.pop()


for start in oriented_edges:
    extend([start])

edge_simple_walks = [walk for walk in closed_walks
                     if len(set(base_edge(e) for e in walk)) == len(walk)]

checked_pairs = ZZ(0)
for walk in edge_simple_walks:
    m = len(walk)
    for k in range(m):
        for l in range(m):
            if k == l or tgt(walk[k]) != tgt(walk[l]):
                continue
            out_l = walk[(l + 1) % m]
            out_k = walk[(k + 1) % m]
            assert src(out_l) == tgt(walk[k])
            assert out_l != reversal(walk[k])
            assert src(out_k) == tgt(walk[l])
            assert out_k != reversal(walk[l])
            checked_pairs += 1

counterexample = [
    ("h", 0, 0, 0), ("h", 0, 1, 0), ("v", 0, 0, 0),
    ("h", 1, 0, 0), ("h", 1, 1, 0), ("v", 0, 0, 1),
]
assert tuple(counterexample) in closed_walks
assert len(set(base_edge(e) for e in counterexample)) < len(counterexample)
assert base_edge(counterexample[2]) == base_edge(counterexample[5])

assert 0 < len(edge_simple_walks)
assert 0 < checked_pairs

print("PASS: closed walks (L=%d, length <= %d): %d; base-edge-simple: %d; "
      "same-vertex index pairs with nonbacktracking reconnections: %d; "
      "counterexample walk correctly violates base-edge simplicity"
      % (L, MAX_LENGTH, len(closed_walks), len(edge_simple_walks), checked_pairs))
