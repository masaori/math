# 対象ラベル: def_quadratic_positive_cone
# （def_quadratic_field_set・def_quadratic_representation_map も同じ検証で見る）
# 帰属: QQ / QQbar / AA（実代数的数）の厳密計算。浮動小数点を使わない。
# AA の順序比較は根の分離による厳密判定であり、丸めは入らない。

# 定義（def_quadratic_positive_cone）: s·s=2 を満たす s ∈ QQbar と ξ ∈ Q_s、
# (a,b) := rep_s(ξ) について、ξ が正であるとは次の三条件の少なくとも一つ:
#   (1) 0 ≤ a かつ 0 ≤ b かつ (a,b) ≠ (0,0)
#   (2) 0 < a かつ b < 0 かつ 2·b·b < a·a
#   (3) a < 0 かつ 0 < b かつ a·a < 2·b·b
# 検査すること:
#   cross: この三条件（QQ の順序だけで書かれた判定）が、「s を正の実代数的数
#          √2 として読む埋め込みで a+b·√2 > 0」と全標本で一致する
#          （定義が「s を正と宣言する」順序を正しく符号化していることの裏取り）。
#   s-pos: rep_s(s) = (0,1) が条件 (1) を満たす（s ∈ P_s）。
#   swap:  a+b·s = a+(-b)·(-s) が QQbar の厳密等号で成り立つ
#          （remark_positive_cone_sign_choice の台集合一致・表示の対応の裏取り）。
#   rep:   標本の範囲で表示が一意である（(a,b) ≠ (a',b') なら a+b·s ≠ a'+b'·s。
#          claim_quadratic_representation_unique の対偶の再確認）。


def cone(a, b):
    """def_quadratic_positive_cone の三条件（QQ の順序だけを使う）。"""
    assert a in QQ and b in QQ
    c1 = (0 <= a) and (0 <= b) and not (a == 0 and b == 0)
    c2 = (0 < a) and (b < 0) and (2 * b * b < a * a)
    c3 = (a < 0) and (0 < b) and (a * a < 2 * b * b)
    return c1 or c2 or c3


# s·s = 2 を満たす QQbar の元をすべて列挙する（t^2 - 2 の根。ちょうど 2 個）。
R.<t> = PolynomialRing(QQ)
roots = (t ** 2 - 2).roots(QQbar, multiplicities=False)
assert len(roots) == 2, "t^2 - 2 の QQbar の根がちょうど 2 個でない"

# 「s を正と宣言する」読み方の対応物: 正の実代数的数 √2（AA の厳密元）。
sqrt2_pos = AA(2).sqrt()
assert sqrt2_pos > 0 and sqrt2_pos * sqrt2_pos == 2

BOUND = 4
DEN = 3
samples = sorted(set(QQ(p) / QQ(q) for p in range(-BOUND, BOUND + 1)
                     for q in range(1, DEN + 1)))

checked_cross = 0
checked_swap = 0
checked_rep = 0

# cross: 三条件と「a + b·√2 > 0」（AA の厳密順序）の一致。
# 判定は (a,b) だけに依存するので根の選択に依らない。
for a in samples:
    for b in samples:
        lhs = cone(a, b)
        rhs = (AA(a) + AA(b) * sqrt2_pos) > 0
        assert lhs == rhs, f"三条件と正値性が食い違う: a={a}, b={b}"
        checked_cross += 1

# s-pos: rep_s(s) = (0,1) は条件 (1) を満たす。
assert cone(QQ(0), QQ(1)), "rep_s(s)=(0,1) が正の判定を満たさない"

for s in roots:
    assert s * s == 2, "s·s = 2 が壊れている"

    # swap: a+b·s = a+(-b)·(-s)（QQbar の厳密等号）。
    for a in samples:
        for b in samples:
            assert QQbar(a) + QQbar(b) * s == QQbar(a) + QQbar(-b) * (-s), \
                f"根の取り替えの恒等式が壊れている: a={a}, b={b}, s={s}"
            checked_swap += 1

    # rep: 標本の範囲での表示の一意性（対偶）。
    small = sorted(set(QQ(p) for p in range(-2, 3)))
    for a in small:
        for b in small:
            for ap in small:
                for bp in small:
                    if (a, b) != (ap, bp):
                        assert QQbar(a) + QQbar(b) * s != QQbar(ap) + QQbar(bp) * s, \
                            f"表示の一意性が壊れている: ({a},{b}) vs ({ap},{bp})"
                        checked_rep += 1

print(f"OK: cross {checked_cross} 組, swap {checked_swap} 組, rep {checked_rep} 組")
