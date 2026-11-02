# 対象ラベル: V2_invertible
# 主張 V_2 ∈ R^× を、証明の h = (a^{-1})_C exp(-Y) で厳密に確かめる。K_2 = log x（x ∈ {2, 3, 3/2}）と選ぶと、
# V_2 は def_transfer_matrix の成分 exp(K_2 n) = x^n で QQ に、h は a ∈ AA と exp(-K_2^* · iH_2) のスペクトル射影で AA に乗る
# （共通の準備 transfer_matrix_factor_inverses.sage）。ℝ への脱出は K_2 の選び方の一点だけで、等号は厳密。
#   - V_2（成分の定義）が a exp(Y) に等しい: 証明の第一行が引く V2_exponential_representation を、成分の定義の側から確かめる
#   - V_2 h = I、h V_2 = I（二つの鎖の両端）
#   - 第二行の係数 (2s_2)^{M/2} は Sage の AA の有理数冪で、第三行の a_C は a を実数の対 (a, 0) に移して作る。第三行と第四行の
#     exp の肩 iK_2^*H_2 と Y = (i(K_2^*)_C)H_2 は同じ射影の和になる（K_2^* の像を取っても行列は変わらない）
#   - 二つの鎖の各行を、書かれた括弧の形どおりに本文の定め方（mat_mult・def_matrix_scalar_multiple の成分の式）で組み、
#     隣り合う行が等しい（exp(-(-Y)) は exp の肩 -(-Y) を KG で作って Y に等しいことを見てから同じ exp を当てる）
#   - Sage の inverse で V_2 から直接求めた逆行列が h に等しい（独立な経路）
load("_prelude.sage")
# スカラーの行（a_C(a^{-1})_C → (aa^{-1})_C → (1)_C → 1_C）は、ℂ を実数の対で持つ complex_as_real_pairs.sage の積と包含で作る。
# 行列の成分は AA に置くので、対の虚部が 0 であることを確かめてから実部をスカラーとして掛ける。
load("../../_shared/complex_as_real_pairs.sage")
def scalar_of(z):
    assert z[1] == 0
    return z[0]
for M in range(1, 5):
    n = 2**M
    for x in [QQ(2), QQ(3), QQ(3)/2]:
        V2 = V2_components_exact(M, x)
        a = prefactor_exact(M, x)
        EY = exp_iK2star_H2_exact(M, x, +1)
        EmY = exp_iK2star_H2_exact(M, x, -1)
        assert V2 == body_scalar(a, EY)
        h = body_scalar(a**(-1), EmY)
        Id = body_identity(AA, n)
        ainv = a**(-1)
        s2, _ = second_coupling_exact(x)
        a_rep = AA(2 * s2) ** (QQ(M) / 2)   # V2_exponential_representation の係数 (2s_2)^{M/2}（Sage の AA の有理数冪）
        Y = body_scalar(i_K, H2(M))  # -(-Y) = Y は K_2^* の値に依らないので、肩の行列 iH_2 で確かめる
        assert body_negation(body_negation(Y)) == Y
        chain1 = [
            body_product(V2, h),
            body_product(V2, body_scalar(ainv, EmY)),
            body_product(body_scalar(a_rep, EY), body_scalar(ainv, EmY)),
            body_product(body_scalar(scalar_of(iota(a, AA)), EY), body_scalar(ainv, EmY)),
            body_product(body_scalar(a, EY), body_scalar(ainv, EmY)),
            body_scalar(a, body_product(EY, body_scalar(ainv, EmY))),
            body_scalar(a, body_scalar(ainv, body_product(EY, EmY))),
            body_scalar(scalar_of(cc_mul(iota(a, AA), iota(ainv, AA))), body_product(EY, EmY)),
            body_scalar(scalar_of(iota(a * ainv, AA)), body_product(EY, EmY)),
            body_scalar(scalar_of(iota(AA(1), AA)), body_product(EY, EmY)),
            body_scalar(scalar_of(iota(1, AA)), body_product(EY, EmY)),
            body_product(EY, EmY),
            body_product(exp_iK2star_H2_exact(M, x, -(-1)), EmY),
            Id,
        ]
        chain2 = [
            body_product(h, V2),
            body_product(body_scalar(ainv, EmY), V2),
            body_product(body_scalar(ainv, EmY), body_scalar(a_rep, EY)),
            body_product(body_scalar(ainv, EmY), body_scalar(scalar_of(iota(a, AA)), EY)),
            body_product(body_scalar(ainv, EmY), body_scalar(a, EY)),
            body_scalar(ainv, body_product(EmY, body_scalar(a, EY))),
            body_scalar(ainv, body_scalar(a, body_product(EmY, EY))),
            body_scalar(scalar_of(cc_mul(iota(ainv, AA), iota(a, AA))), body_product(EmY, EY)),
            body_scalar(scalar_of(iota(ainv * a, AA)), body_product(EmY, EY)),
            body_scalar(scalar_of(iota(AA(1), AA)), body_product(EmY, EY)),
            body_scalar(scalar_of(iota(1, AA)), body_product(EmY, EY)),
            body_product(EmY, EY),
            Id,
        ]
        check_chain(chain1, f"V_2 h（M={M}, x={x}）")
        check_chain(chain2, f"h V_2（M={M}, x={x}）")
        assert V2.inverse() == h
    print(f"  M_col={M}: x ∈ {{2,3,3/2}} で V_2 = a exp(Y)、二つの鎖の各行が等しく I に着き、Sage の逆行列 = h（AA で厳密）")
print("RESULT: PASS")
