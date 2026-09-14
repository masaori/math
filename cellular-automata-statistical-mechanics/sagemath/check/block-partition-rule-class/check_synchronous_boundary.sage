# 対象ラベル: claim_synchronous_rule_not_forced_block_local
# 併せて検証: def_global_map, claim_block_phase_characterization
# 二セル交換は同期局所更新だが、一元ブロック分割への依存条件を破ることを検査する。
# 帰属: 二元有限集合、有限写像表、ZZ。対数、除算、浮動小数点、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

cells = (0, 1)
singleton_partition = ((0,), (1,))
swap_map = {configuration: (configuration[1], configuration[0]) for configuration in configurations(cells)}
x = (0, 0)
y = (0, 1)

assert is_block_partition(cells, singleton_partition)
assert restrict_configuration(x, (0,)) == restrict_configuration(y, (0,))
assert swap_map[x][0] == x[1]
assert swap_map[x][0] == 0
assert swap_map[y][0] == y[1]
assert swap_map[y][0] == 1
assert restrict_configuration(swap_map[x], (0,)) != restrict_configuration(swap_map[y], (0,))
assert not block_dependence_condition(cells, singleton_partition, swap_map)
assert all(swap_map[configuration] == (configuration[1], configuration[0]) for configuration in configurations(cells))

print('synchronous local inputs checked:', ZZ(len(configurations(cells))))
print('witness inputs:', x, y)
print('RESULT: PASS')
