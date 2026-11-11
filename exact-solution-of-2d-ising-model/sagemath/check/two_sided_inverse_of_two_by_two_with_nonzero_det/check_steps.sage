# two_sided_inverse_of_two_by_two_with_nonzero_det（det B ≠ 0 なら h := (det B)^{-1} adj B は Bh = I かつ hB = I）の検算。
# (1) 有理関数体 QQ(B11, B12, B21, B22) の上で、証明の 2 本の 6 行の鎖の各行が一致すること。
# (2) 成分が QQ[i]（ガウス有理数）の 2×2 行列の全数（成分の実部・虚部 ∈ {-1,0,1}）で、det ≠ 0 のものについて Bh = hB = I、
#     det = 0 のものについては Bh = 0 で h が逆元にならない（h を作れない側の確認）こと。
# diagonalization_check_P_D の Step 4 はこの主張を B → P̌_μ で引く（P̌_μ の det ≠ 0 は 048_claim_A_theta_tilde/check_07 が確かめる）。
# 浮動小数点は使わない。

F = FractionField(PolynomialRing(QQ, 'B11, B12, B21, B22'))
B11, B12, B21, B22 = F.gens()
B = matrix(F, [[B11, B12], [B21, B22]])
adjB = matrix(F, [[B22, -B12], [-B21, B11]])          # def_adjugate_two_by_two
detB = B11*B22 - B12*B21                              # def_det_two_by_two
I2 = identity_matrix(F, 2)
dinv = 1 / detB                                       # multiplicative_group_of_cc の逆元（det B ∈ ℂ^×）
h = dinv * adjB

right = [B*h, B*(dinv*adjB), dinv*(B*adjB), dinv*(detB*I2), (dinv*detB)*I2, 1*I2, I2]
left = [h*B, (dinv*adjB)*B, dinv*(adjB*B), dinv*(detB*I2), (dinv*detB)*I2, 1*I2, I2]
assert all(t == right[0] for t in right), "Bh"
assert all(t == left[0] for t in left), "hB"
print("Bh の鎖 6 行・hB の鎖 6 行: 有理関数体で一致")

K.<i> = QuadraticField(-1)
vals = [a + b*i for a in (-1, 0, 1) for b in (-1, 0, 1)]
import itertools
n_inv = n_sing = 0
for e in itertools.product(vals, repeat=4):
    Bm = matrix(K, 2, 2, list(e))
    d = Bm[0,0]*Bm[1,1] - Bm[0,1]*Bm[1,0]
    adj = matrix(K, [[Bm[1,1], -Bm[0,1]], [-Bm[1,0], Bm[0,0]]])
    if d != 0:
        hm = d^(-1) * adj
        assert Bm*hm == 1 and hm*Bm == 1 and hm == Bm.inverse()
        n_inv += 1
    else:
        assert Bm*adj == 0 and adj*Bm == 0
        n_sing += 1
print("QQ[i] の全数", n_inv + n_sing, "個: det ≠ 0 の", n_inv, "個で Bh = hB = I（Sage の逆行列とも一致）、det = 0 の", n_sing, "個で B adj B = 0")

# 否定コントロール: (det B)^{-1} を掛けないと I にならない
assert B*adjB != I2
print("否定コントロール: adj B だけでは B adj B ≠ I")
print("ALL PASS")
