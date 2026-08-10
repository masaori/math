/-
具体版が必要十分版の特殊化として得られることを示す（`docs/context/証明の書き方.md` の要件 4）。

必要十分版の `IsMin` / `existsUnique_min` / `ne_of_mem_of_mem_of_disjoint` に
ι := RowConfig L、lt := rowConfigLess L を代入すると、具体版が得られる。

代入に要るのは次の 3 つだけである。いずれも `claim_row_config_order_linear`
（三分律と推移律）と `claim_row_config_orbit_partition`（互いに素であること）から出る。

1. `hcompare`: 相異なる 2 つの行配位は `≺` で比較できる（三分律の一部）。
2. `htrans`: 推移律。
3. `hasymm`: 非対称性（三分律の「ちょうど 1 つ」の一部）。

すなわち具体版が使っているのは、順序については三分律と推移律だけ、
軌道については「相異なる 2 つは交わらない」だけである。
行配位であることも巡回シフトも最小周期も効いていない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RowConfigMin
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RowConfigMin

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 相異なる 2 つの行配位は `≺` で比較できる（三分律から）。 -/
theorem rowConfigLess_compare (τ τ' : RowConfig L) (h : τ ≠ τ') :
    rowConfigLess L τ τ' ∨ rowConfigLess L τ' τ := by
  rcases rowConfigLess_trichotomy τ τ' with hc | hc | hc
  · exact Or.inl hc.1
  · exact absurd hc.2.1 h
  · exact Or.inr hc.2.2

/-- `≺` は非対称である（三分律の「ちょうど 1 つ」から）。 -/
theorem rowConfigLess_asymm {τ τ' : RowConfig L} (h : rowConfigLess L τ τ') :
    ¬ rowConfigLess L τ' τ := by
  rcases rowConfigLess_trichotomy τ τ' with hc | hc | hc
  · exact hc.2.2
  · exact absurd h hc.1
  · exact absurd h hc.1

/-- 具体版の最小元の条件が、必要十分版の `IsMin` と同じ述語であること。 -/
theorem isRowConfigMin_eq_necSuf (X : Finset (RowConfig L)) (τ₀ : RowConfig L) :
    IsRowConfigMin L X τ₀ = NecSuf.AlgebraicEigenvalue.IsMin (rowConfigLess L) X τ₀ := rfl

/-- 主張「行配位の空でない部分集合は最小元をちょうど 1 つ持つ」を、必要十分版から導いたもの。 -/
theorem existsUnique_rowConfigMin_from_necSuf {X : Finset (RowConfig L)} (hX : X.Nonempty) :
    ∃! τ₀ : RowConfig L, IsRowConfigMin L X τ₀ :=
  NecSuf.AlgebraicEigenvalue.existsUnique_min (lt := rowConfigLess L)
    rowConfigLess_compare (fun h h' => rowConfigLess_trans h h')
    (fun h => rowConfigLess_asymm h) hX

/-- 主張「相異なる軌道の最小元は相異なる」を、必要十分版から導いたもの。

必要十分版が要求するのは 2 つの軌道が交わらないことだけなので、渡すのは
`disjoint_of_ne_of_mem_orbitSet` と、`μ(O) ∈ O`（`rowConfigMin_mem`）である。 -/
theorem rowConfigMin_orbit_ne_from_necSuf {O O' : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) (hO' : O' ∈ rowShiftOrbitSet L) (hOO' : O ≠ O')
    (hOne : O.Nonempty) (hO'ne : O'.Nonempty) :
    rowConfigMin L hOne ≠ rowConfigMin L hO'ne :=
  NecSuf.AlgebraicEigenvalue.ne_of_mem_of_mem_of_disjoint
    (fun _ h h' => disjoint_of_ne_of_mem_orbitSet hO hO' hOO' h h')
    (rowConfigMin_mem hOne) (rowConfigMin_mem hO'ne)

end Ising2DLambda.AlgebraicEigenvalue
