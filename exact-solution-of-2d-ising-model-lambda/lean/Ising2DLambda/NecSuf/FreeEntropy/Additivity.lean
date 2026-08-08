/-
主張「対数の加法性」と「対数の冪の法則」の必要十分版。

具体版（`Ising2DLambda.FreeEntropy.Additivity`）の証明が実際に使っているのは次だけである。
素数であること・素因数分解であること・値が `Λ` に住むこと・有理数であることは、どこにも使っていない。

加法性（`sub_add_sub_of_mul`）:

  使っている性質            なぜ削れないか
  `AddCommGroup G`          「引き算どうしの和」へ並べ替える Step 5 に、逆元と可換性の両方が要る。
                            可換モノイドでは `(x₁+x₂)-(y₁+y₂) = (x₁-y₁)+(x₂-y₂)` を書けない。
  `e (m * n) = e m + e n`   Step 4 で分子側と分母側の両方へ適用する。
  （`m ≠ 0`, `n ≠ 0` のとき）
  4 つの非零性              加法性を `a₁a₂` と `b₁b₂` の両方へ適用するのに 4 つとも要る。

すなわちこの版が言っているのは「積を和へ移す写像があれば、分子どうし・分母どうしを掛けた
表示の差は、それぞれの表示の差の和になる」ということである。

冪の法則（`map_pow_eq_nsmul`）:

  使っている性質            なぜ削れないか
  `Monoid M`                `x^k` を書き、`x^(k+1) = x^k * x` を使う Step 3 に要る。
  `AddCommMonoid G`         Step 4 の `k • g + g = (k+1) • g` に要る（逆元は使わない。
                            冪の法則は引き算を一度も使っていない）。
  述語 `P` と閉性           加法性が使えるのは述語を満たす元どうしの積に限るので、
                            `P 1`・`P x` から `P (x^k)` を作れないと Step 3 で適用できない
                            （具体版ではこれが「正の有理数の積は正の有理数」にあたる）。
  `f 1 = 0`                 Step 1（`k = 0` の場合）そのもの。

証明手順は具体版と同じである（加法性は Step 3–5、冪の法則は `k` についての帰納法で Step 1–5）。
加法性の Step 1–2（表示を取り、積の表示を作ること）は具体版に固有の書き換えなので、
ここでは仮定として受け取る。

住処: ここに ℝ / ℂ は現れない（添字は ℕ、値は一般の可換群・可換モノイド）。
-/
import Mathlib.Algebra.Group.Basic
import Mathlib.Tactic.Abel

namespace Ising2DLambda.NecSuf.FreeEntropy

/-- Step 3–5（加法性）。`e` が積を和へ移すなら、分子どうし・分母どうしを掛けた表示の差は
それぞれの差の和である。 -/
theorem sub_add_sub_of_mul {G : Type*} [AddCommGroup G] (e : ℕ → G)
    (he : ∀ {m n : ℕ}, m ≠ 0 → n ≠ 0 → e (m * n) = e m + e n)
    {a₁ b₁ a₂ b₂ : ℕ} (ha₁ : a₁ ≠ 0) (hb₁ : b₁ ≠ 0) (ha₂ : a₂ ≠ 0) (hb₂ : b₂ ≠ 0) :
    e (a₁ * a₂) - e (b₁ * b₂) = (e a₁ - e b₁) + (e a₂ - e b₂) := by
  -- Step 4。加法性を分子側と分母側の両方へ適用する。
  rw [he ha₁ ha₂, he hb₁ hb₂]
  -- Step 5。ℤ の中の並べ替えにあたる部分（可換群の中で引き算どうしの和へ直す）。
  abel

/-- Step 1–5（冪の法則）。`f` が述語 `P` の上で積を和へ移し `f 1 = 0` を満たすなら、
`P` を満たす `x` について `f (x^k) = k • f x` である。 -/
theorem map_pow_eq_nsmul {M : Type*} [Monoid M] {G : Type*} [AddCommMonoid G]
    (f : M → G) (P : M → Prop)
    (hP1 : P 1) (hPmul : ∀ {x y : M}, P x → P y → P (x * y))
    (h1 : f 1 = 0) (hmul : ∀ {x y : M}, P x → P y → f (x * y) = f x + f y)
    {x : M} (hx : P x) : ∀ k : ℕ, f (x ^ k) = k • f x
  | 0 => by
    -- Step 1（k = 0）。x^0 = 1 なので、両辺とも単位元である。
    rw [pow_zero, h1, zero_nsmul]
  | k + 1 => by
    -- Step 3。x^(k+1) = x^k · x へ加法性を適用する（P が積で閉じているので適用できる）。
    have hxk : P (x ^ k) := by
      induction k with
      | zero => simpa using hP1
      | succ n ih => rw [pow_succ]; exact hPmul ih hx
    rw [pow_succ, hmul hxk hx]
    -- Step 4。帰納法の仮定を代入し、k • g + g = (k+1) • g で括る。
    rw [map_pow_eq_nsmul f P hP1 hPmul h1 hmul hx k, succ_nsmul]

end Ising2DLambda.NecSuf.FreeEntropy
