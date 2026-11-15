# 対象ラベル: range_of_args_of_square_of_complex_numbers
# r ≠ 0 の場合の地の文「r ≠ 0 なので r·r ≠ 0」を real_product_of_nonzero_is_nonzero（a → r、b → r）の参照に替えた行を確かめる。
#   代入 a → r、b → r の後の主張: r^{-1}·r = 1 と r·r = 0 のもとで r = 0（すなわち r ≠ 0 なら r·r ≠ 0）。
# 帰属: 多項式環 QQ[ri, r]（ri は r^{-1} の不定元）のイデアルと、QQ・AA の厳密な値。浮動小数点は使わない。
R.<ri, r> = QQ[]
n = 0
assert r in R.ideal([ri * r - 1, r * r]); n += 1      # 主張の a, b に r を代入した形
for v in [QQ(1), QQ(-3), QQ(2)/7, AA(2).sqrt(), AA(1) + AA(5).sqrt()]:
    assert v != 0 and v * v != 0; n += 1               # 半径に取りうる 0 でない値で r·r ≠ 0
# 否定コントロール: r = 0 では r·r = 0（r ≠ 0 の仮定を外すと結論は成り立たない）。
assert QQ(0) * QQ(0) == 0
# 否定コントロール: 逆元の前提を外すと r·r = 0 から r = 0 はイデアルの所属として従わない。
assert r not in R.ideal([r * r])
print("nonzero-radius row of range_of_args_of_square_of_complex_numbers: %d checks" % n)
print("negative controls (broken lines detected): 2")
print("RESULT: PASS")
