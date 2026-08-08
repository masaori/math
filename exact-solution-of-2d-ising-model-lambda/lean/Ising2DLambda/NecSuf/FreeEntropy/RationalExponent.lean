/-
主張「有理数の指数は表示の取り方によらない」の必要十分版。

具体版（`Ising2DLambda.FreeEntropy.RationalExponent`）の証明が実際に使っているのは次だけである。
素数であること・指数が素因数分解から来ること・値が `ℤ` であること・台が有限であることは、
どこにも使っていない。

  使っている性質            なぜ削れないか
  `AddCommGroup G`          Step 4 の移項に引き算（逆元）が要る。和の可換性と結合性は
                            Step 3 の左右の並べ替えに要る。モノイドでは移項ができない。
  `e (m * n) = e m + e n`   Step 2 でそのまま使う。これが無いと Step 1 の等式
  （`m ≠ 0`, `n ≠ 0` のとき）  `a b' = a' b` から指数の関係を取り出せない。
  `a ≠ 0` などの 4 つ        加法性を `a * b'` と `a' * b` の両方へ適用するのに、
                            4 つとも非零であることが要る（`a`, `b'` と `a'`, `b`）。

すなわちこの版が言っているのは「積を和へ移す写像があれば、交差積が等しい 2 つの表示の
差は等しい」ということであり、素因数分解であることは本質ではない。

証明手順は具体版と同じ Step 1–4 である（別の論法へ差し替えていない）。
Step 1（分母を払う）は仮定 `a * b' = a' * b` そのものなので、ここでは仮定として受け取る。

住処: ここに ℝ / ℂ は現れない（添字は ℕ、値は一般の可換群）。
-/
import Mathlib.Algebra.Group.Basic

namespace Ising2DLambda.NecSuf.FreeEntropy

variable {G : Type*} [AddCommGroup G] (e : ℕ → G)

/-- Step 2–4。`a b' = a' b` ならば `e a - e b = e a' - e b'`。 -/
theorem sub_eq_sub_of_mul_eq_mul
    (he : ∀ {m n : ℕ}, m ≠ 0 → n ≠ 0 → e (m * n) = e m + e n)
    {a b a' b' : ℕ} (ha : a ≠ 0) (hb : b ≠ 0) (ha' : a' ≠ 0) (hb' : b' ≠ 0)
    (h : a * b' = a' * b) :
    e a - e b = e a' - e b' := by
  -- Step 3。両辺は同じ自然数なので、その像も等しい。
  have hval : e (a * b') = e (a' * b) := by rw [h]
  -- Step 2。加法性を両辺へ適用する。
  rw [he ha hb', he ha' hb] at hval
  -- Step 4。移項する（ここで逆元を使う）。
  exact sub_eq_sub_iff_add_eq_add.mpr hval

end Ising2DLambda.NecSuf.FreeEntropy
