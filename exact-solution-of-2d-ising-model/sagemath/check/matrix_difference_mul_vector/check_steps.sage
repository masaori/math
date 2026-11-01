# matrix_difference_mul_vector: Av - Bv = (A - B)v の証明の各行を、m, n = 1..3 の不定元の成分で確かめる。
for m in range(1, 4):
    for n in range(1, 4):
        names = ['A%d_%d' % (i, j) for i in range(m) for j in range(n)] + ['B%d_%d' % (i, j) for i in range(m) for j in range(n)] + ['v%d' % j for j in range(n)]
        R = PolynomialRing(QQ, names)
        g = R.gens()
        A = [[g[i*n + j] for j in range(n)] for i in range(m)]
        B = [[g[m*n + i*n + j] for j in range(n)] for i in range(m)]
        v = list(g[2*m*n:])
        Av = [sum(A[i][j] * v[j] for j in range(n)) for i in range(m)]               # mat_mult
        Bv = [sum(B[i][j] * v[j] for j in range(n)) for i in range(m)]
        AmB = [[A[i][j] - B[i][j] for j in range(n)] for i in range(m)]              # def_matrix_difference
        for i in range(m):
            l1 = Av[i] - Bv[i]                                                       # def_matrix_difference
            l2 = sum(A[i][j] * v[j] for j in range(n)) - sum(B[i][j] * v[j] for j in range(n))  # mat_mult
            l3 = sum(A[i][j] * v[j] - B[i][j] * v[j] for j in range(n))              # 有限和の差
            l4 = sum((A[i][j] - B[i][j]) * v[j] for j in range(n))                   # 分配則
            l5 = sum(AmB[i][j] * v[j] for j in range(n))                             # def_matrix_difference
            assert l1 == l2 == l3 == l4 == l5
            assert (matrix(R, A) * vector(R, v) - matrix(R, B) * vector(R, v))[i] == ((matrix(R, A) - matrix(R, B)) * vector(R, v))[i] == l5
        # 否定コントロール: 和 A + B を使うと一致しない
        assert sum((A[0][j] + B[0][j]) * v[j] for j in range(n)) != Av[0] - Bv[0]
print("m, n = 1..3: ((A - B)v)_i への 6 行が一致。否定コントロール（A + B）は一致しない")
print("ALL PASS")
