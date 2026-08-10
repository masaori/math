# 対象ラベル: claim_qbar_prod_eq_zero
#   併せて引く定義: def_algebraic_numbers
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「代数的数の有限積が 0 ならば、0 である因子がある」
# （prod_{i in s} c_i = 0 ならば c_{i0} = 0 を満たす i0 in s が存在する）を、小さい s で確かめる。
#
# 計算はすべて厳密に行う（浮動小数点は使わない）。代数的数の全体 Qbar は SageMath の
# QQbar（厳密な代数的数の体）で表す。
#
# 何を確かめるか（人手証明の段に 1 対 1 で対応させる）:
#   1. 帰納法の出発点。空の積は Qbar の単位元 1 であり、1 != 0 である
#      （したがって空の s は仮定を満たさない）。
#   2. 帰納法の一歩の第 1 の鎖。prod_{i in s∪{a}} c_i = c_a * prod_{i in s} c_i。
#   3. 帰納法の一歩の第 2 の鎖（c_a != 0 の場合）。5 段の各段が成り立つこと
#      （1 を掛ける → 逆元を差し込む → 結合則 → 仮定を代入 → 零元との積）。
#   4. 主張そのもの。族の全部分集合 s について、積が 0 ならば 0 である因子があること。
#   5. 主張が空虚でないこと。積が 0 になる s と、ならない s の両方が実際にあること。
#   6. 仮定が外せないこと。零因子を持つ環（Z/6Z）では同じ言明が破れること
#      （2*3 = 0 だが 2 も 3 も 0 でない）。すなわちこの主張は Qbar が体であることを使っている。

# ---- 1. 帰納法の出発点 -------------------------------------------------------

empty_prod = prod([], z=QQbar(1))
assert empty_prod == QQbar(1), "空の積が単位元でない"
assert QQbar(1) != QQbar(0), "Qbar で 1 = 0 になっている"
print("1. 出発点: 空の積は 1 であり、1 != 0（したがって空の s は仮定を満たさない）")

# ---- 検証に使う代数的数の族 ---------------------------------------------------
# 0 を含むもの・含まないものの両方を用意する（5 個）。

family = [QQbar(0), QQbar(2), QQbar(-3) / QQbar(4), QQbar(2).sqrt(), QQbar(-1)]
family_nonzero = [QQbar(2), QQbar(-3) / QQbar(4), QQbar(2).sqrt(), QQbar(-1), QQbar(5)]


def subsets(n):
    """{0,...,n-1} の全部分集合を返す。"""
    out = []
    for mask in range(2 ** n):
        out.append([i for i in range(n) if (mask >> i) & 1])
    return out


# ---- 2. 一歩の第 1 の鎖（因子を 1 つ括り出す） ---------------------------------

count_step1 = 0
for c in (family, family_nonzero):
    for s in subsets(len(c)):
        for a in range(len(c)):
            if a in s:
                continue
            lhs = prod([c[i] for i in s + [a]], z=QQbar(1))
            rhs = c[a] * prod([c[i] for i in s], z=QQbar(1))
            assert lhs == rhs, "因子の括り出しが破れた"
            count_step1 += 1
print("2. 一歩の第 1 の鎖: prod_{s∪{a}} = c_a * prod_s が %d 組で成立" % count_step1)

# ---- 3. 一歩の第 2 の鎖（c_a != 0 のときの 5 段） ------------------------------

count_step2 = 0
for c in (family, family_nonzero):
    for s in subsets(len(c)):
        for a in range(len(c)):
            if a in s or c[a] == QQbar(0):
                continue
            ps = prod([c[i] for i in s], z=QQbar(1))
            inv = c[a] ** (-1)
            # 第 1 段: 1 を掛ける
            assert ps == QQbar(1) * ps
            # 第 2 段: 逆元を差し込む
            assert QQbar(1) * ps == (inv * c[a]) * ps
            # 第 3 段: 結合則
            assert (inv * c[a]) * ps == inv * (c[a] * ps)
            # 第 4・5 段: c_a * ps = 0 の場合に限り、inv * 0 = 0 で閉じる
            if c[a] * ps == QQbar(0):
                assert inv * (c[a] * ps) == inv * QQbar(0)
                assert inv * QQbar(0) == QQbar(0)
                assert ps == QQbar(0), "残りの積が 0 にならなかった"
            count_step2 += 1
print("3. 一歩の第 2 の鎖: 5 段が %d 組で成立" % count_step2)

# ---- 4. 主張そのもの ---------------------------------------------------------

count_zero = 0
count_nonzero = 0
for c in (family, family_nonzero):
    for s in subsets(len(c)):
        p = prod([c[i] for i in s], z=QQbar(1))
        if p == QQbar(0):
            witnesses = [i for i in s if c[i] == QQbar(0)]
            assert len(witnesses) >= 1, "積が 0 なのに 0 である因子が無い"
            count_zero += 1
        else:
            assert all(c[i] != QQbar(0) for i in s)
            count_nonzero += 1
print("4-5. 主張: 積が 0 の s が %d 個（いずれも 0 の因子を持つ）、0 でない s が %d 個"
      % (count_zero, count_nonzero))
assert count_zero >= 1 and count_nonzero >= 1, "主張が空虚（片方の場合しか出ていない）"

# ---- 5b. 応用の形（軌道ごとの因子の値 z^m - 1 に取る） -------------------------
# 次のセクションが chi_U の値へこれを当てるので、その形でも確かめる。
# chi_U の値は prod_O (z^{|O|} - 1) である（claim_shift_char_orbit_factorization と
# claim_second_evaluation_prod による）。

orbit_sizes_list = [[1, 1], [1, 2], [1, 3], [2, 2], [1, 1, 2, 4], [1, 2, 3, 6]]
zs = [QQbar(1), QQbar(-1), QQbar.zeta(3), QQbar.zeta(6), QQbar(2), QQbar(2).sqrt()]
count_app = 0
for sizes in orbit_sizes_list:
    for z in zs:
        factors = [z ** m - QQbar(1) for m in sizes]
        p = prod(factors, z=QQbar(1))
        if p == QQbar(0):
            witnesses = [k for k in range(len(sizes)) if factors[k] == QQbar(0)]
            assert len(witnesses) >= 1, "chi_U の値が 0 なのに 0 の因子が無い"
            # 0 になる因子の指数 m について z^m = 1 であること（次の段が引く形）
            for k in witnesses:
                assert z ** sizes[k] == QQbar(1)
            count_app += 1
print("5b. 応用の形: chi_U の値が 0 になった %d 組すべてで、0 になる因子が取れ z^{|O|} = 1" % count_app)
assert count_app >= 1

# ---- 6. 仮定が外せないこと（零因子を持つ環では破れる） -------------------------

R6 = IntegerModRing(6)
p = R6(2) * R6(3)
assert p == R6(0), "Z/6Z で 2*3 = 0 になっていない"
assert R6(2) != R6(0) and R6(3) != R6(0)
print("6. 仮定が外せないこと: Z/6Z では積が 0 でも 0 である因子が無い（体であることを使っている）")

print("すべて通過")
