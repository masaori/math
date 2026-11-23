# 対象ラベル: inclusion_nn_to_zz_preserves_sum
# すべての x, y ∈ N で ι_{N→Z}(x + y) = ι_{N→Z}(x) + ι_{N→Z}(y) を、証明の帰納法の二つの鎖に沿って確かめる。
#   ι は inclusion_nn_to_zz の二つの式 ι(0_N) := 0_Z、ι(n + 1_N) := ι(n) + 1_Z で再帰的に作る（Sage の ZZ(n) とは別に組む）。
#   y = 0_N の鎖: ι(x + 0) = ι(x) = ι(x) + 0_Z = ι(x) + ι(0_N)
#   y + 1_N の鎖: ι(x + (y + 1)) = ι((x + y) + 1) = ι(x + y) + 1 = (ι(x) + ι(y)) + 1 = ι(x) + (ι(y) + 1) = ι(x) + ι(y + 1)
# 帰属: 整数 ZZ（x, y は 0..60）と多項式環 ZZ[a, b, c]。浮動小数点は使わない。

def iota(n):
    # inclusion_nn_to_zz の二つの式だけで値を作る
    v = ZZ(0)                                   # ι(0_N) := 0_Z
    for _ in range(n):
        v = v + ZZ(1)                           # ι(n + 1_N) := ι(n) + 1_Z
    return v

N_MAX = 60
count0 = count1 = 0
for x in range(N_MAX + 1):
    # y = 0_N の鎖
    L = [iota(x + 0), iota(x), iota(x) + ZZ(0), iota(x) + iota(0)]
    for a, b in zip(L, L[1:]):
        assert a == b
    count0 += 1
    # y + 1_N の鎖（y = 0..N_MAX-1）。帰納法の仮定 φ(y) もその y で確かめる。
    for y in range(N_MAX):
        assert iota(x + y) == iota(x) + iota(y)                     # 帰納法の仮定（前の y の鎖の結論）
        L = [iota(x + (y + 1)), iota((x + y) + 1), iota(x + y) + 1,
             (iota(x) + iota(y)) + 1, iota(x) + (iota(y) + 1), iota(x) + iota(y + 1)]
        for a, b in zip(L, L[1:]):
            assert a == b
        count1 += 1
    assert iota(x) == ZZ(x)                     # 組んだ ι が ZZ への包含と一致すること（Lean の inclusionNNtoZZ_eq_natCast の裏取り）

# ℤ の段の根拠の等式を ZZ[a, b, c] で恒等的に
P.<a, b, c> = ZZ[]
assert a + P(0) == a                            # 和の単位元 x + 0 = x
assert (a + b) + c == a + (b + c)               # 加法の結合律

# 否定コントロール: ι(0_N) := 0_Z を 1_Z と取り違えると、x = y = 1 で ι(1 + 1) = 3 ≠ 4 = ι(1) + ι(1) と主張が崩れる。
# 帰納法の段で 1_Z を足し忘れる（(ι(x) + 1) + ι(y) を ι(x) + ι(y) と比べる）と崩れる。
neg = 0
def iota_wrong(n):
    v = ZZ(1)                                   # ι(0_N) を 1_Z と取り違える
    for _ in range(n):
        v = v + ZZ(1)
    return v
if iota_wrong(1 + 1) != iota_wrong(1) + iota_wrong(1):
    neg += 1
if (iota(3) + 1) + iota(2) != iota(3) + iota(2):
    neg += 1
assert neg == 2

print(f"x, y = 0..{N_MAX}: y = 0 の鎖 3 段を {count0} 個の x で、y + 1 の鎖 5 段を {count1} 組の (x, y) で ZZ で確かめた")
print("negative controls (broken lines detected): 2")
print("RESULT: PASS")
