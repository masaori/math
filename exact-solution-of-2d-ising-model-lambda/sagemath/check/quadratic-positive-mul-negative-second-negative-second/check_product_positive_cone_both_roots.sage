# 対象ラベル: claim_quadratic_positive_mul_negative_second_negative_second
# 実際の二次数体で s の両根について積を作り、rep_s を復元して正錐所属を検査する。
import os
_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, '_prelude.sage'))
T = PolynomialRing(QQ, 'z')
z = T.gen()
K = NumberField(z*z-2, 'theta')
theta = K.gen()
checked = 0
for a,u,ap,up,b,bp,A,B,V,D in rational_cases():
    for root_sign in [QQ(1),QQ(-1)]:
        s = root_sign*theta
        xi,eta = K(a)+K(b)*s,K(ap)+K(bp)*s
        value = xi*eta
        actualA,actualB = QQ(value[0]),QQ(value[1])/root_sign
        assert (actualA,actualB)==(A,B)
        assert actualA>0 and actualB<0 and 2*(actualB*actualB)<actualA*actualA
        checked += 1
assert checked == 90738
print(f'RESULT: PASS ({checked} products, both quadratic roots)')
