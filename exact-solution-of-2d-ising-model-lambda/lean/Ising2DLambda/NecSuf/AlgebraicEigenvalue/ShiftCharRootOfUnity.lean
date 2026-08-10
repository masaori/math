/-
主張「シフト行列の特性多項式の値を 0 にする代数的数は 1 の L 乗根である」の必要十分版。

証明手順は具体版（`Ising2DLambda.AlgebraicEigenvalue.ShiftCharRootOfUnity`）と同じである
（積の値を値の積へ開く → 0 である因子を 1 つ取る → その因子から所属を出す →
指数の整除で所属を移す）。

  使っている性質                なぜ削れないか
  `CommMonoid R`                積の側で有限積 `∏ i ∈ s, f i` が定義されるのに要る。
  `CommGroupWithZero M`         値の側で「有限積が零元なら零元である因子がある」を出すのに要る
                                （`exists_eq_zero_of_prod_eq_zero_necSuf` がこれを要求する）。
  φ が有限積を有限積へ写すこと  第 1 段。φ が環準同型であることは要らない（和を保つことは
                                使わない）。
  各因子から所属が出ること      第 2 段。因子が多項式であることも、所属先が 1 の冪根の全体で
                                あることも使わない。
  各指数が N を割り切ること     第 3 段。指数が軌道の元の個数であることは使わない。
  所属先が整除で単調であること  第 3 段。`A : ℕ → Set M` は任意でよい。

削れたもの: 多項式環であること・特性多項式であること・行列であること・軌道であること・
値が代数的数であること（`Qbar`）・添字の型の有限性・順序 ≺・シフトの全単射性。
すなわちこの段は**組み立てだけ**であり、対象についての性質を一つも使っていない。

住処: ここに ℝ / ℂ は現れない（値は一般の可換群に零元を添えたもの、指数は ℕ）。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarProdZero

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 必要十分版の本体。有限積の値が零元ならば、値が零元である因子から出る所属を、
指数の整除に沿って全体の指数へ移せる。 -/
theorem mem_of_prod_eval_eq_zero_necSuf
    {β R M : Type*} [DecidableEq β] [CommMonoid R] [CommGroupWithZero M]
    (φ : R → M)
    (hφ : ∀ (s : Finset β) (f : β → R), φ (∏ i ∈ s, f i) = ∏ i ∈ s, φ (f i))
    {A : ℕ → Set M} (hmono : ∀ {d n : ℕ}, d ∣ n → A d ⊆ A n)
    {s : Finset β} {f : β → R} {n : β → ℕ} {N : ℕ} {z : M}
    (hroot : ∀ i ∈ s, φ (f i) = 0 → z ∈ A (n i))
    (hdvd : ∀ i ∈ s, n i ∣ N)
    (h : φ (∏ i ∈ s, f i) = 0) :
    z ∈ A N := by
  -- 第 1 段。積の値を値の積へ開く。
  have h0 : (∏ i ∈ s, φ (f i)) = 0 := by rw [← hφ]; exact h
  -- 第 2 段。値が零元である因子を 1 つ取る。
  obtain ⟨i₀, hi₀, hzero⟩ := exists_eq_zero_of_prod_eq_zero_necSuf (fun i => φ (f i)) s h0
  -- 第 3 段。その因子から出る所属を、指数の整除に沿って移す。
  exact hmono (hdvd i₀ hi₀) (hroot i₀ hi₀ hzero)

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
