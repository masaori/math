# SageMath: 商の塔が誘導する剰余類セル写像の共通有限データ
# 対象ラベル: def_quotient_tower_induced_coset_cell_maps
# 帰属: 有限置換群、有限商群、有限部分群、有限剰余類集合だけを用いる。

ambient = SymmetricGroup(4)
face_source = ambient("(1,2,3)")
vertex_source = ambient("(1,2,3,4)")
edge_source = ambient("(1,2)")
common_group = PermutationGroup(
    [face_source, vertex_source, edge_source],
    canonicalize=False,
)

double_transpositions = (
    ambient("(1,2)(3,4)"),
    ambient("(1,3)(2,4)"),
    ambient("(1,4)(2,3)"),
)
fine_kernel = common_group.subgroup([*double_transpositions])
coarse_kernel = common_group.subgroup(
    [ambient("(1,2,3)"), ambient("(1,2)(3,4)")]
)

FINE = "fine"
COARSE = "coarse"


def left_coset(element, subgroup):
    return frozenset(element * member for member in subgroup)


def projection(element, subgroup, label):
    return (label, left_coset(element, subgroup))


def quotient_product(left_class, right_class, subgroup, label):
    left_representative = next(iter(left_class[1]))
    right_representative = next(iter(right_class[1]))
    return projection(
        left_representative * right_representative,
        subgroup,
        label,
    )


def quotient_inverse(quotient_class, subgroup, label):
    representative = next(iter(quotient_class[1]))
    return projection(representative.inverse(), subgroup, label)


def stage_map(fine_class):
    label, coset = fine_class
    assert label == FINE
    representative = next(iter(coset))
    return projection(representative, coarse_kernel, COARSE)


def cyclic_quotient_subgroup(generator, subgroup, label):
    identity_class = projection(common_group.one(), subgroup, label)
    generated = {identity_class}
    current = identity_class
    while True:
        current = quotient_product(current, generator, subgroup, label)
        if current in generated:
            return frozenset(generated)
        generated.add(current)


def quotient_left_coset(element, subgroup_elements, kernel, label):
    return frozenset(
        quotient_product(element, member, kernel, label)
        for member in subgroup_elements
    )


source_roles = {
    "face": face_source,
    "vertex": vertex_source,
    "edge": edge_source,
}
fine_roles = {
    role: projection(element, fine_kernel, FINE)
    for role, element in source_roles.items()
}
coarse_roles = {
    role: projection(element, coarse_kernel, COARSE)
    for role, element in source_roles.items()
}
fine_quotient = frozenset(
    projection(element, fine_kernel, FINE)
    for element in common_group
)
coarse_quotient = frozenset(
    projection(element, coarse_kernel, COARSE)
    for element in common_group
)
fine_stabilizers = {
    role: cyclic_quotient_subgroup(generator, fine_kernel, FINE)
    for role, generator in fine_roles.items()
}
coarse_stabilizers = {
    role: cyclic_quotient_subgroup(generator, coarse_kernel, COARSE)
    for role, generator in coarse_roles.items()
}


def induced_cell_image(role, fine_cell_coset):
    fine_representative = next(iter(fine_cell_coset))
    coarse_representative = stage_map(fine_representative)
    return quotient_left_coset(
        coarse_representative,
        coarse_stabilizers[role],
        coarse_kernel,
        COARSE,
    )
