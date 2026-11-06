# 対象ラベル: epsilon_real_permutes_entries_by_spin_flip
# 証明の l ≠ ord(-s) の 5 行、l = ord(-s) の 5 行、5 行の主鎖と単射性による結論を、
# M_col = 1, 2, 3 の全ての s と、成分が有理数のベクトル u（各 M_col で 5 本）で厳密に（QQbar・AA）確かめる。
load("../epsilon_entries_in_row_configuration_numbering/_epsilon_exact.sage")


def rho(B):
    """def_real_matrix_of_real_entry_matrix: 成分がすべて実数の複素行列 B から B_ℝ。"""
    assert all(z.imag() == 0 for z in B.list())
    return matrix(AA, B.nrows(), B.ncols(), [AA(z.real()) for z in B.list()])


def inc(r):
    """inclusion_rr_to_cc: r ↦ r_ℂ。"""
    return QQbar(r)


def check(M, u):
    E = epsilon_site_product(M)                                  # def_global_spin_flip_matrix
    ER = rho(E)                                                  # def_epsilon_real
    d = 2 ** M
    for s in configurations(M):
        k = ord_(s)
        r = [ER[k - 1, l - 1] * u[l - 1] for l in range(1, d + 1)]   # y_l := (ε_ℝ)_{ord(s),l} u_l
        for t in configurations(M):
            l = ord_(t)
            if t == neg(s):
                continue
            chain = [inc(r[l - 1]),
                     inc(ER[k - 1, l - 1] * u[l - 1]),
                     inc(ER[k - 1, l - 1]) * inc(u[l - 1]),
                     E[k - 1, l - 1] * inc(u[l - 1]),
                     QQbar(0) * inc(u[l - 1]),
                     QQbar(0)]
            assert all(c == chain[0] for c in chain), (M, s, t, "l ≠ ord(-s) の 5 行")
        lm = ord_(neg(s))
        chain = [inc(r[lm - 1]),
                 inc(ER[k - 1, lm - 1] * u[lm - 1]),
                 inc(ER[k - 1, lm - 1]) * inc(u[lm - 1]),
                 E[k - 1, lm - 1] * inc(u[lm - 1]),
                 QQbar(1) * inc(u[lm - 1]),
                 inc(u[lm - 1])]
        assert all(c == chain[0] for c in chain), (M, s, "l = ord(-s) の 5 行")
        prod_entry = sum(ER[k - 1, l - 1] * u[l - 1] for l in range(1, d + 1))   # (ε_ℝu)_{ord(s)}（def_real_matrix_vector_product）
        main = [inc(prod_entry),
                inc(sum(ER[k - 1, l - 1] * u[l - 1] for l in range(1, d + 1))),
                inc(sum(r)),
                sum(inc(x) for x in r),
                inc(r[lm - 1]),
                inc(u[lm - 1])]
        assert all(c == main[0] for c in main), (M, s, "主鎖の 5 行")
        assert prod_entry == u[lm - 1], (M, s, "主張")             # inclusion_rr_to_cc_is_injective の結論と主張


count = 0
set_random_seed(20261106)
for M in [1, 2, 3]:
    for _ in range(5):
        u = [AA(QQ.random_element(num_bound=9, den_bound=5)) for _ in range(2 ** M)]
        check(M, u)
        count += 1
# 否定コントロール: 主張の右辺を u_{ord(s)}（並べ替えない）にすると、u の成分が異なれば外れる
M = 2
u = [AA(j) for j in range(1, 2 ** M + 1)]
ER = rho(epsilon_site_product(M))
s = configurations(M)[0]
assert sum(ER[ord_(s) - 1, l] * u[l] for l in range(2 ** M)) != u[ord_(s) - 1]
print(f"{count} 本の (M_col, u) で、全ての s について 2 つの 5 行・主鎖の 5 行と主張が成り立った。否定コントロール 1 件")
print("RESULT: PASS")
