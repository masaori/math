"""非後退置換の単純通過の辺集合が偶部分グラフであることを厳密検査する。

対象: claim_single_traversal_edge_set_even。
一辺 L=2 のトーラスで非後退置換を全列挙し（反転対を含むものも除外しない）、
反転対の辺集合 D(φ) = { e | (e,0) ∈ M(φ) かつ (e,1) ∈ M(φ) } と
単純通過の辺集合 E_1(φ) = E_supp(φ) \\ D(φ) を作り、次を検査する。

- E_supp(φ) が E_1(φ) と D(φ) の互いに素な合併であること。
- 各頂点 v で、動く辺のうち v を終点とするものと始点とするものの個数が
  等しいこと（証明の全単射 Φ）。
- 各頂点 v で d_{E_1(φ)}(v) + 2a = 2b（a は D(φ) の端点の指示値の総和、
  b は v を終点とする動く辺の個数）が成り立つこと（証明の二通りの総和）。
- E_1(φ) のすべての頂点の端点の個数が偶数であること（結論）。

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


def base_endpoints(base):
    kind, i, j = base
    v0 = (i, j)
    v1 = (i, (j + 1) % L) if kind == "h" else ((i + 1) % L, j)
    return (v0, v1)


vertices = [(i, j) for i in range(L) for j in range(L)]

with_reversal_pair_count = 0
reversal_free_count = 0

for phi in nonbacktracking_permutations:
    moved = {edge for edge in oriented if phi[edge] != edge}
    support = {(kind, i, j) for (kind, i, j, d) in moved}
    doubled = {base for base in support
               if (base + (0,)) in moved and (base + (1,)) in moved}
    single = support - doubled
    if doubled:
        with_reversal_pair_count += 1
    else:
        reversal_free_count += 1
    # E_supp は E_1 と D の互いに素な合併である。
    assert single | doubled == support
    assert single & doubled == set()
    # 単純通過の辺の上の動く向き付き辺はちょうど一つ、反転対の辺の上は二つ。
    for base in single:
        assert sum(1 for d in (0, 1) if (base + (d,)) in moved) == 1
    for base in doubled:
        assert sum(1 for d in (0, 1) if (base + (d,)) in moved) == 2
    for v in vertices:
        # 全単射 Φ: v を終点とする動く辺の個数 = v を始点とする動く辺の個数。
        tgt_count = sum(1 for edge in moved if endpoints(L, edge)[1] == v)
        src_count = sum(1 for edge in moved if endpoints(L, edge)[0] == v)
        assert tgt_count == src_count
        # 二通りの総和の一致 d_{E_1}(v) + 2a = 2b。
        degree_single = sum(1 for base in single for w in base_endpoints(base)
                            if w == v)
        a = sum(1 for base in doubled for w in base_endpoints(base) if w == v)
        assert degree_single + 2 * a == 2 * tgt_count
        # 結論: E_1(φ) の端点の個数は偶数である。
        assert degree_single % 2 == 0

# 反転対を含む置換が実在すること（主張が旧主張の真の一般化であること）。
assert with_reversal_pair_count > 0
assert reversal_free_count + with_reversal_pair_count == 30784

print("PASS: nonbacktracking permutations =", len(nonbacktracking_permutations))
print("PASS: permutations containing a reversal pair =", with_reversal_pair_count)
print("PASS: all single-traversal edge sets are even subgraphs (L = 2)")
