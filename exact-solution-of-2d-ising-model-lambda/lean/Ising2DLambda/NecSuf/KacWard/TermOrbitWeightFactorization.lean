/-
必要十分版: 可換モノイドに値を取る有限積は、単射で各点が回帰する自己写像について、
固定点の部分積と、動く点の軌道族ごとの部分積の積に分かれる。

使う構造は可換モノイド、有限性、相等の判定、写像の単射性、各点の回帰の存在だけである。
多項式環、行列、符号は使わない。
-/
import Ising2DLambda.NecSuf.KacWard.MovedOrbitPartition

namespace Ising2DLambda.NecSuf.KacWard

open Finset
open Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {E : Type} [Fintype E] [DecidableEq E]

/-- 有限積は固定点の積と軌道族ごとの積の積に分かれる。 -/
theorem prod_fixed_orbit_factorization {R : Type} [CommMonoid R]
    (f : E → E) (hf : Function.Injective f)
    (hreturn : ∀ e : E, ∃ k, 1 ≤ k ∧ iterLeft f k e = e)
    (g : E → R) :
    ∏ e, g e =
      (∏ e ∈ univ.filter fun e => f e = e, g e) *
        ∏ O ∈ movedOrbitSet f, ∏ e ∈ O, g e := by
  classical
  obtain ⟨-, hdisj, hcover⟩ := movedOrbitSet_partition f hf hreturn
  -- 全体を固定点集合と動く点集合へ互いに素に分ける。
  have hsplit : ∏ e, g e =
      (∏ e ∈ univ.filter fun e => f e = e, g e) * ∏ e ∈ movedSet f, g e := by
    rw [← Finset.prod_filter_mul_prod_filter_not univ (fun e => f e = e) g]
    rfl
  -- 動く点集合の積を、軌道族の合併の積として読み替えて族ごとの積へ開く。
  have hbiUnion : ∏ e ∈ movedSet f, g e =
      ∏ O ∈ movedOrbitSet f, ∏ e ∈ O, g e := by
    rw [← hcover]
    exact Finset.prod_biUnion fun O₁ hO₁ O₂ hO₂ hne => hdisj O₁ hO₁ O₂ hO₂ hne
  rw [hsplit, hbiUnion]

end Ising2DLambda.NecSuf.KacWard
