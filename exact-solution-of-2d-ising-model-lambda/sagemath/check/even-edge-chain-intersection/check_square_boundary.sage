load(os.path.join(directory, 'defs.sage'))
for L in (1, 2, 3, 4):
    for r in range(L):
        for s in range(L):
            P = square(L, r, s)
            for axis in ('H', 'V'):
                for i in range(L):
                    for j in range(L):
                        C = {edge_key(L, axis, i, j)}
                        left = intersect(L, P, C)
                        right = intersect(L, C, P)
                        expected_left = sum(ZZ(axis == 'H' and (i, j) == key) for key in ((r % L, s % L), (r % L, (s + 1) % L))) + sum(ZZ(axis == 'V' and (i, j) == key) for key in (((r - 1) % L, (s + 1) % L), (r % L, (s + 1) % L)))
                        expected_right = sum(ZZ(axis == 'H' and (i, j) == key) for key in (((r + 1) % L, (s - 1) % L), ((r + 1) % L, s % L))) + sum(ZZ(axis == 'V' and (i, j) == key) for key in ((r % L, s % L), ((r + 1) % L, s % L)))
                        assert left == expected_left % 2
                        assert right == expected_right % 2
            for C in (horizontal(L), vertical(L)):
                assert even(L, C)
                assert intersect(L, P, C) == 0
                assert intersect(L, C, P) == 0
print('PASS square boundary expansion and even-degree cancellation')
