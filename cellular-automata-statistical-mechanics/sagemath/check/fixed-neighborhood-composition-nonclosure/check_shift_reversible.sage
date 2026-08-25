# claim_three_cell_cyclic_shift_reversible の検算。
# s の三回合成が恒等であること、G(x)(v) = x(s(s(v))) が F の両側逆写像であること、
# したがって F が全単射であることを、8 配位全てについて厳密に検査する。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

# s(s(s(v))) = v（三つの値を順に代入する）
for v in range(CELL_COUNT):
    assert shift(shift(shift(v))) == v

F = shift_global_table()
G = tuple(INDEX[tuple(config[shift(shift(v))] for v in range(CELL_COUNT))] for config in CONFIGS)

assert compose(F, G) == identity_table()   # F o G = id
assert compose(G, F) == identity_table()   # G o F = id
assert len(set(F)) == len(F)               # 単射
assert set(F) == set(range(len(CONFIGS)))  # 全射

# F が固定近傍 N で表せること（M(V, N) への所属）
assert F in fixed_neighborhood_global_tables()

print(f"PASS configs={len(CONFIGS)}")
