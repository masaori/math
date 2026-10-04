# 対象ラベル: claim_terminal_matrix_entries / def_terminal_matrix
load('sagemath/check/terminal-matrix-entries/_prelude.sage')

count = 0
overlaps = 0
for case in terminal_cases:
    L, spin, oriented, rev, J, I, M, K, T, sums = case
    expected = matrix(terminal_ring, len(oriented), lambda i, j:
        terminal_final_chain(case, i, j)[-1])
    assert T == expected
    assert T.base_ring() is terminal_ring
    for i, e in enumerate(oriented):
        for j, f in enumerate(oriented):
            same_source = terminal_source(L, f) == terminal_source(L, e) and f != e
            if f == terminal_reverse(e) and same_source:
                assert L == 1
                overlaps += 1
            count += 1
    if L == 1:
        for i, e in enumerate(oriented):
            assert T[i, rev[i]] == 1 - terminal_x * terminal_twist(L, spin, terminal_reverse(e))
            if spin == (0, 0):
                assert T[i, rev[i]] == 1 - terminal_x
                assert T[i, rev[i]] != 1
print('PASS matrix product and component formula: {} components; {} overlapping conditions'.format(count, overlaps))
