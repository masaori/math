/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

必要十分版に α := RowConfig L、lt := rowConfigLess L、s := O を代入すると、
具体版の定義と 2 主張が出る。代入する仮定は次の 4 つだけである。
`a ∈ O`、`b ∈ O`、`rowConfigLess L a b`、および順序 ≺ の非対称性と推移律。

このことは、具体版の証明が次を使っていないという主張の裏取りになっている。
行配位であること・格子の形・`O` が軌道であること・`≺` の全順序性・型の有限性。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitTranspositionSign
import Ising2DLambda.AlgebraicEigenvalue.OrbitTranspositionFromNecSuf
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitTranspositionSign

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 具体版が使う順序の性質を、必要十分版の仮定の形へ書き直したもの（非対称性）。 -/
theorem rowConfigLess_asymm_necSuf :
    ∀ τ τ' : RowConfig L, rowConfigLess L τ τ' → ¬ rowConfigLess L τ' τ :=
  fun _ _ h => asymm_of_rowConfigLess h

/-- 同じく推移律。 -/
theorem rowConfigLess_trans_necSuf :
    ∀ τ τ' τ'' : RowConfig L, rowConfigLess L τ τ' → rowConfigLess L τ' τ'' →
      rowConfigLess L τ τ'' :=
  fun _ _ _ h1 h2 => rowConfigLess_trans h1 h2

/-- 具体版の `orbitInversionSet` が、必要十分版の `inversionSetOn` の特殊化であること。

`rfl` ではなく外延性で述べる（具体版の定義が `noncomputable` で置かれており、
決定可能性の実例が別々に選ばれうるため）。 -/
theorem orbitInversionSet_eq_necSuf (O : Finset (RowConfig L))
    (g : RowConfig L → RowConfig L) :
    orbitInversionSet L O g
      = NecSuf.AlgebraicEigenvalue.inversionSetOn (rowConfigLess L) O g := by
  ext p
  rw [mem_orbitInversionSet, NecSuf.AlgebraicEigenvalue.mem_inversionSetOn]

/-- 第一の主張を、必要十分版から導いたもの。 -/
theorem orbitTransposition_inversionCount_from_necSuf {O : Finset (RowConfig L)}
    {a b : RowConfig L} (ha : a ∈ O) (hb : b ∈ O) (hab : rowConfigLess L a b) :
    orbitInversionCount L O (orbitTransposition L a b)
      = 2 * (NecSuf.AlgebraicEigenvalue.betweenOn (rowConfigLess L) O a b).card + 1 := by
  have hnec := NecSuf.AlgebraicEigenvalue.inversionCountOn_transposition
    (rowConfigLess L) rowConfigLess_asymm_necSuf rowConfigLess_trans_necSuf ha hb hab
  calc orbitInversionCount L O (orbitTransposition L a b)
      = (orbitInversionSet L O (orbitTransposition L a b)).card :=
        orbitInversionCount_eq_card _ _
    _ = (NecSuf.AlgebraicEigenvalue.inversionSetOn (rowConfigLess L) O
          (orbitTransposition L a b)).card := by
        rw [orbitInversionSet_eq_necSuf]
    _ = (NecSuf.AlgebraicEigenvalue.inversionSetOn (rowConfigLess L) O
          (NecSuf.AlgebraicEigenvalue.transpositionOn a b)).card := by
        have hfun : orbitTransposition L a b
            = NecSuf.AlgebraicEigenvalue.transpositionOn a b :=
          funext fun τ => orbitTransposition_eq_necSuf a b τ
        rw [hfun]
    _ = 2 * (NecSuf.AlgebraicEigenvalue.betweenOn (rowConfigLess L) O a b).card + 1 := hnec

/-- 第二の主張を、必要十分版から導いたもの。 -/
theorem orbitTransposition_sign_from_necSuf {O : Finset (RowConfig L)}
    {a b : RowConfig L} (ha : a ∈ O) (hb : b ∈ O) (hab : rowConfigLess L a b) :
    orbitPermSign L O (orbitTransposition L a b) = -1 := by
  have hcount := orbitTransposition_inversionCount_from_necSuf ha hb hab
  calc orbitPermSign L O (orbitTransposition L a b)
      = (-1 : ℤ) ^ orbitInversionCount L O (orbitTransposition L a b) := rfl
    _ = (-1 : ℤ) ^ (2 *
          (NecSuf.AlgebraicEigenvalue.betweenOn (rowConfigLess L) O a b).card + 1) := by
        rw [hcount]
    _ = ((-1 : ℤ) ^ 2) ^
          (NecSuf.AlgebraicEigenvalue.betweenOn (rowConfigLess L) O a b).card
            * (-1 : ℤ) ^ 1 := by
        rw [pow_add, pow_mul]
    _ = -1 := by norm_num

end Ising2DLambda.AlgebraicEigenvalue
