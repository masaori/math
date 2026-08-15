/-
章「熱力学極限」の「開境界長方形の分配多項式の正の有理点での値」
（`def_open_rectangle_partition_value_at_positive_rational`）と
「開境界長方形の分配多項式の正の有理点での値は正の有理数である」
（`claim_open_rectangle_value_at_rational_is_positive`）の具体版（人手証明と 1 対 1 に対応させる）。

  人手証明の段                                          このファイル
  Z^op_{a,b}(q) := (Σ_σ x^{b^op(σ)})(q)                  openPartitionValueRat
  二つ目の等号: 代入は和と冪を保つ ⇒ Σ_σ q^{b^op(σ)}      openPartitionValueRat_eq_sum
  準備: 各項 0 < q^{b^op(σ)}                             pow_pos（正の有理数の冪は正）
  準備: |Σ^op_{a,b}| = 2^{ab} ≥ 1                         instance Nonempty (OpenConfig a b)
  「正の有理数を 1 個以上足したものは正」                 Finset.sum_pos
  結論 Z^op_{a,b}(q) ∈ ℚ_{>0}                            openPartitionValueRat_pos

住処: ℕ・ℚ のみ。ℝ / ℂ は現れない（代入先は `ℚ`、指数は `ℕ`）。
正の実数での値 `openPartitionValue`（`OpenRectangleGluingInequality.lean`）はこの実数側の像であり、
旧経路の撤去まで併存させる。
-/
import Mathlib.Algebra.Order.BigOperators.Ring.Finset
import Mathlib.Algebra.Polynomial.AlgebraMap
import Ising2DLambda.ThermodynamicLimit.OpenRectangle

namespace Ising2DLambda.ThermodynamicLimit

open Finset

variable (a b : ℕ)

/-- 開境界長方形の分配多項式の正の有理点での値 `Z^op_{a,b}(q)`（多項式への代入。ℚ の元）。 -/
noncomputable def openPartitionValueRat (q : ℚ) : ℚ :=
  Polynomial.aeval q (openPartitionPolynomial a b)

/-- 代入は和と冪を保つ（人手証明の定義の二つ目の等号 `Σ_σ q^{b^op(σ)}`）。 -/
lemma openPartitionValueRat_eq_sum (q : ℚ) :
    openPartitionValueRat a b q = ∑ σ : OpenConfig a b, q ^ openBrokenBondCount a b σ := by
  rw [openPartitionValueRat, openPartitionPolynomial, map_sum]
  exact sum_congr rfl fun σ _ => by rw [map_pow, Polynomial.aeval_X]

/-- 準備: 配位は少なくとも 1 つある（人手証明の `|Σ^op_{a,b}| = 2^{ab} ≥ 1`。定数配位を挙げる）。 -/
instance instNonemptyOpenConfig : Nonempty (OpenConfig a b) := ⟨fun _ => ⟨1, Or.inl rfl⟩⟩

/-- `claim_open_rectangle_value_at_rational_is_positive`: `0 < Z^op_{a,b}(q)`（`q ∈ ℚ_{>0}`）。 -/
theorem openPartitionValueRat_pos {q : ℚ} (hq : 0 < q) : 0 < openPartitionValueRat a b q := by
  rw [openPartitionValueRat_eq_sum]
  -- 正の有理数を 1 個以上足したものは正
  refine sum_pos (fun σ _ => ?_) univ_nonempty
  -- 準備: 各項 0 < q^{b^op(σ)}（正の有理数の冪は正。指数 0 なら空積 1 > 0）
  exact pow_pos hq (openBrokenBondCount a b σ)

end Ising2DLambda.ThermodynamicLimit
