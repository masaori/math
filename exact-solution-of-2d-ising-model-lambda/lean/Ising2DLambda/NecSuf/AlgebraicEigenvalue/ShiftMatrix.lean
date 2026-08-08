/-
主張「シフト行列を左から掛けると行の添字がシフトされる」「シフト行列を右から掛けると
列の添字が逆向きにシフトされる」と定理「シフト行列と転送行列は可換である」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.ShiftMatrix`）の証明が実際に使っているのは
次だけである。行配位であること・格子の形・スピンの値が ±1 であること・成分が多項式で
あること・成分が不定元の冪であること・シフトが巡回であることは、どこにも使っていない。

  使っている性質            なぜ削れないか
  `Fintype ι`               成分の和が有限和であること。
  `DecidableEq ι`           `if j = e i then 1 else 0` の場合分けが定まること。
  `e : ι ≃ ι`               左からの積では `e` が写像であることしか使わないが、
                            右からの積では `k = e j ⟺ e.symm k = j` を使うので
                            全単射でなければならない（単なる写像へ弱めると、
                            `k` に写る `j` が無い／2 つ以上ある場合が出て成り立たない）。
  `AddCommMonoid S`         成分の有限和が定まること。
  `Mul S` / `One S`         積と単位元の記号があること（法則は仮定していない）。
  4 つの規則               `1 * a = a`、`a * 1 = a`、`0 * a = 0`、`a * 0 = 0`。
                            型クラスではなく、各定理の**明示の仮定**として渡す。

**証明が使うのは単位元と零元の上記 4 規則と有限和の分解だけであり、分配則も積の結合則も
積の可換性も使っていない。** このことは散文の主張ではなく、仮定の書き方で機械的に裏取り
してある。すなわち代数構造としては `AddCommMonoid` と、法則を一切持たない `Mul` / `One`
しか仮定しておらず、分配則・結合則・可換性はそもそも**述べることができない**。
4 つの規則を型クラス（`MulZeroOneClass` 等）で与えないのは、`AddCommMonoid` の `Zero` と
別の `Zero` が現れて同じ零元として扱えなくなるためで、明示の仮定にすればこの問題も起きない。
引き算も順序も使っていない。

可換性（`permMatrix_comm`）が `A` に要求するのは
  ∀ i j, A (e i) (e j) = A i j
という不変性ただ 1 つである。すなわち **`A` が転送行列であることは使っていない**。
人手証明で言えば、`claim_transfer_matrix_shift_invariant` を満たす行列であれば
何であってもシフト行列と可換になる。

証明手順は具体版と同じである（和を 1 点だけ残して他を零で落とす、
可換性は 4 つの等号でつなぐ）。別の論法へ差し替えていない。
mathlib の置換行列（`Equiv.Perm.permMatrix`）や `Matrix.mul` は引いていない。

住処: ここに ℝ / ℂ は現れない（添字は一般の有限型、値は一般の代数構造）。
-/
import Mathlib.Algebra.BigOperators.Finprod
import Mathlib.Data.Fintype.BigOperators

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {S : Type*} [AddCommMonoid S] [Mul S] [One S]

/-- 具体版の `U`（人手証明の「シフト行列」）にあたる行列。

全単射 `e` を成分へ書き写したもの。人手証明の `U_{τ,τ'} = κ(1) (τ' = S(τ))、κ(0)` と同じ形。 -/
def permMatrix (e : ι ≃ ι) : ι → ι → S :=
  fun i j => if j = e i then (1 : S) else (0 : S)

/-- 人手証明の主張「シフト行列を左から掛けると行の添字がシフトされる」。

和を `j = e i` の項とそれ以外へ分け、零元で残りを落とし、単位元で結論する。 -/
theorem permMatrix_mul_apply (hone : ∀ a : S, (1 : S) * a = a)
    (hzero : ∀ a : S, (0 : S) * a = 0)
    (e : ι ≃ ι) (A : ι → ι → S) (i k : ι) :
    (∑ j : ι, permMatrix e i j * A j k) = A (e i) k := by
  rw [Finset.sum_eq_single (e i)]
  · rw [permMatrix, if_pos rfl, hone]
  · intro j _ hj
    rw [permMatrix, if_neg hj, hzero]
  · intro h
    exact absurd (mem_univ _) h

/-- 人手証明が `(AU)` の計算の前に置く同値 `τ'' = S(τ') ⟺ S'(τ'') = τ'`。 -/
theorem eq_apply_iff (e : ι ≃ ι) (j k : ι) : k = e j ↔ e.symm k = j := by
  constructor
  · intro h
    rw [h]
    exact e.symm_apply_apply j
  · intro h
    rw [← h]
    exact (e.apply_symm_apply k).symm

/-- 人手証明の主張「シフト行列を右から掛けると列の添字が逆向きにシフトされる」。 -/
theorem mul_permMatrix_apply (hone' : ∀ a : S, a * (1 : S) = a)
    (hzero' : ∀ a : S, a * (0 : S) = 0)
    (e : ι ≃ ι) (A : ι → ι → S) (i k : ι) :
    (∑ j : ι, A i j * permMatrix e j k) = A i (e.symm k) := by
  rw [Finset.sum_eq_single (e.symm k)]
  · rw [permMatrix, if_pos ((eq_apply_iff e _ k).mpr rfl), hone']
  · intro j _ hj
    have : ¬ (k = e j) := fun h => hj (((eq_apply_iff e j k).mp h).symm)
    rw [permMatrix, if_neg this, hzero']
  · intro h
    exact absurd (mem_univ _) h

/-- 人手証明の定理「シフト行列と転送行列は可換である」。

`A` に要求するのは `e` による不変性 `A (e i) (e j) = A i j` だけであり、
`A` が転送行列であることは使っていない。証明は人手証明どおり 4 つの等号である。 -/
theorem permMatrix_comm (hone : ∀ a : S, (1 : S) * a = a)
    (hzero : ∀ a : S, (0 : S) * a = 0)
    (hone' : ∀ a : S, a * (1 : S) = a)
    (hzero' : ∀ a : S, a * (0 : S) = 0)
    (e : ι ≃ ι) (A : ι → ι → S)
    (hA : ∀ i j : ι, A (e i) (e j) = A i j) (i k : ι) :
    (∑ j : ι, permMatrix e i j * A j k) = ∑ j : ι, A i j * permMatrix e j k := by
  rw [permMatrix_mul_apply hone hzero, mul_permMatrix_apply hone' hzero']
  -- A (e i) k = A (e i) (e (e.symm k)) = A i (e.symm k)
  conv_lhs => rw [show k = e (e.symm k) from (e.apply_symm_apply k).symm]
  exact hA i (e.symm k)

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
