/-
章「固有値の代数性」の行列式の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 1 件
（ラベル `def_constant_polynomial` / `def_identity_matrix` / `def_determinant`）と主張 2 件
（`claim_permutation_moves_two` / `claim_determinant_diagonal`）に対応する。

  人手証明                                  このファイル
  κ : ℤ → ℤ[x]（定数多項式）                constPoly
  I（単位行列）                             identityRowMatrix
  det A                                     determinant
  M(φ)（φ が動かす行配位の集合）            movedBy
  |M(φ)| ≥ 2                                two_le_card_movedBy
  対角行列の行列式                          determinant_diagonal
  det I = κ(1)                              determinant_identity

`constPoly` は mathlib の `Polynomial.C` そのものである（`x^0` の係数が `n` で他が `0` の
多項式を与える写像）。人手証明が整数と定数多項式を同じ記号で書かないと約束しているので、
ここでも `(n : Polynomial ℤ)` のような自動強制に任せず、この名前を通す。

`determinant` の積 `∏ τ : RowConfig L` に添字の順序は入れていない。人手証明が述べるとおり
`ℤ[x]` の積が可換なので順序によらないためで、順序 `≺` が要るのは `permSign` の中の転倒数だけである。

`permSign` が `noncomputable`（`Nat.find` を使う）なので、`determinant` も `noncomputable` である。
これは数学の内容ではなく Lean の実行可能性の話である。

住処: 人手証明のこれらのブロックは ℤ / ℕ を宣言している。ここに ℝ / ℂ は現れない
（係数は ℤ、値は `Polynomial ℤ`、数え上げは ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.PermutationSign
import Ising2DLambda.TransferMatrix.WeightProduct
import Mathlib.Data.Fintype.Perm

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable (L : ℕ) [NeZero L]

/-- 人手証明の `κ : ℤ → ℤ[x]`。`x^0` の係数が `n` で、他の係数はすべて `0`。 -/
noncomputable def constPoly (n : ℤ) : Polynomial ℤ := Polynomial.C n

@[simp] lemma constPoly_zero : constPoly 0 = 0 := map_zero _

@[simp] lemma constPoly_one : constPoly 1 = 1 := map_one _

/-- 人手証明の単位行列 `I`。 -/
noncomputable def identityRowMatrix : RowMatrix L :=
  fun τ τ' => if τ = τ' then constPoly 1 else constPoly 0

/-- 人手証明の `det A = Σ_φ κ(sgn φ) · Π_τ A_{τ,φ(τ)}`。 -/
noncomputable def determinant (A : RowMatrix L) : Polynomial ℤ :=
  ∑ φ : Equiv.Perm (RowConfig L), constPoly (permSign L φ) * ∏ τ : RowConfig L, A τ (φ τ)

/-- 人手証明の `M(φ) = { τ ∈ R_L | φ(τ) ≠ τ }`。 -/
noncomputable def movedBy (φ : Equiv.Perm (RowConfig L)) : Finset (RowConfig L) :=
  univ.filter fun τ => φ τ ≠ τ

variable {L}

lemma mem_movedBy {φ : Equiv.Perm (RowConfig L)} {τ : RowConfig L} :
    τ ∈ movedBy L φ ↔ φ τ ≠ τ := by
  simp [movedBy]

/-- 人手証明の主張「恒等写像でない置換は少なくとも 2 つの行配位を動かす」。

