# 対象ラベル: real_zero_less_than_two
# 準備の鎖 1 = 0 + 1 < 1 + 1 = 2 と、本体 0 < 1 ∧ 1 < 2 ⇒ 0 < 2 を確かめる。
# def_real_two の 2 を不定元 t に置き（1 + 1 = 2 を前提にしないため）、
# 定義を使う段は、その前提が生成するイデアル (t − 2) に差が入ることとして確かめる。
# 不等号の段（順序と加法の両立、推移律）は、両辺の差が当てた c によらないこと、
# および有理数の標本で公理の形が成り立つことで確かめる。
# 帰属: 多項式環 QQ[t] とそのイデアル、有理数 QQ、代数的実数 AA。浮動小数点は使わない。

R.<t> = QQ[]
I_two = R.ideal([t - (1 + 1)])     # def_real_two の 2 := 1 + 1（2 を t と書く）

chain = [
    R(1),       # 鎖の左辺 1
    0 + R(1),   # 加法の単位元を右辺から左辺へ
    R(1) + 1,   # 0 < 1 と順序と加法の両立（x → 0, y → 1, c → 1）
    t,          # def_real_two を右辺から左辺へ
]

k = 0
assert chain[0] == chain[1]; k += 1                         # 1 段目は恒等的
c = R(1)
assert chain[1] == R(0) + c and chain[2] == R(1) + c; k += 1   # 2 段目: x → 0, y → 1 の両辺に同じ c = 1 を足した形
assert (chain[2] - chain[3]) in I_two; k += 1               # 3 段目は 2 := 1 + 1 のもとで等しい
# 不等号の段の公理の形を有理数の標本で確かめる。
vals = [QQ(-3), QQ(-1)/2, QQ(0), QQ(2)/7, QQ(1), QQ(5)]
m = 0
for x in vals:
    for y in vals:
        if x < y:
            for c in vals:
                assert x + c < y + c; m += 1                # 順序と加法の両立
            for z in vals:
                if y < z:
                    assert x < z; m += 1                    # 推移律
# 鎖の値と主張: 1 < 2、0 < 1、0 < 2（QQ と AA のそれぞれで。2 は 1 + 1 として組む）。
two_q = QQ(1) + QQ(1)
assert QQ(1) < two_q and QQ(0) < QQ(1); k += 1
assert QQ(0) < two_q; k += 1
two_a = AA(1) + AA(1)
assert AA(1) < two_a and AA(0) < AA(1) and AA(0) < two_a; k += 1
# 否定コントロール: 定義の前提を外すと 1 + 1 = t は恒等的な等号ではない。
assert chain[2] != chain[3]
# 否定コントロール: 2 を 1 + 0 と取り違えると 1 < 2 の段が崩れる。
assert not (QQ(1) < QQ(1) + QQ(0))
# 否定コントロール: 推移律を誤って当てる（x < y かつ z < y から x < z）と偽になる組がある。
assert QQ(0) < two_q and QQ(1) < two_q and not (QQ(1) < QQ(0))

print("QQ[t] で準備の鎖の 3 段を、QQ・AA で主張を確かめた（計 %d 個）。不等号の段の公理の形を有理数の標本 %d 件で確かめた" % (k, m))
print("negative controls (broken lines detected): 3")
print("RESULT: PASS")
