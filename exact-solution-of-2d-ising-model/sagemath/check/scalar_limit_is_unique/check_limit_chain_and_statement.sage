# 対象ラベル: scalar_limit_is_unique
# 証明の後半を確かめる。
#   ‖[a_N]_K - [b]_K‖ = ‖[a_N - b]_K‖ = |a_N - b| → 0      （b ∈ {a, a'}）
#   a = ([a]_K)_11 = ([a']_K)_11 = a'
# 帰属: 列 a_N と極限 b は QQ・QQ(i) の具体の値に取る（a_N = b + c/(N+1) と、b + c·2^{-N}）。等号は AA で厳密、
# 「→ 0」は N を増やしたとき |a_N - b| が N に依る明示の上界の下にあり、上界が単調に 0 へ近づくことで確かめる
# （無限列の極限そのものは有限の計算では判定できないので、上界の形で確かめる）。
# 主張（a_N → a かつ a_N → a' なら a = a'）は全称命題なので、計算では反例が無いことしか見られない。
# ここでは、二つの異なる候補 b ≠ b' について、|a_N - b| と |a_N - b'| の和が |b - b'| 以上であること
# （三角不等式。どちらか一方は 0 へ行けないこと）を確かめる。
load("../../_shared/one_by_one_matrix.sage")


def abs_K(w, F):
    if F is QQ:
        return AA(max(w, -w))
    return AA(QQ(w[0])^2 + QQ(w[1])^2).sqrt()


def body_norm(A, F):
    total = sum(abs_K(entry(A, i, j), F)^2 for i in range(1, A.nrows() + 1) for j in range(1, A.ncols() + 1))
    return AA(total).sqrt()


ii = GAUSSIAN.gen()
cases = [
    (QQ, QQ(2) / 3, QQ(5), "harmonic"),
    (QQ, QQ(-7), QQ(-1) / 2, "geometric"),
    (GAUSSIAN, 1 + 2 * ii, 3 - ii, "harmonic"),
    (GAUSSIAN, GAUSSIAN(-1) / 4 * ii, 7 * ii, "geometric"),
]
for F, b, c, kind in cases:
    seq = (lambda N: b + c / (N + 1)) if kind == "harmonic" else (lambda N: b + c * QQ(2)^(-N))
    bound = (lambda N: abs_K(c, F) / (N + 1)) if kind == "harmonic" else (lambda N: abs_K(c, F) * QQ(2)^(-N))
    prev = None
    for N in [0, 1, 5, 20, 100, 1000]:
        aN = F(seq(N))
        l1 = body_norm(one_by_one(F, aN) - one_by_one(F, b), F)
        l2 = body_norm(one_by_one(F, aN - b), F)
        l3 = abs_K(aN - b, F)
        assert l1 == l2 == l3, (F, b, N)
        assert l3 <= bound(N)
        if prev is not None:
            assert bound(N) < prev
        prev = bound(N)
    assert prev < AA(10)^(-2)
    # 最後の鎖: a = ([a]_K)_11 = ([a']_K)_11 = a'（a = a' = b のとき、各行が同じ値）
    assert b == entry11(one_by_one(F, b)) == entry11(one_by_one(F, F(b))) == F(b)
    # 対照: b' ≠ b なら、各 N で |a_N - b| + |a_N - b'| ≥ |b - b'| > 0（両方が 0 へ行くことはない）
    b2 = b + 1
    for N in [0, 5, 1000]:
        aN = F(seq(N))
        assert abs_K(aN - b, F) + abs_K(aN - b2, F) >= abs_K(b - b2, F) > 0
print(f"{len(cases)} 本の列で ‖[a_N]_K - [b]_K‖ = ‖[a_N - b]_K‖ = |a_N - b| が厳密に成り立ち、|a_N - b| が 0 へ近づく上界の下にあること、")
print("最後の鎖の各行の一致、異なる二つの候補へ同時には近づけないこと（対照）を確かめた")
print("RESULT: PASS")
