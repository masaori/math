# 対象ラベル: claim_tail_cross_power_failure_not_sufficient_for_limit_quantity
# 本文の構成（箱幅の偶奇で 1 と 2 に交互化する正の有理数列）について、次の二つを
# 一段ずつ確かめる。
#   (1) 任意の閾値 K の先に、交差冪等式 A_L^{M^3} = A_M^{L^3} を破る二つの箱幅がある。
#   (2) 偶数の箱幅に沿う部分列は定数 1、奇数の箱幅に沿う部分列は定数 2 であり、
#       二つの定数が相異なる。
# 帰属: QQ と ZZ の厳密計算と有限列挙だけを使う。箱の大きさの極限そのもの、浮動小数点、
# 実対数、指数関数、無限和、級数、積分、微分は使わない。

# 点数は本文と同じく #V_L = L^3 とする。
def vertex_count(L):
    return ZZ(L) ** 3

# c_L: L が偶数なら 1、奇数なら 2。
def c(L):
    return QQ(1) if ZZ(L) % 2 == 0 else QQ(2)

# A_L := c_L^{#V_L}
def A(L):
    return c(L) ** vertex_count(L)

results = []

# --- 段 1: 構成が本文の定義どおりであること ---
step1 = all(A(L) == c(L) ** (ZZ(L) ** 3) and c(L) > 0 for L in range(1, 13))
results.append(("構成が定義どおりで各項が正であること", step1))

# --- 段 2: 本文の証明が指定する二箱の取り方が、閾値以後にあること ---
# N := max{K, 1}。N が偶数なら L := N、奇数なら L := N + 1。M := L + 1。
def chosen_pair(K):
    N = max(ZZ(K), ZZ(1))
    L = N if N % 2 == 0 else N + 1
    return L, L + 1

step2 = True
for K in range(0, 25):
    L, M = chosen_pair(K)
    step2 = step2 and L >= max(K, 1) and M >= max(K, 1)
    step2 = step2 and L % 2 == 0 and M % 2 == 1
results.append(("選んだ二箱が閾値以後にあり L が偶数・M が奇数であること", step2))

# --- 段 3: その二箱で交差冪等式が破れること ---
# A_L^{M^3} = 1 かつ A_M^{L^3} = 2^{L^3 M^3} > 1。
step3 = True
for K in range(0, 13):
    L, M = chosen_pair(K)
    left = A(L) ** vertex_count(M)
    right = A(M) ** vertex_count(L)
    step3 = step3 and left == QQ(1)
    step3 = step3 and right == QQ(2) ** (vertex_count(L) * vertex_count(M))
    step3 = step3 and right > QQ(1)
    step3 = step3 and left != right
results.append(("選んだ二箱で交差冪等式が破れること", step3))

# --- 段 4: 二つの部分列がそれぞれ定数であり、その定数が相異なること ---
even_values = set(c(2 * n) for n in range(1, 30))
odd_values = set(c(2 * n + 1) for n in range(1, 30))
step4 = even_values == {QQ(1)} and odd_values == {QQ(2)} and QQ(1) != QQ(2)
results.append(("偶奇の部分列がそれぞれ定数 1 と 2 であり相異なること", step4))

# --- 段 5: 末尾定数ではないこと（どの閾値以後も一定にならない） ---
step5 = all(any(c(L) != c(K) for L in range(K, K + 3)) for K in range(1, 25))
results.append(("どの閾値以後も列が一定にならないこと", step5))

for name, ok in results:
    print(("PASS" if ok else "FAIL") + ": " + name)

assert all(ok for _, ok in results)
print("ALL PASS")
