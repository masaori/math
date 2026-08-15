/-
章「逆写像の局所性」の具体版。
人手証明の正本は structured-latex/content/inverse-map-locality.ts。

人手証明のブロックとこのファイルの対応:

  単射な大域写像の逆写像 F^{-1}（`def_inverse_global_map`）
      `exists_unique_preimage`（全射性は前章の単射 ⟺ 全射、一意性は単射性）、
      `inverseMap`（一意な y を `Fintype.choose` で取る）、
      `globalMap_inverseMap`（F(F^{-1} z) = z）、`inverseMap_globalMap`（F^{-1}(F y) = y）
  逆写像の各セルの値写像 (F^{-1})_v とその本質的依存台（`def_inverse_cell_map_support`）
      `inverseCellMap`、`inverseSupp`（前章の `supp` を S = V で適用）、
      `forwardSupp`（順写像の v での本質的依存台 supp(f_v ∘ ρ^V_{N(v)})）
  claim_inverse_support_finite_decidability
      `mem_inverseSupp_iff`（所属が決定可能な本質的依存と一致）、
      `card_inverse_scan_pairs`（走査する組 (u, z) の総数が |V|·2^{|V|}）
  claim_inverse_support_not_in_neighborhood_counterexample
      `Cell`（5 元集合 V。整数・剰余類は使わない）、`ell`・`r`（表）、`Nbr`（近傍）、
      `g`（規則 45 の表）、`fRule`（局所真理値表 f_v）、
      (1) `counterexample_injective`（32 配位の像の相異。有限個の等号検査）、
      (2) `counterexample_witness`（10 組 (v,u) の証人）、
          `compl_neighborhood_subset_inverseSupp`（V ∖ N(v) ⊆ supp((F^{-1})_v)）、
          `inverseSupp_not_subset_neighborhood`、`forwardSupp_subset_neighborhood`、
          `inverseSupp_not_subset_forwardSupp`

反例の (1) と証人の検査は、人手証明の「有限個の 5 文字列の等号検査」に対応して
`decide`（有限型上の全称・存在の機械的な場合尽くし）で行う。表を人手で書き写さず、
定義から計算した値を照合している点で人手証明の表と同じ内容である。

住処: 有限型・自然数のみ。ℝ / ℂ は現れない（人手証明と同じ）。
-/
import Mathlib.Data.Fintype.Inv
import CellularAutomata.ReversibilityFiniteDecidability

namespace CellularAutomata.InverseMapLocality

open CellularAutomata.EssentialDependency
open CellularAutomata.RedundantNeighbor
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.ReversibilityFiniteDecidability

variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V)
variable (f : (v : V) → (↥(N v) → State) → State)

/-- `def_inverse_global_map` の前段: F が単射なら、各 z について F y = z を満たす y が
    存在し（全射性、前章の単射 ⟺ 全射）、かつ一意である（単射性）。 -/
theorem exists_unique_preimage (hinj : Injective N f) (z : V → State) :
    ∃! y : V → State, globalMap N f y = z := by
  have hsurj : Surjective N f := (injective_iff_surjective N f).mp hinj
  have hz : z ∈ image N f := by
    rw [hsurj]; exact Finset.mem_univ z
  obtain ⟨y, hy⟩ := (mem_image N f z).mp hz
  refine ⟨y, hy, ?_⟩
  intro y' hy'
  exact hinj y' y (hy'.trans hy.symm)

/-- 逆写像 F^{-1}（`def_inverse_global_map`）。z に対して F y = z を満たす一意な y。 -/
def inverseMap (hinj : Injective N f) (z : V → State) : V → State :=
  Fintype.choose (fun y => globalMap N f y = z) (exists_unique_preimage N f hinj z)

/-- F(F^{-1} z) = z（`def_inverse_global_map` の後段）。 -/
theorem globalMap_inverseMap (hinj : Injective N f) (z : V → State) :
    globalMap N f (inverseMap N f hinj z) = z :=
  Fintype.choose_spec (fun y => globalMap N f y = z) (exists_unique_preimage N f hinj z)

/-- F^{-1}(F y) = y（`def_inverse_global_map` の後段。F y = F y を満たす元の一意性）。 -/
theorem inverseMap_globalMap (hinj : Injective N f) (y : V → State) :
    inverseMap N f hinj (globalMap N f y) = y :=
  hinj _ _ (globalMap_inverseMap N f hinj (globalMap N f y))

/-- 逆写像の v での値写像 (F^{-1})_v（`def_inverse_cell_map_support`）。 -/
def inverseCellMap (hinj : Injective N f) (v : V) : (V → State) → State :=
  fun z => inverseMap N f hinj z v

/-- supp((F^{-1})_v)（`def_inverse_cell_map_support`。前章の supp を S = V で適用）。 -/
def inverseSupp (hinj : Injective N f) (v : V) : Finset V :=
  supp (inverseCellMap N f hinj v)

/-- 順写像の v での本質的依存台 supp(f_v ∘ ρ^V_{N(v)})（`def_inverse_cell_map_support`）。 -/
def forwardSupp (v : V) : Finset V :=
  supp (extendRule (N v) (f v))

/-- `claim_inverse_support_finite_decidability` の前半: u ∈ supp((F^{-1})_v) は、
    決定可能な本質的依存（前章のインスタンス）と一致する。 -/
theorem mem_inverseSupp_iff (hinj : Injective N f) (v u : V) :
    u ∈ inverseSupp N f hinj v ↔ EssentialDep (inverseCellMap N f hinj v) u :=
  mem_supp_iff _ u

