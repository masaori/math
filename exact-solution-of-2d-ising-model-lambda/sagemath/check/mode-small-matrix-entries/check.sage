# 対象ラベル: claim_mode_small_matrix_entries
K = CyclotomicField(24)
z = K.gen()**3
t = PolynomialRing(K, 'T').gen()
steps = ((0, 1), (1, 0), (0, -1), (-1, 0))

def weight(d, p, s):
    di, dj = steps[d]
    return p**dj * s**di

def phase(d, e):
    if e == d:
        return K.one()
    if e == (d + 1) % 4:
        return z
    if e == (d - 1) % 4:
        return z**(-1)
    return K.zero()

count = 0
for L in range(1, 4):
    for a in (0, 1):
        for b in (0, 1):
            ps = (t**L - (-1)**a).roots(K, multiplicities=False)
            ss = (t**L - (-1)**b).roots(K, multiplicities=False)
            for p in ps:
                for s in ss:
                    actual = matrix(K, 4, 4, lambda d, e: phase(d, e) * weight(e, p, s))
                    table = matrix(K, [
                        [p, z*s, 0, z**(-1)*s**(-1)],
                        [z**(-1)*p, s, z*p**(-1), 0],
                        [0, z**(-1)*s, p**(-1), z*s**(-1)],
                        [z*p, 0, z**(-1)*p**(-1), s**(-1)],
                    ])
                    for d in range(4):
                        for e in range(4):
                            assert actual[d, e] == table[d, e]
                    count += 1

print(f'PASS: sixteen mode-matrix entries in {count} exact cyclotomic cases')
