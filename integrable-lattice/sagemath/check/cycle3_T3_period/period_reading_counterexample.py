# cycle 17 / step 3: 「π(p,1)」の 2 つの読みが一致しないことの検証（素の Python 3。依存なし）
#
# 背景: 命題 A は π(p,k) を「行列冪列 (T^N mod p^k)_N の最終周期」と定義する。
#       命題 B は π(p,1) = lcm{ord(λ) : p∤m_λ} と述べるが、その証明（指標の一次独立）が
#       計算しているのは「トレース列 (Tr T^N mod p)_N の最終周期」である。
#       本スクリプトは、この 2 つが一般に一致しないことを示す。
#
# (1) 最小反例（Lean でも形式化した: lean/IntegrableLattice/PropBTracePeriod.lean）
#     T = [[0,1],[1,1]] ⊕ [[0,1],[1,1]] ∈ M_4(Z), p=2, det T = 1（p∤det T）。
#     χ_T ≡ (x^2+x+1)^2 mod 2、相異なる固有値は ω, ω^2（重複度いずれも 2）。
#     ⇒ 命題 B の右辺 = lcm(空集合) = 1。行列冪列の周期 = 3。トレース列の周期 = 1。
# (2) ランダムな整数行列（p∤det T）での頻度測定。0 件観察を根拠にしないための量的確認。

import random


def matmul(A, B, p):
    n = len(A)
    return [[sum(A[i][k] * B[k][j] for k in range(n)) % p for j in range(n)] for i in range(n)]


def det(M):
    n = len(M)
    if n == 1:
        return M[0][0]
    s = 0
    for j in range(n):
        minor = [row[:j] + row[j + 1:] for row in M[1:]]
        s += ((-1) ** j) * M[0][j] * det(minor)
    return s


def periods(A, p, maxN=2000):
    """(行列冪列の周期, トレース列の周期) を返す。A は可逆前提（純周期）。"""
    n = len(A)
    I = [[1 if i == j else 0 for j in range(n)] for i in range(n)]
    X = I
    tr = []
    for N in range(1, maxN + 1):
        X = matmul(X, A, p)
        tr.append(sum(X[i][i] for i in range(n)) % p)
        if X == I:
            mper = N
            for d in range(1, mper + 1):
                if mper % d == 0 and all(tr[i] == tr[(i + d) % mper] for i in range(mper)):
                    return mper, d
    return None, None


print("=" * 70)
print("(1) 最小反例 T = [[0,1],[1,1]]^{⊕2}, p=2")
print("=" * 70)
T = [[0, 1, 0, 0], [1, 1, 0, 0], [0, 0, 0, 1], [0, 0, 1, 1]]
print(f"  det T = {det(T)}  (p=2 で非零 ⇒ 命題 A の仮定 p∤det T を満たす)")
mper, tper = periods([[x % 2 for x in row] for row in T], 2)
print(f"  行列冪列 (T^N mod 2) の最終周期 = {mper}")
print(f"  トレース列 (Tr T^N mod 2) の最終周期 = {tper}")
print("  χ_T = (x^2-x-1)^2 ≡ (x^2+x+1)^2 (mod 2)。相異なる固有値 ω, ω^2 の重複度はともに 2。")
print("  ⇒ 命題 B の右辺 lcm{ord(λ) : 2∤m_λ} = lcm(∅) = 1")
print(f"  ⇒ 右辺 1 はトレース列の周期 {tper} と一致し、行列冪列の周期 {mper} とは一致しない。")

print()
print("=" * 70)
print("(2) ランダム整数行列での頻度（p∤det T のもののみ、seed 固定で再現可能）")
print("=" * 70)
random.seed(1)
tot = 0
diff = 0
for _ in range(4000):
    n = random.choice([2, 3, 4])
    A = [[random.randrange(-3, 4) for _ in range(n)] for _ in range(n)]
    p = random.choice([2, 3, 5, 7])
    if det(A) % p == 0:
        continue
    mper, tper = periods([[x % p for x in row] for row in A], p)
    if mper is None:
        continue
    tot += 1
    if mper != tper:
        diff += 1
print(f"  検査 {tot} 件中、行列冪列の周期 ≠ トレース列の周期 が {diff} 件"
      f"（{100 * diff / tot:.1f}%）")
print("  ⇒ 不一致は例外的な現象ではない。命題 B を『行列冪列の周期』と読むと広く偽になる。")

print()
print("=" * 70)
print("(3) 逆に、命題 C の上界 π(p,k) | p^{k-1}π(p,1) は『トレース列の周期』では偽")
print("=" * 70)
random.seed(7)
tot3 = 0
bad3 = []
for _ in range(3000):
    n = random.choice([2, 3])
    p = random.choice([2, 3, 5])
    A = [[random.randrange(-3, 4) for _ in range(n)] for _ in range(n)]
    if det(A) % p == 0:
        continue
    _, t1 = periods([[x % p for x in row] for row in A], p, maxN=5000)
    _, t2 = periods([[x % (p * p) for x in row] for row in A], p * p, maxN=5000)
    if t1 is None or t2 is None:
        continue
    tot3 += 1
    if (p * t1) % t2 != 0:
        bad3.append((A, p, t1, t2))
print(f"  検査 {tot3} 件中、トレース列の周期で上界が破れる例が {len(bad3)} 件"
      f"（{100 * len(bad3) / tot3:.1f}%）")
for b in bad3[:3]:
    print(f"    A={b[0]}, p={b[1]}: トレース周期 mod p = {b[2]}, mod p^2 = {b[3]}"
          f"（{b[3]} ∤ {b[1]}·{b[2]}）")
print("  ⇒ 命題 C（Pisano 型上界）は『行列冪列の周期』の主張である。")
print("  ⇒ 命題 A・B・C は同じ記号 π(p,1) を使えない。B だけがトレース列の周期についての主張。")
print("=" * 70)
