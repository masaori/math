# 対象ラベル: factorization_of_A_theta_general
# 証明の各行を、ℂ の元を表す不定元の多項式として写す（行の表記どおりに組む）。
# 不定元: a=(cosh K_1)_C, b=(sinh K_1)_C, C=(cosh 2K_2^*)_C, S=(sinh 2K_2^*)_C, ep=e_+, em=e_- = exp((-i)(θ)_C),
#         emn=exp(-(i(θ)_C))（euler_formula_cos_sin の読みの -iθ = -(iθ)）,
#         co=(cos θ)_C, si=(sin θ)_C, c1, s1, c2, c2s, s2s = (c_1)_C, (s_1)_C, (c_2)_C, (c_2^*)_C, (s_2^*)_C。
import sys

Ki = QuadraticField(-1, 'i')          # i ↦ +I に埋め込まれた QQ(i)
i = Ki.gen()
R = PolynomialRing(Ki, 'a,b,C,S,ep,em,emn,co,si,c1,s1,c2,c2s,s2s', order='degrevlex')
a, b, C, S, ep, em, emn, co, si, c1, s1, c2, c2s, s2s = R.gens()

# 証明の行が (∵ …) で引く事実を、多項式の関係式として持つ（左辺 - 右辺）。
RELATIONS = {
    'a2+b2=c1': a**2 + b**2 - c1,                 # 準備の 1 本目
    '2ab=s1': 2*a*b - s1,                         # 準備の 2 本目
    'a2-b2=1': a**2 - b**2 - 1,                   # 準備の 3 本目
    'ep*em=1': ep*em - 1,                         # 準備の 4 本目
    'ep+em=2co': ep + em - 2*co,                  # 準備の 5 本目
    'ep=co+i*si': ep - (co + i*si),               # 準備の 6 本目
    'em=co-i*si': em - (co - i*si),               # 準備の 7 本目
    'em=emn': em - emn,                           # negative_i_times_complex_is_negation_of_i_times（z → (θ)_C）で exp((-i)(θ)_C) = exp(-(i(θ)_C))
    'euler1': co - (ep + emn)/2,                  # euler_formula_cos_sin の第 1 式（-iθ は -(iθ)）
    'euler2': si - (ep - emn)/(2*i),              # euler_formula_cos_sin の第 2 式
    'C=c2s': C - c2s,                             # C の定義
    'S=s2s': S - s2s,                             # S の定義
    'dual': c2s - s2s*c2,                         # duality_c2_star_eq_s2_star_c2（包含の像）
    'C=S*c2': C - S*c2,                           # 準備の C = S(c_2)_C
    'aux+': a**2 + b**2*ep*ep - ep*(c1*co - i*si),  # 補助的な等式の 1 本目
    'aux-': a**2 + b**2*em*em - em*(c1*co + i*si),  # 補助的な等式の 2 本目
}

# B_1(θ), B_2 の成分（def_B1_theta_B2 の式どおり）
B1 = matrix(R, 2, 2, [a, ((-i)*ep)*b, (i*em)*b, a])
B2 = matrix(R, 2, 2, [C, i*S, (-i)*S, C])
N = B2 * B1          # Step 1 の N（Sage の行列積）
P = B1 * N           # Step 2〜5 の P

