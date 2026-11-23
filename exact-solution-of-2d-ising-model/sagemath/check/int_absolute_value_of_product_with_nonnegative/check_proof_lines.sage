# 対象ラベル: int_absolute_value_of_product_with_nonnegative
# x, y ∈ ℤ、0 ≤ y のとき |xy| = |x|y を、証明の場合分けに沿って確かめる。
#   0 ≤ x:                 0 ≤ xy、|xy| = xy = |x|y
#   ¬(0 ≤ x) の準備:       |x|y = (-x)y = -(xy)、0 ≤ |x|y = -(xy)
#     ¬(0 ≤ xy):           |xy| = -(xy) = |x|y
#     0 ≤ xy:              xy = 0 + xy ≤ (-(xy)) + xy = 0、反対称律で xy = 0、
#                          |xy| = xy = 0 = xy + (-(xy)) = 0 + (-(xy)) = -(xy) = |x|y
# 絶対値は def_int_absolute_value の場合分けで自前に定義し、Sage の abs は否定コントロールの比較にだけ使う。
# 帰属: 整数 ZZ と多項式環 ZZ[x, y]。浮動小数点は使わない。

def iabs(z):
    z = ZZ(z)
    return z if 0 <= z else -z

# 代数の段の恒等式（ZZ[x, y]）
P.<X, Y> = ZZ[]
assert (-X) * Y == -(X * Y)                                   # int_negation_times_is_negation_of_product
assert 0 + X * Y == X * Y                                     # 和の単位元
assert (-(X * Y)) + X * Y == 0                                # 加法の逆元 (-z) + z = 0
assert X * Y + (-(X * Y)) == 0                                # 加法の逆元 z + (-z) = 0

count = {"x_nonneg": 0, "x_neg_xy_neg": 0, "x_neg_xy_nonneg": 0}
for x in range(-30, 31):
    for y in range(0, 31):
        x, y = ZZ(x), ZZ(y)
        xy = x * y
        if 0 <= x:
            assert 0 <= xy                                    # 順序と乗法の両立
            chain = [iabs(xy), xy, iabs(x) * y]
            assert iabs(x) == x
            assert len(set(chain)) == 1
            count["x_nonneg"] += 1
        else:
            assert iabs(x) == -x
            pre = [iabs(x) * y, (-x) * y, -xy]
            assert len(set(pre)) == 1
            assert 0 <= iabs(x) and 0 <= iabs(x) * y and 0 <= -xy
            if not (0 <= xy):
                chain = [iabs(xy), -xy, iabs(x) * y]
                assert len(set(chain)) == 1
                count["x_neg_xy_neg"] += 1
            else:
                le_chain = [xy, 0 + xy, (-xy) + xy, 0]
                assert le_chain[0] == le_chain[1] and le_chain[1] <= le_chain[2] and le_chain[2] == le_chain[3]
                assert xy == 0                                # 反対称律
                chain = [iabs(xy), xy, 0, xy + (-xy), 0 + (-xy), -xy, iabs(x) * y]
                assert len(set(chain)) == 1
                count["x_neg_xy_nonneg"] += 1
        assert iabs(xy) == iabs(x) * y                        # 主張
        assert iabs(xy) == abs(xy)                            # 自前の絶対値が Sage の abs と一致

# どの枝も標本で通った（0 ≤ xy かつ x < 0 の枝は y = 0 のときだけ通る）
assert all(v > 0 for v in count.values()), count

# 否定コントロール: 仮定 0 ≤ y を外すと主張は崩れる。準備の鎖で |x| を x に取り違えると崩れる。
neg = 0
if iabs(ZZ(2) * ZZ(-3)) != iabs(ZZ(2)) * ZZ(-3):
    neg += 1
xb, yb = ZZ(-2), ZZ(3)
if iabs(xb * yb) != xb * yb:                         # ¬(0 ≤ x) の準備の鎖で |x| を x に取り違えて |x|y = xy とすると、鎖の左端 |xy| と一致しない
    neg += 1
assert neg == 2

print(f"枝ごとの標本数: {count}（0 ≤ y の整数の組 {sum(count.values())} 件）")
print("全ての枝で鎖の全ての行が等しく、主張 |xy| = |x|y が成り立った")
print("negative controls (broken lines detected): 2")
print("RESULT: PASS")
