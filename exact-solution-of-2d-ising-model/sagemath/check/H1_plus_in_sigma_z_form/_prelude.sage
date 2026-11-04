# 対象ラベル: H1_plus_in_sigma_z_form の検算の共通の準備。
# 成分は QQ(i)（KG）。クロネッカー積は def_kronecker (2) の成分の式（kron は Sage の tensor_product との一致も確かめる）、
# 積・スカラー倍・和・有限和・符号反転・差は本文の定め方どおりに成分から組む（_shared の body_*）。
load("../../_shared/pauli_sites_exact.sage")

i_ = i_K
X, Y, Z, I = SX, SY, SZ, I2
P_ = body_product
S_ = body_scalar
N_ = body_negation
D_ = body_difference
F_ = body_finite_sum
A_ = body_sum


def cc_mul(z, w):
    """definition_of_cc の積 (a,b)(c,d) = (ac − bd, ad + bc) を QQ の対で計算し KG へ戻す。"""
    a, b = z.list()
    c, d = w.list()
    return KG([a*c - b*d, a*d + b*c])


minus_i = body_neg_scalar(i_)          # multiply_by_minus_one の −i := (−1)·i
minus_one = KG(-1)


class Report:
    def __init__(self, title):
        self.title, self.n, self.neg, self.fail = title, 0, 0, 0
        print(f"=== {title} ===", flush=True)

    def chain(self, lines, label):
        for (a, A), (b, B) in zip(lines, lines[1:]):
            self.n += 1
            if A != B:
                self.fail += 1
                print(f"FAIL: {label}: 「{a}」≠「{b}」", flush=True)

    def check(self, ok, label):
        self.n += 1
        if not ok:
            self.fail += 1
            print(f"FAIL: {label}", flush=True)

    def negative(self, differs, label):
        self.neg += 1
        if not differs:
            self.fail += 1
            print(f"FAIL（否定コントロールが外れない）: {label}", flush=True)

    def finish(self):
        print(f"等号・主張 {self.n} 件、否定コントロール {self.neg} 件、失敗 {self.fail} 件")
        print("RESULT: " + ("PASS" if self.fail == 0 else "FAIL"))
        assert self.fail == 0
