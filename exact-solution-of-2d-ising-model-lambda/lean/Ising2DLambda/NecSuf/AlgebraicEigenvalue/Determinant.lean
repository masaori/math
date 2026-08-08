/-
主張「恒等写像でない置換は少なくとも 2 つの行配位を動かす」と
「対角行列の行列式は対角成分の積である」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.Determinant`）の証明が実際に使っているのは
次だけである。行配位であること・格子の形・スピンの値が ±1 であること・順序 `≺` の作り方・
値が多項式であることは、どこにも使っていない。

2 点を動かすこと（`two_le_card_moved`）:

  使っている性質            なぜ削れないか
  `Fintype ι`               `Finset.filter` で「動く元の集合」を作り、その個数を数えるのに要る。
  `DecidableEq ι`           `φ i ≠ i` で filter するのと、`{τ₁, τ₂}` の個数を数えるのに要る。
  `Equiv.Perm ι`（全単射）  `φ τ₂ = τ₂` を仮定して `φ τ₁ = τ₁` を出す背理法が単射性そのもの。
                            単なる写像へ弱めるとこの一歩が通らない
                            （例: 定値写像は 1 点しか動かさないことがある）。

対角行列の行列式（`det_diagonal`）:

  使っている性質            なぜ削れないか
  `Fintype ι`               置換の全体にわたる和と、添字にわたる積が有限であること。
  `DecidableEq ι`           `Equiv.Perm ι` が有限型になるのに要る。
  `CommSemiring R`          零元を掛けると零元（`mul_zero`）、単位元を掛けても変わらない
                            （`one_mul`）、零元は和に寄与しない。積の可換性は `∏` の記法が
                            可換モノイドにしか定義されていないことによる（議論では使っていない）。
                            **引き算を一度も使っていないので、環である必要はない。**
  `w 1 = 1`                 恒等置換の項が積そのものになること。

とくに、重み `w`（具体版の `κ ∘ sgn`）に要求しているのは `w 1 = 1` だけである。すなわち
この証明は **符号の乗法性（`claim_permutation_sign_mul`）を使っていない**。符号が転倒数で
定まることも、`(-1)` の冪であることも使っていない。

証明手順は具体版と同じである（別の論法へ差し替えていない）。

住処: ここに ℝ / ℂ は現れない（添字は一般の有限型、値は一般の可換半環）。
-/
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.GroupTheory.Perm.Basic
import Mathlib.Data.Fintype.Perm

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

/-- 恒等でない全単射は少なくとも 2 点を動かす。

使うのは「有限であること」「相等が判定できること」「全単射（単射）であること」だけであり、
添字の側に順序も代数構造も要らない。 -/
theorem two_le_card_moved {ι : Type*} [Fintype ι] [DecidableEq ι]
    {φ : Equiv.Perm ι} (h : φ ≠ 1) :
    2 ≤ (univ.filter fun i => φ i ≠ i).card := by
  obtain ⟨i₁, hi₁⟩ : ∃ i, φ i ≠ i := by
    by_contra hcon
    exact h (Equiv.ext fun i => not_not.mp (not_exists.mp hcon i))
  set i₂ := φ i₁ with hi₂def
  have hne : i₁ ≠ i₂ := fun hh => hi₁ hh.symm
  -- ここだけが単射性を使う（φ i₂ = i₂ を仮定すると φ i₁ = i₁ が出る）。
  have hmove₂ : φ i₂ ≠ i₂ := by
    intro hh
    exact hi₁ (φ.injective (by rw [← hi₂def, hh]))
  have hsub : ({i₁, i₂} : Finset ι) ⊆ univ.filter fun i => φ i ≠ i := by
    intro i hi
    rcases mem_insert.mp hi with rfl | hi
    · simpa using hi₁
    · rw [mem_singleton] at hi
      subst hi
      simpa using hmove₂
  calc (2 : ℕ) = ({i₁, i₂} : Finset ι).card := by
        rw [card_insert_of_notMem (by simpa using hne), card_singleton]
    _ ≤ _ := card_le_card hsub

/-- 対角行列の行列式は対角成分の積である。

重み `w` に要求するのは `w 1 = 1` だけで、乗法性も符号であることも使わない。
値の側は可換半環で足り、引き算を使わない。 -/
theorem det_diagonal {ι : Type*} [Fintype ι] [DecidableEq ι] {R : Type*} [CommSemiring R]
    (w : Equiv.Perm ι → R) (hw : w 1 = 1) (A : ι → ι → R)
    (hA : ∀ i j, i ≠ j → A i j = 0) :
    (∑ φ : Equiv.Perm ι, w φ * ∏ i, A i (φ i)) = ∏ i, A i i := by
  -- 恒等でない置換の項は、動かされる 1 点の因子が 0 なので 0 である。
  rw [sum_eq_single (1 : Equiv.Perm ι) ?_ (fun hcon => absurd (mem_univ _) hcon)]
  · rw [hw, one_mul]
    rfl
  · intro φ _ hφ
    obtain ⟨i₁, hi₁⟩ : ∃ i, φ i ≠ i := by
      by_contra hcon
      exact hφ (Equiv.ext fun i => not_not.mp (not_exists.mp hcon i))
    rw [prod_eq_zero (mem_univ i₁) (hA i₁ (φ i₁) (Ne.symm hi₁)), mul_zero]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
