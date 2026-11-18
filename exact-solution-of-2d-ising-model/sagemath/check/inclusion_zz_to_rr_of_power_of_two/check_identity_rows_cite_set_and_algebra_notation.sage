# 対象ラベル: inclusion_zz_to_rr_of_power_of_two
# 帰納段の鎖の 2 行の根拠を set_and_algebra_notation の参照に替えた:
#   ι(2_ℤ^M·1 + 2_ℤ^M·1) = ι(2_ℤ^M + 2_ℤ^M)（ℤ の x ·_ℤ 1_ℤ = x、x → 2_ℤ^M、2 箇所へ）
#   2_ℝ^M + 2_ℝ^M = 2_ℝ^M 1_ℝ + 2_ℝ^M 1_ℝ（ℝ の x 1_ℝ = x、x → 2_ℝ^M、2 箇所へ右辺から左辺へ）
# 2^M を不定元に置いた ZZ[P]・QQ[Q] と、M = 0..12 の値で確かめる（厳密。ℝ の側の値は QQ に入る）。
RZ.<P> = ZZ[]
RQ.<Q> = QQ[]
n = 0
assert P*1 + P*1 == P + P; n += 1
assert Q + Q == Q*QQ(1) + Q*QQ(1); n += 1
for M in range(13):
    pz = ZZ(2)^M; pq = QQ(2)^M
    assert pz*1 + pz*1 == pz + pz; n += 1
    assert pq + pq == pq*QQ(1) + pq*QQ(1); n += 1
# 否定コントロール: 単位元を取り違えると等号は成り立たない。
assert P*0 + P*0 != P + P and Q + Q != Q*QQ(2) + Q*QQ(2)
print("identity rows of inclusion_zz_to_rr_of_power_of_two: %d checks" % n)
print("negative controls (broken lines detected): 2")
print("RESULT: PASS")
