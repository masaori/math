"""反転対を含まない非後退置換の軌道列の台の辺が相異なることを厳密検査する。

対象: claim_reversal_free_orbit_support_edges_distinct。
一辺 L=2 のトーラスで非後退置換を全列挙し、動く辺の集合が反転対
{(e,0),(e,1)} を含まない置換について、動く辺 e から始まる軌道列
γ_φ(e) = (e, φ(e), ..., φ^{r-1}(e))（r は最小回帰時刻）を組み、
軌道列の r 個の項の台の辺（第 1 成分）が互いに相異なることを検査する。
あわせて、証明の準備が引く二つの事実（各項が動く辺であること、
r 個の項が向き付き辺として相異なること）も同じ列挙で確かめる。
すべて有限集合の数え上げであり、浮動小数点は使わない。
"""

load("sagemath/check/torus-kac-ward-even-subgraph-square/check.sage")


def successors(L, oriented, edge):
    return [other for other in oriented
            if endpoints(L, edge)[1] == endpoints(L, other)[0]
            and other != reversal(edge)]


L = 2
oriented = edges(L)
successor_lists = {edge: successors(L, oriented, edge) for edge in oriented}
edge_count = len(oriented)

# 非後退置換の全列挙。各辺を固定するか後続の一つへ写し、単射なものだけ残す。
# 有限集合の単射な自己写像は全射でもあるので、これで置換が尽くされる。
nonbacktracking_permutations = []


def extend(position, images, used):
    if position == edge_count:
        nonbacktracking_permutations.append(dict(images))
        return
    edge = oriented[position]
    for image in [edge] + successor_lists[edge]:
        if image in used:
            continue
        images[edge] = image
        used.add(image)
        extend(position + 1, images, used)
        used.discard(image)
        del images[edge]


extend(0, {}, set())
assert len(nonbacktracking_permutations) == 30784

reversal_free_count = 0
orbit_count = 0

for phi in nonbacktracking_permutations:
    moved = {edge for edge in oriented if phi[edge] != edge}
    if any(reversal(edge) in moved for edge in moved):
        continue
    reversal_free_count += 1
    for start in moved:
        # 軌道列 γ_φ(start)。最小回帰時刻 r まで反復合成を並べる。
        walk = [start]
        current = phi[start]
        while current != start:
            walk.append(current)
            current = phi[current]
        orbit_count += 1
        # 準備が引く事実: 各項は動く辺であり、r 個の項は向き付き辺として相異なる。
        assert all(entry in moved for entry in walk)
        assert len(set(walk)) == len(walk)
        # 主張: 軌道列の台の辺（第 1 成分）は相異なる。
        bases = [(kind, i, j) for (kind, i, j, d) in walk]
        assert len(set(bases)) == len(bases)

# 仮定が空でないこと（反転対を含まない置換と、その動く辺の軌道が実在すること）。
assert reversal_free_count == 497
assert orbit_count > 0

print("PASS: reversal-free nonbacktracking permutations =", reversal_free_count)
print("PASS: orbit walks checked =", orbit_count)
print("PASS: every orbit walk has pairwise distinct base edges (L = 2)")
