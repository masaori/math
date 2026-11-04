# 対象ラベル: conjugation_commutes_with_matrix_exp（Step 1 の二つの鎖と Step 2 の二つの鎖）
# X の成分を KG = QQ(i) 上の多項式環の不定元に置き（n = 2, 3）、正則な B（KG）で、帰納法の各段の行を
# p = 0..3、N = 0..3 について厳密に確かめる。n = 4 は X を KG の具体の行列にして同じ行を確かめる。
# 浮動小数点は使わない。
load("_prelude.sage")

n_eq = 0
n_neg = 0


def chain(lines, what):
    global n_eq
    for k in range(len(lines) - 1):
        assert lines[k] == lines[k + 1], f"{what}: {k+1} 行目と {k+2} 行目"
        n_eq += 1


for (B, Binv) in invertible_samples():
    n = B.nrows()
    if n <= 3:
        P = PolynomialRing(KG, [f"x_{r}_{s}" for r in range(n) for s in range(n)])
        X = matrix(P, n, n, P.gens())
    else:
        X = matrix(KG, [[0, 1, 2, i_K], [1, 0, 0, 1], [-1, 3, 1, 0], [0, 0, 2, 1]])
    R = X.base_ring()
    Bp, Bip = B.change_ring(R), Binv.change_ring(R)
    T = lambda A: T_body(Bp, A, Bip)
    TX = T(X)
    Id = body_identity(R, n)
    # Step 1 の p = 0
    chain([T(power_body(X, 0)), T(Id), Id, power_body(TX, 0)], f"n={n}: Step 1 p=0")
    # Step 1 の p → p+1
    for p in range(0, 4):
        chain([T(power_body(X, p + 1)),
               T(body_product(power_body(X, p), X)),
               body_product(T(power_body(X, p)), TX),
               body_product(power_body(TX, p), TX),
               power_body(TX, p + 1)], f"n={n}: Step 1 p={p}")
    # Step 2 の N = 0
    c0 = c_coeff(R, 0)
    chain([T(partial_sum_body(X, 0)), T(body_scalar(c0, power_body(X, 0))),
           body_scalar(c0, T(power_body(X, 0))), body_scalar(c0, power_body(TX, 0)),
           partial_sum_body(TX, 0)], f"n={n}: Step 2 N=0")
    # Step 2 の N → N+1
    for N in range(0, 4):
        cN = c_coeff(R, N + 1)
        chain([T(partial_sum_body(X, N + 1)),
               T(body_sum(partial_sum_body(X, N), body_scalar(cN, power_body(X, N + 1)))),
               body_sum(T(partial_sum_body(X, N)), T(body_scalar(cN, power_body(X, N + 1)))),
               body_sum(partial_sum_body(TX, N), T(body_scalar(cN, power_body(X, N + 1)))),
               body_sum(partial_sum_body(TX, N), body_scalar(cN, T(power_body(X, N + 1)))),
               body_sum(partial_sum_body(TX, N), body_scalar(cN, power_body(TX, N + 1))),
               partial_sum_body(TX, N + 1)], f"n={n}: Step 2 N={N}")
    # 比べる側: Sage の * で組んだ B X^p B^{-1} と (B X B^{-1})^p
    assert (Bp * X**3) * Bip == ((Bp * X) * Bip)**3
    n_eq += 1
    # 否定コントロール
    # (a) 逆行列を取り違える（B^{-1} の代わりに B）と冪の共役にならない
    W = lambda A: T_body(Bp, A, Bp)
    assert W(power_body(X, 2)) != power_body(W(X), 2); n_neg += 1
    # (b) 共役しない X の冪は T_B(X)^p と一致しない（B が X と可換でない）
    assert power_body(X, 2) != power_body(TX, 2); n_neg += 1
    # (c) 部分和の次数を一つずらすと一致しない
    assert T(partial_sum_body(X, 3)) != partial_sum_body(TX, 2); n_neg += 1
    print(f"n = {n}: Step 1・Step 2 の鎖を厳密に確かめた")

print(f"等号 {n_eq} 個、否定コントロール {n_neg} 件")
print("RESULT: PASS")
