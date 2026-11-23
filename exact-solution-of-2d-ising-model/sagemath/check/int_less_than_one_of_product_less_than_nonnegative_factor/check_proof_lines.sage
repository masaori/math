# 対象ラベル: int_less_than_one_of_product_less_than_nonnegative_factor
# x, c ∈ ℤ、0 <= c、x·c < c（def_int_strict_order: x·c + 1 <= c）のとき x < 1（x + 1 <= 1）を、証明の場合分けに沿って確かめる。
#   x <= 0 の場合: そのまま
#   0 <= x かつ x = 0 の場合: 反射律で x <= 0
#   0 <= x かつ x = n + 1（0 <= n）の場合: 0 <= n·c、c = 0 + c <= n·c + c = n·c + 1·c = (n + 1)·c = x·c、
#     c + 1 <= x·c + 1 <= c、1 = 0 + 1 = ((-c) + c) + 1 = (-c) + (c + 1) = (c + 1) + (-c) <= c + (-c) = 0 → 0 <= 1 と反対称律で矛盾
#   最後: x + 1 <= 0 + 1 = 1
# 帰属: 整数 ZZ と多項式環 ZZ[n, c]。浮動小数点は使わない。

P.<N, C> = ZZ[]
assert 0 + C == C                                             # 和の単位元
assert N * C + C == N * C + 1 * C                             # 乗法の単位元
assert N * C + 1 * C == (N + 1) * C                           # 分配律
assert (0 + 1) == 1
assert ((-C) + C) + 1 == 0 + 1                                # 加法の逆元 (-y) + y = 0
assert ((-C) + C) + 1 == (-C) + (C + 1)                       # 加法の結合律
assert (-C) + (C + 1) == (C + 1) + (-C)                       # 加法の交換律
assert C + (-C) == 0                                          # 加法の逆元 y + (-y) = 0

count = {"x_le_0": 0, "x_eq_0": 0, "x_succ_hyp": 0}
for x in range(-30, 31):
    for c in range(0, 31):
        x, c = ZZ(x), ZZ(c)
        hyp = (x * c + 1 <= c)                                # 主張の仮定 x·c < c（def_int_strict_order）
        assert hyp == (x * c < c)
        # 仮定 x·c < c を使わない段: x = n + 1（0 <= n）の側の鎖 c <= x·c
        if 0 <= x and x != 0:
            n = x - 1
            assert 0 <= n and x == n + 1                      # 0 以上の元の分解
            assert 0 <= n * c                                 # 順序と乗法の両立
            le_chain = [c, 0 + c, n * c + c, n * c + 1 * c, (n + 1) * c, x * c]
            assert le_chain[0] == le_chain[1] and le_chain[1] <= le_chain[2]
            assert le_chain[2] == le_chain[3] == le_chain[4] == le_chain[5]
            assert c <= x * c
            # この枝では仮定 x·c < c が成り立たない（成り立てば 1 <= 0 が出て矛盾）
            assert not hyp
            count["x_succ_hyp"] += 1
        if not hyp:
            continue
        if x <= 0:
            count["x_le_0"] += 1
            if x == 0:
                count["x_eq_0"] += 1
        assert x <= 0                                         # どの場合も x <= 0
        fin = [x + 1, 0 + 1, ZZ(1)]
        assert fin[0] <= fin[1] and fin[1] == fin[2]
        assert x + 1 <= 1 and x < 1                           # 主張（def_int_strict_order）

assert all(v > 0 for v in count.values()), count

# 否定コントロール: 仮定 0 <= c を外すと主張が崩れる（x = 2, c = -1: x·c = -2 < -1 だが x < 1 でない）。
# 有理数で < を x + 1 <= y と読むと（0 以上の元の分解だけが成り立たない）崩れる（x = 1/2, c = 2: x·c + 1 = 2 <= 2 だが x + 1 = 3/2 <= 1 でない）。
neg = 0
if ZZ(2) * ZZ(-1) < ZZ(-1) and not (ZZ(2) < 1):
    neg += 1
xq, cq = QQ(1/2), QQ(2)
if xq * cq + 1 <= cq and not (xq + 1 <= 1):
    neg += 1
assert neg == 2

print(f"枝ごとの標本数: {count}")
print("仮定を満たす全ての組で x <= 0 と x + 1 <= 0 + 1 = 1 が成り立ち、x = n + 1 の枝では c <= x·c の鎖が成り立って仮定が崩れた")
print("negative controls (broken lines detected): 2")
print("RESULT: PASS")
