# 対象ラベル: open_chain_spin_sums_positive（K > 0 で二つの開鎖のスピン和は正）
# 証明の二つの鎖（各 3 行: 主張の値、冪を有限積に開く、> 0）と、> 0 の行の根拠
# （cosh K > 0、K > 0 で sinh K > 0、2cosh K > 0、2sinh K > 0、正の実数の有限積は正、2 > 0）を確かめる。
# 冪を有限積に開く行は組合せの層（QQ[x, y]）で厳密に、値と不等号は RealBallField(200) の球の下端で確かめる
# （exp の値は ℝ への脱出）。M_col = 2..7、K ∈ K_POS。
load("../../_shared/open_chain_spin_sums.sage")

K_POS = [QQ(1) / 3, QQ(1), QQ(5) / 2, QQ(1) / 100, QQ(6), QQ(1) / 1000]
count = 0
neg = 0

# 冪を有限積に開く行（厳密）
for M in range(2, 9):
    for c in [(X + Y) / 2, (X - Y) / 2]:
        assert 2 * (2 * c) ^ (M - 1) == 2 * finite_prod([2 * c for j in range(1, M)])
        count += 1

for M in range(2, 8):
    S = configs(M)
    for K in K_POS:
        Zc = finite_sum([rexp(RB(K) * energy(s)) for s in S], RB(0))
        Zs = finite_sum([spin(s, M) * spin(s, 1) * rexp(RB(K) * energy(s)) for s in S], RB(0))
        ch, sh = rcosh_def(K), rsinh_def(K)
        # 1 行目（open_chain_partition_sum / open_chain_endpoint_product_sum）
        assert same(Zc, 2 * (2 * ch) ^ (M - 1)) and same(Zs, 2 * (2 * sh) ^ (M - 1))
        # 2 行目（冪の定義）
        assert same(2 * (2 * ch) ^ (M - 1), 2 * finite_prod([2 * ch for j in range(1, M)]))
        assert same(2 * (2 * sh) ^ (M - 1), 2 * finite_prod([2 * sh for j in range(1, M)]))
        count += 4
        # 3 行目の根拠と結論
        # 準備の鎖の 6 行
        assert ch > 0                                # cosh_sinh_basic_properties (1)
        assert 2 * ch > 0                            # 2 > 0 と正の実数どうしの積
        assert sh > 0                                # cosh_sinh_basic_properties (3)
        assert 2 * sh > 0
        assert finite_prod([2 * ch for j in range(1, M)]) > 0   # finite_product_of_positive_reals_is_positive
        assert finite_prod([2 * sh for j in range(1, M)]) > 0
        # 二つの鎖の 3 行目と主張
        assert 2 * finite_prod([2 * ch for j in range(1, M)]) > 0
        assert 2 * finite_prod([2 * sh for j in range(1, M)]) > 0
        assert Zc > 0 and Zs > 0
        count += 10

# 否定コントロール: K > 0 の仮定を外すと、M_col - 1 が奇数のとき端点因子のある和は負になる
for M in [2, 4, 6]:
    for K in [QQ(-1) / 3, QQ(-2)]:
        Zs = finite_sum([spin(s, M) * spin(s, 1) * rexp(RB(K) * energy(s)) for s in configs(M)], RB(0))
        if Zs < 0:
            neg += 1
        Zc = finite_sum([rexp(RB(K) * energy(s)) for s in configs(M)], RB(0))
        assert Zc > 0      # 端点因子の無い和は K の符号に依らず正（cosh の側）
        count += 1
assert neg == 6
print(f"checked {count} equalities/inequalities")
print(f"negative controls detected: {neg}")
print("RESULT: PASS")
