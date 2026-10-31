"""反転対を含まない非後退置換の台が偶部分グラフであることを厳密検査する。

対象: claim_reversal_free_moved_support_even。
一辺 L=2 のトーラスで非後退置換を全列挙し、動く辺の集合が反転対
{(e,0),(e,1)} を含まない置換について、動く辺の台の辺集合
E_supp(φ) = { e | (e,0) ∈ M(φ) または (e,1) ∈ M(φ) } のすべての頂点の
端点の個数（次数）が偶数であることを検査する。あわせて、台の各辺の上に
ある動く向き付き辺が一意であること（証明の写像 ℓ の全単射性）も確かめる。
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
# 有限集合の単射な自己写像は全単射なので、これで置換が尽くされる。
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
with_reversal_pair_count = 0

for phi in nonbacktracking_permutations:
    moved = {edge for edge in oriented if phi[edge] != edge}
    if any(reversal(edge) in moved for edge in moved):
        with_reversal_pair_count += 1
        continue
    reversal_free_count += 1
    # 台の各辺の上にある動く向き付き辺は一意である（写像 ℓ の全単射性）。
    support = {(kind, i, j) for (kind, i, j, d) in moved}
    assert len(support) == len(moved)
    # 台の辺集合のすべての頂点の端点の個数は偶数である。
    degree = {}
    for base in support:
        kind, i, j = base
        v0 = (i, j)
        v1 = (i, (j + 1) % L) if kind == "h" else ((i + 1) % L, j)
        degree[v0] = degree.get(v0, 0) + 1
        degree[v1] = degree.get(v1, 0) + 1
    assert all(count % 2 == 0 for count in degree.values())

# 反転対を含む置換が実在すること（仮定が空でないこと）も確認する。
assert with_reversal_pair_count > 0
assert reversal_free_count + with_reversal_pair_count == 30784

print("PASS: reversal-free nonbacktracking permutations =", reversal_free_count)
print("PASS: permutations containing a reversal pair =", with_reversal_pair_count)
print("PASS: all reversal-free supports are even subgraphs (L = 2)")
