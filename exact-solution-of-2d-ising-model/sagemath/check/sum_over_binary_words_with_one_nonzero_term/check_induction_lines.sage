# 対象ラベル: sum_over_binary_words_with_one_nonzero_term（ε ≠ ε' で B_ε = O なら Σ_{ε∈{0,1}^r} B_ε = B_{ε'}）
# 証明の各行:
#   r = 1, ε' = (1): Σ B_ε = B_(1) + B_(0)   (def_sum_over_binary_words)
#                          = B_(1) + O       (B_(0) = O)
#                          = B_(1)           (matrix_plus_zero_matrix)
#   r = 1, ε' = (0): Σ B_ε = B_(1) + B_(0) = O + B_(0) = B_(0)   (zero_matrix_plus_matrix)
#   r → r+1: δ := (ε'_1,…,ε'_r)、e := ε'_{r+1}、(δ, e) = ε'。
#            δ' ≠ δ なら C_δ' = B_(δ',1) + B_(δ',0) = O + O = O  (C の定義、仮定、matrix_plus_zero_matrix (X → O))
#            Σ_{ε∈{0,1}^{r+1}} B_ε = Σ_{δ'} (B_(δ',1) + B_(δ',0)) (def_sum_over_binary_words)
#                                 = Σ_{δ'} C_δ'                  (C の定義)
#                                 = C_δ                          (帰納法の仮定)
#                                 = B_(δ,1) + B_(δ,0)            (C の定義)
#            e = 1: = B_(δ,1) + O = B_(δ,1) = B_{ε'}
#            e = 0: = O + B_(δ,0) = B_(δ,0) = B_{ε'}
# {0,1}^r の元は長さ r のタプル、(ε', e) は ε' の末尾に e を付けたタプルで表す。和は def_sum_over_binary_words の帰納法どおりに組む。
# 行列の和は本文の成分の式（_shared の body_sum）で組む。
# 帰属: QQ 上の多項式環（B_{ε'} の成分は不定元）。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
load("../../_shared/matrix_operations_by_definition.sage")
import itertools


def words(r):
    return [tuple(w) for w in itertools.product([1, 0], repeat=r)]


def binary_word_sum(r, B):
    """def_sum_over_binary_words: B は {0,1}^r の元（タプル）から行列への写像。"""
    if r == 1:
        return body_sum(B((1,)), B((0,)))
    return binary_word_sum(r - 1, lambda ep: body_sum(B(ep + (1,)), B(ep + (0,))))


count = 0
for (m, n) in [(1, 1), (2, 2), (2, 3), (3, 1)]:
    P, _, (X,) = generic_ring([("X", m, n)])
    O = matrix(P, m, n, 0)
    for r in range(1, 5):
        for wp in words(r):
            B = lambda w, wp=wp: X if w == wp else O
            lhs = binary_word_sum(r, B)
            if r == 1:
                if wp == (1,):
                    lines = [lhs, body_sum(B((1,)), B((0,))), body_sum(B((1,)), O), B((1,)), B(wp)]
                else:
                    lines = [lhs, body_sum(B((1,)), B((0,))), body_sum(O, B((0,))), B((0,)), B(wp)]
            else:
                d, e = wp[:-1], wp[-1]
                assert d + (e,) == wp
                C = lambda dp: body_sum(B(dp + (1,)), B(dp + (0,)))
                # 帰納法の仮定の前提: δ' ≠ δ なら C_{δ'} = O + O = O
                for dp in words(r - 1):
                    if dp != d:
                        assert B(dp + (1,)) == O and B(dp + (0,)) == O
                        assert C(dp) == body_sum(B(dp + (1,)), B(dp + (0,))) == body_sum(O, O) == O
                        count += 3
                # 帰納法の仮定（r - 1 で ε' → δ）
                assert binary_word_sum(r - 1, C) == C(d)
                lines = [lhs, binary_word_sum(r - 1, lambda dp: body_sum(B(dp + (1,)), B(dp + (0,)))), binary_word_sum(r - 1, C), C(d), body_sum(B(d + (1,)), B(d + (0,)))]
                if e == 1:
                    lines += [body_sum(B(d + (1,)), O), B(d + (1,)), B(wp)]
                else:
                    lines += [body_sum(O, B(d + (0,))), B(d + (0,)), B(wp)]
            for a, b in zip(lines, lines[1:]):
                assert a == b, (m, n, r, wp)
                count += 1
            # 独立な経路: Sage の和
            assert lhs == sum(B(w) for w in words(r))
# 対照: ε' 以外に零でない項が一つでもあると一致しない
P, _, (X, Y) = generic_ring([("X", 2, 2), ("Y", 2, 2)])
O = matrix(P, 2, 2, 0)
B = lambda w: X if w == (1, 0) else (Y if w == (0, 0) else O)
assert binary_word_sum(2, B) != X
print(f"checked {count} lines")
print("RESULT: PASS")
