# 対象ラベル: int_absolute_value_zero_implies_zero
# 絶対値が 0 の整数は 0 であることの証明の各行を確かめる。
# 絶対値は def_int_absolute_value の場合分けの式のまま組む（0 <= x なら x、そうでなければ -x）。
# 0 <= x の場合の鎖 x = |x| = 0 と、そうでない場合の準備 -x = |x| = 0 と鎖 x = x + 0 = x + (-x) = 0 の各段を確かめる。
# 仮定に依らない段（場合分けの式、和の単位元、加法の逆元）は全ての整数の標本と多項式環 ZZ[x] で、
# 仮定 |x| = 0 を使う段は、多項式環 ZZ[x, nx]（nx は -x を表す変数）でイデアル (nx) への所属として確かめる。
# 帰属: 整数 ZZ と多項式環 ZZ[x]・ZZ[x, nx]。浮動小数点は使わない。

def abs_cases(x):
    x = ZZ(x)
    return x if 0 <= x else -x

# 仮定に依らない段: ZZ[x] の恒等式
P.<x> = ZZ[]
k = 0
assert x + P(0) == x; k += 1                      # 和の単位元 x + 0 = x
assert x + (-x) == P(0); k += 1                   # 加法の逆元 x + (-x) = 0

# 仮定 -x = 0（準備の結論）を使う段: x + 0 = x + (-x) は、nx を -x の変数としてイデアル (nx) に入る
R.<x, nx> = ZZ[]
assert ((x + R(0)) - (x + nx)) in R.ideal([nx]); k += 1
# 否定コントロール: -x = 0 を使わずに x + 0 = x + (-x) は出ない
assert ((x + R(0)) - (x + nx)) not in R.ideal([R(0)])

samples = list(range(-40, 41))
m = 0
for a in samples:
    a = ZZ(a)
    # 仮定に依らない段を全ての標本で確かめる
    if 0 <= a:
        assert a == abs_cases(a); m += 1          # 定義の 0 <= x の場合の式を右辺から左辺へ
    else:
        assert -a == abs_cases(a); m += 1         # 定義の ¬(0 <= x) の場合の式を右辺から左辺へ
        assert a == a + 0 and a + (-a) == 0; m += 1   # 和の単位元、加法の逆元
    # 仮定 |x| = 0 を満たす標本では鎖の終わりまで確かめる
    if abs_cases(a) == 0:
        assert a == abs_cases(a) == 0; m += 1     # x = |x| = 0
        assert a == 0; m += 1                     # 主張
# 標本のうち仮定 |x| = 0 を満たすのは x = 0 だけで、主張は空でない
assert [a for a in samples if abs_cases(a) == 0] == [0]
# 否定コントロール: 場合分けの二つ目の式を -x でなく 0 にすると、負の x で仮定が成り立ち主張が崩れる
assert any((ZZ(a) if 0 <= a else ZZ(0)) == 0 and a != 0 for a in samples)

print("ZZ[x]・ZZ[x, nx] で等号の段 %d 個を確かめた。整数の標本で各段と主張を %d 件確かめた" % (k, m))
print("negative controls (broken lines detected): 2")
print("RESULT: PASS")
