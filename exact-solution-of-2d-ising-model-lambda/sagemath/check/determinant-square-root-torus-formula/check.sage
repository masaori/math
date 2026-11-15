# 対象ラベル: claim_determinant_polynomial_square_root_exists
# 対象ラベル: claim_determinant_square_root_torus_formula
load('sagemath/check/torus-kac-ward-even-subgraph-square/construction.sage')

checked = 0
for L in (1, 2):
    oriented = edges(L)
    evens = even_subgraphs(L)
    sector_zero = P(0)
    roots = []
    for subset in evens:
        h = sum(seam_parities(L, edge)[0] for edge in subset) % 2
        v = sum(seam_parities(L, edge)[1] for edge in subset) % 2
        if h == 0 and v == 0:
            sector_zero += x ** len(subset)
    z = 2 * sector_zero
    for a in (0, 1):
        for b in (0, 1):
            q = P(0)
            for subset in evens:
                h = sum(seam_parities(L, edge)[0] for edge in subset) % 2
                v = sum(seam_parities(L, edge)[1] for edge in subset) % 2
                q += ZZ(-1) ** ((1+a)*h + (1+b)*v + h*v) * x ** len(subset)
            transition = matrix(P, len(oriented), len(oriented),
                                lambda r, s: P(transition_entry(L, a, b, oriented[r], oriented[s])))
            d = (identity_matrix(P, len(oriented)) - x * transition).det()
            # 定数項の式鎖: 一行目（|A| = 0 の項の和）・二行目（空集合だけ）・三行目（巻き付き偶奇は零）・四行目
            line1 = sum(ZZ(-1) ** ((1+a)*(sum(seam_parities(L, e)[0] for e in A) % 2)
                                   + (1+b)*(sum(seam_parities(L, e)[1] for e in A) % 2)
                                   + (sum(seam_parities(L, e)[0] for e in A) % 2)
                                   * (sum(seam_parities(L, e)[1] for e in A) % 2))
                        for A in evens if len(A) == 0)
            assert q[0] == line1
            assert [A for A in evens if len(A) == 0] == [[]]
            empty = []
            assert sum(seam_parities(L, e)[0] for e in empty) % 2 == 0
            assert sum(seam_parities(L, e)[1] for e in empty) % 2 == 0
            assert line1 == ZZ(-1) ** ((1+a)*0 + (1+b)*0 + 0*0) == 1
            assert q * q == d
            roots.append(q)
            checked += 1
    assert sum(roots) == 2 * z

print('RESULT: PASS; %d polynomial square roots and two finite-torus sums' % checked)
