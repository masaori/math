# 対象ラベル: range_of_args_of_square_of_complex_numbers
# r ≠ 0 の場合の 2 本の鎖の最後の行 arg(z)+arg(z) = 2arg(z)（と −2π を付けた形）を割った 3 行を、行に書いた形と代入どおりに一行ずつ比べる。
# 帰属: 多項式環 QQ[A, P]（A = arg(z)、P = π の不定元）。浮動小数点は使わない。
# 多項式環は式を正規化するので、形の左右と「右辺から左辺へ」の向きは区別できず、それはレビューの目視で確かめる。
R.<A, P> = QQ[]
one = R(1)
two = one + one                          # def_real_two: 2 := 1 + 1
n = 0
for tail in [R(0), -2*P]:                # 第 1 の場合の鎖と第 2 の場合の鎖（−2π を付けた形）
    rows = [
        A + A + tail,                    # arg(z)+arg(z)
        one*A + one*A + tail,            # 1·x = x（x → A）を 2 箇所へ右辺から左辺へ
        (one + one)*A + tail,            # (x+y)t = xt+yt（x → 1, y → 1, t → A）を右辺から左辺へ
        two*A + tail,                    # def_real_two を右辺から左辺へ
    ]
    for k in range(len(rows) - 1):
        assert rows[k] == rows[k + 1]; n += 1
assert two == 2; n += 1
# 否定コントロール: 1 + 1 を 1 に取り違えると等号は成り立たない。
assert one*A != A + A
print("double-argument rows of range_of_args_of_square_of_complex_numbers: %d checks" % n)
print("negative controls (broken lines detected): 1")
print("RESULT: PASS")
