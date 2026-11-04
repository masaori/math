# 対象ラベル: real_sum_over_binary_words_distributes_in_left_factor（(Σ_{ε∈{0,1}^r} x_ε) c = Σ_{ε∈{0,1}^r} x_ε c）
# 証明の 2 本の鎖:
#   r = 1:     (Σ_{ε∈{0,1}^1} x_ε) c = (x_(1) + x_(0)) c                  (def_sum_over_binary_words_of_real_numbers)
#                                    = x_(1) c + x_(0) c                    (ℝ の分配則 (a+b)c = ac + bc)
#                                    = Σ_{ε∈{0,1}^1} x_ε c                  (def_sum_over_binary_words_of_real_numbers を右辺から左辺へ)
#   r → r+1:   (Σ_{ε∈{0,1}^{r+1}} x_ε) c = (Σ_{ε'} (x_(ε',1) + x_(ε',0))) c (def_sum_over_binary_words_of_real_numbers)
#                                        = Σ_{ε'} (x_(ε',1) + x_(ε',0)) c   (帰納法の仮定)
#                                        = Σ_{ε'} (x_(ε',1) c + x_(ε',0) c) (ℝ の分配則を各項へ同時に)
#                                        = Σ_{ε∈{0,1}^{r+1}} x_ε c          (def_sum_over_binary_words_of_real_numbers を右辺から左辺へ)
# 帰属: x_ε と c は QQ 上の多項式環の不定元（ℝ の元の代わり。鎖が使うのは ℝ の和・積と分配則だけで、
# どれも QQ 上の多項式環で成り立つ）。厳密計算で、浮動小数点は無い。r = 1..5。
# 和は定義どおり、最後の成分で 1 の項を 0 の項より先に足す帰納法で組む（語は 0/1 のタプル）。
# 否定コントロール: 3 行目の分配則の行で x_(ε',0) c を落とすと隣の行と一致しないことを確かめる。


def binary_words(r):
    return [tuple(w) for w in cartesian_product([[0, 1]] * r)]


def bsum(r, f):
    # def_sum_over_binary_words_of_real_numbers: Σ_{ε∈{0,1}^1} f(ε) := f((1)) + f((0))、
    # Σ_{ε∈{0,1}^{r+1}} f(ε) := Σ_{ε'∈{0,1}^r} (f((ε',1)) + f((ε',0)))
    if r == 1:
        return f((1,)) + f((0,))
    return bsum(r - 1, lambda e: f(e + (1,)) + f(e + (0,)))


count = 0
broken = 0
for r in range(1, 6):
    words = binary_words(r)
    names = ['x_' + ''.join(str(b) for b in w) for w in words] + ['c']
    R = PolynomialRing(QQ, names)
    xs = dict(zip(words, R.gens()[:-1]))
    c = R.gens()[-1]
    x = lambda e: xs[e]
    # 主張
    assert bsum(r, x) * c == bsum(r, lambda e: x(e) * c)
    count += 1
    if r == 1:
        lines = [bsum(1, x) * c, (x((1,)) + x((0,))) * c, x((1,)) * c + x((0,)) * c, bsum(1, lambda e: x(e) * c)]
    else:
        # 帰納法の仮定（r − 1 の族 ε' ↦ x_(ε',1) + x_(ε',0) について）を先に確かめる
        y = lambda e: x(e + (1,)) + x(e + (0,))
        assert bsum(r - 1, y) * c == bsum(r - 1, lambda e: y(e) * c)
        count += 1
        lines = [
            bsum(r, x) * c,
            bsum(r - 1, y) * c,
            bsum(r - 1, lambda e: y(e) * c),
            bsum(r - 1, lambda e: x(e + (1,)) * c + x(e + (0,)) * c),
            bsum(r, lambda e: x(e) * c),
        ]
        bad = bsum(r - 1, lambda e: x(e + (1,)) * c)
        if bad != lines[2]:
            broken += 1
    for a, b in zip(lines, lines[1:]):
        assert a == b, r
        count += 1
assert broken > 0
print(f"checked {count} lines (r = 1..5)")
print(f"negative controls (broken lines detected): {broken}")
print("RESULT: PASS")
