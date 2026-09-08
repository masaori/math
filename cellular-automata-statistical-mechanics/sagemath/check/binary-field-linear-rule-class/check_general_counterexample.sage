# 対象ラベル: claim_general_binary_rule_need_not_preserve_zero
# 一セル上の状態入れ替え規則が零配位を保存せず、線形でないことを全入力で検査する。
# 帰属: 有限集合と二元体の有限表。対数、除算、浮動小数点、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

cells = (0,)
stage = {0: frozenset((0,))}
swap = {((0, 0),): 1, ((0, 1),): 0}
family = {0: swap}
zero = zero_input(cells)

assert global_map(cells, stage, family, zero) == ((0, 1),)
assert global_map(cells, stage, family, zero) != zero
assert not is_linear(stage[0], swap)
print('one-cell configurations checked:', ZZ(len(configurations(cells))))
print('zero image:', global_map(cells, stage, family, zero))
print('RESULT: PASS')
