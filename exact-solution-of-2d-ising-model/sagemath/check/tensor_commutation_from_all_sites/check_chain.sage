# 対象ラベル: tensor_commutation_from_all_sites
# 鎖 XY = (x_1y_1)⊠⋯⊠(x_My_M) = (y_1x_1)⊠⋯⊠(y_Mx_M) = YX。
# x_i は不定元の 2 次行列、y_i = a_i I + b_i x_i（y_ix_i = x_iy_i）。クロネッカー積は def_kronecker (2) の成分の式と
# Sage の tensor_product の両方で組んで一致を確かめる。M = 1, 2, 3。
# 対照: 一つの因子の y_j を独立な不定元にすると、仮定を使う第 2→3 だけが崩れ、主張 XY = YX も崩れる。
load("_prelude.sage")

for M in [1, 2, 3]:
    names = [f"{x}{k}" for k in range(M) for x in "ab"] + [f"x{k}_{r}_{s}" for k in range(M) for r in range(2) for s in range(2)] + [f"z_{r}_{s}" for r in range(2) for s in range(2)]
    R = PolynomialRing(QQ, names)
    g = R.gens()
    xs = [matrix(R, 2, 2, g[2*M + 4*k:2*M + 4*k + 4]) for k in range(M)]
    Zg = matrix(R, 2, 2, g[6*M:])
    I = identity_matrix(R, 2)
    ys = [g[2*k] * I + g[2*k+1] * xs[k] for k in range(M)]
    def lines(xs, ys):
        X, Y = kron(xs), kron(ys)
        return [body_product(X, Y), kron([body_product(a, b) for a, b in zip(xs, ys)]),
                kron([body_product(b, a) for a, b in zip(xs, ys)]), body_product(Y, X)]
    check_chain(lines(xs, ys), f"M={M}")
    ys2 = ys[:-1] + [Zg]
    ln = lines(xs, ys2)
    assert [k for k in range(1, 4) if ln[k - 1] != ln[k]] == [2]
    assert ln[0] != ln[3]
    print(f"  M={M}: 3 等号が成り立ち、一つの因子が非可換なら第 2→3 だけが崩れる")
print("RESULT: PASS")
