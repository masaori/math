# 対象ラベル: monoid_of_polar_representation
# 結合律の鎖の七つの式（行 0 〜 行 6）
#   行 0: ([(r1,θ1)]·[(r2,θ2)])·[(r3,θ3)]
#   行 1: [(r1r2, θ1+θ2)]·[(r3,θ3)]                 （積の定義）
#   行 2: [((r1r2)r3, (θ1+θ2)+θ3)]                   （積の定義）
#   行 3: [(r1(r2r3), (θ1+θ2)+θ3)]                   （R の積の結合律）
#   行 4: [(r1(r2r3), θ1+(θ2+θ3))]                   （R の和の結合律）
#   行 5: [(r1,θ1)]·[(r2r3, θ2+θ3)]                  （積の定義）
#   行 6: [(r1,θ1)]·([(r2,θ2)]·[(r3,θ3)])            （積の定義）
# (一般の点) 行 2 → 行 3 と行 3 → 行 4 で、根拠に挙げた成分だけが変わり、変わった成分が多項式として等しいこと。
# (具体の点) 各行を成分から別々に組み立てる。積の定義の行は、前の行の二つの因子に代表元の積を当てると次の行の代表元に
#   一致すること（行 0 → 1、1 → 2、5 → 4、6 → 5 の向き）を、R の結合律の行は、変わらない成分が同じ式で、変わる成分が等しいことを確かめる。
load("../../_shared/polar_representation.sage")

# 一般の点
assert (r1 * r2) * r3 == r1 * (r2 * r3)                      # 行 2 → 3 の第 1 成分
assert (th1 + th2) + th3 == th1 + (th2 + th3)                # 行 3 → 4 の第 2 成分

cnt = 0
for p in SAMPLE:
    for q in SAMPLE:
        for s in SAMPLE:
            (a1, t1), (a2, t2), (a3, t3) = p, q, s
            row1_factors = ((a1 * a2, t1 + t2), s)
            row2 = ((a1 * a2) * a3, (t1 + t2) + t3)
            row3 = (a1 * (a2 * a3), (t1 + t2) + t3)
            row4 = (a1 * (a2 * a3), t1 + (t2 + t3))
            row5_factors = (p, (a2 * a3, t2 + t3))
            # 行 0 → 1: 内側の積 [(r1,θ1)]·[(r2,θ2)] に定義を当てると行 1 の左の因子
            assert mul_rep(p, q) == row1_factors[0]
            # 行 1 → 2: 行 1 の二つの因子に定義を当てると行 2
            assert mul_rep(*row1_factors) == row2
            # 行 2 → 3: 第 2 成分は同じ式、第 1 成分は R の積の結合律で等しい
            assert row2[1] == row3[1] and row2[0] == row3[0]
            # 行 3 → 4: 第 1 成分は同じ式、第 2 成分は R の和の結合律で等しい
            assert row3[0] == row4[0] and row3[1] == row4[1]
            # 行 5 → 4: 行 5 の二つの因子に定義を当てると行 4
            assert mul_rep(*row5_factors) == row4
            # 行 6 → 5: 内側の積 [(r2,θ2)]·[(r3,θ3)] に定義を当てると行 5 の右の因子
            assert mul_rep(q, s) == row5_factors[1]
            # 各段の右辺が R_{>=0} × R の元であること
            assert all(is_pair(x) for x in (row1_factors[0], row2, row3, row4, row5_factors[1]))
            cnt += 1
print(f"associativity rows 2->3, 3->4 as polynomial identities; all seven rows built separately on {cnt} triples")
print("RESULT: PASS")
