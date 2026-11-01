# 対象ラベル: exp_of_diagonal_matrix
# 中間目標「対角行列の冪」（帰納法の基底と帰納の段の各行）と「指数級数の部分和の成分」の鎖を確かめる。
#   基底:  (D^0)_kl = I_kl = 0（k ≠ l）、(D^0)_kk = I_kk = 1 = d_k^0
#   帰納:  (D^{p+1})_kk = (D^p D)_kk = (D^p)_kk D_kk = d_k^p D_kk = d_k^p d_k = d_k^{p+1}、D^{p+1} は対角
#   部分和: (S_N)_kk = Σ_p (1/p!)(D^p)_kk = Σ_p d_k^p/p!、(S_N)_kl = Σ_p (1/p!)(D^p)_kl = Σ_p (1/p!)·0 = 0
# 対角成分は QQ(i) 上の多項式環の不定元。冪は本文 def_exp の D^{p+1} := D^p D を右から掛けて作り、
# 数の冪は d^{p+1} := d^p d を右から掛けて作る（Sage の ^ とは独立な経路）。
load("../../_shared/one_by_one_matrix.sage")

PMAX = 10
for n in range(1, 5):
    R = PolynomialRing(GAUSSIAN, [f"d{k}" for k in range(1, n + 1)])
    d = R.gens()
    Dm = diagonal_matrix(R, d)
    I = identity_matrix(R, n)
    # 基底
    D0 = matrix_power_by_definition(Dm, 0)
    for k in range(1, n + 1):
        for l in range(1, n + 1):
            if k != l:
                assert entry(D0, k, l) == entry(I, k, l) == 0
            else:
                assert entry(D0, k, k) == entry(I, k, k) == 1 == scalar_power_by_definition(d[k - 1], 0)
    # 帰納の段（p = 0..PMAX-1）
    for p in range(PMAX):
        Dp = matrix_power_by_definition(Dm, p)
        Dp1 = matrix_power_by_definition(Dm, p + 1)
        assert Dp1 == Dp * Dm                                        # D^{p+1} = D^p D
        assert Dp1.is_diagonal()
        for k in range(1, n + 1):
            dk = d[k - 1]
            chain = [
                entry(Dp1, k, k),
                product_entry_by_definition(Dp, Dm, k, k),            # (D^p D)_kk
                entry(Dp, k, k) * entry(Dm, k, k),                    # (D^p)_kk D_kk
                scalar_power_by_definition(dk, p) * entry(Dm, k, k),  # d_k^p D_kk（帰納法の仮定）
                scalar_power_by_definition(dk, p) * dk,               # d_k^p d_k
                scalar_power_by_definition(dk, p + 1),                # d_k^{p+1}
            ]
            assert all(c == chain[0] for c in chain), (n, p, k)
    # 部分和の成分（N = 0..PMAX）
    for N in range(PMAX + 1):
        SN = matrix_partial_sum(Dm, N)
        for k in range(1, n + 1):
            for l in range(1, n + 1):
                line1 = sum(QQ(1) / factorial(p) * entry(matrix_power_by_definition(Dm, p), k, l) for p in range(N + 1))
                if k == l:
                    line2 = sum(scalar_power_by_definition(d[k - 1], p) / factorial(p) for p in range(N + 1))
                    assert entry(SN, k, k) == line1 == line2, (n, N, k)
                else:
                    line2 = sum(QQ(1) / factorial(p) * 0 for p in range(N + 1))
                    assert entry(SN, k, l) == line1 == line2 == 0, (n, N, k, l)
print(f"n = 1..4、p = 0..{PMAX - 1}、N = 0..{PMAX} で、冪の帰納法の各行と部分和の成分の鎖が QQ(i)[d] で厳密に成り立つ")

# 対照: 非対角の行列 N = [[0,1],[0,0]] では (S_N)_12 = 1（N ≥ 1）で 0 でない
Nm = matrix(QQ, [[0, 1], [0, 0]])
assert all(entry(matrix_partial_sum(Nm, N), 1, 2) == 1 for N in range(1, 6))
print("対照: N = [[0,1],[0,0]] の部分和の (1,2) 成分は N ≥ 1 で 1")
print("RESULT: PASS")
