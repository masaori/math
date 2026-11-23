# 対象ラベル: inclusion_nn_to_zz_preserves_product
# すべての x, y ∈ N で ι_{N→Z}(x·y) = ι_{N→Z}(x)·ι_{N→Z}(y) を、証明の帰納法の二つの鎖に沿って確かめる。
#   ι は inclusion_nn_to_zz の二つの式 ι(0_N) := 0_Z、ι(n + 1_N) := ι(n) + 1_Z で再帰的に作る（Sage の ZZ(n) とは別に組む）。
#   y = 0_N の鎖: ι(x·0) = ι(0) = 0 = 0·ι(x) = ι(x)·0 = ι(x)·ι(0)
#   y + 1_N の鎖: ι(x(y + 1)) = ι(xy + x) = ι(xy) + ι(x) = ι(x)ι(y) + ι(x) = ι(x)ι(y) + ι(x)·1 = ι(x)(ι(y) + 1) = ι(x)ι(y + 1)
# 帰属: 整数 ZZ（x, y は 0..40）と多項式環 ZZ[a, b, c]。浮動小数点は使わない。

def iota(n):
    # inclusion_nn_to_zz の二つの式だけで値を作る
    v = ZZ(0)                                   # ι(0_N) := 0_Z
    for _ in range(n):
        v = v + ZZ(1)                           # ι(n + 1_N) := ι(n) + 1_Z
    return v

N_MAX = 40
count0 = count1 = 0
for x in range(N_MAX + 1):
    # y = 0_N の鎖
    L = [iota(x * 0), iota(0), ZZ(0), ZZ(0) * iota(x), iota(x) * ZZ(0), iota(x) * iota(0)]
    for a, b in zip(L, L[1:]):
        assert a == b
    count0 += 1
    # y + 1_N の鎖（y = 0..N_MAX-1）。帰納法の仮定 φ(y) と、引く inclusion_nn_to_zz_preserves_sum の形もその場で確かめる。
    for y in range(N_MAX):
        assert iota(x * y) == iota(x) * iota(y)                     # 帰納法の仮定（前の y の鎖の結論）
        assert iota(x * y + x) == iota(x * y) + iota(x)             # inclusion_nn_to_zz_preserves_sum（x -> x·y, y -> x）
        L = [iota(x * (y + 1)), iota(x * y + x), iota(x * y) + iota(x),
             iota(x) * iota(y) + iota(x), iota(x) * iota(y) + iota(x) * 1,
             iota(x) * (iota(y) + 1), iota(x) * iota(y + 1)]
        for a, b in zip(L, L[1:]):
            assert a == b
        count1 += 1

# ℤ の段の根拠の等式を ZZ[a, b, c] で恒等的に
P.<a, b, c> = ZZ[]
assert P(0) * a == P(0)                         # int_zero_times_is_zero
assert a * b == b * a                           # 乗法の交換律
assert a * P(1) == a                            # 乗法の単位元 x·1 = x
assert a * (b + c) == a * b + a * c             # 分配律 x(y + t) = xy + xt

# 否定コントロール: 帰納法の段で ι(x) を足し忘れる（ι(x)ι(y) を ι(x(y + 1)) と比べる）と崩れる。
# 分配律の段で 1 の代わりに ι(x) を掛ける（ι(x)ι(y) + ι(x)·ι(x)）と崩れる。
neg = 0
if iota(3) * iota(2) != iota(3 * (2 + 1)):
    neg += 1
if iota(3) * iota(2) + iota(3) * iota(3) != iota(3) * (iota(2) + 1):
    neg += 1
assert neg == 2

print(f"x, y = 0..{N_MAX}: y = 0 の鎖 5 段を {count0} 個の x で、y + 1 の鎖 6 段を {count1} 組の (x, y) で ZZ で確かめた")
print("negative controls (broken lines detected): 2")
print("RESULT: PASS")
