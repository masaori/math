# 対象ラベル: congruence_preserves_positive_definite
# 正値性の段を、具体の QQ(i) の行列で厳密に確かめる。A は C^*C + I（Sage の is_positive_definite で正定値を別に確かめる）、
# B は可逆な QQ(i) の行列、B' := B^{-1}（Sage で求め、B'B = I を本文の積で確かめる）。
# x = Ix = (B'B)x = B'(Bx) の 3 行と、x ≠ 0 ⇒ Bx ≠ 0、x^*(B^*(AB))x = (Bx)^*A(Bx) = r_C（r > 0）を確かめる。
load("../../_shared/hermitian_forms_by_definition.sage")

set_random_seed(11)
for n in [1, 2, 3, 4]:
    for trial in range(4):
        gA = rand_posdef(n)
        assert sage_is_positive_definite(gA)
        gB = rand_gauss_matrix(n)
        while gB.det() == 0:
            gB = rand_gauss_matrix(n)
        gBp = gB.inverse()
        A, B, Bp = from_g_mat(gA), from_g_mat(gB), from_g_mat(gBp)
        I = body_identity(n, QQ)
        assert body_prod(Bp, B) == I                       # 仮定 B'B = I（本文の積で）
        Bs = body_star(B)
        C = body_prod(Bs, body_prod(A, B))                  # B^*(AB)
        assert body_star(C) == C                            # エルミート
        for _ in range(6):
            gx = rand_nonzero_vector(n)
            x = from_g_vec(gx)
            Bx = body_matvec(B, x)
            # x = Ix = (B'B)x = B'(Bx)
            chain = [x, body_matvec(I, x), body_matvec(body_prod(Bp, B), x), body_matvec(Bp, Bx)]
            for t in range(len(chain) - 1):
                assert chain[t] == chain[t + 1], (n, trial, t)
            assert any(z != (0, 0) for z in Bx)             # Bx ≠ 0
            v1 = body_cbv(x, C, x)
            v2 = body_cbv(Bx, A, Bx)
            assert v1 == v2                                 # conjugate_bilinear_value_of_congruence の y = x
            assert is_positive_real_inclusion(v2)           # A が正定値で Bx ≠ 0 なので r_C（r > 0）
            assert to_g(v1, KG) == gx.conjugate() * (gB.conjugate_transpose() * gA * gB) * gx   # 比べる側
        assert sage_is_positive_definite(gB.conjugate_transpose() * gA * gB)   # 主張を Sage でも
    print(f"n = {n}: 4 組の (A, B, B')、各 6 本の x で、正値性の段と主張を厳密に確かめた")

# 仮定 B'B = I が要ることの確認: B が非可逆なら B^*(AB) は正定値でない
for n in [2, 3]:
    gA = rand_posdef(n)
    gB = rand_gauss_matrix(n)
    gB[n - 1] = gB[0]                                      # 二つの行を等しくして非可逆にする
    assert gB.det() == 0
    assert not sage_is_positive_definite(gB.conjugate_transpose() * gA * gB)
print("B が非可逆のときは B^*(AB) が正定値でないことを確かめた")
print("RESULT: PASS")
