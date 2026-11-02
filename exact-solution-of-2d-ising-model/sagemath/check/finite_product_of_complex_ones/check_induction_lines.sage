# 対象ラベル: finite_product_of_complex_ones
# 証明の帰納法の各行:
#   m = 1:  ∏_{j=1}^{1} 1 = 1
#   m → m+1: ∏_{j=1}^{m+1} 1 = (∏_{j=1}^{m} 1)·1 = 1·1 = 1
# 有限積は def_finite_product_of_complex_numbers の帰納法どおり左から掛ける経路と、Sage の prod の経路で作る。
# 帰属: QQ(i)（1_C は QQ(i) の 1）。m = 1,…,20。
K.<I> = QuadraticField(-1)
one = K(1)

def left_to_right_product(zs):
    acc = zs[0]
    for z in zs[1:]:
        acc = acc * z
    return acc

assert left_to_right_product([one]) == one
count = 1
for m in range(1, 20):
    line1 = left_to_right_product([one] * (m + 1))
    line2 = left_to_right_product([one] * m) * one
    assert left_to_right_product([one] * m) == one          # 帰納法の仮定
    line3 = one * one
    assert line1 == line2 == line3 == one == prod([one] * (m + 1))
    count += 1
# 対照: 1 でない因子が一つあれば 1 にならない
assert left_to_right_product([one, one, 1 + I]) != one
print(f"checked m = 1..{count}")
print("RESULT: PASS")
