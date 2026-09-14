# 対象ラベル: def_rational_transition_transfer_matrix
# 大域遷移重みを値を変えずに、現在配位を行、次配位を列とする有限有理行列へ送る比較写像を検査する。
# 帰属: 有限集合、QQ、ZZ。浮動小数点、対数、極限、R/C 脱出はない。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))

family_count = ZZ(0)
entry_count = ZZ(0)

for family in sample_probabilistic_families():
    cell_count = len(family)
    states = configurations(cell_count)
    kernel = transition_matrix(family, cell_count)
    matrix = transfer_matrix_from_kernel(kernel)
    for source in states:
        for target in states:
            assert matrix[source][target] == QQ(kernel[source][target])
            assert matrix[source][target] == global_transition_weight(family, source, target)
            entry_count += 1
    family_count += 1

# 行と列を逆にした慣習とは同一視できない証人。
constant_zero = {0: {(ZZ(0),): QQ(0), (ZZ(1),): QQ(0)}}
witness_matrix = transfer_matrix_from_kernel(transition_matrix(constant_zero, 1))
zero_state = (ZZ(0),)
one_state = (ZZ(1),)
assert witness_matrix[one_state][zero_state] == QQ(1)
assert witness_matrix[zero_state][one_state] == QQ(0)

assert family_count == ZZ(13)
assert entry_count == ZZ(85)
print('finite transition families checked:', family_count)
print('matrix entries checked:', entry_count)
print('row-column orientation witness checked: 1')
print('RESULT: PASS')
