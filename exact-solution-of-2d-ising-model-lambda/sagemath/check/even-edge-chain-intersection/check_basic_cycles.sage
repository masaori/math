load(os.path.join(directory, 'defs.sage'))
for L in (1, 2, 3, 4):
    Rh, Rv = horizontal(L), vertical(L)
    assert intersect(L, Rh, Rh) == 0
    assert intersect(L, Rv, Rv) == 0
    assert intersect(L, Rh, Rv) == 1
    assert intersect(L, Rv, Rh) == 1
print('PASS basic cycles')
