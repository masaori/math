# ---------------------------------------------------------
# 対象ラベル: maximum_value_of_real_family_is_unique
# 対象: structured-latex/content/000_calculation_formulae_00_09.ts
#       ブロック calc_formulae_claim_maximum_value_of_real_family_is_unique
# 検査: def_maximum_value_of_real_family の (1)(2) を満たす値 m, m' を、有限の族 (x_i)_{i in S}（S = {0,...,n-1}、
#       x_i in QQ、同じ値が何度も現れる族を含む）の値の中から全部取り、証明の 2 本の鎖
#       m = x_{i0} <= m'、m' = x_{i0'} <= m の各行と、結論 m = m' を厳密に確かめる。
#       否定コントロール: (2) だけを満たす上界（max + 1）と、(1) だけを満たす値（max でない族の値）は
#       最大値の定義を満たさないこと。
# 帰属: 値はすべて QQ。浮動小数点と RR / CC への脱出はない。主張は族の値の順序だけを使うので、
#       一般の実数の族は人手証明が担い、ここでは有限の有理数の族で各行の写し間違いを検出する。
# ---------------------------------------------------------
set_random_seed(20261104)

def is_max_value(x, m):
    cond1 = any(x[i] == m for i in range(len(x)))   # (1)
    cond2 = all(x[i] <= m for i in range(len(x)))   # (2)
    return cond1 and cond2

ok_all = True
n_pairs = 0
n_steps = 0
n_neg = 0
families = []
for n in range(1, 9):
    for _ in range(20):
        families.append([QQ(randint(-5, 5)) / randint(1, 3) for _ in range(n)])
families.append([QQ(2)] * 4)            # すべて同じ値
families.append([QQ(1), QQ(3), QQ(3)])  # 最大値を取る添字が二つ
for x in families:
    S = range(len(x))
    maxima = sorted(set(x[i] for i in S if is_max_value(x, x[i])))   # 最大値の候補（重複を除く）
    if len(maxima) == 0:
        ok_all = False
    for m in maxima:
        for mp in maxima:
            i0 = next(i for i in S if x[i] == m)       # i0 の取り方
            i0p = next(i for i in S if x[i] == mp)     # i0' の取り方
            line1 = (m == x[i0]) and (x[i0] <= mp)     # m = x_{i0} <= m'
            line2 = (mp == x[i0p]) and (x[i0p] <= m)   # m' = x_{i0'} <= m
            concl = (m <= mp) and (mp <= m) and (m == mp)
            n_pairs += 1
            n_steps += 4
            ok_all = ok_all and line1 and line2 and concl
    top = max(x)
    neg_upper = not is_max_value(x, top + 1)            # (2) だけを満たす上界
    others = [x[i] for i in S if x[i] != top]
    neg_value = all(not is_max_value(x, v) for v in others)   # (1) だけを満たす値
    n_neg += 1 + len(others)
    ok_all = ok_all and neg_upper and neg_value

print(f"族 {len(families)} 個、最大値の組 {n_pairs} 組、鎖の段 {n_steps} 段、否定コントロール {n_neg} 件")
print("RESULT: PASS" if ok_all else "RESULT: FAIL")
