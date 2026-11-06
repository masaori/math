# 対象ラベル: claim_vertex_simple_boundary_nonloop_propagation
# 各隣接位置の等号を全位置へ伝播する帰納法を厳密整数で検算する。
for length in range(1, 9):
    for constant in range(-3, 4):
        coefficients = [ZZ(constant) for _ in range(length)]
        assert all(coefficients[k] == coefficients[(k + 1) % length]
                   for k in range(length))
        assert coefficients[0] == constant
        for k in range(1, length):
            assert coefficients[k] == coefficients[k - 1]
            assert coefficients[k - 1] == coefficients[0]
            assert coefficients[k] == coefficients[0]

# 単一セル境界の四辺を巡る向き付き係数は全て一である。
walk = [((0, 0, 0), 0), ((1, 0, 1), 0),
        ((0, 1, 0), 1), ((1, 0, 0), 1)]
boundary = walk
coefficient = lambda edge: sum(ZZ(1 - 2 * d) for base, d in boundary if base == edge)
signed = [coefficient(base) * ZZ(1 - 2 * d) for base, d in walk]
assert signed == [ZZ(1)] * 4
assert all(signed[k] == signed[0] for k in range(4))
print('RESULT: PASS; cyclic induction and four-edge cell boundary')
