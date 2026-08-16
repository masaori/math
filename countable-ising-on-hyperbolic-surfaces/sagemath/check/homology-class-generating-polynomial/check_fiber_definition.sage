# SageMath: 第一ホモロジー類別の高温生成多項式のファイバー定義を厳密検算
# 対象ラベル: def_homology_class_generating_polynomial
# 式: Q_{C,h}(u,v) = sum_{A in eta_C^{-1}({h})} u^{|E|-|A|} v^{|A|}
# 帰属: 形式的有限集合、GF(2) 上の有限商、ZZ[u,v] だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

first_homology_group = {
    quotient_map(cycle)
    for cycle in first_cycle_space
}

fibers = {
    homology_class: {
        chosen
        for chosen in even_edge_subsets
        if homology_class_map(chosen) == homology_class
    }
    for homology_class in first_homology_group
}

zero_class = quotient_map((GF(2).zero(), GF(2).zero(), GF(2).zero()))
nonzero_class = quotient_map((GF(2).one(), GF(2).zero(), GF(2).one()))

assert len(first_homology_group) == 2
assert zero_class != nonzero_class
assert fibers[zero_class] == {
    frozenset(),
    frozenset(("upper", "lower")),
}
assert fibers[nonzero_class] == {
    frozenset(("upper", "middle")),
    frozenset(("lower", "middle")),
}

assert homology_class_generating_polynomial(zero_class) == u^3 + u * v^2
assert homology_class_generating_polynomial(nonzero_class) == 2 * u * v^2

alternate_zero_representative = (GF(2).one(), GF(2).one(), GF(2).zero())
assert quotient_map(alternate_zero_representative) == zero_class
assert (
    homology_class_generating_polynomial(quotient_map(alternate_zero_representative))
    == homology_class_generating_polynomial(zero_class)
)

assert set().union(*fibers.values()) == set(even_edge_subsets)
for left_class in first_homology_group:
    for right_class in first_homology_group:
        if left_class != right_class:
            assert fibers[left_class].isdisjoint(fibers[right_class])

print("RESULT: PASS — each polynomial is the exact finite fiber sum indexed by a quotient-set element")
