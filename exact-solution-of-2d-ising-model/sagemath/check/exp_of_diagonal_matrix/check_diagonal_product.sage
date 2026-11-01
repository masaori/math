# 対象ラベル: exp_of_diagonal_matrix
# 中間目標「対角行列の積」の二つの鎖を確かめる。
#   k ≠ l: (PQ)_kl = Σ_j P_kj Q_jl = P_kk Q_kl = 0
#   k = l: (PQ)_kk = Σ_j P_kj Q_jk = P_kk Q_kk
# 対角成分を QQ(i) 上の多項式環の独立な不定元 d_1..d_n, e_1..e_n に置く（n = 1, …, 5）。
# 各行は本文の書き方どおりに別々に作り、Sage の行列の積 (P*Q)_kl とも比べる。
load("../../_shared/one_by_one_matrix.sage")

for n in range(1, 6):
    R = PolynomialRing(GAUSSIAN, [f"d{k}" for k in range(1, n + 1)] + [f"e{k}" for k in range(1, n + 1)])
    d, e = R.gens()[:n], R.gens()[n:]
    Pm = diagonal_matrix(R, d)
    Qm = diagonal_matrix(R, e)
    PQ = Pm * Qm
    for k in range(1, n + 1):
        for l in range(1, n + 1):
            line1 = product_entry_by_definition(Pm, Qm, k, l)     # Σ_j P_kj Q_jl
            if k != l:
                line2 = entry(Pm, k, k) * entry(Qm, k, l)          # P_kk Q_kl
                assert entry(PQ, k, l) == line1 == line2 == 0, (n, k, l)
            else:
                line2 = entry(Pm, k, k) * entry(Qm, k, k)          # P_kk Q_kk
                assert entry(PQ, k, k) == line1 == line2 == d[k - 1] * e[k - 1], (n, k)
print("n = 1..5 で、対角行列の積の二つの鎖の各行が QQ(i)[d, e] で厳密に成り立つ")

# 対照: 非対角成分を持つ行列では、(PQ)_kl（k ≠ l）は一般に 0 でない（仮定「対角」が効いていること）
R = PolynomialRing(GAUSSIAN, 'a,b,c,x,y,z')
a, b, c, x, y, z = R.gens()
A = matrix(R, [[a, b], [0, c]])
B = matrix(R, [[x, y], [0, z]])
assert entry(A * B, 1, 2) != 0
print("対照: 上三角行列の積の (1,2) 成分は a·y + b·z で 0 でない")
print("RESULT: PASS")
