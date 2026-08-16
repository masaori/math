# SageMath: 主辺係数から双対辺係数への移送写像の厳密検算
# 対象ラベル: def_primal_to_dual_edge_coefficient_transport
# 対象: finite-fourier-duality.ts のブロック finite_fourier_definition_primal_to_dual_edge_coefficient_transport
# 帰属: 有限集合と GF(2)。浮動小数点、実数、複素数を使用しない

primal_edges = ("a", "b", "c")
dual_edges = tuple(("dual_edge", edge) for edge in primal_edges)


def d1(edge):
    return ("dual_edge", edge)


inverse_d1 = {d1(edge): edge for edge in primal_edges}
assert set(inverse_d1) == set(dual_edges)
assert len(inverse_d1) == len(primal_edges)

primal_coefficient_space = VectorSpace(GF(2), len(primal_edges))
dual_coefficient_space = VectorSpace(GF(2), len(dual_edges))


def coefficient_function(labels, coefficients):
    return {
        label: coefficients[index]
        for index, label in enumerate(labels)
    }


def transport(primal_coefficients):
    primal_function = coefficient_function(primal_edges, primal_coefficients)
    dual_function = {
        dual_edge: primal_function[inverse_d1[dual_edge]]
        for dual_edge in dual_edges
    }
    return dual_coefficient_space(
        [dual_function[dual_edge] for dual_edge in dual_edges]
    )


for primal_coefficients in primal_coefficient_space:
    dual_coefficients = transport(primal_coefficients)
    primal_function = coefficient_function(primal_edges, primal_coefficients)
    dual_function = coefficient_function(dual_edges, dual_coefficients)

    assert dual_coefficients in dual_coefficient_space
    for dual_edge in dual_edges:
        assert dual_function[dual_edge] == primal_function[inverse_d1[dual_edge]]

assert {
    tuple(transport(primal_coefficients))
    for primal_coefficients in primal_coefficient_space
} == {
    tuple(dual_coefficients)
    for dual_coefficients in dual_coefficient_space
}

print(
    "RESULT: PASS — all eight primal GF(2) edge-coefficient functions "
    "transport coordinatewise to the separate dual-edge coefficient space"
)
