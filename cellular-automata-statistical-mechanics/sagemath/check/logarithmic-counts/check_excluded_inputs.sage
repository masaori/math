# 対象ラベル: def_prime_logarithm
# 式ペア・判定: 零・負有理数と零除算を拒否
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for q in (QQ(0), QQ(-1), QQ(-2)/3):
    for call in (lambda: logarithm(q), lambda: valuation(q,ZZ(2)), lambda: divide(0,{})):
        try:
            call()
        except ValueError:
            pass  # 指定した負入力の拒否を確認する。
        else:
            raise AssertionError('input outside domain accepted')
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
