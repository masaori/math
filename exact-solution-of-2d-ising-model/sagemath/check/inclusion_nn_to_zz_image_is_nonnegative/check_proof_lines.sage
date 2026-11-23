# 対象ラベル: inclusion_nn_to_zz_image_is_nonnegative
# すべての n ∈ N で 0_Z <= ι_{N→Z}(n) を、証明の帰納法の二つの鎖に沿って確かめる。
#   ι は inclusion_nn_to_zz の二つの式 ι(0_N) := 0_Z、ι(n + 1_N) := ι(n) + 1_Z で再帰的に作る（Sage の ZZ(n) とは別に組む）。
#   n = 0_N の鎖: 0_Z <= 0_Z = ι(0_N)
#   n + 1_N の鎖: 0 = 0 + 0 <= 1 + 0 = 0 + 1 <= ι(n) + 1 = ι(n + 1_N)
# 帰属: 整数 ZZ（n は 0..200）と多項式環 ZZ[y]。浮動小数点は使わない。

def iota(n):
    # inclusion_nn_to_zz の二つの式だけで値を作る
    v = ZZ(0)                                   # ι(0_N) := 0_Z
    for _ in range(n):
        v = v + ZZ(1)                           # ι(n + 1_N) := ι(n) + 1_Z
    return v

zero, one = ZZ(0), ZZ(1)
N_MAX = 200

# n = 0_N の鎖
assert zero <= zero                             # 順序の反射律（x -> 0_Z）
assert zero == iota(0)                          # ι(0_N) := 0_Z を右辺から左辺へ

# n + 1_N の鎖（n = 0..N_MAX-1）。帰納法の仮定 0 <= ι(n) もその n で確かめる。
count = 0
for n in range(N_MAX):
    assert zero <= iota(n)                      # 帰納法の仮定（前の n の鎖の結論）
    L = [zero, zero + zero, one + zero, zero + one, iota(n) + one, iota(n + 1)]
    rel = ["=", "<=", "=", "<=", "="]
    for a, b, r in zip(L, L[1:], rel):
        assert (a == b) if r == "=" else (a <= b)
    count += 1
    assert iota(n) == ZZ(n)                     # 作った ι が ZZ への包含と一致すること（Lean の inclusionNNtoZZ_eq_natCast の裏取り）
assert zero <= iota(N_MAX) and iota(N_MAX) == ZZ(N_MAX)   # 主張の n = N_MAX

# 等号の段の根拠の等式を ZZ[y] で恒等的に（y は x の位置に置いた変数）
P.<y> = ZZ[]
assert P(0) + y == y                            # 和の単位元 0 + x = x（1 行目は x -> 0 の場合）
assert P(1) + y == y + P(1)                     # 加法の交換律（3 行目は x -> 1, y -> 0 の場合）

# 否定コントロール: 再帰の式で 1 を足す代わりに 1 を引くと、n = 1 で結論が崩れる。
# int_zero_at_most_one を逆向きの 1 <= 0 と取り違えると、2 行目の 0 + 0 <= 1 + 0 が 1 + 0 <= 0 + 0 になり崩れる。
neg = 0
def iota_wrong(n):
    v = ZZ(0)
    for _ in range(n):
        v = v - ZZ(1)
    return v
if not (zero <= iota_wrong(1)):
    neg += 1
if not (one + zero <= zero + zero):
    neg += 1
assert neg == 2

print(f"n = 0..{N_MAX}: 0_Z <= ι(n) と、n = 0 の 2 行・n + 1 の 5 行の各段が ZZ で成り立った（{count} 個の n で後者の鎖）")
print("negative controls (broken lines detected): 2")
print("RESULT: PASS")
