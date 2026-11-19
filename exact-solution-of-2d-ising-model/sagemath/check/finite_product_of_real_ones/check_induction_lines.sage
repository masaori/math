# 対象ラベル: finite_product_of_real_ones
# 証明の帰納法の各行:
#   m = 1:  ∏_{j=1}^{1} 1 = 1                                   （def_finite_product_of_real_numbers の Π^{1}、r_j → 1）
#   m → m+1: ∏_{j=1}^{m+1} 1 = (∏_{j=1}^{m} 1)·1               （def_finite_product_of_real_numbers の帰納の式、r_j → 1）
#                            = 1·1                             （帰納法の仮定）
#                            = 1                               （ℝ の乗法の単位元 p·1 = p、p → 1）
# 有限積は def_finite_product_of_real_numbers の帰納法どおり左から掛ける経路と、Sage の prod の経路で作る。
# 帰属: QQ（ℝ の 1 は QQ の 1 で表せる。主張に現れる数は 1 だけなので ℝ への脱出は無い）。m = 1,…,20。
one = QQ(1)

def left_to_right_product(rs):
    acc = rs[0]
    for r in rs[1:]:
        acc = acc * r
    return acc

assert left_to_right_product([one]) == one                    # m = 1 の行
count = 1
for m in range(1, 20):
    line1 = left_to_right_product([one] * (m + 1))
    line2 = left_to_right_product([one] * m) * one             # 帰納の式
    assert line1 == line2
    assert left_to_right_product([one] * m) == one             # 帰納法の仮定
    line3 = one * one
    assert line2 == line3
    assert line3 == one                                        # p·1 = p（p → 1）
    assert line1 == prod([one] * (m + 1))
    count += 1
# 対照: 1 でない因子が一つあれば 1 にならない
assert left_to_right_product([one, one, QQ(2)]) != one
assert left_to_right_product([QQ(-1), one]) != one
print(f"checked m = 1..{count}")
print("RESULT: PASS")
