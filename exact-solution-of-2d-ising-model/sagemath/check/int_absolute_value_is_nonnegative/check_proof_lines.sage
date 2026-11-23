# 対象ラベル: int_absolute_value_is_nonnegative
# 整数の絶対値は 0 以上であることの証明の各行を確かめる。
# 絶対値は def_int_absolute_value の場合分けの式のまま組む（0 <= x なら x、そうでなければ -x）。
# 0 <= x の場合の鎖 0 <= x = |x| と、そうでない場合の鎖 0 = x + (-x) <= 0 + (-x) = -x = |x| の各段を、
# 等号は多項式環 ZZ[x, nx]（nx は -x）のイデアル (x + nx) への所属で、不等号の段は整数の標本で確かめる。
# 帰属: 整数 ZZ と多項式環 ZZ[x, nx]。浮動小数点は使わない。

def abs_cases(x):
    x = ZZ(x)
    return x if 0 <= x else -x

R.<x, nx> = ZZ[]
I_neg = R.ideal([x + nx])                 # 加法の逆元 x + (-x) = 0
# そうでない場合の等号の段: 0 = x + (-x)、0 + (-x) = -x
k = 0
assert (R(0) - (x + nx)) in I_neg; k += 1      # 加法の逆元を右辺から左辺へ
assert R(0) + nx == nx; k += 1                 # 和の単位元 0 + x = x（x -> -x）
# 否定コントロール: 加法の逆元を外すと 0 = x + (-x) は出ない
assert (R(0) - (x + nx)) not in R.ideal([R(0)])

samples = list(range(-40, 41))
m = 0
for a in samples:
    a = ZZ(a)
    if 0 <= a:
        assert 0 <= a and a == abs_cases(a); m += 1              # 場合の仮定、定義の 0 <= x の場合の式
    else:
        assert not (0 <= a)
        assert (0 <= a) or (a <= 0); assert a <= 0; m += 1     # 全順序の左が成り立たないので x <= 0
        assert 0 == a + (-a); m += 1                            # 加法の逆元
        assert a + (-a) <= 0 + (-a); m += 1                     # 順序と加法の両立（t -> -x）
        assert 0 + (-a) == -a; m += 1                           # 和の単位元
        assert -a == abs_cases(a); m += 1                       # 定義の ¬(0 <= x) の場合の式
    assert 0 <= abs_cases(a) and abs_cases(a) == abs(a); m += 1  # 主張と、Sage の abs との一致
# 否定コントロール: 場合分けの二つ目の式を -x でなく x にすると、負の x で主張が崩れる
assert not all(0 <= (ZZ(a) if 0 <= a else ZZ(a)) for a in samples)

print("ZZ[x, nx] で等号の段 %d 個を確かめた。整数の標本 %d 件で各段と主張を確かめた" % (k, m))
print("negative controls (broken lines detected): 2")
print("RESULT: PASS")
