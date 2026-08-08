/-
具体版が必要十分版の特殊化として得られることを示す（`docs/context/証明の書き方.md` の要件 4）。

必要十分版の `crossPairs` / `crossPairsImage` / `crossInv` / `card_pairs_image_eq` /
`card_crossInv_eq_two_mul` に ι := RowConfig L、lt := rowConfigLess L、P := orderedPairs L、
O・O' := 軌道 を代入すると、具体版の `crossOrderedPairs` / `crossOrderedPairsImage` /
`crossInversions` / `card_crossOrderedPairsImage` / `card_crossInversions_eq_two_mul` が得られる。

代入に要るのは次の 5 つだけである。

1. `hφO` / `hφinvO`: 軌道を保つ置換とその逆写像が軌道を軌道へ写すこと
   （`mem_of_orbitPreserving` / `inv_mem_of_orbitPreserving`）。
2. `hdisj`: 相異なる 2 つの軌道が交わらないこと（`disjoint_of_ne_of_mem_orbitSet`。
   人手証明では `claim_row_config_orbit_disjoint_or_eq`）。
3. `hasymm`: `≺` の非対称性（`not_rowConfigLess_of_rowConfigLess`。三分律から出る）。
4. `htotal`: 相異なる 2 点が `≺` で比較できること（`rowConfigLess_or_rowConfigLess`。同上）。
5. `hP`: `orderedPairs L` が `≺` で順序づけられた対をちょうど集めていること（`mem_orderedPairs`）。

すなわち具体版が使っているのは、`≺` については**三分律だけ**（推移律は使っていない）であり、
軌道については「相異なるものは交わらない」「置換で保たれる」だけである。
巡回シフト・最小周期・行配位であることはいずれも効いていない。
-/
import Ising2DLambda.AlgebraicEigenvalue.CrossOrbitInversions
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.CrossOrbitInversions

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 具体版の `F(O,O')` が、必要十分版の `crossPairs` と同じ有限集合であること。 -/
theorem crossOrderedPairs_eq_necSuf (O O' : Finset (RowConfig L)) :
    crossOrderedPairs L O O' = NecSuf.AlgebraicEigenvalue.crossPairs (rowConfigLess L) O O' := rfl

/-- 具体版の `F_φ(O,O')` が、必要十分版の `crossPairsImage` と同じ有限集合であること。 -/
theorem crossOrderedPairsImage_eq_necSuf (φ : Equiv.Perm (RowConfig L))
    (O O' : Finset (RowConfig L)) :
    crossOrderedPairsImage L φ O O'
      = NecSuf.AlgebraicEigenvalue.crossPairsImage (rowConfigLess L) φ O O' := rfl

/-- 具体版の `J_φ(O,O')` が、必要十分版の `crossInv` と同じ有限集合であること。 -/
theorem crossInversions_eq_necSuf (φ : Equiv.Perm (RowConfig L))
    (O O' : Finset (RowConfig L)) :
    crossInversions L φ O O'
      = NecSuf.AlgebraicEigenvalue.crossInv (rowConfigLess L) φ (orderedPairs L) O O' := rfl

/-- 必要十分版へ渡す「`≺` は非対称である」（三分律から出る）。 -/
theorem rowConfigLess_asymm (τ τ' : RowConfig L) :
    rowConfigLess L τ τ' → ¬ rowConfigLess L τ' τ :=
  fun h => not_rowConfigLess_of_rowConfigLess h

/-- 必要十分版へ渡す「相異なる 2 点は `≺` で比較できる」（三分律から出る）。 -/
theorem rowConfigLess_total (τ τ' : RowConfig L) (h : τ ≠ τ') :
    rowConfigLess L τ τ' ∨ rowConfigLess L τ' τ :=
  rowConfigLess_or_rowConfigLess h

/-- 主張「軌道を保つ置換はまたがる順序づけられた対の個数を変えない」を、必要十分版から導いたもの。 -/
theorem card_crossOrderedPairsImage_from_necSuf {φ : Equiv.Perm (RowConfig L)}
    (hφ : OrbitPreserving L φ) {O O' : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) (hO' : O' ∈ rowShiftOrbitSet L) :
    (crossOrderedPairsImage L φ O O').card = (crossOrderedPairs L O O').card :=
  NecSuf.AlgebraicEigenvalue.card_pairs_image_eq (lt := rowConfigLess L)
    (fun _ h => mem_of_orbitPreserving hφ hO h)
    (fun _ h => mem_of_orbitPreserving hφ hO' h)
    (fun _ h => inv_mem_of_orbitPreserving hφ hO h)
    (fun _ h => inv_mem_of_orbitPreserving hφ hO' h)

/-- 主張「2 つの相異なる軌道にまたがる転倒対の個数は偶数である」を、必要十分版から導いたもの。 -/
theorem card_crossInversions_eq_two_mul_from_necSuf {φ : Equiv.Perm (RowConfig L)}
    (hφ : OrbitPreserving L φ) {O O' : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) (hO' : O' ∈ rowShiftOrbitSet L) (hne : O ≠ O') :
    (crossInversions L φ O O').card
      = 2 * (crossOrderedPairs L O O' \ crossOrderedPairsImage L φ O O').card :=
  NecSuf.AlgebraicEigenvalue.card_crossInv_eq_two_mul (P := orderedPairs L)
    rowConfigLess_asymm rowConfigLess_total
    (fun _ h h' => disjoint_of_ne_of_mem_orbitSet hO hO' hne h h')
    (fun _ h => mem_of_orbitPreserving hφ hO h)
    (fun _ h => mem_of_orbitPreserving hφ hO' h)
    (fun _ h => inv_mem_of_orbitPreserving hφ hO h)
    (fun _ h => inv_mem_of_orbitPreserving hφ hO' h)
    (fun _ => mem_orderedPairs)

end Ising2DLambda.AlgebraicEigenvalue
