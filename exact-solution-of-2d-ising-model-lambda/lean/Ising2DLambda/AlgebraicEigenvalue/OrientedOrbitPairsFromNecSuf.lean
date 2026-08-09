/-
具体版が必要十分版の特殊化として得られることを示す（`docs/context/証明の書き方.md` の要件 4）。

必要十分版の `crossInv_disjoint` / `crossInv_eq_biUnion` / `card_biUnion_eq_two_mul` に
ι := RowConfig L、lt := rowConfigLess L、φ := φ、P := orderedPairs L、
orb := rowShiftOrbit L、𝒪 := rowShiftOrbitSet L、D := orientedOrbitPairs L を代入すると、
具体版の 3 主張が得られる。

代入に要るのは次の 10 個だけである。

1. `huniq`: 軌道に属する点の軌道はその軌道であること（`rowShiftOrbit_eq_of_mem_orbitSet`。
   人手証明の `claim_row_config_orbit_mem_eq`）。
2. `hself` / `horbMem`: 点は自分の軌道に属し、その軌道は軌道の全体に属すること。
3. `hDsub` / `hDne` / `hDasymm` / `hDtotal`: `D_L` が `𝒪_L × 𝒪_L` の中にあり、2 成分が
   相異なり、向きについて非対称で、相異なる 2 つの軌道の順序対の一方を含むこと
   （`mem_orientedOrbitPairs` / `ne_of_mem_orientedOrbitPairs` /
   `swap_not_mem_orientedOrbitPairs` / `mem_orientedOrbitPairs_or_swap`）。
4. `hasymm` / `htotal` / `hP` / `hdisj` / `hφ` / `hφinv`: 前のセクションの対ごとの偶数性が
   要求するもの（三分律から出る 2 つ、台の同定、軌道が互いに素であること、
   軌道を保つ置換とその逆写像が軌道を保つこと）。

**最小元 `μ` は代入に現れない。** 必要十分版が `D` から取り出しているのは
「非対称であること」と「相異なる 2 元の順序対の一方を含むこと」だけであり、
それがどう作られたかを問わないからである。すなわち人手証明が最小元を用意したのは
向きを 1 つ選ぶためであって、最小元の性質そのものは偶数性の議論に効いていない。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrientedOrbitPairs
import Ising2DLambda.AlgebraicEigenvalue.InversionOrbitDecompositionFromNecSuf
import Ising2DLambda.AlgebraicEigenvalue.CrossOrbitInversionsFromNecSuf
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrientedOrbitPairs

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L] {φ : Equiv.Perm (RowConfig L)}

/-- 必要十分版へ渡す `hDsub`。 -/
theorem orientedOrbitPairs_subset (q : Finset (RowConfig L) × Finset (RowConfig L))
    (hq : q ∈ orientedOrbitPairs L) :
    q.1 ∈ rowShiftOrbitSet L ∧ q.2 ∈ rowShiftOrbitSet L :=
  (mem_orientedOrbitPairs.mp hq).1

/-- 必要十分版へ渡す `huniq`。 -/
theorem rowShiftOrbit_uniq (O : Finset (RowConfig L)) (hO : O ∈ rowShiftOrbitSet L)
    (τ : RowConfig L) (hτ : τ ∈ O) : rowShiftOrbit L τ = O :=
  rowShiftOrbit_eq_of_mem_orbitSet hO hτ

