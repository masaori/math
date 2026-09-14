# 対象ラベル: claim_general_binary_rule_not_forced_reversible
# 一セル定値規則の異なる二配位が同じ像を持ち、一般の一段規則では可逆性が強制されないことを検査する。
# 帰属: 有限集合と二元状態の有限表。対数、除算、浮動小数点、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

cells = (0,)
stage = {0: frozenset((0,))}
constant_zero = {((0, 0),): 0, ((0, 1),): 0}
family = {0: constant_zero}
x_zero = ((0, 0),)
x_one = ((0, 1),)

assert x_zero != x_one
assert global_map(cells, stage, family, x_zero) == ((0, 0),)
assert global_map(cells, stage, family, x_one) == ((0, 0),)
assert global_map(cells, stage, family, x_zero) == global_map(cells, stage, family, x_one)
images = tuple(global_map(cells, stage, family, x) for x in configurations(cells))
assert len(set(images)) == ZZ(1)
assert len(set(images)) != ZZ(len(configurations(cells)))
print('one-cell configurations checked:', ZZ(len(configurations(cells))))
print('distinct images:', ZZ(len(set(images))))
print('RESULT: PASS')
