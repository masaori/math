/-
章「Onsager 閉形式への接続」の
「非零巻き付きの頂点単純閉路の周期延長した持ち上げ点は相異なる」
（`claim_periodic_plane_lift_points_distinct`）の具体版。

人手証明と同じく、整数の除法による余りを格子剰余で区別し、非零巻き付きから
商を区別し、最後に商余り表示から整数添字を復元する。住処は ℕ・ℤ と有限剰余環であり、
ℝ / ℂ は現れない。
-/
import Ising2DLambda.NecSuf.KacWard.PeriodicPlaneLiftDistinct
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 整数格子点を一辺 `L` のトーラスの剰余類へ射影する。 -/
def residuePoint (L : ℕ) (p : ℤ × ℤ) : ZMod L × ZMod L :=
  ((p.1 : ZMod L), (p.2 : ZMod L))

/-- 一周期の平面並進ベクトル `(L wᵥ, L wₕ)`。 -/
def windingShift (L : ℕ) (wv wh : ℤ) : ℤ × ℤ :=
  ((L : ℤ) * wv, (L : ℤ) * wh)

/-- `def_periodic_plane_lift`。整数の除法の商と余りで一周期の持ち上げを延長する。 -/
def periodicPlaneLift
    (m : ℕ) (base : ℤ → ℤ × ℤ) (L : ℕ) (wv wh : ℤ) (k : ℤ) : ℤ × ℤ :=
  periodicLiftCore base (windingShift L wv wh) (fun t => t / (m : ℤ))
    (fun t => t % (m : ℤ)) k

/-- 周期並進は格子剰余への射影で消える。 -/
lemma residuePoint_add_windingShift
    (L : ℕ) (base : ℤ × ℤ) (q wv wh : ℤ) :
    residuePoint L (base + q • windingShift L wv wh) = residuePoint L base := by
  ext <;> simp [residuePoint, windingShift]

/-- `L > 0` かつ巻き付きが非零なら、周期並進ベクトルに整数ねじれは無い。 -/
lemma windingShift_zsmul_eq_zero_imp
    (L : ℕ) (hL : 0 < L) (wv wh : ℤ) (hwind : wv ≠ 0 ∨ wh ≠ 0) (z : ℤ)
    (hzero : z • windingShift L wv wh = 0) : z = 0 := by
  rcases hwind with hwv | hwh
  · have hcomponent : z * ((L : ℤ) * wv) = 0 := congrArg Prod.fst hzero
    rcases mul_eq_zero.mp hcomponent with hz | hperiod
    · exact hz
    · exact False.elim (mul_ne_zero (by omega) hwv hperiod)
  · have hcomponent : z * ((L : ℤ) * wh) = 0 := congrArg Prod.snd hzero
    rcases mul_eq_zero.mp hcomponent with hz | hperiod
    · exact hz
    · exact False.elim (mul_ne_zero (by omega) hwh hperiod)

/-- 正の除数に対する整数の商と余りは元の整数を区別する。 -/
lemma edivEmodPair_injective (m : ℕ) (hm : 0 < m) :
    Function.Injective (fun k : ℤ => (k / (m : ℤ), k % (m : ℤ))) := by
  have _hmz : (m : ℤ) ≠ 0 := by omega
  intro k k' h
  have hq : k / (m : ℤ) = k' / (m : ℤ) := congrArg Prod.fst h
  have hr : k % (m : ℤ) = k' % (m : ℤ) := congrArg Prod.snd h
  calc
    k = k / (m : ℤ) * (m : ℤ) + k % (m : ℤ) :=
      (Int.ediv_mul_add_emod k (m : ℤ)).symm
    _ = k' / (m : ℤ) * (m : ℤ) + k' % (m : ℤ) := by rw [hq, hr]
    _ = k' := Int.ediv_mul_add_emod k' (m : ℤ)

/-- `claim_periodic_plane_lift_points_distinct` の具体版。 -/
theorem periodicPlaneLift_injective
    (m L : ℕ) (hm : 0 < m) (hL : 0 < L)
    (base : ℤ → ℤ × ℤ) (wv wh : ℤ) (hwind : wv ≠ 0 ∨ wh ≠ 0)
    (hbase : ∀ k k' : ℤ,
      residuePoint L (base (k % (m : ℤ))) = residuePoint L (base (k' % (m : ℤ))) →
        k % (m : ℤ) = k' % (m : ℤ)) :
    Function.Injective (periodicPlaneLift m base L wv wh) := by
  apply periodic_lift_injective_necSuf base (windingShift L wv wh)
    (fun t => t / (m : ℤ)) (fun t => t % (m : ℤ)) (residuePoint L)
  · intro r q
    exact residuePoint_add_windingShift L (base r) q wv wh
  · exact hbase
  · exact windingShift_zsmul_eq_zero_imp L hL wv wh hwind
  · exact edivEmodPair_injective m hm

end Ising2DLambda.KacWard
