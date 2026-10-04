# 対象ラベル: claim_dual_edge_map_bijective / def_dual_edge_map
# 帰属: L と辺番号は ZZ、i, j, one は Zmod(L)。
load('sagemath/_shared/defs.sage')


def horizontal_number(L, i, j):
    return edge_number_horizontal(L, i.lift(), j.lift())


def vertical_number(L, i, j):
    return edge_number_vertical(L, i.lift(), j.lift())


def dual_image(L, edge):
    assert 1 <= edge <= 2 * L^2
    residue_ring = Zmod(L)
    one = residue_ring.one()
    if edge <= L^2:
        row, column = divmod(ZZ(edge) - 1, L)
        return vertical_number(L, residue_ring(row), residue_ring(column) + one)
    row, column = divmod(ZZ(edge) - L^2 - 1, L)
    return horizontal_number(L, residue_ring(row) + one, residue_ring(column))


def dual_inverse(L, edge):
    assert 1 <= edge <= 2 * L^2
    residue_ring = Zmod(L)
    one = residue_ring.one()
    if edge <= L^2:
        row, column = divmod(ZZ(edge) - 1, L)
        return vertical_number(L, residue_ring(row) - one, residue_ring(column))
    row, column = divmod(ZZ(edge) - L^2 - 1, L)
    return horizontal_number(L, residue_ring(row), residue_ring(column) - one)


coordinate_cases = [
    (ZZ(L), i, j, Zmod(L).one())
    for L in (1, 2, 3, 4, 5)
    for i in Zmod(L)
    for j in Zmod(L)
]
assert len(coordinate_cases) == 55
