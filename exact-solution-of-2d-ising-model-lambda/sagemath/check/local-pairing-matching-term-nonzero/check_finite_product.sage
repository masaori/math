# 対象ラベル: claim_local_pairing_matching_term_nonzero
# 各長い寄与・短い寄与・符号と有限積の非零性を円分体上で厳密に検算する。
F = CyclotomicField(8)
z = F.gen()
R = PolynomialRing(F, 'x')
x = R.gen()
assert z**4 == -1

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
                long_factor = R(weight)
                short_coefficient = weight * F((-1)**twist_f) * phase
                short_factor = x * R(short_coefficient)
                assert long_factor != 0
                assert short_coefficient != 0
                assert short_factor != 0
                for short_count in range(3):
                    for long_count in range(3):
                        sign = F((-1)**(short_count + long_count))
                        term = R(sign) * (-1)**short_count * long_factor**long_count * short_factor**short_count
                        assert term != 0
                        checked += 1
print('RESULT: PASS; %d exact labelled finite products' % checked)
