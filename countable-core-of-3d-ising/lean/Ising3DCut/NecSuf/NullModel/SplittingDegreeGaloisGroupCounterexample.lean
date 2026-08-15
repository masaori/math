/-
「分解体の次数と Galois 群だけでは多項式を決めない」の必要十分版。

具体版の証明で使う性質だけを残す。

  使っている性質                                  なぜ削れないか
  二つの対象 `A` `B` とデータ写像 `constantCoeff`  相違を定数係数の相違から導くため。
  `constantCoeff A ≠ constantCoeff B`             人手証明の相違の段（定数係数の比較）を保つため。
  分解の述語 `splits` と二つの成立                 二つの対象が同じ「分解する」データを持つことを述べるため。
  次数の値 `degree` と `degree = 1`                二つの対象が同じ次数データを持つことを述べるため。
  型 `GaloisGroup` の一元性                        二つの対象が同じ（一元の）Galois 群データを持つことを述べるため。

多項式・有理数・体・自己同型は仮定しない。それらは対象・データ写像・述語・型を
与える具体的な仕組みである。証明手順は具体版と同じ
（データ写像の値の相違から対象の相違を得て、共有されるデータと並べる）。

住処: 任意の型・自然数のみ。ℝ / ℂ は現れない。
-/
import Mathlib

namespace Ising3DCut.NecSuf.NullModel

/-- 必要十分版の主定理。データ写像の値が異なる二つの対象は相異なるが、
分解・次数・Galois 群のデータは共有する。 -/
theorem splittingDegree_galoisGroup_do_not_determine_polynomial
    {Poly Value : Type*} {GaloisGroup : Type*}
    (A B : Poly)
    (constantCoeff : Poly → Value)
    (splits : Poly → Prop)
    (degree : ℕ)
    (hcoeff : constantCoeff A ≠ constantCoeff B)
    (hsplitsA : splits A) (hsplitsB : splits B)
    (hdegree : degree = 1)
    (hgalois : Subsingleton GaloisGroup) :
    A ≠ B ∧ splits A ∧ splits B ∧ degree = 1 ∧ Subsingleton GaloisGroup := by
  refine ⟨?_, hsplitsA, hsplitsB, hdegree, hgalois⟩
  intro h
  exact hcoeff (congrArg constantCoeff h)

end Ising3DCut.NecSuf.NullModel
