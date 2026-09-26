# 対象ラベル: epsilon_is_real_symmetric
# 本文: sigma^x の成分は 0 または 1 で、クロネッカー積の成分は各因子の成分の積（def_kronecker (1)）なので
#       epsilon の成分もすべて実数（実際には 0 または 1）。
# 帰属: Mat(2^M, QQ)。成分ごとに因子の成分の積と一致することも確かめる。
load("_prelude.sage")

assert all(sigma_x[a, b] in (0, 1) for a in range(2) for b in range(2))
for M in M_COL_RANGE:
    eps = epsilon_by_definition(M)
    d = 2 ** M
    for r in range(d):
        for c in range(d):
            # 先頭因子が最上位の桁: r = sum_m r_m 2^{M-m}
            r_digits = [(r >> (M - m)) & 1 for m in range(1, M + 1)]
            c_digits = [(c >> (M - m)) & 1 for m in range(1, M + 1)]
            product = prod(sigma_x[r_digits[m], c_digits[m]] for m in range(M))
            assert eps[r, c] == product
            assert eps[r, c] in (0, 1)
    print(f"  M_col={M}: 成分は各因子の成分の積に等しく、すべて 0 または 1（実数）")

print("RESULT: PASS")
