/-
具体版が必要十分版の特殊化として得られることを示す（`docs/context/証明の書き方.md` の要件 4）。

必要十分版の `glue` / `glue_mem_block` / `glue_bijective` / `restriction_glue` に
ι := RowConfig L、blk := τ ↦ O(τ)、𝒪 := 𝒪_L、α := 組 を代入すると、具体版の
`glueFun` / `glueFun_mem_orbit` / `glueFun_bijective` / `glueFun_apply_of_mem` が得られる。

代入に要るのは次の 4 つだけである。

1. `hself`: どの τ も自分の軌道に属すること（`self_mem_rowShiftOrbit`）。
2. `hblk`: O(τ) が 𝒪_L に属すること（`mem_rowShiftOrbitSet`）。
3. `huniq`: τ ∈ O ∈ 𝒪_L ならば O(τ) = O（`rowShiftOrbit_eq_of_mem_orbitSet`。
   具体版ではこれを `claim_row_config_orbit_mem_eq` から出しており、
   互いに素であること（`claim_row_config_orbit_disjoint_or_eq`）はこの一意性の別の顔である）。
4. `hbij`: 軌道の上で組が全単射であること（具体版の `OrbitFamilyBijective`）。

すなわち具体版が軌道の理論から借りているのは「各点に軌道が 1 つ定まる」ことだけであり、
巡回シフト・最小周期・行配位であることはいずれも効いていない。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitGluing
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitGluing

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 必要十分版へ渡す「どの τ も自分の軌道に属する」。 -/
theorem self_mem_blk (L : ℕ) [NeZero L] (τ : RowConfig L) : τ ∈ rowShiftOrbit L τ :=
  self_mem_rowShiftOrbit τ

/-- 必要十分版へ渡す「点の属する集合が一意であること」。

具体版では `claim_row_config_orbit_mem_eq` から出している。 -/
theorem blk_uniq (L : ℕ) [NeZero L] :
    ∀ O ∈ {O : Finset (RowConfig L) | O ∈ rowShiftOrbitSet L},
      ∀ τ ∈ O, rowShiftOrbit L τ = O :=
  fun _ hO _ hτ => rowShiftOrbit_eq_of_mem_orbitSet hO hτ

/-- 具体版の貼り合わせが、必要十分版の貼り合わせと同じ写像であること。 -/
theorem glueFun_eq_necSuf (α : OrbitFamily L) :
    glueFun α = NecSuf.AlgebraicEigenvalue.glue α (rowShiftOrbit L) (self_mem_blk L) := by
  funext τ
  rfl

/-- 主張「貼り合わせは軌道を保つ置換である」の本体を、必要十分版から導いたもの。 -/
theorem glueFun_mem_orbit_from_necSuf (α : OrbitFamily L) (τ : RowConfig L) :
    glueFun α τ ∈ rowShiftOrbit L τ := by
  rw [glueFun_eq_necSuf α]
  exact NecSuf.AlgebraicEigenvalue.glue_mem_block α (rowShiftOrbit L) (self_mem_blk L) τ

/-- 主張「貼り合わせは行配位の全体の上の全単射である」を、必要十分版から導いたもの。 -/
theorem glueFun_bijective_from_necSuf {α : OrbitFamily L} (hbij : OrbitFamilyBijective α) :
    Function.Bijective (glueFun α) := by
  rw [glueFun_eq_necSuf α]
  refine NecSuf.AlgebraicEigenvalue.glue_bijective
    (𝒪 := {O : Finset (RowConfig L) | O ∈ rowShiftOrbitSet L}) ?_ (blk_uniq L) ?_
  · -- O(τ) ∈ 𝒪_L
    intro τ
    exact mem_rowShiftOrbitSet.mpr ⟨τ, rfl⟩
  · -- 軌道の上で組は全単射
    intro O hO
    exact hbij O hO

/-- 主張「貼り合わせの各軌道への制限はもとの組に一致する」を、必要十分版から導いたもの。 -/
theorem orbitRestriction_gluePerm_from_necSuf {α : OrbitFamily L}
    (hbij : OrbitFamilyBijective α)
    {O : Finset (RowConfig L)} (hO : O ∈ rowShiftOrbitSet L) :
    orbitRestriction (gluePerm_orbitPreserving hbij) hO = α O := by
  funext τ
  refine Subtype.ext ?_
  show glueFun α τ.1 = (α O τ).1
  rw [glueFun_eq_necSuf α]
  rw [NecSuf.AlgebraicEigenvalue.restriction_glue (blk_uniq L) hO τ.2, Subtype.coe_eta]

end Ising2DLambda.AlgebraicEigenvalue
