# 対象ラベル: exp_of_real_symmetric_is_real_symmetric
# 人手の証明の 4 つの事実と結論を、具体の実対称な行列（QQ 成分の C + C^⊤、n = 1..4、各 3 個）で確かめる。
# - A^* = A（real_symmetric_matrix_is_hermitian）と A^⊤ = A は厳密に。
# - exp(A) は ℝ への脱出を含むので、本文の部分和に尾の評価を半径として足したボールの行列（_shared の body_exp_ball）で囲み、
#   exp(A)^*・exp(A)^⊤ と exp(A) の囲みが重なること（exp_of_hermitian_is_hermitian・exp_of_symmetric_is_symmetric の結論）、
#   各成分の虚部の囲みが 0 を含むこと（結論の「成分がすべて実数」）、Sage の exp の囲みと重なることを見る。
load("../../_shared/hermitian_forms_by_definition.sage")

set_random_seed(20261105)


def rand_real_symmetric(n):
    C = matrix(KG, n, n, lambda r, c: KG(ZZ.random_element(-3, 4)))
    return C + C.transpose()


def ball_star(Eb):
    return Eb.transpose().apply_map(lambda z: z.conjugate())


count = 0
for n in range(1, 5):
    for _ in range(3):
        A = rand_real_symmetric(n)
        assert A.conjugate_transpose() == A            # A^* = A
        assert A.transpose() == A                      # A^⊤ = A
        Eb = body_exp_ball(A)
        assert balls_overlap(ball_star(Eb), Eb)        # exp(A)^* = exp(A)
        assert balls_overlap(Eb.transpose(), Eb)       # exp(A)^⊤ = exp(A)
        assert all(Eb[r, c].imag().contains_exact(0) for r in range(n) for c in range(n))   # 成分の虚部は 0
        assert balls_overlap(Eb, sage_exp_ball(A))     # 本文の exp と Sage の exp
        count += 1
    print(f"n = {n}: 実対称な 3 個の A で exp(A)^*・exp(A)^⊤ と exp(A) が重なり、虚部の囲みが 0 を含むことを確かめた")

# 否定コントロール 1: エルミートだが実でない A = [[0, i], [-i, 0]] では exp(A)^⊤ と exp(A) が重ならない
neg = 0
H = matrix(KG, [[0, i_K], [-i_K, 0]])
assert H.conjugate_transpose() == H and H.transpose() != H
EbH = body_exp_ball(H)
assert not balls_overlap(EbH.transpose(), EbH)
neg += 1
# 否定コントロール 2: 転置で不変だが実でない A = [[i, 0], [0, 0]] では exp(A)^* と exp(A) が重ならない
T = matrix(KG, [[i_K, 0], [0, 0]])
assert T.transpose() == T and T.conjugate_transpose() != T
EbT = body_exp_ball(T)
assert not balls_overlap(ball_star(EbT), EbT)
assert not all(EbT[r, c].imag().contains_exact(0) for r in range(2) for c in range(2))
neg += 1
print(f"{count} 個の実対称な行列、否定コントロール {neg} 件（エルミートだけ・転置で不変だけでは結論が外れる）")
print("RESULT: PASS")
