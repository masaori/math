# claim_fixed_neighborhood_reversible_maps_not_composition_closed の
# 「合成の a 座標が c に本質的に依存する」段の検算。
# g_a(x) = ((F o F) x)(a) が x(c) に一致し、定値零配位とその c での一点反転で値が変わり、
# supp(g_a) = {c} が N(a) = {b} に含まれないことを検査する。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

F = shift_global_table()
FF = compose(F, F)

g_a = coordinate_map(FF, CELL_A)

# g_a(x) = x(c)
for config in CONFIGS:
    assert g_a[INDEX[config]] == config[CELL_C]

# 定値零配位 x_0 と x_1 = phi_c x_0 が本文の証人であること
x_0 = tuple(0 for _ in range(CELL_COUNT))
x_1 = flip(x_0, CELL_C)
assert x_0[CELL_C] == 0 and x_1[CELL_C] == 1
assert g_a[INDEX[x_0]] == 0
assert g_a[INDEX[x_1]] == 1
assert g_a[INDEX[x_0]] != g_a[INDEX[x_1]]

# supp(g_a) = {c} で、N(a) = {b} に含まれない
assert support(g_a) == frozenset({CELL_C})
assert set(neighborhood(CELL_A)) == {CELL_B}
assert not support(g_a).issubset(set(neighborhood(CELL_A)))

print("PASS supp(g_a)={c}")
