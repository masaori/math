# 対象ラベル: claim_terminal_matrix_entries
if 'terminal_cases' not in globals():
    load('sagemath/check/terminal-matrix-entries/_prelude.sage')

count = 0
for L, oriented in terminal_oriented.items():
    for e in oriented:
        for f in oriented:
            values = terminal_next_chain(L, e, f)
            assert values[3] == values[4]
            count += 1
print('PASS check_next_symmetry.sage: {} edge pairs'.format(count))
