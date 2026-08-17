# SageMath: 商の塔における役割生成元の整合性の厳密検算
# 対象ラベル: def_quotient_tower_role_generator_compatibility
# 帰属: 有限置換群、有限商群、有限集合間の写像だけを用いる。

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

assert common_group.order() == 24
assert fine_kernel.order() == 4
assert coarse_kernel.order() == 12
assert fine_kernel.is_normal(common_group)
assert coarse_kernel.is_normal(common_group)
assert all(element in coarse_kernel for element in fine_kernel)


def left_coset(element, subgroup):
    return frozenset(element * member for member in subgroup)


FINE = "fine"
COARSE = "coarse"


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


def stage_map(fine_class):
    label, coset = fine_class
    assert label == FINE
    representative = next(iter(coset))
    return projection(representative, coarse_kernel, COARSE)


def generated_quotient(generators, subgroup, label):
    identity_class = projection(common_group.one(), subgroup, label)
    generated = {identity_class, *generators}
    while True:
        products = {
            quotient_product(left, right, subgroup, label)
            for left in generated
            for right in generated
        }
        enlarged = generated | products
        if enlarged == generated:
            return generated
        generated = enlarged


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

fine_quotient = {
    projection(element, fine_kernel, FINE)
    for element in common_group
}
coarse_quotient = {
    projection(element, coarse_kernel, COARSE)
    for element in common_group
}

assert common_group.subgroup(list(source_roles.values())) == common_group
assert generated_quotient(
    set(fine_roles.values()),
    fine_kernel,
    FINE,
) == fine_quotient
assert generated_quotient(
    set(coarse_roles.values()),
    coarse_kernel,
    COARSE,
) == coarse_quotient

for role in source_roles:
    assert stage_map(fine_roles[role]) == coarse_roles[role]

assert len(fine_quotient) == 6
assert len(coarse_quotient) == 2

print(
    "RESULT: PASS — the face, vertex, and edge source generators generate "
    "S_4; their images generate both quotient stages; and the stage "
    "homomorphism preserves all three role generators"
)
