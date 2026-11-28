# 対象ラベル: real_square_is_nonnegative
# 実数の二乗は 0 以上であることの証明の各行を確かめる。
# 0 <= r の場合の鎖 0 <= r r = r^2 と、そうでない場合の鎖 0 = r + (-r) <= 0 + (-r) = -r と 0 <= (-r)(-r) = r r = r^2 の各段を、
# 等号は多項式環 QQ[r, nr]（nr は -r）のイデアル (r + nr) への所属で、不等号の段は有理数の標本で確かめる。
# 帰属: 有理数 QQ と多項式環 QQ[r, nr]。浮動小数点は使わない。

R.<r, nr> = QQ[]
I_neg = R.ideal([r + nr])                 # 加法の逆元 r + (-r) = 0
k = 0
assert r*r - r^2 == 0; k += 1                          # square_of_real_number_is_product を右辺から左辺へ
assert (R(0) - (r + nr)) in I_neg; k += 1              # 加法の逆元を右辺から左辺へ
assert R(0) + nr == nr; k += 1                         # 加法の単位元 0 + x = x（x -> -r）
assert (nr*nr - r*r) in I_neg; k += 1                  # real_negation_times_negation_is_product（a -> r, b -> r）
# 否定コントロール: 加法の逆元を外すと (-r)(-r) = r r は出ない
assert (nr*nr - r*r) not in R.ideal([R(0)])

samples = [QQ(a)/b for a in range(-30, 31) for b in [1, 2, 7]]
m = 0
for a in samples:
    if 0 <= a:
        assert 0 <= a*a and a*a == a^2; m += 1                    # 順序と乗法の両立、square_of_real_number_is_product
    else:
        assert not (0 <= a)
        assert (0 <= a) or (a <= 0); assert a <= 0; m += 1       # 全順序の左が成り立たないので r <= 0
        assert 0 == a + (-a) and a + (-a) <= 0 + (-a) and 0 + (-a) == -a; m += 1   # 0 = r + (-r) <= 0 + (-r) = -r
        assert 0 <= (-a)*(-a) and (-a)*(-a) == a*a and a*a == a^2; m += 1          # 0 <= (-r)(-r) = r r = r^2
    assert 0 <= a^2; m += 1                                       # 主張
# 否定コントロール: 符号反転どうしの積の段を (-r) r に取り違えると、負の r で 0 以上が崩れる
assert not all(0 <= (-a)*a for a in samples if a < 0)

print("QQ[r, nr] で等号の段 %d 個を確かめた。有理数の標本 %d 件で各段と主張を確かめた" % (k, m))
print("negative controls (broken lines detected): 2")
print("RESULT: PASS")
