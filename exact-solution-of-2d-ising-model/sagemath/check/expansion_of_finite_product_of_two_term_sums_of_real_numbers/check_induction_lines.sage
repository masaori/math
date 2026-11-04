# 対象ラベル: expansion_of_finite_product_of_two_term_sums_of_real_numbers
#   Π_{j=1}^{r} (a_j^(1) + a_j^(0)) = Σ_{ε∈{0,1}^r} Π_{j=1}^{r} a_j^(ε_j)
# 証明の 2 本の鎖（r = 1 の 4 行、r → r+1 の 7 行）を、隣り合う行どうしで比べる:
#   r = 1:   Π_{j=1}^1 (a_j^(1) + a_j^(0)) = a_1^(1) + a_1^(0)                 (def_finite_product_of_real_numbers)
#                                          = a_1^((1)_1) + a_1^((0)_1)         (def_sum_over_binary_words の (1)_1 = 1, (0)_1 = 0)
#                                          = Π_{j=1}^1 a_j^((1)_j) + Π_{j=1}^1 a_j^((0)_j) (積の定義を右辺から左辺へ 2 か所)
#                                          = Σ_{ε∈{0,1}^1} Π_{j=1}^1 a_j^(ε_j)  (和の定義を右辺から左辺へ)
#   r → r+1: Π_{j=1}^{r+1}(…) = (Π_{j=1}^{r}(…))(a_{r+1}^(1) + a_{r+1}^(0))    (積の定義)
#                             = (Σ_{ε'} Π_{j=1}^{r} a_j^(ε'_j))(a_{r+1}^(1) + a_{r+1}^(0)) (帰納法の仮定)
#                             = Σ_{ε'} (Π_{j=1}^{r} a_j^(ε'_j))(a_{r+1}^(1) + a_{r+1}^(0)) (real_sum_over_binary_words_distributes_in_left_factor)
#                             = Σ_{ε'} ((Π a_j^(ε'_j)) a_{r+1}^(1) + (Π a_j^(ε'_j)) a_{r+1}^(0)) (ℝ の分配則 a(b+c) = ab + ac を各項へ)
#                             = Σ_{ε'} ((Π a_j^((ε',1)_j)) a_{r+1}^((ε',1)_{r+1}) + …)      ((ε',e)_j = ε'_j、(ε',e)_{r+1} = e)
#                             = Σ_{ε'} (Π_{j=1}^{r+1} a_j^((ε',1)_j) + Π_{j=1}^{r+1} a_j^((ε',0)_j)) (積の定義を右辺から左辺へ)
#                             = Σ_{ε∈{0,1}^{r+1}} Π_{j=1}^{r+1} a_j^(ε_j)   (和の定義を右辺から左辺へ)
# 帰属: a_j^(e) は QQ 上の多項式環の不定元（ℝ の元の代わり。鎖が使うのは ℝ の和・積と二つの分配則だけ）。厳密計算。r = 1..6。
# 有限積は def_finite_product_of_real_numbers どおり a_1 から左へ掛け、和は def_sum_over_binary_words_of_real_numbers どおりに組む。
# 独立な経路として、Sage の prod と全ての語の積の和とも比べる。
# 否定コントロール: 語を一つ落とした和は主張の左辺と一致しないことを確かめる。


def binary_words(r):
    return [tuple(w) for w in cartesian_product([[0, 1]] * r)]


def bsum(r, f):
    if r == 1:
        return f((1,)) + f((0,))
    return bsum(r - 1, lambda e: f(e + (1,)) + f(e + (0,)))


def fprod(ys):
    p = ys[0]
    for y in ys[1:]:
        p = p * y
    return p


count = 0
broken = 0
for r in range(1, 7):
    names = [f'a{j}_{e}' for j in range(1, r + 1) for e in (1, 0)]
    R = PolynomialRing(QQ, names)
    g = R.gens()
    a = lambda j, e: g[2 * (j - 1) + (0 if e == 1 else 1)]      # a_j^(e)、j = 1..r
    lhs = fprod([a(j, 1) + a(j, 0) for j in range(1, r + 1)])
    rhs = bsum(r, lambda eps: fprod([a(j, eps[j - 1]) for j in range(1, r + 1)]))
    assert lhs == rhs
    assert lhs == prod(a(j, 1) + a(j, 0) for j in range(1, r + 1))
    assert rhs == sum(prod(a(j, w[j - 1]) for j in range(1, r + 1)) for w in binary_words(r))
    count += 1
    words = binary_words(r)
    bad = sum(prod(a(j, w[j - 1]) for j in range(1, r + 1)) for w in words[1:])
    if bad != lhs:
        broken += 1
    if r == 1:
        lines = [
            fprod([a(1, 1) + a(1, 0)]),
            a(1, 1) + a(1, 0),
            a(1, (1,)[0]) + a(1, (0,)[0]),
            fprod([a(1, (1,)[0])]) + fprod([a(1, (0,)[0])]),
            bsum(1, lambda eps: fprod([a(1, eps[0])])),
        ]
    else:
        s = r - 1   # 証明の r（r → r+1 の r+1 がここの r）
        P = lambda eps: fprod([a(j, eps[j - 1]) for j in range(1, s + 1)])
        last = a(r, 1) + a(r, 0)
        # 帰納法の仮定を先に確かめる
        assert fprod([a(j, 1) + a(j, 0) for j in range(1, s + 1)]) == bsum(s, P)
        count += 1
        lines = [
            lhs,
            fprod([a(j, 1) + a(j, 0) for j in range(1, s + 1)]) * last,
            bsum(s, P) * last,
            bsum(s, lambda e: P(e) * last),
            bsum(s, lambda e: P(e) * a(r, 1) + P(e) * a(r, 0)),
            bsum(s, lambda e: P(e + (1,)) * a(r, (e + (1,))[r - 1]) + P(e + (0,)) * a(r, (e + (0,))[r - 1])),
            bsum(s, lambda e: fprod([a(j, (e + (1,))[j - 1]) for j in range(1, r + 1)])
                              + fprod([a(j, (e + (0,))[j - 1]) for j in range(1, r + 1)])),
            bsum(r, lambda eps: fprod([a(j, eps[j - 1]) for j in range(1, r + 1)])),
        ]
    for x, y in zip(lines, lines[1:]):
        assert x == y, r
        count += 1
assert broken > 0
print(f"checked {count} lines (r = 1..6)")
print(f"negative controls (broken lines detected): {broken}")
print("RESULT: PASS")
