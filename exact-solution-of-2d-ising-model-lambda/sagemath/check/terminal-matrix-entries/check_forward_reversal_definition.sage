# 対象ラベル: claim_terminal_matrix_entries
if 'terminal_cases' not in globals():
    load('sagemath/check/terminal-matrix-entries/_prelude.sage')

count = 0
for L in terminal_oriented:
    for u in range(1, 2 * L * L + 1):
        values = (terminal_target(L, terminal_reverse((u, 0))),
            terminal_target(L, (u, 1)),
            endpoints(L, u)[0],
            terminal_source(L, (u, 0)))
        assert values[0] == values[1]
        count += 1
print('PASS check_forward_reversal_definition.sage: {} edges'.format(count))
