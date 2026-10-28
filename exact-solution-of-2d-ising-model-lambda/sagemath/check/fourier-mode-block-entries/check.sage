# 対象ラベル: claim_fourier_mode_block_entries, claim_fourier_fiber_direction_bijection, claim_fourier_block_fiber_determinant_product, claim_fourier_fiber_direction_determinant
K = CyclotomicField(24)
xroots = PolynomialRing(K, 't').gen()
steps = ((0, 1), (1, 0), (0, -1), (-1, 0))
zeta = K.gen()**3

def target(edge, L):
    i, j, direction = edge
    di, dj = steps[direction]
    return ((i + di) % L, (j + dj) % L)

def phase(direction, following):
    if following == direction:
        return K(1)
    if following == (direction + 1) % 4:
        return zeta
    if following == (direction - 1) % 4:
        return zeta**(-1)
    return K(0)

def twist(edge, L, a, b):
    i, j, direction = edge
    if direction == 0:
        return (-1)**(a * (j == L - 1))
    if direction == 2:
        return (-1)**(a * (j == 0))
    if direction == 1:
        return (-1)**(b * (i == L - 1))
    return (-1)**(b * (i == 0))

def weight(direction, varpi, varsigma):
    di, dj = steps[direction]
    return varpi**dj * varsigma**di

R = PolynomialRing(K, 'x')
x = R.gen()
for L in range(1, 4):
    edges = [(i, j, d) for i in range(L) for j in range(L) for d in range(4)]
    for a in (0, 1):
        for b in (0, 1):
            modes = [(v, w, d)
                     for v in (xroots**L - (-1)**a).roots(K, multiplicities=False)
                     for w in (xroots**L - (-1)**b).roots(K, multiplicities=False)
                     for d in range(4)]
            B = matrix(K, len(modes), len(modes),
                       lambda i, j: phase(modes[i][2], modes[j][2]) *
                       weight(modes[j][2], modes[i][0], modes[i][1])
                       if modes[i][:2] == modes[j][:2]
                       and modes[j][2] != (modes[i][2] + 2) % 4 else 0)
            T = identity_matrix(R, len(modes)) - x * B.change_ring(R)
            pairs = list(dict.fromkeys(m[:2] for m in modes))
            blocks = []
            for pair in pairs:
                fiber = [i for i, m in enumerate(modes) if m[:2] == pair]
                assert len(fiber) == 4
                assert [modes[i][2] for i in fiber] == list(range(4))
                small = matrix(K, 4, 4,
                               lambda d, e: phase(d, e) * weight(e, pair[0], pair[1])
                               if e != (d + 2) % 4 else 0)
                block = identity_matrix(R, 4) - x * small.change_ring(R)
                assert T.matrix_from_rows_and_columns(fiber, fiber) == block
                assert T.matrix_from_rows_and_columns(fiber, fiber).det() == block.det()
                blocks.append(block)
            assert all(T[i, j] == 0 for i in range(len(modes))
                       for j in range(len(modes)) if modes[i][:2] != modes[j][:2])
            if L <= 2:
                assert T.det() == prod(block.det() for block in blocks)
print('PASS: mode fibers and block determinants for L=1..3')
