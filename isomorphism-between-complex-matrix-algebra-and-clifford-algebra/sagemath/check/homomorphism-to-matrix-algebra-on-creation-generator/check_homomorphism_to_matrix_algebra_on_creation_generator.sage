# 対象ラベル: claim_homomorphism_to_matrix_algebra_sends_creation_generator_to_creation_operator_matrix
# 分裂した二次空間 V=W⊕W^* を組 (x,g) として実装し、in_1・in_2・座標の写像 β^w_k・双対基底 f・
# φ((x,g)):=Σ_k β^w_k(x)∗c_k + Σ_k g(w_k)∗c_k^T（def_matrix_valued_map_on_split_quadratic_space）を関数として作る。
# W の基底 w は標準基底のほか、非対角の可逆な QQ 行列の列も試し、座標の写像はその基底についての連立一次方程式を解いて求める。
# Φ(a†_i)=Φ(γ(in_1(w_i)))=φ(in_1(w_i)) の右辺での確認であり、クリフォード代数の中の元 a†_i そのものは計算しない。
# 証明の式変形を一行ずつ QQ の厳密計算で確かめ、否定の対照として in_1 と in_2 を取り違えた値が一致しないことを確かめる。
from itertools import combinations

def power_set(M):
    base = list(range(1, M + 1))
    return [frozenset(c) for r in range(M + 1) for c in combinations(base, r)]

def N(i, T):                       # def_count_of_subset_elements_below_index
    if i == 1:
        return 0
    return N(i - 1, T) + 1 if (i - 1) in T else N(i - 1, T)

def sign(n):                       # def_sign_of_nonnegative_integer
    return QQ(1) if n == 0 else QQ(-1) * sign(n - 1)

def creation_matrices(M, P):       # def_creation_operator_matrix
    return {i: matrix(QQ, len(P), len(P), lambda s, t: sign(N(i, P[t])) if (i not in P[t] and P[s] == P[t] | {i}) else 0)
            for i in range(1, M + 1)}

# 分裂した二次空間 V = W ⊕ W^* の実装。
# W := QQ^M（列ベクトル）。W^* の元 g は行ベクトルで表し、g(x) := g·x（W 上の線型形式）とする。
# V の元は組 (x, g)（x ∈ W、g ∈ W^*）であり、W や W^* の元を V の元として使うときは in_1・in_2 を必ず通す。
class SplitSpace:
    def __init__(self, M, Bmat):
        # Bmat の第 k 列を基底の元 w_k とする（Bmat は QQ 上の可逆行列）。
        assert Bmat.base_ring() == QQ and Bmat.nrows() == M and Bmat.ncols() == M and Bmat.det() != 0
        self.M = M
        self.Bmat = Bmat
        self.Binv = Bmat.inverse()
        self.zero_W = vector(QQ, [0] * M)
        self.zero_Wdual = vector(QQ, [0] * M)          # 0_{W^*}：すべての x を 0 へ送る線型形式
    def w(self, k):                                    # 基底 w の第 k 元
        return self.Bmat.column(k - 1)
    def beta(self, k, x):                              # 基底 w についての第 k 座標の写像 β^w_k
        # x = Σ_j a_j w_j を満たす a を連立一次方程式 Bmat·a = x として解き、a_k を返す
        a = self.Bmat.solve_right(x)
        assert self.Bmat * a == x
        return a[k - 1]
    def f(self, i):                                    # 双対基底の第 i 元 f_i（f_i(w_k)=δ_{i,k} で特徴づける）
        return self.Binv.row(i - 1)
    @staticmethod
    def ev(g, x):                                      # W^* の元 g の x ∈ W での値 g(x)
        return g * x
    def in_1(self, x):                                 # def_embedding_into_first_component_of_direct_sum
        return (x, self.zero_Wdual)
    def in_2(self, g):                                 # def_embedding_into_second_component_of_direct_sum
        return (self.zero_W, g)
    def phi(self, v, c, ct, n):                        # def_matrix_valued_map_on_split_quadratic_space
        x, g = v
        first = sum((self.beta(k, x) * c[k] for k in range(1, self.M + 1)), zero_matrix(QQ, n))
        second = sum((self.ev(g, self.w(k)) * ct[k] for k in range(1, self.M + 1)), zero_matrix(QQ, n))
        return first + second

