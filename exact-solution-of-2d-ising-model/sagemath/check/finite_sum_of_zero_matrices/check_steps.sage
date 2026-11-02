# 対象ラベル: finite_sum_of_zero_matrices（Σ_{j=1}^{r} O = O）
# 帰納法の基底 Σ_{j=1}^{1} O = O と、帰納の段 Σ_{j=1}^{r+1} O = (Σ_{j=1}^{r} O) + O = O + O = O の各行を、
# 行に書かれた式どおりに別々に組み、隣り合う項が等しいことを確かめる。
# 行列の有限和は def_finite_sum_of_matrices のとおり def_matrix_sum の和で左から順に足して組む（body_finite_sum）。
# 帰属: QQ（零行列の成分は 0 だけなので不定元は要らない）。帰納法そのもの（r についての全称）は有限の計算に落ちないので、
# r = 1..8 の各段を確かめる。
load("../../_shared/matrix_operations_by_definition.sage")

RMAX = 8
count = 0
for m in [1, 2, 3]:
    for n in [1, 2, 3]:
        O = matrix(QQ, m, n, lambda i, k: 0)                              # def_zero_matrix
        assert body_finite_sum([O]) == O                                  # 基底（def_finite_sum_of_matrices）
        for r in range(1, RMAX):
            chain = [
                body_finite_sum([O] * (r + 1)),                           # Σ_{j=1}^{r+1} O
                body_sum(body_finite_sum([O] * r), O),                    # (Σ_{j=1}^{r} O) + O
                body_sum(O, O),                                           # O + O（帰納法の仮定）
                O,                                                        # O（matrix_plus_zero_matrix, X = O）
            ]
            for t in range(len(chain) - 1):
                assert chain[t] == chain[t + 1], (m, n, r, t)
            count += 1
        for r in range(1, RMAX + 1):
            assert sum([O] * r, matrix(QQ, m, n, 0)) == O                 # 独立な経路: Sage の行列の和
print(f"checked {count} induction steps (r = 1..{RMAX - 1}) over 9 shapes")
# 対照: 1 つでも零でない項が混じると O にならない
E = matrix(QQ, 1, 1, [1])
assert body_finite_sum([matrix(QQ, 1, 1, 0), E]) != matrix(QQ, 1, 1, 0)
print("対照: 零でない項が混じると O にならない")
print("RESULT: PASS")
