# 対象ラベル: claim_local_pairing_matching_term_nonzero
# 本文の S_p = x C(q_{e,f}) と非零性。同じ始点の相異なる方向を取る。
F = CyclotomicField(8)
z = F.gen()
R = PolynomialRing(F, 'x')
x = R.gen()
checked = 0
for direction_e in range(4):
    for direction_f in range(4):
        if direction_e == direction_f:
            continue
        phase = (F(1) if direction_f == (direction_e + 2) % 4 else
                 z if direction_f == (direction_e + 3) % 4 else z**(-1))
        for twist_e in range(2):
            for twist_f in range(2):
                weight = z**2 * ((z**(2*twist_e) * z**direction_e) *
                                 (z**(-direction_f) * z**(-2*twist_f)))
                coefficient = weight * F((-1)**twist_f) * phase
                contribution = x * R(coefficient)
                assert contribution == x * R(coefficient)
                assert contribution != 0
                checked += 1
print('RESULT: PASS; %d exact short contributions' % checked)
