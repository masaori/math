"""非自明な選択文字を持つ鍵の対角軌道の自由性を一辺三で全数検査する。

対象: claim_selection_sum_character_evaluation,
      claim_kac_ward_determinant_fiber_stratified_phase_sum。

一辺 L の鍵 (D,E)（D,E は基底辺集合の互いに素な部分集合、E は偶部分グラフ）の
うち、E が非自明な選択文字を持つものを考える。選択文字の非自明性は E だけで
決まるので、まず偶部分グラフの全体（一辺三では巡回空間の 2^10 = 1024 個）を
GF(2) の境界行列の核として列挙し、

(1) 文字の非自明性が対角平行移動 (1,1) と可換であること（軌道上で一定）、
(2) (1,1)（一辺三では (2,2) も同じ部分群を生成する）で固定される非自明文字の
    偶部分グラフが全辺集合 E_L ただ一つであること、
(3) 従って全辺鍵 (∅, E_L) 以外の非自明文字鍵は、E 水準で既に動くか
    （E が動けば鍵も動く）、E = E_L で D = ∅ の全辺鍵に限られるので、
    すべて大きさちょうど 3 の自由な対角軌道に入ること、
(4) 非自明文字鍵の総数 N = Σ_{E 非自明} 2^(18-|E|) について N - 1 が 3 で
    割り切れ、自由軌道の個数が (N-1)/3 になること、

を有限集合と整数の等号だけで検査する。素数の奇数辺長では全ての非零対角
平行移動が同じ部分群を生成するので、(2) は L=5,7 の既存の固定鍵分類
（translation-diagonal-fixed-nontrivial-character）と合わせて素数辺長を覆う。
最初の未検査は L=9（真部分群 (3,3) の固定集合）である。浮動小数点は使わない。
"""

side = 3


def base_edges():
    return [(kind, i, j)
            for kind in ("h", "v")
            for i in range(side)
            for j in range(side)]


def edge_endpoints(edge):
    kind, i, j = edge
    if kind == "h":
        return (i, j), (i, (j + 1) % side)
    return (i, j), ((i + 1) % side, j)


def translate_edge(shift, edge):
    a, b = shift
    kind, i, j = edge
    return (kind, (i + a) % side, (j + b) % side)


edges = base_edges()
edge_index = {edge: position for position, edge in enumerate(edges)}
vertices = [(i, j) for i in range(side) for j in range(side)]
vertex_index = {vertex: position for position, vertex in enumerate(vertices)}

boundary = matrix(GF(2), len(vertices), len(edges))
for edge in edges:
    first, second = edge_endpoints(edge)
    boundary[vertex_index[first], edge_index[edge]] += 1
    boundary[vertex_index[second], edge_index[edge]] += 1

cycle_space = boundary.right_kernel()
assert cycle_space.dimension() == 10

even_subsets = []
for vector_item in cycle_space:
    subset = frozenset(edges[position]
                       for position in range(len(edges))
                       if vector_item[position] == 1)
    even_subsets.append(subset)
assert len(even_subsets) == 1024
assert len(set(even_subsets)) == 1024


def winding_parities(subset):
    return (
        sum(ZZ(kind == "h" and j == side - 1)
            for kind, i, j in subset) % 2,
        sum(ZZ(kind == "v" and i == side - 1)
            for kind, i, j in subset) % 2,
    )


def has_nontrivial_character(single):
    """E 内の閉路 H で <E,H> = 1 となるものがあるかを GF(2) 上で判定する。"""
    winding_h, winding_v = winding_parities(single)

    def character_edge(edge):
        kind, i, j = edge
        return ZZ((winding_v * (kind == "h" and j == side - 1)
                   + winding_h * (kind == "v" and i == side - 1)) % 2)

    adjacency = {}
    for edge in single:
        first, second = edge_endpoints(edge)
        adjacency.setdefault(first, []).append((second, edge))
        adjacency.setdefault(second, []).append((first, edge))

    potential = {}
    for root in sorted(adjacency):
        if root in potential:
            continue
        potential[root] = ZZ(0)
        stack = [root]
        while stack:
            vertex = stack.pop()
            for neighbor, edge in adjacency[vertex]:
                required = ZZ((potential[vertex] + character_edge(edge)) % 2)
                if neighbor not in potential:
                    potential[neighbor] = required
                    stack.append(neighbor)
                elif potential[neighbor] != required:
                    return True
    return False


def translate_subset(shift, subset):
    return frozenset(translate_edge(shift, edge) for edge in subset)


full_edge_set = frozenset(edges)
assert full_edge_set in set(even_subsets)
assert has_nontrivial_character(full_edge_set)

# (1) 文字の非自明性は対角平行移動と可換（全 1024 偶部分グラフで検査）。
diagonal = (1, 1)
for subset in even_subsets:
    image = translate_subset(diagonal, subset)
    assert image in set(even_subsets)
    assert has_nontrivial_character(image) == has_nontrivial_character(subset)

nontrivial = [subset for subset in even_subsets
              if has_nontrivial_character(subset)]
assert len(nontrivial) == 346
print(f"L={side}: even subgraphs 1024, nontrivial-character {len(nontrivial)}")

# (2) 対角固定の非自明文字の偶部分グラフは全辺集合ただ一つ。
for shift in [(1, 1), (2, 2)]:
    fixed_nontrivial = [subset for subset in nontrivial
                        if translate_subset(shift, subset) == subset]
    assert fixed_nontrivial == [full_edge_set]

# (3) 全辺集合以外の非自明文字の E は E 水準で大きさちょうど 3 の自由軌道。
#     文字は (1) で軌道上一定なので、軌道は nontrivial の中で閉じる。
nontrivial_set = set(nontrivial)
seen = set()
e_level_orbits = 0
for subset in nontrivial:
    if subset == full_edge_set or subset in seen:
        continue
    orbit = {subset,
             translate_subset((1, 1), subset),
             translate_subset((2, 2), subset)}
    assert len(orbit) == 3
    assert orbit <= nontrivial_set
    seen |= orbit
    e_level_orbits += 1
assert len(seen) == len(nontrivial) - 1

# (4) 鍵の総数と軌道の個数。E を止めた鍵は D ⊆ (E の補集合) の 2^(18-|E|) 個。
#     E が動く鍵は鍵ごと動くので、全辺鍵 1 個を除いた総数は 3 の倍数。
#     全辺集合は補集合が空なので D = ∅ の全辺鍵しか与えない。
assert len(full_edge_set) == 18
key_count = sum(ZZ(2) ** (18 - len(subset)) for subset in nontrivial)
fixed_key_count = 1
free_key_count = key_count - fixed_key_count
assert key_count == 148033
assert free_key_count % 3 == 0
orbit_count = free_key_count // 3
assert orbit_count == 49344
print(f"L={side}: nontrivial-character keys {key_count}, "
      f"fixed key 1 (the full-edge key), free diagonal orbits {orbit_count}")

# E 水準の軌道代表ごとの鍵数（|E| は軌道上で一定なので代表の 2^(18-|E|)）の和が
# 鍵水準の軌道数と一致すること（各 E 軌道は 3 つの E を持ち、鍵は E ごとに同数）。
recount = ZZ(0)
seen = set()
for subset in nontrivial:
    if subset == full_edge_set or subset in seen:
        continue
    orbit = {subset,
             translate_subset((1, 1), subset),
             translate_subset((2, 2), subset)}
    sizes = {len(item) for item in orbit}
    assert len(sizes) == 1
    recount += ZZ(2) ** (18 - len(subset))
    seen |= orbit
assert recount == orbit_count

print("PASS: translation-nonfull-key-orbit-freeness")
