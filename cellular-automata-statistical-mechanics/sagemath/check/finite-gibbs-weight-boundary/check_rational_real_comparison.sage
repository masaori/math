# 対象ラベル: def_rational_transition_real_comparison
# 併せて検証: def_single_cell_identity_rational_transition_weight
# 式ペア: K(x_a,x_b) in QQ_prob を標準単射で実数へ送り、零と一および順序を保つ。
# 帰属: QQ、実代数的数体 AA。AA への標準埋め込みの後に AA -> RR を合成すれば本文の標準実数像になる。
# 浮動小数点、実対数、指数関数、除算、極限は使わない。
identity_kernel = (
    (QQ(1), QQ(0)),
    (QQ(0), QQ(1)),
)

entry_count = ZZ(0)
for row in identity_kernel:
    for rational_weight in row:
        real_algebraic_image = AA(rational_weight)
        assert AA(0) <= real_algebraic_image
        assert real_algebraic_image <= AA(1)
        assert real_algebraic_image == rational_weight
        entry_count += 1

assert AA(identity_kernel[0][1]) == AA(0)
assert entry_count == ZZ(4)
print('rational transition entries embedded exactly:', entry_count)
print('RESULT: PASS')
