# SageMath: 向き付き剰余類辺の端点写像の厳密検算
# 対象ラベル: def_finite_quotient_oriented_coset_edge_endpoint_data
# 帰属: 有限置換群と有限集合だけを用いる

ambient = SymmetricGroup(8)

face_rotation = ambient("(1,6,2)(3,8,4)")
vertex_rotation = ambient("(1,8,4,2,5,6,7)")
edge_half_turn = ambient("(1,4)(2,5)(3,8)(6,7)")

quotient_group = PermutationGroup(
    [face_rotation, vertex_rotation, edge_half_turn],
    canonicalize=False,
)

vertex_stabilizer = quotient_group.subgroup([vertex_rotation])
edge_stabilizer = quotient_group.subgroup([edge_half_turn])

vertex_cosets = [frozenset(coset) for coset in quotient_group.cosets(vertex_stabilizer, side="left")]
edge_cosets = [frozenset(coset) for coset in quotient_group.cosets(edge_stabilizer, side="left")]


def permutation_key(permutation):
    return tuple(permutation(index) for index in range(1, 9))


def representative_selector(edge_coset):
    return min(edge_coset, key=permutation_key)


def vertex_coset_of(group_element):
    candidate = frozenset(group_element * member for member in vertex_stabilizer)
    assert candidate in vertex_cosets
    return candidate


def endpoints(edge_coset, selector):
    representative = selector(edge_coset)
    assert representative in edge_coset
    return (
        vertex_coset_of(representative),
        vertex_coset_of(representative * edge_half_turn),
    )


def reversed_selector(edge_coset):
    return representative_selector(edge_coset) * edge_half_turn


for edge_coset in edge_cosets:
    source_vertex, target_vertex = endpoints(edge_coset, representative_selector)

    assert representative_selector(edge_coset) * edge_half_turn in edge_coset
    assert not edge_coset.isdisjoint(source_vertex)
    assert not edge_coset.isdisjoint(target_vertex)
    assert source_vertex != target_vertex

    reversed_source, reversed_target = endpoints(edge_coset, reversed_selector)
    assert reversed_source == target_vertex
    assert reversed_target == source_vertex

assert len(edge_cosets) == 84

print(
    "RESULT: PASS — a finite representative selector defines both incident "
    "vertices of every quotient edge, and multiplying every selected "
    "representative by the edge half-turn swaps source and target"
)
