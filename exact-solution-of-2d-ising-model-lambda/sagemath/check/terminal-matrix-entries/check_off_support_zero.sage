# 対象ラベル: claim_terminal_matrix_entries
if 'terminal_cases' not in globals():
    load('sagemath/check/terminal-matrix-entries/_prelude.sage')

count = 0
for L, spin, oriented, rev, J, I, M, K, T, sums in terminal_cases:
    for i in range(len(oriented)):
        for g in range(len(oriented)):
            if g == rev[i]:
                continue
            for j in range(len(oriented)):
                values = (terminal_ring(terminal_field(J[i, g])) * K[g, j],
                    terminal_ring(terminal_field(ZZ(0))) * K[g, j],
                    terminal_ring(terminal_field.zero()) * K[g, j],
                    terminal_ring.zero() * K[g, j],
                    terminal_ring.zero())
                assert values[3] == values[4]
                count += 1
print('PASS check_off_support_zero.sage: {} triples'.format(count))
