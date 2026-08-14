/-
「同じ分配多項式は異なる二点データを区別しない」の必要十分版。

具体版の証明で使う性質だけを残す。

  使っている性質                                  なぜ削れないか
  共通データ `partition`                           二つの標識が同じ単変数データを持つことを述べるため。
  二つの二点データと整数値の係数写像              四次係数を比較して二点データの相違を示すため。
  一致数・不一致数と係数の差の等式                人手証明の係数計算を保つため。
  四つの有限な数え上げ結果 20・10・12・18         係数 10 と -6 を得るため。

箱・頂点・辺・配位・破れ数・多項式は仮定しない。それらは四つの有限な
数え上げと係数写像を与える具体的な仕組みである。証明手順は具体版と同じ
（二つの係数を差として計算し、データが等しいと仮定して係数の一致から矛盾を得る）。

住処: 任意の型・自然数・整数のみ。ℝ / ℂ は現れない。
-/
import Mathlib

namespace Ising3DCut.NecSuf.NullModel

/-- 必要十分版の主定理。共通の単変数データを持ちながら、二つの二点データは異なる。 -/
theorem same_partition_different_pairData
    {PartitionData PairData : Type*}
    (partition : PartitionData) (adjacent diagonal : PairData)
    (coeff : PairData → ℕ → ℤ)
    (adjacentAgree adjacentDisagree diagonalAgree diagonalDisagree : ℕ)
    (hadjAgree : adjacentAgree = 20) (hadjDisagree : adjacentDisagree = 10)
    (hdiagAgree : diagonalAgree = 12) (hdiagDisagree : diagonalDisagree = 18)
    (hadjCoeff : coeff adjacent 4 = (adjacentAgree : ℤ) - adjacentDisagree)
    (hdiagCoeff : coeff diagonal 4 = (diagonalAgree : ℤ) - diagonalDisagree) :
    partition = partition ∧
    coeff adjacent 4 = 10 ∧
    coeff diagonal 4 = -6 ∧
    adjacent ≠ diagonal := by
  refine ⟨rfl, ?_, ?_, ?_⟩
  · rw [hadjCoeff, hadjAgree, hadjDisagree]
    norm_num
  · rw [hdiagCoeff, hdiagAgree, hdiagDisagree]
    norm_num
  · intro h
    have hcoeff := congrArg (fun pair ↦ coeff pair 4) h
    rw [hadjCoeff, hdiagCoeff, hadjAgree, hadjDisagree,
      hdiagAgree, hdiagDisagree] at hcoeff
    norm_num at hcoeff

end Ising3DCut.NecSuf.NullModel
