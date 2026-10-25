# 対象ラベル: claim_short_pair_rotation_phase_nonzero
# 原始八乗根の四乗と三つの位相の非零性を厳密計算する。
F = CyclotomicField(8)
z = F.gen()
assert z**4 == -1
assert z != 0
assert z**(-1) != 0
assert all(phase != 0 for phase in (F(1), z, z**(-1)))
print('RESULT: PASS; all three phases are nonzero')
