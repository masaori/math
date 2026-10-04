# 対象ラベル: claim_terminal_matrix_entries
if 'terminal_cases' not in globals():
    load('sagemath/check/terminal-matrix-entries/_prelude.sage')

count = 0
for L in terminal_oriented:
    for u in range(1, 2 * L * L + 1):
        values = (terminal_target(L, terminal_reverse((u, 1))),
            terminal_target(L, (u, 0)),
            endpoints(L, u)[1],
            terminal_source(L, (u, 1)))
        assert values[1] == values[2]
        count += 1
print('PASS check_backward_target_definition.sage: {} edges'.format(count))
