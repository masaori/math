# 対象ラベル: inclusion_nn_to_zz_preserves_order
# x, y ∈ N が x ≤ y を満たすなら ι_{N→Z}(x) ≤ ι_{N→Z}(y) を、証明の鎖に沿って確かめる。
#   ι は inclusion_nn_to_zz の二つの式 ι(0_N) := 0_Z、ι(n + 1_N) := ι(n) + 1_Z で再帰的に作る（Sage の ZZ(n) とは別に組む）。
#   x ≤ y から順序と和で x + d = y の d を取り、ι(x) = 0 + ι(x) ≤ ι(d) + ι(x) = ι(x) + ι(d) = ι(x + d) = ι(y)。
# 帰属: 整数 ZZ（x, y は 0..60）と多項式環 ZZ[a, b]。浮動小数点は使わない。

def iota(n):
    # inclusion_nn_to_zz の二つの式だけで値を作る
    v = ZZ(0)                                   # ι(0_N) := 0_Z
    for _ in range(n):
        v = v + ZZ(1)                           # ι(n + 1_N) := ι(n) + 1_Z
    return v

N_MAX = 60
count = 0
for x in range(N_MAX + 1):
    for y in range(x, N_MAX + 1):
        # 順序と和: x ≤ y なら x + d = y の d ∈ N がただ一つある
        ds = [d for d in range(N_MAX + 1) if x + d == y]
        assert len(ds) == 1
        d = ds[0]
        assert 0 <= iota(d)                      # inclusion_nn_to_zz_image_is_nonnegative（n -> d）
        assert iota(x + d) == iota(x) + iota(d)  # inclusion_nn_to_zz_preserves_sum（y -> d）
        # 鎖: 等号の段は等しく、≤ の段は ≤ が成り立つ
        L = [iota(x), ZZ(0) + iota(x), iota(d) + iota(x), iota(x) + iota(d), iota(x + d), iota(y)]
        rel = ["=", "<=", "=", "=", "="]
        for (a, b), r in zip(zip(L, L[1:]), rel):
            assert (a == b) if r == "=" else (a <= b)
        assert iota(x) <= iota(y)                # 主張
        count += 1

# ℤ の段の根拠の等式を ZZ[a, b] で恒等的に
P.<a, b> = ZZ[]
assert P(0) + a == a                            # 和の単位元 0 + x = x
assert a + b == b + a                           # 加法の交換律

# 否定コントロール: x > y の組（d が取れない）では主張の結論が崩れる。≤ の段を等号と取り違えると d ≥ 1 で崩れる。
neg = 0
if not (iota(3) <= iota(2)):
    neg += 1
if ZZ(0) + iota(5) != iota(2) + iota(5):
    neg += 1
assert neg == 2

print(f"x ≤ y, x, y = 0..{N_MAX}: 鎖の 5 段を {count} 組の (x, y) で ZZ で確かめた")
print("negative controls (broken lines detected): 2")
print("RESULT: PASS")
