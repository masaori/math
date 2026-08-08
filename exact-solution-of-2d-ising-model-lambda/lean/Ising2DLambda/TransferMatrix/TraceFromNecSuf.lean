/-
具体版が必要十分版の特殊化として得られることの明示（`lean/README.md` の要件 4）。

必要十分版 `NecSuf.TransferMatrix.trace_matPow_eq_sum_cyclicWeight` に
  S := ℤ[x]（可換半環として使う。環であることは使わない）、ι := RowConfig L、n := L
を代入すると、人手証明の「Θ が全単射である等号」までが出る。残るのは
  rows が全単射である等号  配位全体と行配位の族全体の 1 対 1 対応（rowsEquiv）
  重みの積の等号          配位の重みが行に沿った転送行列の成分の積であること（transfer_weight_product）
  分配多項式の定義の等号  分配多項式の定義
の 3 つで、これらは分配多項式と転送行列に固有なので必要十分版には無い。
このファイルはその 3 つだけを足して具体版の定理を導く。

したがってこのファイルは、`Z_L = Tr(T^L)` のうち
「トレースを周期的な添字づけにわたる和として書き直す」部分が
値が多項式であることにも格子の形にも依存していないことの裏取りになっている。

住処: ℤ[x] のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.TransferMatrix.Trace
import Ising2DLambda.TransferMatrix.PowerEntryFromNecSuf
import Ising2DLambda.NecSuf.TransferMatrix.Trace

namespace Ising2DLambda.TransferMatrix

open Finset PartitionPolynomial

variable (L : ℕ) [NeZero L]

/-- トレースが一致する。 -/
lemma rowMatrixTrace_eq_matTrace (A : RowMatrix L) :
    rowMatrixTrace L A = NecSuf.TransferMatrix.matTrace A := rfl

/-- 閉じた道の全体が一致する。 -/
lemma closedRowWalks_eq (L : ℕ) [NeZero L] :
    closedRowWalks L = NecSuf.TransferMatrix.closedWalks (RowConfig L) L := rfl

/-- `Θ` が一致する。 -/
lemma walkOfFamily_eq (c : RowFamily L) :
    walkOfFamily L c = NecSuf.TransferMatrix.walkOfFamily c := rfl

/-- 具体版の定理を、必要十分版から導いたもの。 -/
theorem partitionPolynomial_eq_trace_from_necSuf :
    partitionPolynomial L = rowMatrixTrace L (rowMatrixPow L (transferMatrix L) (L - 1)) := by
  rw [rowMatrixTrace_eq_matTrace, rowMatrixPow_eq_matPow]
  rw [NecSuf.TransferMatrix.trace_matPow_eq_sum_cyclicWeight
    (S := Polynomial ℤ) (ι := RowConfig L) (n := L) (transferMatrix L)]
  -- 必要十分版は添字づけを `ZMod L → RowConfig L` と書くが、これは行配位の族の型そのものである。
  have hfamily :
      ∑ c : ZMod L → RowConfig L, ∏ i : ZMod L, transferMatrix L (c i) (c (i + 1))
        = ∑ c : RowFamily L, ∏ i : ZMod L, transferMatrix L (c i) (c (i + 1)) := rfl
  rw [hfamily]
  -- rows が全単射である等号。配位全体と行配位の族全体の 1 対 1 対応で和の添字を移す。
  rw [← Equiv.sum_comp (rowsEquiv L)
    fun c : RowFamily L => ∏ i : ZMod L, transferMatrix L (c i) (c (i + 1))]
  -- 配位の重みの等号と、分配多項式の定義の等号。
  exact (sum_congr rfl fun σ _ => transfer_weight_product L σ).symm

end Ising2DLambda.TransferMatrix
