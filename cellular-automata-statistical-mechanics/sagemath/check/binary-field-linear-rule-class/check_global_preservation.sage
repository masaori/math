# 対象ラベル: claim_binary_field_linear_global_map_preserves_zero
# 併せて検証: claim_binary_field_linear_global_map_additive, claim_binary_field_linear_global_map_preserves_scalar_multiplication
# 局所線形性から大域写像の三保存則へ至る各セルの等号を有限全数検査する。
# 帰属: 有限集合と二元体の有限表。対数、除算、浮動小数点、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

stage_count = ZZ(0)
family_count = ZZ(0)
equality_count = ZZ(0)
for cell_count in range(3):
    for cells, stage in stages(cell_count):
        local_coefficients = tuple(tuple(itertools.product(STATES, repeat=len(stage[cell]))) for cell in cells)
        for coefficient_family in itertools.product(*local_coefficients):
            family = {cell: linear_table(stage[cell], coefficients) for cell, coefficients in zip(cells, coefficient_family)}
            zero = zero_input(cells)
            assert global_map(cells, stage, family, zero) == zero
            equality_count += 1
            for p in configurations(cells):
                for q in configurations(cells):
                    assert global_map(cells, stage, family, pointwise_add(p, q)) == pointwise_add(
                        global_map(cells, stage, family, p), global_map(cells, stage, family, q))
                    equality_count += 1
                for a in STATES:
                    assert global_map(cells, stage, family, scalar_multiply(a, p)) == scalar_multiply(
                        a, global_map(cells, stage, family, p))
                    equality_count += 1
            family_count += 1
        stage_count += 1

assert stage_count == ZZ(19)
assert family_count == ZZ(85)
assert equality_count > 0
print('finite stages checked:', stage_count)
print('linear local-rule families checked:', family_count)
print('preservation equalities checked:', equality_count)
print('RESULT: PASS')
