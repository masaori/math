# 第二双対結合関係の人手証明に現れる各等号を、高精度実数で一行ずつ照合する。
# 実対数を使う証明なので、この検査は「実対数による R 脱出」後の数値検査である。
RF = RealField(200)
K2_VALUES = [RF('0.05'), RF('0.1'), RF('0.2'), RF('0.3'), RF('0.4407'),
             RF('0.6'), RF('0.9'), RF('1.3'), RF('2.0'), RF('3.0')]
TOLERANCE = RF(2) ** (-150)

def second_dual_coupling(k):
    return -log(tanh(k)) / RF(2)

def check_pair(left, right, label):
    max_relative_error = RF(0)
    for k in K2_VALUES:
        left_value = RF(left(k))
        right_value = RF(right(k))
        scale = max(RF(1), abs(left_value), abs(right_value))
        relative_error = abs(left_value - right_value) / scale
        max_relative_error = max(max_relative_error, relative_error)
        if relative_error > TOLERANCE:
            print('MISMATCH: %s, K2=%s, relative error=%s' % (label, k, relative_error))
            print('RESULT: FAIL')
            import sys
            sys.exit(1)
    print('%s: max relative error = %s' % (label, max_relative_error))
    print('RESULT: PASS')
