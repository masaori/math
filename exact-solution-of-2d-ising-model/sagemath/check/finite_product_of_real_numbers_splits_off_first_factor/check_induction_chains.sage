# 対象ラベル: finite_product_of_real_numbers_splits_off_first_factor（Π_{j=1}^{m+1} r_j = r_1(Π_{j=1}^{m} r_{j+1})）
# m = 1:     Π_{j≤2} r_j = (Π_{j≤1} r_j) r_2                      (def_finite_product_of_real_numbers の帰納の式、m → 1)
#                        = r_1 r_2                                 (def_finite_product_of_real_numbers の Π_{j=1}^{1} r_j := r_1)
#                        = r_1(Π_{j≤1} r_{j+1})                    (同じ式（r_j → r_{j+1}）を右辺から左辺へ)
# m → m+1:   Π_{j≤m+2} r_j = (Π_{j≤m+1} r_j) r_{m+2}               (def_finite_product_of_real_numbers の帰納の式、m → m+1)
#                          = (r_1(Π_{j≤m} r_{j+1})) r_{m+2}         (帰納法の仮定)
#                          = r_1((Π_{j≤m} r_{j+1}) r_{m+2})         (ℝ の乗法の結合律（set_and_algebra_notation）)
#                          = r_1(Π_{j≤m+1} r_{j+1})                 (def_finite_product_of_real_numbers の帰納の式（r_j → r_{j+1}）を右辺から左辺へ)
#
# 確かめ方は二つ。
# (a) 行ごとの根拠: 各行を、積を評価しない二分木（("*", 左, 右) の入れ子）で書き、
#     定義の行は「定義の式で一段ほどくと隣の行と木が文字どおり一致する」こと、
#     帰納法の仮定の行は「部分木を、前の段の鎖が示した等式（鎖の最初の木 = 最後の木）の右辺の木に差し替えると一致する」こと、
#     結合律の行は「根で (xy)t → x(yt) を一回だけ書き換えると一致する」ことを確かめる。
#     どの検査も、比べる 2 行の木をそれぞれ読む（片方を因子の列から組み直さない）。
# (b) 値: 木を QQ 上の非可換な自由代数（FreeAlgebra。結合律だけを持つ）で評価し、全ての行の値が等しいことを確かめる。
#     可換律を使わないことは、可換律の成り立たない環で等号が立つことで確かめる。
# 鎖は m = 1 の 3 行と、帰納法の段 k = 1..7（因子 r_1..r_{k+2}）の 4 行ずつ（延べ 31 行。各段は一度だけ確かめる）。
# 否定コントロールは m = 1..8 の主張それぞれに 2 件。帰属: 全て厳密（QQ 上の自由代数と、記号の木）。浮動小数点はない。


def mul(a, b):
    return ("*", a, b)


def ftree(xs):
    """def_finite_product_of_real_numbers（左から掛ける）を、積を評価しない木で書く。"""
    if len(xs) == 1:
        return xs[0]                    # Π_{j=1}^{1} r_j := r_1
    return mul(ftree(xs[:-1]), xs[-1])  # Π_{j=1}^{m+1} r_j := (Π_{j=1}^{m} r_j) r_{m+1}


def unfold_step(xs):
    """定義の帰納の式で一段だけほどいた木 (Π_{j=1}^{m} r_j) r_{m+1}（中の Π はほどかない記号として残す）。"""
    return mul(("prod", tuple(xs[:-1])), xs[-1])


def as_prod(xs):
    """ほどかない有限積の記号。"""
    return ("prod", tuple(xs))


def assoc_at_root(t):
    """根で (xy)t → x(yt) を一回だけ書き換える。根の形が合わなければ None。"""
    if t[0] == "*" and isinstance(t[1], tuple) and t[1][0] == "*":
        return mul(t[1][1], mul(t[1][2], t[2]))
    return None


def evaluate(t, gens):
    if isinstance(t, str):
        return gens[t]
    if t[0] == "prod":
        return evaluate(ftree(list(t[1])), gens)
    return evaluate(t[1], gens) * evaluate(t[2], gens)


N = 9
names = [f"r{j}" for j in range(1, N + 1)]
F = FreeAlgebra(QQ, N, names)
gens = dict(zip(names, F.gens()))
r = names                               # r[j - 1] が人手の r_j

