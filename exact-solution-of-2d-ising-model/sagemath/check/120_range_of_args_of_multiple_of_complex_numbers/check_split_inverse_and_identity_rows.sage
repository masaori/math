# 対象ラベル: range_of_args_of_multiple_of_complex_numbers
# 2π ≤ θ_1+θ_2−2(n_1+n_2)π < 4π の場合の鎖の 1 行目「ℝ の加法の逆元と単位元」を割った 5 行を、行に書いた形と代入どおりに一行ずつ比べる。
# 帰属: 多項式環 QQ[A1, A2, P]（A1 = arg(z_1)、A2 = arg(z_2)、P = π の不定元）。浮動小数点は使わない。
# 多項式環は式を正規化するので、形の左右・括弧の付け方・「右辺から左辺へ」の向きは区別できず、それはレビューの目視で確かめる。
R.<A1, A2, P> = QQ[]
S = A1 + A2
T = 2*P
neg = lambda z: -z
diff = lambda y, t: y + neg(t)          # def_real_difference: y − t = y + (−t)
rows = [
    S,                                   # arg(z_1)+arg(z_2)
    S + 0,                               # x + 0 = x（x → S）を右辺から左辺へ
    S + (T + neg(T)),                    # t + (−t) = 0（t → 2π）を右辺から左辺へ
    S + (neg(T) + T),                    # x + y = y + x（x → 2π, y → −2π）
    (S + neg(T)) + T,                    # (x+y)+t = x+(y+t)（x → S, y → −2π, t → 2π）を右辺から左辺へ
    diff(S, T) + T,                      # y − t = y + (−t)（y → S, t → 2π）を右辺から左辺へ
]
n = 0
for k in range(len(rows) - 1):
    assert rows[k] == rows[k + 1]; n += 1
# 根拠の等式そのもの
assert T + neg(T) == 0; n += 1
assert diff(S, T) == S - T; n += 1
# 否定コントロール: 逆元の符号を落とすと等号は成り立たない。
assert S + (T + T) != S
print("split inverse/identity rows of range_of_args_of_multiple_of_complex_numbers: %d checks" % n)
print("negative controls (broken lines detected): 1")
print("RESULT: PASS")
