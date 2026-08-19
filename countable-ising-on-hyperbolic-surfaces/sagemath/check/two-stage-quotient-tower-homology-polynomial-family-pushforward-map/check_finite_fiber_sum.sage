# SageMath: ホモロジー類別多項式族の押し出し写像を厳密検算
# 対象ラベル: def_quotient_tower_homology_polynomial_family_pushforward_map
# 帰属: 有限第一ホモロジー群と ZZ[u,v] 上の有限和だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(
    _dir,
    "../two-stage-quotient-tower-first-homology-pushforward-map-over-f2/_prelude.sage",
))

fine_classes = tuple(sorted(fine_first_homology, key=repr))
coarse_classes = tuple(sorted(coarse_first_homology, key=repr))

R = PolynomialRing(
    ZZ,
    names=("u", "v") + tuple(f"A_{index}" for index in range(len(fine_classes))),
)
ring_generators = R.gens()
u, v = ring_generators[:2]
family_generators = ring_generators[2:]
fine_family = dict(zip(fine_classes, family_generators))


def polynomial_family_pushforward(family):
    return {
        coarse_class: sum(
            (
                family[fine_class]
                for fine_class in fine_classes
                if first_homology_pushforward(fine_class) == coarse_class
            ),
            R.zero(),
        )
        for coarse_class in coarse_classes
    }


pushed_family = polynomial_family_pushforward(fine_family)
checked_components = 0
for coarse_class in coarse_classes:
    fiber = tuple(
        fine_class
        for fine_class in fine_classes
        if first_homology_pushforward(fine_class) == coarse_class
    )
    expected_component = sum(
        (fine_family[fine_class] for fine_class in fiber),
        R.zero(),
    )
    assert pushed_family[coarse_class] == expected_component
    checked_components += 1

assert all(
    sum(
        ZZ(first_homology_pushforward(fine_class) == coarse_class)
        for coarse_class in coarse_classes
    )
    == ZZ.one()
    for fine_class in fine_classes
)
assert sum(pushed_family.values(), R.zero()) == sum(fine_family.values(), R.zero())

print(
    "RESULT: PASS — every coarse component is the exact ZZ[u,v] sum over "
    "its finite homology-pushforward fiber; the fibers partition all fine "
    f"classes ({len(fine_classes)} fine classes, {checked_components} coarse components)"
)