count = 0
# m = 1 の 3 行
L = [as_prod(r[:2]), mul(as_prod(r[:1]), r[1]), mul(r[0], r[1]), mul(r[0], as_prod(r[1:2]))]
# 木の形: L[0] は有限積の記号、L[1] は「有限積の記号 × 因子」、L[2] は「因子 × 因子」、L[3] は「因子 × 有限積の記号」
assert L[0][0] == "prod"
assert L[1][0] == "*" and L[1][1][0] == "prod" and isinstance(L[1][2], str)
assert L[2][0] == "*" and isinstance(L[2][1], str) and isinstance(L[2][2], str)
assert L[3][0] == "*" and isinstance(L[3][1], str) and L[3][2][0] == "prod"
# 1 行目: L[0] を定義の帰納の式（m → 1）で一段ほどくと L[1]
assert unfold_step(list(L[0][1])) == L[1]
# 2 行目: L[1] の左の部分木（因子 1 つの有限積）を Π_{j=1}^{1} r_j := r_1 でほどくと L[2]（右の部分木は不変）
assert L[1][2] == L[2][2] and len(L[1][1][1]) == 1 and ftree(list(L[1][1][1])) == L[2][1]
# 3 行目: L[3] の右の部分木（因子 1 つの有限積）を同じ式でほどくと L[2]（右辺から左辺へ。左の部分木は不変）
assert L[3][1] == L[2][1] and len(L[3][2][1]) == 1 and ftree(list(L[3][2][1])) == L[2][2]
count += 3
vals = [evaluate(t, gens) for t in L]
assert all(v == vals[0] for v in vals)
prev = L                                # 前の段の鎖（最初の木 = 最後の木 を示した）
# 帰納法の段 k = 1..7（因子 r_1..r_{k+2}。帰納法の仮定は因子 r_1..r_{k+1} の主張）
for k in range(1, N - 1):
    xs = r[:k + 2]
    ih_lhs, ih_rhs = as_prod(xs[:k + 1]), mul(xs[0], as_prod(xs[1:k + 1]))
    assert prev[0] == ih_lhs and prev[-1] == ih_rhs                  # 帰納法の仮定は前の段の鎖の結論である
    L = [
        as_prod(xs),
        mul(as_prod(xs[:k + 1]), xs[k + 1]),
        mul(mul(xs[0], as_prod(xs[1:k + 1])), xs[k + 1]),
        mul(xs[0], mul(as_prod(xs[1:k + 1]), xs[k + 1])),
        mul(xs[0], as_prod(xs[1:k + 2])),
    ]
    assert unfold_step(list(L[0][1])) == L[1]                       # 1 行目: L[0] を定義の帰納の式（m → m+1）で一段ほどくと L[1]
    assert L[1][1] == ih_lhs and mul(ih_rhs, L[1][2]) == L[2]       # 2 行目: 部分木を帰納法の仮定の右辺に差し替える
    assert assoc_at_root(L[2]) == L[3]                              # 3 行目: 根で結合律を一回
    # 4 行目: L[4] の右の部分木を定義の帰納の式（r_j → r_{j+1}）で一段ほどくと L[3]（右辺から左辺へ。左の因子は不変）
    assert L[4][1] == L[3][1] and unfold_step(list(L[4][2][1])) == L[3][2]
    count += 4
    vals = [evaluate(t, gens) for t in L]
    assert all(v == vals[0] for v in vals), k
    prev = L
# 否定コントロール（m = 1..8 の主張それぞれ）: 先頭の因子を右へ出した (Π_{j=1}^{m} r_{j+1}) r_1（可換律を使う誤り）と、
# 添字をずらし忘れた r_1(Π_{j=1}^{m} r_j) は左辺と値が外れる（2 件は m = 1 でも別の値 r_2 r_1・r_1 r_1 になる）
negatives = 0
for m in range(1, N):
    rs = r[:m + 1]
    lhs = evaluate(as_prod(rs), gens)
    assert lhs != evaluate(mul(as_prod(rs[1:]), rs[0]), gens)
    wrong_shift = mul(rs[0], as_prod(rs[:m]))
    assert lhs != evaluate(wrong_shift, gens)
    assert evaluate(wrong_shift, gens) != evaluate(mul(as_prod(rs[1:]), rs[0]), gens)
    negatives += 2
print(f"checked {count} lines")
print(f"negative controls: {negatives}")
print("RESULT: PASS")
