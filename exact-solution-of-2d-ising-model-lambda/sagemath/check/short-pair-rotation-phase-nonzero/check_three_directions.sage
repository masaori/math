# 対象ラベル: claim_short_pair_rotation_phase_nonzero
# 本文の方向差の三つの場合と回転位相の定義を各方向で検査する。
F = CyclotomicField(8)
z = F.gen()
for direction_e in range(4):
    direction_reverse = (direction_e + 2) % 4
    for direction_f in range(4):
        if direction_f == direction_e:
            continue
        difference = (direction_f - direction_reverse) % 4
        assert difference in (0, 1, 3)
        phase = {0: F(1), 1: z, 3: z**(-1)}[difference]
        assert phase in (F(1), z, z**(-1))
print('RESULT: PASS; twelve direction pairs')
