"""対角平行移動で固定される鍵の非自明な選択文字を小さい辺長で判定する。

対象: claim_selection_even_subgraph_action_character,
      claim_selection_sum_character_evaluation。

一辺 L の対角平行移動 (1,1) で固定されるファイバー鍵 (D,E) は、D と E が
ともに辺軌道の和で、互いに素、かつ E が偶部分グラフであるものに限る。
E の中の偶部分グラフ H に対する文字

  <E,H> = eps_h(E) eps_v(H) + eps_v(E) eps_h(H) mod 2

が非自明かを、E が作る有限グラフの基本閉路上で判定する。各 E に対して D は
E に使わなかった辺軌道の任意の和なので、該当する固定鍵の個数は整数の有限和で
数える。L=2,...,8 を全数検査し、一辺二の固定鍵零が固有の偶然かを確かめる。
"""

from itertools import combinations


def base_edges(side):
    return [(kind, i, j)
            for kind in ("h", "v")
            for i in range(side)
            for j in range(side)]


def translate_edge(side, edge):
    kind, i, j = edge
    return (kind, (i + 1) % side, (j + 1) % side)


def edge_endpoints(side, edge):
    kind, i, j = edge
    if kind == "h":
        return (i, j), (i, (j + 1) % side)
    return (i, j), ((i + 1) % side, j)


def winding_parities(side, subset):
    return (
        sum(ZZ(kind == "h" and j == side - 1)
            for kind, i, j in subset) % 2,
        sum(ZZ(kind == "v" and i == side - 1)
            for kind, i, j in subset) % 2,
    )


def is_even_subset(side, subset):
    degrees = {}
    for edge in subset:
        for vertex in edge_endpoints(side, edge):
            degrees[vertex] = degrees.get(vertex, 0) + 1
    return all(degree % 2 == 0 for degree in degrees.values())


def diagonal_edge_orbits(side):
    unseen = set(base_edges(side))
    orbits = []
    while unseen:
        first = min(unseen)
        orbit = []
        edge = first
        for _ in range(side):
            orbit.append(edge)
            edge = translate_edge(side, edge)
        orbit = frozenset(orbit)
        assert len(orbit) == side
        assert frozenset(translate_edge(side, item) for item in orbit) == orbit
        orbits.append(orbit)
        unseen -= orbit
    assert len(orbits) == 2 * side
    assert set().union(*orbits) == set(base_edges(side))
    return orbits


def has_nontrivial_character(side, single):
    """E 内の閉路 H で <E,H>=1 となるものがあるかを F_2 上で判定する。"""
    winding_h, winding_v = winding_parities(side, single)

    def character_edge(edge):
        kind, i, j = edge
        return ZZ((winding_v * (kind == "h" and j == side - 1)
                   + winding_h * (kind == "v" and i == side - 1)) % 2)

    adjacency = {}
    for edge in single:
        first, second = edge_endpoints(side, edge)
        adjacency.setdefault(first, []).append((second, edge))
        adjacency.setdefault(second, []).append((first, edge))

    # character_edge が E の頂点ポテンシャルの差なら全閉路で文字は零。
    # 木でポテンシャルを定め、非木辺で矛盾が出ることと文字が非自明なことは同値。
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


expected = {
    2: (41, 0, 0),
    3: (189, 1, 1),
    4: (881, 0, 0),
    5: (4149, 1, 1),
    6: (19721, 0, 0),
    7: (94509, 1, 1),
    8: (456161, 0, 0),
}

observed = {}
for side in range(2, 9):
    orbits = diagonal_edge_orbits(side)
    fixed_key_count = ZZ(0)
    nontrivial_single_count = ZZ(0)
    nontrivial_fixed_key_count = ZZ(0)
    nontrivial_singles = set()
    for orbit_count in range(len(orbits) + 1):
        for chosen in combinations(range(len(orbits)), orbit_count):
            single = (frozenset().union(*(orbits[index] for index in chosen))
                      if chosen else frozenset())
            if not is_even_subset(side, single):
                continue
            doubled_choices = ZZ(2) ** (len(orbits) - orbit_count)
            fixed_key_count += doubled_choices
            if has_nontrivial_character(side, single):
                nontrivial_single_count += 1
                nontrivial_fixed_key_count += doubled_choices
                nontrivial_singles.add(single)
    if side % 2 == 0:
        assert nontrivial_singles == set()
    else:
        assert nontrivial_singles == {frozenset(base_edges(side))}
    observed[side] = (
        int(fixed_key_count),
        int(nontrivial_single_count),
        int(nontrivial_fixed_key_count),
    )
    print(
        f"L={side}: diagonal-fixed keys {fixed_key_count}, "
        f"nontrivial E {nontrivial_single_count}, "
        f"nontrivial-character keys {nontrivial_fixed_key_count}"
    )

assert observed == expected
assert observed[2][2] == 0
assert all(observed[side][2] == (side % 2) for side in range(2, 9))
print("PASS: translation-diagonal-fixed-nontrivial-character")
