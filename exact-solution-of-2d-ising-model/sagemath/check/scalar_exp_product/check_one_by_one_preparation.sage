# 対象ラベル: scalar_exp_product
# 証明の準備の四つの鎖を確かめる。
#   (AB)_11 = Σ_{j=1}^{1} A_1j B_j1 = A_11 B_11（A, B ∈ Mat(1,K)）
#   ([x][y])_11 = ([x])_11([y])_11 = xy = yx = ([y])_11([x])_11 = ([y][x])_11
#   [x][y] = [([x][y])_11] = [([y][x])_11] = [y][x]
#   [x] + [y] = [([x]+[y])_11] = [([x])_11 + ([y])_11] = [x+y]
# 帰属: 係数 QQ（K = R）と QQ(i)（K = C）の上の多項式環。a, b, x, y は不定元。
load("../../_shared/one_by_one_matrix.sage")

for name, F in COEFFICIENT_FIELDS:
    R = PolynomialRing(F, 'a,b,x,y')
    a, b, x, y = R.gens()
    A = matrix(R, 1, 1, [a])
    B = matrix(R, 1, 1, [b])
    # (AB)_11 = Σ_{j=1}^{1} A_1j B_j1 = A_11 B_11
    assert entry11(A * B) == product_entry_by_definition(A, B, 1, 1) == entry11(A) * entry11(B)
    X = one_by_one(R, x)
    Y = one_by_one(R, y)
    chain = [entry11(X * Y), entry11(X) * entry11(Y), x * y, y * x, entry11(Y) * entry11(X), entry11(Y * X)]
    assert all(c == chain[0] for c in chain), name
    chain = [X * Y, one_by_one(R, entry11(X * Y)), one_by_one(R, entry11(Y * X)), Y * X]
    assert all(c == chain[0] for c in chain), name
    chain = [X + Y, one_by_one(R, entry11(X + Y)), one_by_one(R, entry11(X) + entry11(Y)), one_by_one(R, x + y)]
    assert all(c == chain[0] for c in chain), name
    print(f"{name}: 準備の四つの鎖が多項式として成り立つ")

# 対照: 2 行 2 列では一般に AB ≠ BA。準備の可換性は 1 行 1 列であることに依る。
R2 = PolynomialRing(QQ, 'p0,p1,p2,p3,q0,q1,q2,q3')
g = R2.gens()
A2 = matrix(R2, 2, 2, g[:4])
B2 = matrix(R2, 2, 2, g[4:])
assert A2 * B2 != B2 * A2
print("対照: 2 行 2 列の一般の行列は可換でない")
print("RESULT: PASS")
