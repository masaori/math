# 対象ラベル: def_gamma1_gamma2_of_theta
# 証明の各行を、ℂ の元を表す不定元の多項式として写す（行の表記どおりに組む）。
# 不定元: c1, s1, c2, c2s, s2s = (c_1)_C, (s_1)_C, (c_2)_C, (c_2^*)_C, (s_2^*)_C、
#         co, si = (cos θ)_C, (sin θ)_C、ep = exp(iθ)、em = exp(-iθ)、
#         com, sim = (cos(-θ))_C, (sin(-θ))_C、epm = exp(i(-θ))（-θ での値を θ での値と独立な不定元に置く）。
import sys

Ki = QuadraticField(-1, 'i')          # i ↦ +I に埋め込まれた QQ(i)
i = Ki.gen()
R = PolynomialRing(Ki, 'c1,s1,c2,c2s,s2s,co,si,ep,em,com,sim,epm', order='degrevlex')
c1, s1, c2, c2s, s2s, co, si, ep, em, com, sim, epm = R.gens()

def gamma1_def(Co):
    """本ブロックの γ_1 の定義式を、cos の値 Co で組む。"""
    return c1*c2s - s1*s2s*Co

def gamma2_def(E, Co, Si):
    """本ブロックの γ_2 の定義式を、exp(i・角) = E、cos = Co、sin = Si で組む。"""
    return i*E*s2s*(c1*Co - i*Si - s1*c2)

# 証明の行が (∵ …) で引く事実を、多項式の関係式として持つ（左辺 - 右辺）。
RELATIONS = {
    'i(-θ)=-iθ': epm - em,          # exp(i(-θ)) = exp(-iθ)
    'cos(-θ)=cos θ': com - co,
    'sin(-θ)=-sin θ': sim + si,
}

# def_A_theta の A(θ)（実数の成分を包含の像として読む）
A = matrix(R, 2, 2, [
    c1*c2s - s1*s2s*co,
    i*ep*s2s*(c1*co - i*si - s1*c2),
    -i*em*s2s*(c1*co + i*si - s1*c2),
    c1*c2s - s1*s2s*co,
])

# 鎖: [(式, 引く関係式のリスト)]。最初の行は始点で、関係式は None。
CHAINS = {
    'γ_2(-θ)': [
        (gamma2_def(epm, com, sim), None),                       # 本ブロックの γ_2 の定義式
        (i*em*s2s*(c1*com - i*sim - s1*c2), ['i(-θ)=-iθ']),
        (i*em*s2s*(c1*co - i*sim - s1*c2), ['cos(-θ)=cos θ']),
        (i*em*s2s*(c1*co + i*si - s1*c2), ['sin(-θ)=-sin θ']),
    ],
    'A(θ)_{2,1}': [
        (A[1, 0], None),
        (-(i*em*s2s*(c1*co + i*si - s1*c2)), []),               # 直前の γ_2(-θ) の式の終点の符号反転
    ],
}


class Report:
    def __init__(self, title):
        self.title = title
        self.n = 0
        self.fail = 0
        print("==", title)

    def check(self, ok, label):
        self.n += 1
        if not ok:
            self.fail += 1
        print(("PASS " if ok else "FAIL ") + label)

    def finish(self):
        print(f"-- {self.title}: {self.n - self.fail}/{self.n} PASS")
        if self.fail:
            print("RESULT: FAIL")
            sys.exit(1)
        print("RESULT: PASS")
