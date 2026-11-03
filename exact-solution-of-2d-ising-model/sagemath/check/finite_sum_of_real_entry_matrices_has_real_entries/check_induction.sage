# 対象ラベル: finite_sum_of_real_entry_matrices_has_real_entries
# 人手の帰納法の 2 つの段 Σ_{j=1}^{1} X_j = X_1 と Σ_{j=1}^{r+1} X_j = (Σ_{j=1}^{r} X_j) + X_{r+1}（def_finite_sum_of_matrices）と、
# 各 r で和の成分が実であることを、X_j の成分を QQ 上の不定元として r = 1..5、m, n = 1..2 で確かめる。
# 係数は QQ(i) に広げた多項式環で組み、成分が実であることは「多項式の係数がすべて虚部 0」で判定する。
KG = QuadraticField(-1, 'i')
iK = KG.gen()
def is_real_matrix(X):
    return all(KG(c).imag() == 0 for e in X.list() for c in e.coefficients())
def lsum(Xs):                                   # def_finite_sum_of_matrices（左から足す）
    out = Xs[0]
    for X in Xs[1:]:
        out = out + X
    return out
count = 0
for m in range(1, 3):
    for n in range(1, 3):
        for r in range(1, 6):
            names = [f'x_{j}_{p}_{q}' for j in range(r + 1) for p in range(m) for q in range(n)]
            P = PolynomialRing(QQ, names)
            PK = P.change_ring(KG)
            g = PK.gens()
            X = [matrix(PK, m, n, lambda p, q: g[j * m * n + p * n + q]) for j in range(r + 1)]
            assert lsum(X[:1]) == X[0]                                       # r = 1 の段
            assert lsum(X[:r + 1]) == lsum(X[:r]) + X[r]                     # 帰納法の段
            assert is_real_matrix(lsum(X[:r])) and is_real_matrix(X[r])      # 帰納法の仮定と仮定
            assert is_real_matrix(lsum(X[:r + 1]))                           # sum_of_real_entry_matrices_has_real_entries
            count += 4
# 否定コントロール: 1 つの項だけ i 倍すると有限和は実でない
P1.<x0, x1> = PolynomialRing(QQ)
PK1 = P1.change_ring(KG)
assert not is_real_matrix(lsum([matrix(PK1, 1, 1, [x0]), matrix(PK1, 1, 1, [iK * x1])]))
print(f"  {count} 段（r = 1..5、m, n = 1..2 の帰納法の 2 段と実性 2 件。QQ(i) 係数の多項式環の厳密計算）")
print("  否定コントロール 1 件: 1 項を i 倍すると有限和は実でない")
print("RESULT: PASS")