証明は人手証明どおり。`φ τ₁ ≠ τ₁` となる `τ₁` を取り、`τ₂ := φ τ₁` と置いて、
`τ₁ ≠ τ₂` と `φ τ₂ ≠ τ₂` の 2 つを見る（後者は `φ` の単射性を使う背理法）。 -/
theorem two_le_card_movedBy {φ : Equiv.Perm (RowConfig L)} (h : φ ≠ 1) :
    2 ≤ (movedBy L φ).card := by
  -- φ ≠ id_{R_L} なので φ(τ₁) ≠ τ₁ となる τ₁ が取れる。
  obtain ⟨τ₁, hτ₁⟩ : ∃ τ, φ τ ≠ τ := by
    by_contra hcon
    exact h (Equiv.ext fun i => not_not.mp (not_exists.mp hcon i))
  set τ₂ := φ τ₁ with hτ₂def
  -- 第一に τ₁ ≠ τ₂（τ₁ の取り方そのもの）。
  have hne : τ₁ ≠ τ₂ := fun hh => hτ₁ hh.symm
  -- 第二に φ(τ₂) ≠ τ₂（仮に等しいとすると φ の単射性から φ(τ₁) = τ₁ が出る）。
  have hmove₂ : φ τ₂ ≠ τ₂ := by
    intro hh
    exact hτ₁ (φ.injective (by rw [← hτ₂def, hh]))
  -- τ₁, τ₂ はともに M(φ) に属し、相異なる。
  have hsub : ({τ₁, τ₂} : Finset (RowConfig L)) ⊆ movedBy L φ := by
    intro τ hτ
    rcases mem_insert.mp hτ with rfl | hτ
    · exact mem_movedBy.mpr hτ₁
    · rw [mem_singleton] at hτ
      subst hτ
      exact mem_movedBy.mpr hmove₂
  calc (2 : ℕ) = ({τ₁, τ₂} : Finset (RowConfig L)).card := by
        rw [card_insert_of_notMem (by simpa using hne), card_singleton]
    _ ≤ (movedBy L φ).card := card_le_card hsub

/-- 人手証明の準備。恒等写像でない置換の項は `κ(0)` である。 -/
lemma term_eq_zero_of_ne_one {A : RowMatrix L}
    (hA : ∀ τ τ' : RowConfig L, τ ≠ τ' → A τ τ' = constPoly 0)
    {φ : Equiv.Perm (RowConfig L)} (h : φ ≠ 1) :
    constPoly (permSign L φ) * ∏ τ : RowConfig L, A τ (φ τ) = 0 := by
  obtain ⟨τ₁, hτ₁⟩ : ∃ τ, φ τ ≠ τ := by
    by_contra hcon
    exact h (Equiv.ext fun i => not_not.mp (not_exists.mp hcon i))
  -- 有限積から τ₁ の因子を取り出すと κ(0) である。
  have hzero : ∏ τ : RowConfig L, A τ (φ τ) = 0 :=
    prod_eq_zero (mem_univ τ₁) (by rw [hA τ₁ (φ τ₁) (Ne.symm hτ₁), constPoly_zero])
  rw [hzero, mul_zero]

/-- 人手証明の主張「対角行列の行列式は対角成分の積である」。 -/
theorem determinant_diagonal (A : RowMatrix L)
    (hA : ∀ τ τ' : RowConfig L, τ ≠ τ' → A τ τ' = constPoly 0) :
    determinant L A = ∏ τ : RowConfig L, A τ τ := by
  rw [determinant]
  -- 第 2 の等号。恒等写像でない置換の項は κ(0) であり、和に寄与しない。
  rw [sum_eq_single (1 : Equiv.Perm (RowConfig L))
    (fun φ _ hφ => term_eq_zero_of_ne_one hA hφ) (fun hcon => absurd (mem_univ _) hcon)]
  -- 第 3・第 4・第 5 の等号。sgn(id) = 1、id(τ) = τ、κ(1) は単位元。
  rw [permSign_id, constPoly_one, one_mul]
  rfl

/-- 人手証明の `det I = κ(1)`。 -/
theorem determinant_identity : determinant L (identityRowMatrix L) = constPoly 1 := by
  rw [determinant_diagonal (identityRowMatrix L)
    (fun τ τ' h => by simp [identityRowMatrix, h])]
  -- 対角成分はすべて κ(1) なので、単位元の有限積は単位元である。
  simp [identityRowMatrix]

end Ising2DLambda.AlgebraicEigenvalue
