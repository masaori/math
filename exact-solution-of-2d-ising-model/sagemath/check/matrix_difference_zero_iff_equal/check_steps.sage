# matrix_difference_zero_iff_equal: A - B = O ⟺ A = B を、成分 ∈ {-1, 0, 1} の小さな行列の全数で確かめる（ZZ の厳密計算）。
import itertools
count = 0
for (m, p) in [(1, 1), (1, 2), (2, 1), (2, 2)]:
    entries = list(itertools.product(range(-1, 2), repeat=m*p))
    for a in entries:
        for b in entries:
            A = [[a[i*p + k] for k in range(p)] for i in range(m)]
            B = [[b[i*p + k] for k in range(p)] for i in range(m)]
            D = [[A[i][k] - B[i][k] for k in range(p)] for i in range(m)]            # def_matrix_difference
            O = [[0 for k in range(p)] for i in range(m)]                            # def_zero_matrix
            l1 = all(D[i][k] == O[i][k] for i in range(m) for k in range(p))         # 行列の等号は成分ごと
            l2 = all(A[i][k] - B[i][k] == O[i][k] for i in range(m) for k in range(p))  # def_matrix_difference
            l3 = all(A[i][k] - B[i][k] == 0 for i in range(m) for k in range(p))     # def_zero_matrix
            l4 = all(A[i][k] == B[i][k] for i in range(m) for k in range(p))         # 移項
            l5 = (matrix(ZZ, m, p, a) == matrix(ZZ, m, p, b))                        # 行列の等号
            assert l1 == l2 == l3 == l4 == l5
            assert (matrix(ZZ, m, p, a) - matrix(ZZ, m, p, b) == 0) == l4
            count += 1
# 否定コントロール: 差の代わりに和を使うと「和が O ⟺ 等しい」は成り立たない
assert (matrix(ZZ, [[1]]) + matrix(ZZ, [[-1]]) == 0) and not (matrix(ZZ, [[1]]) == matrix(ZZ, [[-1]]))
print("全数検査:", count, "組で 5 つの条件が一致。否定コントロール（和）は崩れる")
print("ALL PASS")
