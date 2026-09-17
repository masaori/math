R = RealIntervalField(200)

positive_couplings = [
    R(1) / 100,
    R(1) / 5,
    R(4407) / 10000,
    R(1),
    R(5),
]


def assert_strictly_positive(value, label):
    if not value.lower() > 0:
        print('RESULT: FAIL')
        raise AssertionError('{} is not strictly positive: {}'.format(label, value))


def report_pass(label, count):
    print('{}: {} interval assertions'.format(label, count))
    print('RESULT: PASS')
