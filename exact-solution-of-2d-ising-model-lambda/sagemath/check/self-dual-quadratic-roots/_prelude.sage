# 対象ラベル: claim_self_dual_quadratic_roots
# 帰属: QQbar の厳密計算。浮動小数点は使わない。
sd_ring = PolynomialRing(QQbar, 't')
sd_t = sd_ring.gen()
sd_s_candidates = (sd_t**2 - sd_ring(2)).roots(multiplicities=False)
assert len(sd_s_candidates) == 2
sd_sqrt2 = QQbar(2).sqrt()
sd_i = QQbar(QQ[I].gen())
sd_test_points = [QQbar(0), QQbar(1), QQbar(2), QQbar(-2), QQbar(1)/2,
    QQbar(-1)/3, QQbar(7)/5, sd_sqrt2, sd_sqrt2-1, -QQbar(1)-sd_sqrt2,
    -sd_sqrt2, QQbar(3).sqrt()/2, sd_i, QQbar(2)*sd_i,
    QQbar.zeta(3), QQbar.zeta(8), QQbar.zeta(8)**3]
assert len(sd_test_points) == len(set(sd_test_points)) == 17
sd_line_cases = [(s, xi) for s in sd_s_candidates for xi in sd_test_points]
assert all(s*s == QQbar(2) for s, xi in sd_line_cases)

def sd_inputs(group):
    if group == 'factor':
        return sd_line_cases
    if group == 'root_plus':
        return [(s, xi) for s, xi in sd_line_cases if xi == -1+s]
    if group == 'root_minus':
        return [(s, xi) for s, xi in sd_line_cases if xi == -1-s]
    if group == 'zero_product':
        return [(s, xi) for s, xi in sd_line_cases if xi**2+2*xi-1 == 0]
    if group == 'extract_plus':
        return [(s, xi) for s, xi in sd_line_cases
            if xi**2+2*xi-1 == 0 and (xi+1)-s == 0]
    if group == 'extract_minus':
        return [(s, xi) for s, xi in sd_line_cases
            if xi**2+2*xi-1 == 0 and (xi+1)-s != 0 and (xi+1)+s == 0]
    raise ValueError(group)

sd_expected_cases = {'factor': 34, 'root_plus': 2, 'root_minus': 2,
    'zero_product': 4, 'extract_plus': 2, 'extract_minus': 2}
for sd_group, sd_expected in sd_expected_cases.items():
    assert len(sd_inputs(sd_group)) == sd_expected, sd_group
