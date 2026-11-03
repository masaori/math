# 対象ラベル: finite_sum_of_nonnegative_reals_is_at_least_each_term
# a_1,…,a_m ≥ 0 なら Σ_{j=1}^{m} a_j ≥ a_k（すべての k）の帰納法の各行を確かめる。
#   m = 1 の 2 行、m → m+1 の k ≤ m の場合の 4 行、k = m+1 の場合の前置き Σ_{j=1}^{m} a_j ≥ a_1 ≥ 0 と 4 行。
# 等号の行は QQ 上の多項式環（a_j は不定元）で恒等式として、不等号の行は 0 以上の有理数の組（0 を含む）で厳密に確かめる。
# 帰属: QQ と QQ 上の多項式環（厳密計算）。浮動小数点は使わない。
N = 8
P = PolynomialRing(QQ, [f"a{j}" for j in range(1, N + 1)])


def fsum(rs):
    """def_finite_sum_of_real_numbers: 左から順に足す。"""
    s = rs[0]
    for r in rs[1:]:
        s = s + r
    return s


eqs = 0
ineqs = 0
# 等号の行（恒等式）: 和の定義の展開と 0 の単位元
x = P.gens()
for m in range(1, N):
    assert fsum(list(x[:m + 1])) == fsum(list(x[:m])) + x[m]          # def_finite_sum_of_real_numbers
    assert fsum(list(x[:m])) + 0 == fsum(list(x[:m]))                 # 0 は和の単位元（k ≤ m の場合）
    assert 0 + x[m] == x[m]                                           # 0 は和の単位元（k = m+1 の場合）
    eqs += 3
assert fsum([x[0]]) == x[0]
eqs += 1

# 不等号の行の差が、仮定で 0 以上とされる量に恒等的に一致すること（多項式環）
ident = 0
for m in range(1, N):                                                 # 本文の m（m+1 項の和）
    S = fsum(list(x[:m]))
    assert (S + x[m]) - (S + 0) == x[m]; ident += 1                   # k ≤ m の 1 本目: 差は a_{m+1}
    for k in range(m):
        rest = sum(x[j] for j in range(m) if j != k)
        assert S - x[k] == rest; ident += 1                           # k ≤ m の 2 本目: 差は a_k 以外の項の和（帰納法の仮定の中身）
    assert (S + x[m]) - (0 + x[m]) == S; ident += 1                   # k = m+1: 差は Σ_{j=1}^{m} a_j（前置きで 0 以上）
    assert S - x[0] == sum(x[j] for j in range(1, m)); ident += 1     # 前置き 1 行目: 差は a_2,…,a_m の和

# 不等号の行: 0 以上の有理数の組で
set_random_seed(20261103)
samples = []
for m in range(1, N + 1):
    for trial in range(30):
        samples.append([QQ(randint(0, 9)) / randint(1, 7) if randint(0, 3) else QQ(0) for _ in range(m)])
for avals in samples:
    m = len(avals)
    assert all(v >= 0 for v in avals)
    for k in range(m):                                                # k は 0 始まり（本文の k − 1）
        if m == 1:
            lines = [fsum(avals), avals[0], avals[k]]
            assert lines[0] == lines[1] == lines[2]
            eqs += 2
            continue
        mm = m - 1                                                    # 本文の m（m+1 項の和の帰納法の段）
        S = fsum(avals[:mm])
        if k < mm:                                                    # k ≤ m
            l0, l1, l2, l3 = fsum(avals), S + avals[mm], S + 0, S
            assert l0 == l1; eqs += 1
            assert l1 >= l2; ineqs += 1                               # a_{m+1} ≥ 0 の両辺に同じ実数を足す
            assert l2 == l3; eqs += 1
            assert l3 >= avals[k]; ineqs += 1                         # 帰納法の仮定
        else:                                                         # k = m+1
            assert S >= avals[0] >= 0; ineqs += 2                     # 前置き（帰納法の仮定を k → 1 で）
            l0, l1, l2, l3 = fsum(avals), S + avals[mm], 0 + avals[mm], avals[mm]
            assert l0 == l1; eqs += 1
            assert l1 >= l2; ineqs += 1                               # Σ_{j=1}^{m} a_j ≥ 0 の両辺に同じ実数を足す
            assert l2 == l3; eqs += 1
            assert l3 == avals[k]; eqs += 1
        assert fsum(avals) >= avals[k]                                # 主張そのもの
        assert sum(avals) >= avals[k]                                 # 比べる側: Sage の sum

# 否定コントロール: 負の項を含むと主張は成り立たないことがある
assert fsum([QQ(-1), QQ(1)]) < QQ(1)
print(f"等号 {eqs} 行、不等号 {ineqs} 行、不等号の差の恒等式 {ident} 本を確かめた")
print("RESULT: PASS")
