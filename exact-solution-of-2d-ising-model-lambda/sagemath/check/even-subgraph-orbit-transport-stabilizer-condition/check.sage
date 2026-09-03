"""代表上の完全マッチングを軌道へ運べる条件を有限作用の全数検査で切り出す。

対象: claim_selection_even_subgraph_action_character,
      claim_selection_sum_character_evaluation。

有限群 G がファイバーの有限集合に作用し、各ファイバーの候補グラフを
G が同型で移す（共変な候補集合）とする。軌道の代表 r の完全マッチング M を
g・r へ g・M として運ぶとき、次を有限の全数比較で検査する。

(1) 運搬が well-defined（g・r = h・r なら g・M = h・M）であることは、
    M が固定部分群 Stab(r) の全元で不変であることと同値である。
(2) 不変な M を運んだ族は、各ファイバーで候補辺だけの完全マッチングであり、
    G の全元と可換（共変）である。
(3) 逆に、共変な完全マッチングの族は代表上の Stab(r) 不変な完全マッチングの
    運搬に限る。従って共変族の存在は、代表の候補グラフに Stab(r) 不変な
    完全マッチングが存在することと同値である。

固定部分が非自明な二つの実例（不変マッチングを持つもの・持たないもの）と、
一辺二の未被覆ファイバーと同じ自由作用の実例で検査する。
"""


def check_instance(name, group, act_fiber, act_vertex, fibers, vertices_by_fiber,
                   edges_by_fiber, expected):
    # 作用の整合性: 各 g はファイバーを移し、頂点を全単射で移し、候補辺を保つ。
    for g in group:
        for fiber in fibers:
            image_fiber = act_fiber(g, fiber)
            assert image_fiber in fibers
            image_vertices = {act_vertex(g, v) for v in vertices_by_fiber[fiber]}
            assert image_vertices == vertices_by_fiber[image_fiber]
            image_edges = {
                frozenset({act_vertex(g, v) for v in edge})
                for edge in edges_by_fiber[fiber]
            }
            assert image_edges == edges_by_fiber[image_fiber]

    def perfect_matchings(fiber):
        edges = sorted(edges_by_fiber[fiber], key=sorted)
        vertex_set = vertices_by_fiber[fiber]

        def extend(remaining, chosen):
            if not remaining:
                yield frozenset(chosen)
                return
            first = min(remaining)
            for edge in edges:
                if first in edge and edge <= remaining:
                    yield from extend(remaining - edge, chosen | {edge})

        return sorted(set(extend(frozenset(vertex_set), frozenset())), key=sorted)

    def act_matching(g, matching):
        return frozenset(
            frozenset(act_vertex(g, v) for v in edge) for edge in matching
        )

    representative = fibers[0]
    stabilizer = [g for g in group if act_fiber(g, representative) == representative]
    assert group[0] in stabilizer

    transporters_by_fiber = {
        fiber: [g for g in group if act_fiber(g, representative) == fiber]
        for fiber in fibers
    }
    # 代表の軌道が全ファイバー（この実例では軌道は一本）。
    assert all(transporters_by_fiber[fiber] for fiber in fibers)

    representative_matchings = perfect_matchings(representative)
    invariant_matchings = []
    for matching in representative_matchings:
        invariant = all(
            act_matching(s, matching) == frozenset(matching)
            for s in stabilizer
        )
        well_defined = all(
            act_matching(g, matching) == act_matching(h, matching)
            for fiber in fibers
            for g in transporters_by_fiber[fiber]
            for h in transporters_by_fiber[fiber]
        )
        # (1) 運搬の well-defined 性と固定部分群不変性の同値。
        assert well_defined == invariant
        if invariant:
            invariant_matchings.append(frozenset(matching))

    transported_families = []
    for matching in invariant_matchings:
        family = {
            fiber: act_matching(transporters_by_fiber[fiber][0], matching)
            for fiber in fibers
        }
        # (2) 運んだ族は候補辺だけの完全マッチングで、全元と可換。
        for fiber in fibers:
            assert family[fiber] <= edges_by_fiber[fiber]
            covered = [v for edge in family[fiber] for v in edge]
            assert len(covered) == len(set(covered))
            assert set(covered) == vertices_by_fiber[fiber]
        for g in group:
            for fiber in fibers:
                assert act_matching(g, family[fiber]) == family[act_fiber(g, fiber)]
        transported_families.append(
            frozenset((fiber, family[fiber]) for fiber in fibers)
        )

    # (3) 共変な族の全数列挙が、不変マッチングの運搬と一致する。
    matchings_by_fiber = {fiber: perfect_matchings(fiber) for fiber in fibers}
    covariant_families = []

    def enumerate_families(index, family):
        if index == len(fibers):
            covariant_families.append(
                frozenset((fiber, frozenset(family[fiber])) for fiber in fibers)
            )
            return
        fiber = fibers[index]
        for matching in matchings_by_fiber[fiber]:
            family[fiber] = matching
            if all(
                act_fiber(g, other) not in family
                or act_matching(g, family[other]) == frozenset(
                    family[act_fiber(g, other)]
                )
                for g in group for other in list(family)
            ):
                enumerate_families(index + 1, family)
            del family[fiber]

    enumerate_families(0, {})
    assert sorted(covariant_families, key=sorted) == sorted(
        set(transported_families), key=sorted
    )

    counts = {
        "stabilizer_order": len(stabilizer),
        "representative_matchings": len(representative_matchings),
        "invariant_matchings": len(invariant_matchings),
        "covariant_families": len(covariant_families),
    }
    print(f"{name}: {counts}")
    assert counts == expected


