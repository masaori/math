# 対象ラベル: int_zero_at_most_one
# 0_Z <= 1_Z を、証明の場合分けに沿って確かめる。
#   全順序: 0 <= 1 または 1 <= 0（ZZ では 0 <= 1 の側だけが成り立つ）
#   1 <= 0 の側の鎖（記号の上で恒等的に）: 0 = 1 + (-1) <= 0 + (-1) = -1、
#     0 <= (-1)(-1) = -(1·(-1)) = -(-1) = -(-1) + 0 = -(-1) + ((-1) + 1) = (-(-1) + (-1)) + 1 = 0 + 1 = 1
# ZZ では 1 <= 0 の枝は通らないので、その枝の等号の段は具体の値と多項式環 ZZ[y] の恒等式の両方で確かめる。
# 帰属: 整数 ZZ と多項式環 ZZ[y]。浮動小数点は使わない。

one, zero, m1 = ZZ(1), ZZ(0), ZZ(-1)

# 全順序と主張
assert (zero <= one) or (one <= zero)
assert zero <= one                                            # 主張
assert not (one <= zero)                                      # ZZ では 1 <= 0 の枝は通らない

# 1 <= 0 の側の 3 段の鎖の等号（値として）
assert zero == one + (-one)                                   # 加法の逆元 y + (-y) = 0（y -> 1）
assert zero + (-one) == m1                                    # 和の単位元 0 + y = y（y -> -1）

# 8 段の鎖の等号（値として）
chain = [m1 * m1, -(one * m1), -(m1), -(m1) + zero, -(m1) + (m1 + one), (-(m1) + m1) + one, zero + one, one]
assert len(set(chain)) == 1

# 同じ段を ZZ[y] で恒等的に（y は鎖の 1 の位置に置いた変数）
P.<y> = ZZ[]
assert (-y) * (-y) == -(y * (-y))                             # int_negation_times_is_negation_of_product（x -> y, t -> -y）
assert 1 * (-y) == -y                                         # 乗法の単位元 1·z = z
assert -(-y) + 0 == -(-y)                                     # 和の単位元 z + 0 = z
assert (-y) + y == 0                                          # 加法の逆元 (-z) + z = 0
assert -(-y) + ((-y) + y) == (-(-y) + (-y)) + y               # 加法の結合律
assert (-(-y) + (-y)) == 0                                    # 加法の逆元 (-z) + z = 0（z -> -y）
assert 0 + y == y                                             # 和の単位元 0 + z = z
assert y + (-y) == 0 and 0 + (-y) == -y                       # 3 段の鎖の等号

# 否定コントロール: 鎖の 2 行目で int_negation_times_is_negation_of_product の符号を落とすと崩れる。
# 乗法の単位元の段で -(-1) を -1 と取り違えると鎖の右端 1 と一致しない。
neg = 0
if m1 * m1 != (one * m1):
    neg += 1
if -(m1) + zero != m1 + zero:
    neg += 1
assert neg == 2

print("0_Z <= 1_Z が成り立ち、1 <= 0 の側の鎖の全ての等号が ZZ の値と ZZ[y] の恒等式で成り立った")
print("negative controls (broken lines detected): 2")
print("RESULT: PASS")
