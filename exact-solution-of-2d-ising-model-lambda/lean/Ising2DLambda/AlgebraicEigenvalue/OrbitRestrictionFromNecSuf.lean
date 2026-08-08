/-
具体版が必要十分版の特殊化として得られることを示す（`docs/context/証明の書き方.md` の要件 4）。

必要十分版の `restrictionOf` / `restriction_bijective` / `eq_of_agree_on_cover` に
ι := RowConfig L、O := 軌道、φ := 軌道を保つ置換を代入すると、具体版の
`orbitRestriction` / `orbitRestriction_bijective` / `eq_of_orbitRestriction_eq` が得られる。

代入に要るのは次の 2 つだけである。

1. 軌道が置換の像で閉じていること `O.image φ = O`
   （具体版の `image_orbit_eq_of_orbitPreserving`。これが必要十分版の唯一の仮定である）。
2. 軌道の全体が R_L を覆うこと（どの τ も自分の軌道に属すること）。
   必要十分版の `eq_of_agree_on_cover` が要求するのはこれだけで、
   **軌道どうしが互いに素であることは渡していない。**

すなわち具体版が軌道の理論から借りているのは「像で閉じる」と「覆う」の 2 つだけであり、
最小周期・巡回シフト・行配位であることはいずれも効いていない。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitRestriction
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitRestriction

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 具体版の制限が、必要十分版の制限（仮定は `O.image φ = O` だけ）と同じ写像であること。 -/
theorem orbitRestriction_eq_necSuf {φ : Equiv.Perm (RowConfig L)} (hφ : OrbitPreserving L φ)
    {O : Finset (RowConfig L)} (hO : O ∈ rowShiftOrbitSet L) :
    orbitRestriction hφ hO =
      NecSuf.AlgebraicEigenvalue.restrictionOf φ
        (image_orbit_eq_of_orbitPreserving hφ hO) := by
  funext τ
  rfl

/-- 主張「軌道への制限はその軌道の上の全単射である」を、必要十分版から導いたもの。 -/
theorem orbitRestriction_bijective_from_necSuf {φ : Equiv.Perm (RowConfig L)}
    (hφ : OrbitPreserving L φ) {O : Finset (RowConfig L)} (hO : O ∈ rowShiftOrbitSet L) :
    Function.Bijective (orbitRestriction hφ hO) := by
  rw [orbitRestriction_eq_necSuf hφ hO]
  exact NecSuf.AlgebraicEigenvalue.restriction_bijective φ
    (image_orbit_eq_of_orbitPreserving hφ hO)

/-- 主張「制限の全体が一致する軌道を保つ置換は一致する」を、必要十分版から導いたもの。

族としては軌道の全体 `𝒪_L` を渡す。覆うことは「どの τ も自分の軌道に属する」ことから出る。 -/
theorem eq_of_orbitRestriction_eq_from_necSuf {φ ψ : Equiv.Perm (RowConfig L)}
    (hφ : OrbitPreserving L φ) (hψ : OrbitPreserving L ψ)
    (heq : ∀ (O : Finset (RowConfig L)) (hO : O ∈ rowShiftOrbitSet L),
      orbitRestriction hφ hO = orbitRestriction hψ hO) : φ = ψ := by
  classical
  refine NecSuf.AlgebraicEigenvalue.eq_of_agree_on_cover
    {O : Finset (RowConfig L) | O ∈ rowShiftOrbitSet L} ?_ ?_
  · -- 覆うこと: τ ∈ O(τ) ∈ 𝒪_L
    intro τ
    exact ⟨rowShiftOrbit L τ, mem_rowShiftOrbitSet.mpr ⟨τ, rfl⟩, self_mem_rowShiftOrbit τ⟩
  · -- 各軌道の上で φ と ψ が一致すること
    intro O hO τ hτ
    have h := heq O hO
    rw [orbitRestriction_eq_necSuf hφ hO, orbitRestriction_eq_necSuf hψ hO] at h
    exact NecSuf.AlgebraicEigenvalue.apply_eq_of_restriction_eq _ _ h hτ

end Ising2DLambda.AlgebraicEigenvalue
