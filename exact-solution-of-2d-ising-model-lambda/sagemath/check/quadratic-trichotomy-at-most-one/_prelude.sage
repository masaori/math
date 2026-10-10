# 対象ラベル: claim_quadratic_trichotomy_at_most_one
# QQ の全標本と、二次体の二通りの生成元による零の表示を厳密に計算する。
_qtm_values = sorted({QQ(n) / QQ(d) for n in range(-6, 7) for d in range(1, 4)})
assert len(_qtm_values) == 27
_qtm_pairs = [(a, b) for a in _qtm_values for b in _qtm_values]
_qtm_polynomials = PolynomialRing(QQ, 't')
_qtm_field = NumberField(_qtm_polynomials.gen()**2 - 2, 'r')
_qtm_generator = _qtm_field.gen()


def _qtm_representation(value, orientation):
    polynomial = value.polynomial()
    return QQ(polynomial[0]), QQ(orientation) * QQ(polynomial[1])


def _qtm_zero_rows():
    for orientation in (1, -1):
        root = orientation * _qtm_generator
        assert root * root == 2
        xi = _qtm_field(0)
        a, b = _qtm_representation(xi, orientation)
        assert _qtm_field(a) + _qtm_field(b) * root == xi
        zero = QQ(0)
        chain = (
            _qtm_representation(-xi, orientation), (-a, -b),
            (-zero, -zero), (zero, -zero), (zero, zero))
        assert all(q.parent() is QQ for pair in chain for q in pair)
        yield list(zip(chain, chain[1:]))


def _qtm_rows(a, b):
    two = QQ(2)
    pair = (
        (-a, -b) != (0, 0), not (-a == 0 and -b == 0),
        not (a == 0 and -b == 0), not (a == 0 and b == 0), (a, b) != (0, 0))
    second = (
        (two * (-b)) * (-b) < (-a) * (-a),
        two * ((-b) * (-b)) < (-a) * (-a),
        two * (b * b) < (-a) * (-a), two * (b * b) < a * a)
    third = (
        (-a) * (-a) < (two * (-b)) * (-b),
        a * a < (two * (-b)) * (-b),
        a * a < two * ((-b) * (-b)), a * a < two * (b * b))
    return {
        'sign': [
            (0 <= -a, a <= 0), (0 <= -b, b <= 0),
            (0 < -a, a < 0), (-b < 0, 0 < b),
            (-a < 0, 0 < a), (0 < -b, b < 0)],
        'pair': list(zip(pair, pair[1:])),
        'second': list(zip(second, second[1:])),
        'third': list(zip(third, third[1:])),
        'associate': [
            (two * (b * b), (two * b) * b),
            ((two * b) * b, two * (b * b))],
    }


def _qtm_check(section, index, label):
    rows = list(_qtm_zero_rows()) if section == 'zero' else [
        _qtm_rows(a, b)[section] for a, b in _qtm_pairs]
    count = 0
    for row in rows:
        left, right = row[index]
        assert left == right, (label, left, right)
        count += 1
    assert count == (2 if section == 'zero' else 729)
    print('RESULT: PASS (%s: %d 行)' % (label, count))
