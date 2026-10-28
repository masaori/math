load(os.path.join(directory, 'defs.sage'))
for L in (1, 2, 3):
    generators = [horizontal(L), vertical(L)] + [square(L, i, j) for i in range(L) for j in range(L)]
    chains = {frozenset()}
    for generator in generators:
        chains |= {frozenset(set(C).symmetric_difference(generator)) for C in list(chains)}
    for C0 in chains:
        C = set(C0)
        assert even(L, C)
        hC, vC = seams(L, C)
        for D0 in chains:
            D = set(D0)
            hD, vD = seams(L, D)
            assert intersect(L, C, D) == (hC * vD + vC * hD) % 2
print('PASS normal form intersection')
