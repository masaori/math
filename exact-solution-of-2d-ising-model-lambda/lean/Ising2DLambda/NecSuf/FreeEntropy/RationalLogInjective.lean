/-
主張「正の有理数の対数は単射である」の必要十分版。

具体版（`Ising2DLambda.FreeEntropy.RationalLogInjective`）の証明の (i)・(ii) が実際に使っているのは
次だけである。素数であること・指数が素因数分解の指数であること・値が `ℤ` であることは使っていない。

  使っている性質                          なぜ削れないか
  `AddCommGroup G`                        (i) の移項に引き算（逆元）が要り、結合則・可換則で並べ替える
  `e i (m * n) = e i m + e i n`（非零）    (i) の両端の指数の加法性
  `∀ i, e i m = e i n → m = n`（非零）     (ii) の有限積表示（すべての添字で指数が一致すれば数は等しい）
  `a, b, a', b' ≠ 0`                      加法性と一意性の適用に非零性が要る

添字型 `I` は素数の集合である必要がなく、`e i` が素因数分解の指数である必要もない。
すなわちこの版が言っているのは「積を和へ移す写像の族が数を分離するなら、差が一致する
2 つの表示は交差積が等しい」ということである。(iii) の ℚ の約分は導出側に残す。

証明手順は具体版と同じ (i)・(ii) である。住処: 添字と値は一般。ℝ / ℂ は現れない。
-/
import Mathlib.Algebra.Group.Basic

namespace Ising2DLambda.NecSuf.FreeEntropy

variable {I : Type*} {G : Type*} [AddCommGroup G] (e : I → ℕ → G)

/-- (i)。1 つの添字で、差が一致すれば交差積の像は一致する。 -/
theorem cross_image_eq_of_sub_eq_necSuf (i : I)
    (he : ∀ {m n : ℕ}, m ≠ 0 → n ≠ 0 → e i (m * n) = e i m + e i n)
    {a b a' b' : ℕ} (ha : a ≠ 0) (hb : b ≠ 0) (ha' : a' ≠ 0) (hb' : b' ≠ 0)
    (h : e i a - e i b = e i a' - e i b') :
    e i (a * b') = e i (a' * b) := by
  calc
    e i (a * b') = e i a + e i b' := he ha hb'
    -- w = e a - e b を移項
    _ = ((e i a - e i b) + e i b) + e i b' := by rw [sub_add_cancel]
    -- 仮定を読む
    _ = ((e i a' - e i b') + e i b) + e i b' := by rw [h]
    -- 結合則・可換則と -e b' + e b' = 0
    _ = e i a' + e i b := by
          rw [add_assoc, add_comm (e i b), ← add_assoc, sub_add_cancel]
    _ = e i (a' * b) := (he ha' hb).symm

/-- (i)+(ii)。すべての添字で差が一致し、族が数を分離するなら、交差積は等しい。 -/
theorem cross_mul_eq_of_pointwise_sub_eq_necSuf
    (he : ∀ (i : I) {m n : ℕ}, m ≠ 0 → n ≠ 0 → e i (m * n) = e i m + e i n)
    (hsep : ∀ {m n : ℕ}, m ≠ 0 → n ≠ 0 → (∀ i, e i m = e i n) → m = n)
    {a b a' b' : ℕ} (ha : a ≠ 0) (hb : b ≠ 0) (ha' : a' ≠ 0) (hb' : b' ≠ 0)
    (h : ∀ i, e i a - e i b = e i a' - e i b') :
    a * b' = a' * b :=
  hsep (Nat.mul_ne_zero ha hb') (Nat.mul_ne_zero ha' hb)
    (fun i => cross_image_eq_of_sub_eq_necSuf e i (he i) ha hb ha' hb' (h i))

end Ising2DLambda.NecSuf.FreeEntropy
