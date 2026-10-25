# 対象ラベル: claim_short_pair_coefficient_nonzero
# 本文の三因子を円分体で厳密に調べる。辺長によらない方向表を使う。
F = CyclotomicField(8)
z = F.gen()
assert z**4 == -1

checked = 0
for re in range(4):
    for rf in range(4):
        if re == rf:
            continue
        reverse_dir = (re + 2) % 4
        phase = (F(1) if rf == reverse_dir else
                 z if rf == (reverse_dir + 1) % 4 else z**(-1))
        for ke in range(2):
            for kf in range(2):
                weight = z**2 * ((z**(2*ke) * z**re) *
                                 (z**(-rf) * z**(-2*kf)))
                twist = F((-1)**kf)
                assert weight != 0
                assert twist != 0
                assert phase != 0
                assert weight * twist != 0
                assert (weight * twist) * phase != 0
                checked += 1
print("RESULT: PASS; %d exact short-pair coefficients" % checked)
