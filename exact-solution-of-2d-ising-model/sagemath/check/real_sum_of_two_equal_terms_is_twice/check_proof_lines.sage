# 対象ラベル: real_sum_of_two_equal_terms_is_twice
# a + a = 2·a の 3 行の鎖を一行ずつ確かめる。
# a を多項式環 QQ[a] の不定元に置き、2 は def_real_two の 1 + 1 を QQ の 2 として確かめる。
# 帰属: QQ[a] と QQ。浮動小数点は使わない。

R.<a> = QQ[]
one = R(1)

L1 = a + a                  # a + a
L2 = one*a + one*a          # 乗法の単位元 1·x = x（x → a）を右辺から左辺へ 2 か所に同時適用
L3 = (one + one)*a          # 分配則 (x+y)t = xt+yt（x → 1、y → 1、t → a）を右辺から左辺へ
L4 = 2*a                    # def_real_two の 2 := 1 + 1 を右辺から左辺へ

assert L1 == L2
assert L2 == L3
assert L3 == L4
# 証明の 3 行目の根拠: def_real_two の 1 + 1 = 2。
assert QQ(1) + QQ(1) == QQ(2)
# 鎖の両端を a の有理数の値で QQ の値として確かめる。
for av in [QQ(0), QQ(1), QQ(-3), QQ(7)/5]:
    assert L1.subs(a=av) == L4.subs(a=av) == 2*av
# 否定コントロール: 証明の 2 行目の 1 + 1 を 1 にすると（1·a）、隣の行 a + a = 1·a + 1·a と等しくない。
assert one*a != L2
# 否定コントロール: 証明の 3 行目の 2 を 3 にすると、隣の行 (1 + 1)·a と等しくない。
assert 3*a != L3

print("QQ[a] で恒等的な段 3 個と、根拠 1 + 1 = 2、a の値での両端 4 組を確かめた")
print("negative controls (broken lines detected): 2")
print("RESULT: PASS")
