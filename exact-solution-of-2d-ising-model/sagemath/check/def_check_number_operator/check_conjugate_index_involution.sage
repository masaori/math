# 対象ラベル: def_check_number_operator
# 証明の (1): σ: M̌ → M̌, μ ↦ M_col + 1 - μ の σ(σ(μ)) = μ の鎖（13 個の等号）と、単射・全射の鎖。
# 鎖の各行は ZZ[M, μ] の多項式として厳密に等しいことを確かめる（M_col・μ を不定元に置く）。
# 写像として定まること（def_check_index_set (2)）・対合・単射・全射は、M_col = 2..40 の全ての μ ∈ M̌ で ZZ の中で確かめる。
# 対照: 対を -μ に取ると M̌ に入らず、M_col + 2 - μ に取ると σ(σ(μ)) = μ は保たれても M̌ に入らない添字がある。
import sys

fails = 0


def check(ok, label, quiet=False):
    global fails
    if not ok:
        fails += 1
    if not ok or not quiet:
        print(("PASS " if ok else "FAIL ") + label)


R.<M, mu> = PolynomialRing(ZZ)
sigma = lambda a: M + 1 - a                       # σ の定義（不定元のまま）
A = M + 1                                         # 鎖の M_col + 1
rows = [
    sigma(sigma(mu)),                             # σ(σ(μ))
    M + 1 - sigma(mu),                            # = M_col + 1 - σ(μ)（σ の定義、μ → σ(μ)）
    M + 1 - (M + 1 - mu),                         # = M_col + 1 - (M_col + 1 - μ)（σ の定義）
    A + (-(A - mu)),                              # = (M_col + 1) + (-((M_col + 1) - μ))（def_int_difference）
    A + (-(A + (-mu))),                           # = (M_col + 1) + (-((M_col + 1) + (-μ)))（def_int_difference）
    A + ((-A) + (-(-mu))),                        # int_negation_of_sum_is_sum_of_negations（x → M_col + 1, y → -μ）
    (A + (-A)) + (-(-mu)),                        # 加法の結合律を右辺から左辺へ
    0 + (-(-mu)),                                 # 加法の逆元 x + (-x) = 0（x → M_col + 1）
    -(-mu),                                       # 和の単位元 0 + x = x
    (-(-mu)) + 0,                                 # 和の単位元 x + 0 = x を右辺から左辺へ
    (-(-mu)) + ((-mu) + mu),                      # 加法の逆元 (-x) + x = 0（x → μ）を右辺から左辺へ
    ((-(-mu)) + (-mu)) + mu,                      # 加法の結合律を右辺から左辺へ
    0 + mu,                                       # 加法の逆元 (-x) + x = 0（x → -μ）
    mu,                                           # 和の単位元 0 + x = x（x → μ）
]
for t in range(len(rows) - 1):
    check(rows[t] == rows[t + 1], f"σ(σ(μ)) の鎖の第 {t + 1} 等号（ZZ[M, μ]）")
check(len(rows) - 1 == 13, "σ(σ(μ)) の鎖は 13 個の等号")
check(rows[0] == mu, "σ(σ(μ)) = μ（ZZ[M, μ]）")
# 第 3〜第 13 等号で当てた操作そのものを、別の不定元でも確かめる
S.<x, y, t> = PolynomialRing(ZZ)
check(x - y == x + (-y), "def_int_difference の x - y = x + (-y)（ZZ[x, y]）")
check(-(x + y) == (-x) + (-y), "int_negation_of_sum_is_sum_of_negations（ZZ[x, y]）")
check((x + y) + t == x + (y + t), "ℤ の加法の結合律（ZZ[x, y, t]）")
check(x + (-x) == 0 and (-x) + x == 0, "ℤ の加法の逆元の 2 つの形（ZZ[x]）")
check(0 + x == x and x + 0 == x, "ℤ の和の単位元の 2 つの形（ZZ[x]）")
# 対照: 消えた旧根拠 a - (b - c) = a - b + c の誤った形 a - (b - c) = a - b - c は成り立たない
check(x - (y - t) != x - y - t, "対照: a - (b - c) ≠ a - b - c（ZZ[x, y, t]）")

for Mc in range(2, 41):
    Mset = list(range(1, Mc + 1))                 # def_check_index_set の M̌ = {1, …, M_col}
    sg = {m: Mc + 1 - m for m in Mset}
    check(all(sg[m] in Mset for m in Mset), f"M_col={Mc}: σ は M̌ から M̌ への写像（def_check_index_set (2)）", quiet=True)
    check(all(sg[sg[m]] == m for m in Mset), f"M_col={Mc}: σ∘σ = id", quiet=True)
    # 単射の鎖: σ(μ) = σ(ν) なら μ = σ(σ(μ)) = σ(σ(ν)) = ν
    inj = all((sg[m] != sg[n]) or (m == sg[sg[m]] and sg[sg[m]] == sg[sg[n]] and sg[sg[n]] == n) for m in Mset for n in Mset)
    check(inj and len(set(sg.values())) == Mc, f"M_col={Mc}: 単射（鎖の 3 行と像の個数）", quiet=True)
    # 全射: ν は σ(ν) の像
    check(all(sg[sg[n]] == n and sg[n] in Mset for n in Mset) and sorted(sg.values()) == Mset, f"M_col={Mc}: 全射", quiet=True)
    # ň_μ に現れる添字 μ・σ(μ) はどちらも M̌ に入る
    check(all(m in Mset and sg[m] in Mset for m in Mset), f"M_col={Mc}: ň_μ の添字は M̌ に入る", quiet=True)
    # 対照
    check(not all((-m) in Mset for m in Mset), f"対照 M_col={Mc}: μ ↦ -μ は M̌ に入らない", quiet=True)
    wrong = {m: Mc + 2 - m for m in Mset}
    check(not all(wrong[m] in Mset for m in Mset), f"対照 M_col={Mc}: μ ↦ M_col + 2 - μ は M̌ に入らない添字がある", quiet=True)
print("M_col = 2..40 の具体の確認: 済")

if fails:
    print(f"RESULT: FAIL（{fails} 件）")
    sys.exit(1)
print("RESULT: PASS")
