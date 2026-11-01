# 対象ラベル: scalar_exp_product
# 主張の五行の等号の鎖を、形式冪級数として次数 D = 14 までの項で厳密に確かめる。
#   exp(x)exp(y) = (exp([x]))_11 (exp([y]))_11 = (exp([x]) exp([y]))_11
#                = (exp([x]+[y]))_11 = (exp([x+y]))_11 = exp(x+y)
# 行列の exp は極限なので多項式環に収まらない。そこで各行を、x, y の全次数が D 以下の項
# （D 次の切り捨て）で比べる。exp([x]) の D 次の切り捨ては部分和 S_D([x]) の D 次の切り捨てに等しい
# （m > D の項 x^m/m! は全次数 m > D なので切り捨てで消える）から、この比較は形式冪級数の等号の
# D 次までの部分を厳密に確かめる。
# 第一辺と最後の辺は Sage の多変数形式冪級数環の exp（独立な経路）で作る。
# 帰属: 係数 QQ（K = R）と QQ(i)（K = C）の上の多項式環・形式冪級数環。x, y は不定元。
load("../../_shared/one_by_one_matrix.sage")

D = 14


def truncate(p, D):
    """多項式 p から全次数が D を超える項を落とす。"""
    return sum((c * m for c, m in zip(p.coefficients(), p.monomials()) if m.degree() <= D), p.parent()(0))


def truncate_matrix(A, D):
    return A.apply_map(lambda p: truncate(p, D))


for name, F in COEFFICIENT_FIELDS:
    R = PolynomialRing(F, 'x,y')
    x, y = R.gens()
    PS = PowerSeriesRing(F, 'x,y', default_prec=D + 1)
    xs, ys = PS.gens()

    def from_series(s):
        """形式冪級数の D 次までの部分を多項式にする。"""
        return truncate(R(s.truncate(D + 1).polynomial()), D)

    X = one_by_one(R, x)
    Y = one_by_one(R, y)
    E = lambda A: truncate_matrix(matrix_partial_sum(A, D), D)

    line0 = truncate(from_series(exp(xs)) * from_series(exp(ys)), D)            # 数の exp の積
    line1 = truncate(entry11(E(X)) * entry11(E(Y)), D)                           # def_scalar_exp
    line2 = truncate(entry11(E(X) * E(Y)), D)                                    # 準備の (AB)_11 = A_11 B_11
    line3 = entry11(E(X + Y))                                                    # theorem_exp_product
    line4 = entry11(E(one_by_one(R, x + y)))                                     # [x]+[y] = [x+y]
    line5 = from_series(exp(xs + ys))                                            # def_scalar_exp
    assert line0 == line1 == line2 == line3 == line4 == line5, name
    assert line0 != 0 and len(line0.monomials()) == binomial(D + 2, 2)
    print(f"{name}: 五行が全次数 {D} 以下の {len(line0.monomials())} 項で一致")
print("RESULT: PASS")