# 六点の置換 tau = (0 1 2 3)(4)(5)。位数 4 で、tau^2 = (0 2)(1 3) が
# 固定部分群の非自明元の各ファイバー上の作用になる。
tau = {0: 1, 1: 2, 2: 3, 3: 0, 4: 4, 5: 5}
tau_square = {i: tau[tau[i]] for i in tau}
assert tau_square == {0: 2, 2: 0, 1: 3, 3: 1, 4: 4, 5: 5}


def act_vertex_twisted(g, v):
    """Z/4 の g。奇数の g はファイバーを入れ替えながら tau を施す。"""
    fiber, i = v
    for _ in range(g):
        fiber, i = (1 - fiber, tau[i])
    return (fiber, i)


def act_fiber_two(g, fiber):
    return (fiber + g) % 2


def twisted_instance(base_edges):
    """ファイバー 0 の辺集合 base_edges から、共変な二ファイバーの実例を作る。"""
    fibers = [0, 1]
    vertices_by_fiber = {fiber: {(fiber, i) for i in range(6)} for fiber in fibers}
    edges_by_fiber = {
        0: {frozenset({(0, i), (0, j)}) for i, j in base_edges},
        1: {frozenset({(1, tau[i]), (1, tau[j])}) for i, j in base_edges},
    }
    return fibers, vertices_by_fiber, edges_by_fiber


# 実例 A: 固定部分群 {0,2} が非自明。辺集合 {04,24,15,35,23,01,45} の
# 完全マッチングは {04,15,23}・{24,35,01}・{01,23,45} の三つで、
# tau^2 = (0 2)(1 3) は前二つを入れ替え、最後の一つだけを固定する。
# 従って運べるのは一つで、共変族もその運搬一つに限る。
fibers, vertices_by_fiber, edges_by_fiber = twisted_instance(
    [(0, 4), (2, 4), (1, 5), (3, 5), (2, 3), (0, 1), (4, 5)]
)
check_instance(
    "instance-A-nontrivial-stabilizer-with-invariant-matching",
    list(range(4)), act_fiber_two, act_vertex_twisted,
    fibers, vertices_by_fiber, edges_by_fiber,
    {
        "stabilizer_order": 2,
        "representative_matchings": 3,
        "invariant_matchings": 1,
        "covariant_families": 1,
    },
)

# 実例 B: 辺 45 を除くと各ファイバーの完全マッチングは二つ残るが、
# tau^2 がその二つを入れ替えるので不変なものが無く、共変族は存在しない。
# 従って各ファイバーが完全マッチングを持つだけでは共変族に足りない。
fibers, vertices_by_fiber, edges_by_fiber = twisted_instance(
    [(0, 4), (2, 4), (1, 5), (3, 5), (2, 3), (0, 1)]
)
check_instance(
    "instance-B-nontrivial-stabilizer-without-invariant-matching",
    list(range(4)), act_fiber_two, act_vertex_twisted,
    fibers, vertices_by_fiber, edges_by_fiber,
    {
        "stabilizer_order": 2,
        "representative_matchings": 2,
        "invariant_matchings": 0,
        "covariant_families": 0,
    },
)


# 実例 C: 自由作用（Z/2 が二つのファイバーを入れ替えるだけ）。固定部分群が
# 自明なので全ての完全マッチングが運べる。一辺二の未被覆 16 ファイバーは
# この場合に当たる（even-subgraph-orbit-translation-stabilizer で固定 0 を確認済み）。
def act_vertex_free(g, v):
    fiber, i = v
    return ((fiber + g) % 2, i)


fibers_free = [0, 1]
vertices_free = {fiber: {(fiber, i) for i in range(4)} for fiber in fibers_free}
check_instance(
    "instance-C-free-action",
    list(range(2)),
    lambda g, fiber: (fiber + g) % 2,
    act_vertex_free,
    fibers_free,
    vertices_free,
    {
        0: {frozenset({(0, i), (0, j)}) for i, j in [(0, 1), (1, 2), (2, 3), (3, 0)]},
        1: {frozenset({(1, i), (1, j)}) for i, j in [(0, 1), (1, 2), (2, 3), (3, 0)]},
    },
    {
        "stabilizer_order": 1,
        "representative_matchings": 2,
        "invariant_matchings": 2,
        "covariant_families": 2,
    },
)

print("PASS: even-subgraph-orbit-transport-stabilizer-condition")
