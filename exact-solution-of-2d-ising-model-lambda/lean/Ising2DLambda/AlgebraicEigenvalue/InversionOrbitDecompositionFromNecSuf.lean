/-
具体版が必要十分版の特殊化として得られることを示す（`docs/context/証明の書き方.md` の要件 4）。

必要十分版の `inversionPairs` / `innerInversionPairs` / `crossOrbitInversionPairs` /
`inner_eq_filter_crossPairs` / `inversion_count_decomposition` に
ι := RowConfig L、lt := rowConfigLess L、f := φ、P := orderedPairs L、
orb := rowShiftOrbit L、𝒪 := rowShiftOrbitSet L を代入すると、具体版が得られる。

代入に要るのは次の 4 つだけである。

1. `hP`: `orderedPairs L` が `≺` で順序づけられた対をちょうど集めていること（`mem_orderedPairs`）。
2. `hself`: どの行配位も自分の軌道に属すること（`self_mem_rowShiftOrbit`）。
3. `horbMem`: 軌道が軌道の全体に属すること（`mem_rowShiftOrbitSet`）。
4. `huniq`: 軌道に属する点の軌道はその軌道であること（`rowShiftOrbit_eq_of_mem`。
   人手証明の `claim_row_config_orbit_mem_eq`）。

すなわち具体版が使っているのは、`≺` については**何もなく**（非対称性も三分律も推移律も
使っていない。前のセクションの偶数性とはここが違う）、軌道については
「点は自分の軌道に属する」「軌道に属する点の軌道はその軌道」だけである。
置換であること（単射性・全射性）も巡回シフトも最小周期も効いていない。
-/
import Ising2DLambda.AlgebraicEigenvalue.InversionOrbitDecomposition
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.InversionOrbitDecomposition

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 具体版の `Inv(φ)` が、必要十分版の `inversionPairs` と同じ有限集合であること。 -/
theorem inversionPairs_eq_necSuf (φ : Equiv.Perm (RowConfig L)) :
    inversionPairs L φ
      = NecSuf.AlgebraicEigenvalue.inversionPairs (rowConfigLess L) φ (orderedPairs L) := rfl

/-- 具体版の `A(O)` が、必要十分版の `innerInversionPairs` と同じ有限集合であること。 -/
theorem innerInversionPairs_eq_necSuf (φ : Equiv.Perm (RowConfig L))
    (O : Finset (RowConfig L)) :
    innerInversionPairs L φ O
      = NecSuf.AlgebraicEigenvalue.innerInversionPairs (rowConfigLess L) φ (orderedPairs L) O :=
  rfl

/-- 具体版の `Inv^≠(φ)` が、必要十分版の `crossOrbitInversionPairs` と同じ有限集合であること。 -/
theorem crossOrbitInversionPairs_eq_necSuf (φ : Equiv.Perm (RowConfig L)) :
    crossOrbitInversionPairs L φ
      = NecSuf.AlgebraicEigenvalue.crossOrbitInversionPairs (rowConfigLess L) φ
          (orderedPairs L) (rowShiftOrbit L) := by
  classical
  rfl

/-- 主張「1 つの軌道の中の転倒対の個数は、制限の転倒数である」の集合の等号を、
必要十分版から導いたもの。 -/
theorem innerInversionPairs_eq_filter_from_necSuf (φ : Equiv.Perm (RowConfig L))
    (O : Finset (RowConfig L)) :
    innerInversionPairs L φ O
      = (crossOrderedPairs L O O).filter fun p => rowConfigLess L (φ p.2) (φ p.1) := by
  classical
  rw [innerInversionPairs_eq_necSuf]
  exact NecSuf.AlgebraicEigenvalue.inner_eq_filter_crossPairs
    (fun _ => mem_orderedPairs) O

/-- 主張「1 つの軌道の中の転倒対の個数は、制限の転倒数である」を、必要十分版から導いたもの。 -/
theorem card_innerInversionPairs_from_necSuf {φ : Equiv.Perm (RowConfig L)}
    (hφ : OrbitPreserving L φ) {O : Finset (RowConfig L)} (hO : O ∈ rowShiftOrbitSet L) :
    (innerInversionPairs L φ O).card
      = orbitInversionCount L O (orbitRestrictionAmbient hφ hO) := by
  classical
  rw [orbitInversionCount_congr (g := orbitRestrictionAmbient hφ hO) (g' := φ)
      fun τ hτ => orbitRestrictionAmbient_eq hφ hO hτ,
    orbitInversionCount, ← innerInversionPairs_eq_filter_from_necSuf φ O]

/-- 主張「転倒数は、軌道ごとの転倒数の和と、またぐ転倒対の個数の和である」を、
必要十分版から導いたもの。 -/
theorem inversionCount_orbit_decomposition_from_necSuf {φ : Equiv.Perm (RowConfig L)}
    (hφ : OrbitPreserving L φ) :
    inversionCount L φ
      = (∑ O ∈ (rowShiftOrbitSet L).attach,
          orbitInversionCount L O.1 (orbitRestrictionAmbient hφ O.2))
        + (crossOrbitInversionPairs L φ).card := by
  classical
  have hdec := NecSuf.AlgebraicEigenvalue.inversion_count_decomposition
    (lt := rowConfigLess L) (f := φ) (P := orderedPairs L) (orb := rowShiftOrbit L)
    (𝒪 := rowShiftOrbitSet L)
    self_mem_rowShiftOrbit
    (fun τ => mem_rowShiftOrbitSet.mpr ⟨τ, rfl⟩)
    (fun O hO a ha => by
      obtain ⟨τ, hτ⟩ := mem_rowShiftOrbitSet.mp hO
      subst hτ
      exact rowShiftOrbit_eq_of_mem τ ha)
  rw [inversionCount_eq_card_inversionPairs, inversionPairs_eq_necSuf, hdec,
    ← crossOrbitInversionPairs_eq_necSuf]
  congr 1
  rw [← Finset.sum_attach (rowShiftOrbitSet L)
    (fun O => (NecSuf.AlgebraicEigenvalue.innerInversionPairs (rowConfigLess L) φ
      (orderedPairs L) O).card)]
  refine Finset.sum_congr rfl ?_
  intro O _
  rw [← innerInversionPairs_eq_necSuf]
  exact card_innerInversionPairs_from_necSuf hφ O.2

end Ising2DLambda.AlgebraicEigenvalue
