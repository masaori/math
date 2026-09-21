/-
章「Onsager 閉形式への接続」の
「周期延長した持ち上げは有限幅の整数帯に入る」
（`claim_periodic_plane_lift_transverse_bounded`）の具体版。

人手証明と同じく、巻き付きに直交する整数座標へ周期延長の定義を代入し、
周期並進の二つの交差項を整数の分配法則で打ち消す。住処は ℤ だけであり、ℝ / ℂ は現れない。
-/
import Ising2DLambda.KacWard.PeriodicPlaneLiftDistinct
import Ising2DLambda.NecSuf.KacWard.PeriodicPlaneLiftTransverseBounded
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- `def_winding_transverse_coordinate`。巻き付きベクトルに直交する整数座標。 -/
def windingTransverseCoordinate (wh wv : ℤ) : (ℤ × ℤ) →+ ℤ where
  toFun p := wh * p.1 - wv * p.2
  map_zero' := by simp
  map_add' := by
    intro p p'
    dsimp
    ring

/-- 巻き付きに直交する座標は、一周期の平面並進ベクトルを零へ送る。 -/
lemma windingTransverseCoordinate_windingShift
    (L : ℕ) (wv wh : ℤ) :
    windingTransverseCoordinate wh wv (windingShift L wv wh) = 0 := by
  simp [windingTransverseCoordinate, windingShift]
  ring

/-- `claim_periodic_plane_lift_transverse_bounded` の横断座標の等式。 -/
theorem periodicPlaneLift_transverseCoordinate_eq_base
    (m L : ℕ) (base : ℤ → ℤ × ℤ) (wv wh k : ℤ) :
    windingTransverseCoordinate wh wv (periodicPlaneLift m base L wv wh k) =
      windingTransverseCoordinate wh wv (base (k % (m : ℤ))) := by
  exact periodic_lift_coordinate_eq_base_necSuf
    base (windingShift L wv wh) (fun t => t / (m : ℤ)) (fun t => t % (m : ℤ))
    (windingTransverseCoordinate wh wv)
    (windingTransverseCoordinate_windingShift L wv wh) k

/-- `claim_periodic_plane_lift_transverse_bounded` の具体版。
周期延長した横断座標の値は一周期内の値だけからなり、したがって有限集合である。 -/
theorem periodicPlaneLift_transverseCoordinate_range_finite
    (m L : ℕ) (hm : 0 < m) (base : ℤ → ℤ × ℤ) (wv wh : ℤ) :
    Set.Finite (Set.range fun k : ℤ =>
      windingTransverseCoordinate wh wv (periodicPlaneLift m base L wv wh k)) := by
  let residues : Set ℤ := Set.Ico 0 (m : ℤ)
  have hresidues : residues.Finite := Set.finite_Ico 0 (m : ℤ)
  have himage :
      (windingTransverseCoordinate wh wv ∘ base) '' residues |>.Finite :=
    hresidues.image (windingTransverseCoordinate wh wv ∘ base)
  apply himage.subset
  rintro z ⟨k, rfl⟩
  refine ⟨k % (m : ℤ), ?_, ?_⟩
  · exact ⟨Int.emod_nonneg k (by omega), Int.emod_lt_of_pos k (by omega)⟩
  · exact (periodicPlaneLift_transverseCoordinate_eq_base m L base wv wh k).symm

end Ising2DLambda.KacWard
