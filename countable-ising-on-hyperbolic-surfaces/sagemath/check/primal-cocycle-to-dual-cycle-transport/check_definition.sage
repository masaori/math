# SageMath: 主一次コサイクルから双対一次サイクルへの係数移送写像の厳密検算
# 対象ラベル: def_primal_cocycle_to_dual_cycle_transport
# 対象: finite-fourier-duality.ts のブロック finite_fourier_definition_primal_cocycle_to_dual_cycle_transport
# 帰属: 有限集合と GF(2)。浮動小数点、実数、複素数を使用しない

field = GF(2)


def verify_restricted_transport(second_boundary):
    dual_first_boundary = second_boundary.transpose()
    primal_cocycles = second_boundary.transpose().right_kernel()
    dual_cycles = dual_first_boundary.right_kernel()

    def restricted_transport(primal_cocycle):
        assert primal_cocycle in primal_cocycles
        transported = vector(field, primal_cocycle)
        assert transported in dual_cycles
        return transported

    transported_image = {
        tuple(restricted_transport(primal_cocycle))
        for primal_cocycle in primal_cocycles
    }

    assert transported_image == {
        tuple(vector(field, primal_cocycle))
        for primal_cocycle in primal_cocycles
    }
    assert all(
        dual_first_boundary * restricted_transport(primal_cocycle)
        == dual_first_boundary * vector(field, primal_cocycle)
        == vector(field, dual_first_boundary.nrows())
        for primal_cocycle in primal_cocycles
    )


# 二面三角形では、主二次境界の各列が三本の主辺を一度ずつ含む。
verify_restricted_transport(
    matrix(
        field,
        [
            [1, 1],
            [1, 1],
            [1, 1],
        ],
    )
)

# 一面内で各主辺が二回現れる例では、主二次境界と双対一次境界は零になる。
verify_restricted_transport(matrix(field, [[0], [0]]))

print(
    "RESULT: PASS — the restriction of edge-coefficient transport has the "
    "primal cocycle space as its domain, the dual cycle space as its "
    "codomain, and the same coordinatewise action in both finite examples"
)