def bases_of_W(M):
    # 標準基底、上三角の非対角行列、乱数で選んだ可逆な QQ 行列（種を固定）を基底として試す。
    out = [("標準基底", identity_matrix(QQ, M))]
    U = matrix(QQ, M, M, lambda r, s: (r + s + 2) if r <= s else 0)
    out.append(("上三角の行列（M≥2 で非対角）", U))
    set_random_seed(20261112 + M)
    for t in range(2):
        while True:
            R = random_matrix(QQ, M, M, num_bound=5, den_bound=3)
            if R.det() != 0 and R != identity_matrix(QQ, M) and (M == 1 or not R.is_diagonal()):
                break
        out.append(("乱数の可逆行列 %d" % (t + 1), R))
    return out

def check_dual_basis(V):
    M = V.M
    for i in range(1, M + 1):
        for k in range(1, M + 1):
            d = 1 if i == k else 0
            assert V.ev(V.f(i), V.w(k)) == d                                # def_dual_basis：f_i(w_k)=δ_{i,k}
            assert V.beta(k, V.w(i)) == d                                   # claim_coordinate_maps_form_dual_basis：β^w_k(w_i)=δ_{k,i}

total = 0
for M in range(1, 4):
    P = power_set(M)
    n = len(P)
    c = creation_matrices(M, P)
    ct = {k: c[k].transpose() for k in c}                                    # def_annihilation_operator_matrix
    Z = zero_matrix(QQ, n)
    for name, Bmat in bases_of_W(M):
        V = SplitSpace(M, Bmat)
        check_dual_basis(V)
        for i in range(1, M + 1):
            # 準備の一つ目: β^w_k(w_i)∗c_k = δ_{k,i}∗c_k
            for k in range(1, M + 1):
                assert V.beta(k, V.w(i)) * c[k] == (1 if k == i else 0) * c[k]
            # 準備の二つ目: 0_{W^*}(w_k)∗c_k^T = 0_B
            for k in range(1, M + 1):
                assert V.ev(V.zero_Wdual, V.w(k)) == 0
                assert V.ev(V.zero_Wdual, V.w(k)) * ct[k] == Z
            v = V.in_1(V.w(i))
            assert v[0] == V.w(i) and v[1] == V.zero_Wdual                      # in_1(w_i)=(w_i,0_{W^*})
            line4 = sum((V.beta(k, V.w(i)) * c[k] for k in range(1, M + 1)), Z) + \
                    sum((V.ev(V.zero_Wdual, V.w(k)) * ct[k] for k in range(1, M + 1)), Z)
            assert V.phi(v, c, ct, n) == line4                                   # φ の定義を開いた行
            line5 = sum(((1 if k == i else 0) * c[k] for k in range(1, M + 1)), Z) + \
                    sum((V.ev(V.zero_Wdual, V.w(k)) * ct[k] for k in range(1, M + 1)), Z)
            assert line4 == line5
            line6 = c[i] + sum((V.ev(V.zero_Wdual, V.w(k)) * ct[k] for k in range(1, M + 1)), Z)
            assert line5 == line6
            assert line6 == c[i] + Z
            assert V.phi(v, c, ct, n) == c[i]                                    # 主張: Φ(a†_i)=c_i（像での確認）
            # 否定の対照: in_1 と in_2 を取り違えた値は一致しない
            assert V.phi(V.in_2(V.f(i)), c, ct, n) != c[i]
            assert V.phi(V.in_1(V.w(i)), c, ct, n) != ct[i]
            # 否定の対照: 別の番号の生成作用素の行列とは一致しない
            for j in range(1, M + 1):
                if j != i:
                    assert V.phi(v, c, ct, n) != c[j]
            total += 1
        # 否定の対照: 標準基底でない基底では、w_i の標準座標を β の代わりに入れると c_i にならない番号がある
        if name != "標準基底":
            std = [sum((V.w(i)[k - 1] * c[k] for k in range(1, M + 1)), Z) for i in range(1, M + 1)]
            assert any(std[i - 1] != c[i] for i in range(1, M + 1))
    print("M=%d: PASS" % M)
print("ALL PASS（M, 基底, i の組 %d 件）" % total)