/-- 主張「向きを付けた相異なる軌道の対が与えるまたがる転倒対は交わらない」を、
必要十分版から導いたもの。 -/
theorem crossInversions_disjoint_from_necSuf
    {q₁ q₂ : Finset (RowConfig L) × Finset (RowConfig L)}
    (h₁ : q₁ ∈ orientedOrbitPairs L) (h₂ : q₂ ∈ orientedOrbitPairs L) (hne : q₁ ≠ q₂) :
    Disjoint (crossInversions L φ q₁.1 q₁.2) (crossInversions L φ q₂.1 q₂.2) := by
  classical
  have h := NecSuf.AlgebraicEigenvalue.crossInv_disjoint
    (lt := rowConfigLess L) (φ := φ) (P := orderedPairs L) (orb := rowShiftOrbit L)
    (𝒪 := rowShiftOrbitSet L) (D := orientedOrbitPairs L)
    rowShiftOrbit_uniq orientedOrbitPairs_subset
    (fun _ hq => swap_not_mem_orientedOrbitPairs hq) h₁ h₂ hne
  rwa [← crossInversions_eq_necSuf, ← crossInversions_eq_necSuf] at h

/-- 主張「またぐ転倒対の全体は、向きを付けた軌道の対にわたる合併である」を、
必要十分版から導いたもの。 -/
theorem crossOrbitInversionPairs_eq_biUnion_from_necSuf (L : ℕ) [NeZero L]
    (φ : Equiv.Perm (RowConfig L)) :
    crossOrbitInversionPairs L φ
      = (orientedOrbitPairs L).biUnion fun q => crossInversions L φ q.1 q.2 := by
  classical
  have h := NecSuf.AlgebraicEigenvalue.crossInv_eq_biUnion
    (lt := rowConfigLess L) (φ := φ) (P := orderedPairs L) (orb := rowShiftOrbit L)
    (𝒪 := rowShiftOrbitSet L) (D := orientedOrbitPairs L)
    self_mem_rowShiftOrbit (fun τ => mem_rowShiftOrbitSet.mpr ⟨τ, rfl⟩)
    rowShiftOrbit_uniq orientedOrbitPairs_subset
    (fun _ hq => ne_of_mem_orientedOrbitPairs hq)
    (fun _ hO _ hO' hne => mem_orientedOrbitPairs_or_swap hO hO' hne)
  rw [crossOrbitInversionPairs_eq_necSuf, h]
  exact Finset.biUnion_congr rfl fun q _ => (crossInversions_eq_necSuf φ q.1 q.2).symm

/-- 主張「またぐ転倒対の全体の個数は偶数である」を、必要十分版から導いたもの。 -/
theorem card_crossOrbitInversionPairs_eq_two_mul_from_necSuf (hφ : OrbitPreserving L φ) :
    (crossOrbitInversionPairs L φ).card
      = 2 * ∑ q ∈ orientedOrbitPairs L,
          (crossOrderedPairs L q.1 q.2 \ crossOrderedPairsImage L φ q.1 q.2).card := by
  classical
  have h := NecSuf.AlgebraicEigenvalue.card_biUnion_eq_two_mul
    (lt := rowConfigLess L) (φ := φ) (P := orderedPairs L) (orb := rowShiftOrbit L)
    (𝒪 := rowShiftOrbitSet L) (D := orientedOrbitPairs L)
    rowConfigLess_asymm rowConfigLess_total (fun _ => mem_orderedPairs)
    (fun _ hO _ hO' hne a ha ha' => disjoint_of_ne_of_mem_orbitSet hO hO' hne ha ha')
    (fun _ hO _ ha => mem_of_orbitPreserving hφ hO ha)
    (fun _ hO _ ha => inv_mem_of_orbitPreserving hφ hO ha)
    self_mem_rowShiftOrbit (fun τ => mem_rowShiftOrbitSet.mpr ⟨τ, rfl⟩)
    rowShiftOrbit_uniq orientedOrbitPairs_subset
    (fun _ hq => ne_of_mem_orientedOrbitPairs hq)
    (fun _ hq => swap_not_mem_orientedOrbitPairs hq)
    (fun _ hO _ hO' hne => mem_orientedOrbitPairs_or_swap hO hO' hne)
  rw [crossOrbitInversionPairs_eq_necSuf, h]
  congr 1

end Ising2DLambda.AlgebraicEigenvalue
