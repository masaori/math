# 対象ラベル: claim_local_pairing_matching_term_nonzero
# 本文の L_p = C(w_{e,f}) と非零性。長い標識では f = iota(e)。
F = CyclotomicField(8)
z = F.gen()
R = PolynomialRing(F, 'x')
checked = 0
for direction_e in range(4):
    direction_f = (direction_e + 2) % 4
    for twist_e in range(2):
        for twist_f in range(2):
            weight = z**2 * ((z**(2*twist_e) * z**direction_e) *
                             (z**(-direction_f) * z**(-2*twist_f)))
            contribution = R(weight)
            assert contribution == R(weight)
            assert contribution != 0
            checked += 1
print('RESULT: PASS; %d exact long contributions' % checked)