/-- `claim_inverse_support_finite_decidability` の後半: 走査する組 (u, z) ∈ V × A^V の
    総数は |V|·2^{|V|}（前章の `card_scan_pairs` を S = V で適用）。 -/
theorem card_inverse_scan_pairs :
    Fintype.card (V × (V → State)) = Fintype.card V * 2 ^ Fintype.card V :=
  card_scan_pairs

/-! ### 反例（`claim_inverse_support_not_in_neighborhood_counterexample`） -/

/-- 5 元集合 V = {0,1,2,3,4}。整数の演算・剰余類は使わない。 -/
inductive Cell : Type where
  | c0 | c1 | c2 | c3 | c4
  deriving DecidableEq

instance : Fintype Cell :=
  ⟨{Cell.c0, Cell.c1, Cell.c2, Cell.c3, Cell.c4}, fun a => by cases a <;> simp⟩

/-- ℓ の表。 -/
def ell : Cell → Cell
  | .c0 => .c4 | .c1 => .c0 | .c2 => .c1 | .c3 => .c2 | .c4 => .c3

/-- r の表。 -/
def r : Cell → Cell
  | .c0 => .c1 | .c1 => .c2 | .c2 => .c3 | .c3 => .c4 | .c4 => .c0

/-- 近傍 N(v) := {ℓ(v), v, r(v)}。 -/
def Nbr (v : Cell) : Finset Cell := {ell v, v, r v}

/-- 規則 45 の表 g : A × A × A → A。 -/
def g : State → State → State → State
  | .zero, .zero, .zero => .one
  | .zero, .zero, .one  => .zero
  | .zero, .one,  .zero => .one
  | .zero, .one,  .one  => .one
  | .one,  .zero, .zero => .zero
  | .one,  .zero, .one  => .one
  | .one,  .one,  .zero => .zero
  | .one,  .one,  .one  => .zero

theorem ell_mem_Nbr (v : Cell) : ell v ∈ Nbr v := by simp [Nbr]
theorem self_mem_Nbr (v : Cell) : v ∈ Nbr v := by simp [Nbr]
theorem r_mem_Nbr (v : Cell) : r v ∈ Nbr v := by simp [Nbr]

/-- 局所真理値表 f_v(x) := g(x(ℓ(v)), x(v), x(r(v)))。 -/
def fRule (v : Cell) (x : ↥(Nbr v) → State) : State :=
  g (x ⟨ell v, ell_mem_Nbr v⟩) (x ⟨v, self_mem_Nbr v⟩) (x ⟨r v, r_mem_Nbr v⟩)

/-- (1) F は単射（32 配位の像が相異なることの有限検査）。 -/
theorem counterexample_injective : Injective Nbr fRule := by
  unfold Injective
  decide

/-- (2) の証人: 各 v と各 u ∈ V ∖ N(v) について、ある z で
    (F^{-1}(z))(v) ≠ (F^{-1}(φ_u z))(v)。人手証明の 10 行の証人表に対応する。 -/
theorem counterexample_witness (v u : Cell) (hu : u ∉ Nbr v) :
    ∃ z : Cell → State,
      inverseCellMap Nbr fRule counterexample_injective v z ≠
        inverseCellMap Nbr fRule counterexample_injective v (flip u z) := by
  revert v u
  decide

/-- (2): V ∖ N(v) ⊆ supp((F^{-1})_v)。 -/
theorem compl_neighborhood_subset_inverseSupp (v : Cell) :
    (Finset.univ \ Nbr v) ⊆ inverseSupp Nbr fRule counterexample_injective v := by
  intro u hu
  rw [Finset.mem_sdiff] at hu
  rw [mem_inverseSupp_iff, essentialDep_iff_flip]
  exact counterexample_witness v u hu.2

/-- 各 v で V ∖ N(v) は空でない（2 元）。 -/
theorem compl_neighborhood_nonempty (v : Cell) : (Finset.univ \ Nbr v).Nonempty := by
  revert v; decide

/-- supp((F^{-1})_v) ⊄ N(v)。 -/
theorem inverseSupp_not_subset_neighborhood (v : Cell) :
    ¬ inverseSupp Nbr fRule counterexample_injective v ⊆ Nbr v := by
  intro hsub
  obtain ⟨u, hu⟩ := compl_neighborhood_nonempty v
  have hmem := compl_neighborhood_subset_inverseSupp v hu
  rw [Finset.mem_sdiff] at hu
  exact hu.2 (hsub hmem)

/-- supp(f_v ∘ ρ^V_{N(v)}) ⊆ N(v)（`claim_no_dependency_on_redundant_element` による）。 -/
theorem forwardSupp_subset_neighborhood (v : Cell) : forwardSupp Nbr fRule v ⊆ Nbr v := by
  intro u hu
  rw [forwardSupp, mem_supp_iff] at hu
  by_contra hnot
  exact no_essentialDep_on_added_element (Nbr v) (fRule v) u hnot hu

/-- supp((F^{-1})_v) ⊄ supp(f_v ∘ ρ^V_{N(v)})。 -/
theorem inverseSupp_not_subset_forwardSupp (v : Cell) :
    ¬ inverseSupp Nbr fRule counterexample_injective v ⊆ forwardSupp Nbr fRule v := by
  intro hsub
  exact inverseSupp_not_subset_neighborhood v (hsub.trans (forwardSupp_subset_neighborhood v))

end CellularAutomata.InverseMapLocality
