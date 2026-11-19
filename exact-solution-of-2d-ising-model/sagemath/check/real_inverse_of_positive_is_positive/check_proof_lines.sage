# 対象ラベル: real_inverse_of_positive_is_positive
# 0 < a のとき 0 < a^{-1} を示す証明の各行を確かめる。
# a^{-1} を不定元 b、−a^{-1} を nb、−1 を n に置き（a·a^{-1} = 1、加法の逆元、(−1)·a^{-1} = −a^{-1} を前提にしないため）、
# 前提を使う段は、その前提が生成するイデアルに差が入ることとして確かめる。
# 不等号の段（順序と加法の両立、正の数どうしの積は正、推移律）は、両辺の差の形と、有理数の標本で公理の形が成り立つことで確かめる
# （場合の仮定 a^{-1} < 0 は ℝ では起きないので、鎖の不等号を値で確かめることはできず、段の形だけを確かめる）。
# 帰属: 多項式環 QQ[a, b, nb, n] とそのイデアル、有理数 QQ、代数的実数 AA。浮動小数点は使わない。

R.<a, b, nb, n> = QQ[]
I_inv = R.ideal([a * b - 1])                       # a の乗法の逆元 a·a^{-1} = 1
I_neg_b = R.ideal([b + nb])                        # def_real_difference の加法の逆元 a^{-1} + (−a^{-1}) = 0
I_neg_1 = R.ideal([1 + n])                         # def_real_difference の加法の逆元 1 + (−1) = 0
I_m1 = R.ideal([n * b - nb])                       # real_minus_one_times_is_negation（a → a^{-1}）
I_all = I_inv + I_neg_b + I_neg_1 + I_m1

k = 0
# a^{-1} ≠ 0 を示す鎖: 1 = a·a^{-1} = a·0 = 0（仮定 a^{-1} = 0）
assert (R(1) - a * b) in I_inv; k += 1                       # 逆元を右辺から左辺へ
assert (a * b - a * 0) in R.ideal([b]); k += 1               # 仮定 a^{-1} = 0
assert a * 0 == R(0); k += 1                                 # real_times_zero_is_zero（x → a）
# 第 1 の鎖: 0 = a^{-1} + (−a^{-1}) < 0 + (−a^{-1}) = −a^{-1}
assert (R(0) - (b + nb)) in I_neg_b; k += 1                  # 加法の逆元（z → a^{-1}）を右辺から左辺へ
assert ((b + nb) - (0 + nb)) == b - R(0); k += 1             # 順序と加法の両立: 差は x − y = a^{-1} − 0 で、同じ c = −a^{-1} を足しただけ
assert (0 + nb) == nb; k += 1                                # 加法の単位元
# 第 2 の鎖: 0 < a·(−a^{-1}) = a·((−1)·a^{-1}) = (a·(−1))·a^{-1} = ((−1)·a)·a^{-1} = (−1)·(a·a^{-1}) = (−1)·1 = −1
chain2 = [a * nb, a * (n * b), (a * n) * b, (n * a) * b, n * (a * b), n * 1, n]
assert (chain2[0] - chain2[1]) in I_m1; k += 1               # real_minus_one_times_is_negation（a → a^{-1}）を右辺から左辺へ
assert chain2[1] == chain2[2]; k += 1                        # 乗法の結合律
assert chain2[2] == chain2[3]; k += 1                        # 乗法の可換律
assert chain2[3] == chain2[4]; k += 1                        # 乗法の結合律
assert (chain2[4] - chain2[5]) in I_inv; k += 1              # 逆元 a·a^{-1} = 1
assert chain2[5] == chain2[6]; k += 1                        # real_minus_one_times_is_negation（a → 1）: (−1)·1 = −1
# 第 3 の鎖: 1 = 0 + 1 < (−1) + 1 = 1 + (−1) = 0
assert R(1) == 0 + R(1); k += 1                              # 加法の単位元を右辺から左辺へ
assert ((0 + R(1)) - (n + 1)) == R(0) - n; k += 1            # 順序と加法の両立: 差は x − y = 0 − (−1) で、同じ c = 1 を足しただけ
assert (n + 1) == (1 + n); k += 1                            # 加法の可換律
assert (1 + n) in I_neg_1; k += 1                            # 加法の逆元（z → 1）
# 第 2 の鎖の両端は、前提をすべて合わせたイデアルのもとで −1 に等しい（鎖全体の裏取り）。
assert (chain2[0] - n) in I_all; k += 1

# 不等号の段の公理の形を有理数の標本で確かめる。
vals = [QQ(-3), QQ(-1)/2, QQ(0), QQ(2)/7, QQ(5)]
m = 0
for x in vals:
    for y in vals:
        if x < y:
            for c in vals:
                assert x + c < y + c; m += 1                 # 順序と加法の両立
            for z in vals:
                if y < z:
                    assert x < z; m += 1                     # 推移律
for x in vals:
    for y in vals:
        if x > 0 and y > 0:
            assert x * y > 0; m += 1                         # 正の数どうしの積は正

# 主張: 0 < a ⇒ 0 < a^{-1}（QQ と AA の正の標本で）。準備の a ≠ 0 も。
samples = [QQ(1)/3, QQ(1), QQ(2), QQ(7)/5]
s = 0
for q in samples:
    assert q != 0 and q * q^(-1) == 1 and q^(-1) > 0; s += 1
    assert AA(q)^(-1) > 0; s += 1
assert AA(2).sqrt()^(-1) > 0; s += 1

# 否定コントロール: 逆元の前提を外すと 1 = a·a^{-1} は成り立たない。
assert (R(1) - a * b) not in R.ideal([b + nb, 1 + n, n * b - nb])
# 否定コントロール: real_minus_one_times_is_negation と a^{-1} の加法の逆元の前提を外すと a·(−a^{-1}) = a·((−1)·a^{-1}) は成り立たない
# （2 つの前提はどちらも −a^{-1} = (−1)·a^{-1} を含意するので、両方を外す）。
assert (chain2[0] - chain2[1]) not in I_inv + I_neg_1
# 否定コントロール: 0 < a を外すと主張は偽（a = −2 で a^{-1} < 0）。
assert QQ(-2)^(-1) < 0

print("QQ[a, b, nb, n] で証明の等号の段 %d 個を確かめた。不等号の段の公理の形を有理数の標本 %d 件で、主張を標本 %d 件で確かめた" % (k, m, s))
print("negative controls (broken lines detected): 3")
print("RESULT: PASS")
