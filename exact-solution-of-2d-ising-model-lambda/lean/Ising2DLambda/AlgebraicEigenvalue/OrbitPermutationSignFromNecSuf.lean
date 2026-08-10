/-
具体版が必要十分版の特殊化として得られることを示す（`docs/context/証明の書き方.md` の要件 4）。

必要十分版の `pow_eq_prod_pow_of_even_remainder` に
M := ℤ、u := -1、β := { O // O ∈ 𝒪_L }、s := (rowShiftOrbitSet L).attach、
f := fun O => inv_O(φ↾_O)、n := inv(φ)、k := Σ_{(O,O') ∈ D_L} |F \ F_φ| を代入すると、
具体版の主張が得られる。

代入に要るのは次の 2 つだけである。

1. `hu`: `(-1) * (-1) = 1`（ℤ の中の計算）。
2. `hn`: `inv(φ) = (Σ_O inv_O(φ↾_O)) + 2 k`。これは前 2 セクションの
   `inversionCount_orbit_decomposition`（転倒数の分解）と
   `card_crossOrbitInversionPairs_eq_two_mul`（またぐ転倒対の個数の偶数性）を継いだものである。

**順序 `≺` も軌道も、この代入には現れない。** どちらも `f` と `n` と `k` を作る側にあり、
冪を積へ分ける段そのものには入ってこない。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitPermutationSign
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitPermutationSign

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L] {φ : Equiv.Perm (RowConfig L)}

/-- 主張「軌道を保つ置換の符号は、軌道ごとの符号の積である」を、必要十分版から導いたもの。 -/
theorem permSign_eq_prod_orbitPermSign_from_necSuf (hφ : OrbitPreserving L φ) :
    permSign L φ
      = ∏ O ∈ (rowShiftOrbitSet L).attach,
          orbitPermSign L O.1 (orbitRestrictionAmbient hφ O.2) := by
  classical
  have hn : inversionCount L φ
      = (∑ O ∈ (rowShiftOrbitSet L).attach,
          orbitInversionCount L O.1 (orbitRestrictionAmbient hφ O.2))
        + 2 * ∑ q ∈ orientedOrbitPairs L,
            (crossOrderedPairs L q.1 q.2 \ crossOrderedPairsImage L φ q.1 q.2).card := by
    rw [inversionCount_orbit_decomposition hφ, card_crossOrbitInversionPairs_eq_two_mul hφ]
  exact NecSuf.AlgebraicEigenvalue.pow_eq_prod_pow_of_even_remainder
    (M := ℤ) (-1) (by norm_num) (rowShiftOrbitSet L).attach
    (fun O => orbitInversionCount L O.1 (orbitRestrictionAmbient hφ O.2))
    (inversionCount L φ) _ hn

end Ising2DLambda.AlgebraicEigenvalue
