# 対象ラベル: check_number_operator_is_hermitian の検算が共有する共役転置。
# def_hermitian_positive_definite の (A^*)_{kl} := conj(A_{lk}) を、成分の体の複素共役 conj（体の自己同型）で組む。
# conj が本物の複素共役であること（埋め込み emb について emb(conj(g)) = conj(emb(g))）は、各検算が体の生成元で確かめてから使う。
# 体の自己同型は和と積を保つので、生成元で一致すれば体の全ての元で一致する。


def body_star(A, conj):
    """def_hermitian_positive_definite の共役転置 (A^*)_{kl} := conj(A_{lk})。"""
    R = A.base_ring()
    return matrix(R, A.ncols(), A.nrows(), lambda k, l: R(conj(A[l, k])))


def body_vector_star_times(x, y, conj):
    """def_conjugate_bilinear_value の x^*Ay で A = I の値 Σ_k conj(x_k) y_k（左から足す）。x, y は n 行 1 列。"""
    total = 0
    for k in range(x.nrows()):
        total = total + conj(x[k, 0]) * y[k, 0]
    return total


def body_bilinear(x, A, y, conj):
    """def_conjugate_bilinear_value の x^*Ay := Σ_k Σ_l (conj(x_k) A_{kl}) y_l。"""
    n = A.nrows()
    total = 0
    for k in range(n):
        for l in range(n):
            total = total + (conj(x[k, 0]) * A[k, l]) * y[l, 0]
    return total


class Counter:
    def __init__(self, title):
        self.title = title
        self.n_eq = 0
        self.n_neg = 0
        print("==", title, flush=True)

    def eq(self, a, b, what):
        assert a == b, "FAIL: " + what
        self.n_eq += 1

    def truth(self, ok, what):
        assert ok, "FAIL: " + what
        self.n_eq += 1

    def neq(self, a, b, what):
        assert a != b, "FAIL (否定コントロール): " + what
        self.n_neg += 1

    def control(self, ok, what):
        """否定コントロールを真偽値で（崩れることを ok で表す）。"""
        assert ok, "FAIL (否定コントロール): " + what
        self.n_neg += 1

    def chain(self, lines, what):
        """lines は (行の名前, 値) の並び。隣り合う行の等号を一つずつ確かめる。"""
        for (na, a), (nb, b) in zip(lines, lines[1:]):
            self.eq(a, b, f"{what}: {na} = {nb}")

    def finish(self):
        print(f"-- {self.title}: 等号 {self.n_eq} 件、否定コントロール {self.n_neg} 件")
        print("RESULT: PASS")
