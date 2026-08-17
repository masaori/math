# SageMath: 二段の有限商の塔の入力の厳密検算
# 対象ラベル: def_two_stage_finite_quotient_tower_input
# 帰属: 有限置換群、有限部分群、有限剰余類集合だけを用いる。

ambient = SymmetricGroup(4)
first = ambient("(1,2)")
second = ambient("(1,2,3,4)")
common_group = PermutationGroup([first, second], canonicalize=False)

identity = common_group.one()
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
assert identity in fine_kernel


def left_coset(element, subgroup):
    return frozenset(element * member for member in subgroup)


fine_cosets = tuple(
    {left_coset(element, fine_kernel) for element in common_group}
)
coarse_cosets = tuple(
    {left_coset(element, coarse_kernel) for element in common_group}
)

assert len(fine_cosets) == 6
assert len(coarse_cosets) == 2

FINE = "fine"
COARSE = "coarse"
fine_quotient = tuple((FINE, coset) for coset in fine_cosets)
coarse_quotient = tuple((COARSE, coset) for coset in coarse_cosets)


def fine_projection(element):
    return (FINE, left_coset(element, fine_kernel))


def coarse_projection(element):
    return (COARSE, left_coset(element, coarse_kernel))


def stage_map(fine_class):
    label, coset = fine_class
    assert label == FINE
    representative = next(iter(coset))
    return (COARSE, left_coset(representative, coarse_kernel))


def quotient_product(left_class, right_class, subgroup, label):
    left_representative = next(iter(left_class[1]))
    right_representative = next(iter(right_class[1]))
    return (
        label,
        left_coset(left_representative * right_representative, subgroup),
    )


for fine_class in fine_quotient:
    images = {
        (COARSE, left_coset(representative, coarse_kernel))
        for representative in fine_class[1]
    }
    assert len(images) == 1
    assert stage_map(fine_class) == next(iter(images))

assert {stage_map(fine_class) for fine_class in fine_quotient} == set(coarse_quotient)

for left_class in fine_quotient:
    for right_class in fine_quotient:
        fine_product = quotient_product(
            left_class,
            right_class,
            fine_kernel,
            FINE,
        )
        coarse_product = quotient_product(
            stage_map(left_class),
            stage_map(right_class),
            coarse_kernel,
            COARSE,
        )
        assert stage_map(fine_product) == coarse_product

for element in common_group:
    assert stage_map(fine_projection(element)) == coarse_projection(element)

print(
    "RESULT: PASS — the nested normal subgroups V_4 subset A_4 of S_4 "
    "give quotient groups of orders six and two, a representative-independent "
    "surjective stage homomorphism, and the required commuting quotient maps"
)