# 鎖: [(式, 引く関係式のリスト)]。最初の行は始点で、関係式は None。
TRIG_CO = c1*co - i*si
TRIG_CO_M = c1*co + i*si
CHAINS = {
    'e_+ + e_-': [
        (ep + em, None),
        (2*((ep + em)/2), []),
        (2*((ep + em)/2), []),   # e_± の定義を展開する行（e_- = exp((-i)(θ)_C) のまま。不定元では同じ多項式）
        (2*((ep + emn)/2), ['em=emn']),
        (2*co, ['euler1']),
    ],
    'e_+': [
        (ep, None),
        ((ep + em)/2 + i*((ep - em)/(2*i)), []),
        ((ep + em)/2 + i*((ep - em)/(2*i)), []),   # e_± の定義を展開する行（e_- = exp((-i)(θ)_C) のまま。不定元では同じ多項式）
        ((ep + emn)/2 + i*((ep - emn)/(2*i)), ['em=emn']),
        (co + i*si, ['euler1', 'euler2']),
    ],
    'e_-': [
        (em, None),
        ((ep + em)/2 - i*((ep - em)/(2*i)), []),
        ((ep + em)/2 - i*((ep - em)/(2*i)), []),   # e_± の定義を展開する行（e_- = exp((-i)(θ)_C) のまま。不定元では同じ多項式）
        ((ep + emn)/2 - i*((ep - emn)/(2*i)), ['em=emn']),
        (co - i*si, ['euler1', 'euler2']),
    ],
    '補助的な等式の 1 本目': [
        (a**2 + b**2*ep*ep, None),
        (a**2*(ep*em) + b**2*ep*ep, ['ep*em=1']),
        (ep*(a**2*em + b**2*ep), []),
        (ep*(a**2*(co - i*si) + b**2*ep), ['em=co-i*si']),
        (ep*(a**2*(co - i*si) + b**2*(co + i*si)), ['ep=co+i*si']),
        (ep*((a**2 + b**2)*co - i*(a**2 - b**2)*si), []),
        (ep*(c1*co - i*(a**2 - b**2)*si), ['a2+b2=c1']),
        (ep*(c1*co - i*si), ['a2-b2=1']),
    ],
    '補助的な等式の 2 本目': [
        (a**2 + b**2*em*em, None),
        (a**2*(ep*em) + b**2*em*em, ['ep*em=1']),
        (em*(a**2*ep + b**2*em), []),
        (em*(a**2*(co + i*si) + b**2*em), ['ep=co+i*si']),
        (em*(a**2*(co + i*si) + b**2*(co - i*si)), ['em=co-i*si']),
        (em*((a**2 + b**2)*co + i*(a**2 - b**2)*si), []),
        (em*(c1*co + i*(a**2 - b**2)*si), ['a2+b2=c1']),
        (em*(c1*co + i*si), ['a2-b2=1']),
    ],
    'C = S(c_2)_C': [
        (C, None),
        (c2s, ['C=c2s']),
        (s2s*c2, ['dual']),
        (S*c2, ['S=s2s']),
    ],
    'N_11': [
        (N[0, 0], None),
        (C*a + (i*S)*((i*em)*b), []),
        (C*a - S*b*em, []),
    ],
    'N_12': [
        (N[0, 1], None),
        (C*(((-i)*ep)*b) + (i*S)*a, []),
        (i*(S*a - C*b*ep), []),
    ],
    'N_21': [
        (N[1, 0], None),
        (((-i)*S)*a + C*((i*em)*b), []),
        (i*(C*b*em - S*a), []),
    ],
    'N_22': [
        (N[1, 1], None),
        (((-i)*S)*(((-i)*ep)*b) + C*a, []),
        (C*a - S*b*ep, []),
    ],
    'P_11': [
        (P[0, 0], None),
        (a*N[0, 0] + ((-i)*ep*b)*N[1, 0], []),
        (a*(C*a - S*b*em) + ((-i)*ep*b)*(i*(C*b*em - S*a)), []),
        (a*(C*a - S*b*em) + ep*b*(C*b*em - S*a), []),
        (C*a**2 - S*a*b*em + C*b**2*ep*em - S*a*b*ep, []),
        (C*a**2 - S*a*b*em + C*b**2 - S*a*b*ep, ['ep*em=1']),
        (C*(a**2 + b**2) - S*a*b*(ep + em), []),
        (C*c1 - S*a*b*(ep + em), ['a2+b2=c1']),
        (C*c1 - S*a*b*(2*co), ['ep+em=2co']),
        (C*c1 - S*(2*a*b)*co, []),
        (C*c1 - S*s1*co, ['2ab=s1']),
        (c2s*c1 - s2s*s1*co, ['C=c2s', 'S=s2s']),
        (c1*c2s - s1*s2s*co, []),
        # 末尾の 3 行（real_inclusion_preserves_product を 2 箇所へ、同じく 1 箇所へ、real_inclusion_preserves_difference）は
        # 実数の像を動かすだけで、像を不定元に置くこの環では同じ多項式になる。像の区別は check_diagonal_entries_as_real_image.sage が見る。
        (c1*c2s - s1*s2s*co, []),
        (c1*c2s - s1*s2s*co, []),
        (c1*c2s - s1*s2s*co, []),
    ],
    'P_22': [
        (P[1, 1], None),
        (((i*em)*b)*N[0, 1] + a*N[1, 1], []),
        (((i*em)*b)*(i*(S*a - C*b*ep)) + a*(C*a - S*b*ep), []),
        ((-1)*em*b*(S*a - C*b*ep) + a*(C*a - S*b*ep), []),
        (-S*a*b*em + C*b**2*ep*em + C*a**2 - S*a*b*ep, []),
        (-S*a*b*em + C*b**2 + C*a**2 - S*a*b*ep, ['ep*em=1']),
        (C*(a**2 + b**2) - S*a*b*(ep + em), []),
        (C*c1 - S*a*b*(ep + em), ['a2+b2=c1']),
        (C*c1 - S*a*b*(2*co), ['ep+em=2co']),
        (C*c1 - S*(2*a*b)*co, []),
        (C*c1 - S*s1*co, ['2ab=s1']),
        (c2s*c1 - s2s*s1*co, ['C=c2s', 'S=s2s']),
        (c1*c2s - s1*s2s*co, []),
        # 末尾の 3 行（real_inclusion_preserves_product を 2 箇所へ、同じく 1 箇所へ、real_inclusion_preserves_difference）は
        # 実数の像を動かすだけで、像を不定元に置くこの環では同じ多項式になる。像の区別は check_diagonal_entries_as_real_image.sage が見る。
        (c1*c2s - s1*s2s*co, []),
        (c1*c2s - s1*s2s*co, []),
        (c1*c2s - s1*s2s*co, []),
    ],
    'P_12': [
        (P[0, 1], None),
        (a*N[0, 1] + ((-i)*ep*b)*N[1, 1], []),
        (a*(i*(S*a - C*b*ep)) + ((-i)*ep*b)*(C*a - S*b*ep), []),
        (i*(S*a**2 - C*a*b*ep) + i*(-C*a*b*ep + S*b**2*ep*ep), []),
        (i*(S*(a**2 + b**2*ep*ep) - (2*a*b)*C*ep), []),
        (i*(S*ep*TRIG_CO - (2*a*b)*C*ep), ['aux+']),
        (i*(S*ep*TRIG_CO - s1*C*ep), ['2ab=s1']),
        (i*(S*ep*TRIG_CO - s1*S*c2*ep), ['C=S*c2']),
        (i*ep*S*(c1*co - i*si - s1*c2), []),
        (i*ep*s2s*(c1*co - i*si - s1*c2), ['S=s2s']),
    ],
    'P_21': [
        (P[1, 0], None),
        (((i*em)*b)*N[0, 0] + a*N[1, 0], []),
        (((i*em)*b)*(C*a - S*b*em) + a*(i*(C*b*em - S*a)), []),
        (i*(C*a*b*em - S*b**2*em*em) + i*(C*a*b*em - S*a**2), []),
        ((-i)*(S*(a**2 + b**2*em*em) - (2*a*b)*C*em), []),
        ((-i)*(S*em*TRIG_CO_M - (2*a*b)*C*em), ['aux-']),
        ((-i)*(S*em*TRIG_CO_M - s1*C*em), ['2ab=s1']),
        ((-i)*(S*em*TRIG_CO_M - s1*S*c2*em), ['C=S*c2']),
        ((-i)*em*S*(c1*co + i*si - s1*c2), []),
        ((-i)*em*s2s*(c1*co + i*si - s1*c2), ['S=s2s']),
        ((-i)*em*s2s*(c1*co + i*si - s1*c2), []),   # e_- の定義を展開する行（e_- = exp((-i)(θ)_C) のまま。不定元では同じ多項式）
        ((-i)*emn*s2s*(c1*co + i*si - s1*c2), ['em=emn']),   # negative_i_times_complex_is_negation_of_i_times（z → (θ)_C）
    ],
}

# def_A_theta の A(θ)（実数の成分を包含の像として読む。(2,1) 成分の exp(-iθ) は定義の読みどおり exp(-(i(θ)_C)) = emn）
A = matrix(R, 2, 2, [
    c1*c2s - s1*s2s*co,
    i*ep*s2s*(c1*co - i*si - s1*c2),
    -i*emn*s2s*(c1*co + i*si - s1*c2),
    c1*c2s - s1*s2s*co,
])
A_ENTRY_OF = {'P_11': A[0, 0], 'P_12': A[0, 1], 'P_21': A[1, 0], 'P_22': A[1, 1]}


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
