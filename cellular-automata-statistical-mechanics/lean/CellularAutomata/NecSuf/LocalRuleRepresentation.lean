/-
章「依存台による局所規則の表現」の必要十分版。

具体版（CellularAutomata.LocalRuleRepresentation）と同じ順序で、表現可能性、
一つの添字に依存しないなら値の置換で出力が変わらないこと、有限集合上の帰納法、
表現可能 ⟹ 表される添字集合の外に依存元がないこと、依存元が添字集合に含まれる ⟹ 基準値延長で
表せること、両者の同値、単射な大域写像の逆写像が近傍 N' 上の局所規則で表せる必要十分条件、
最小近傍上の表現とその最小性、走査組数を示す。

必要な構造の検査結果:
  - 表現可能性の定義と「依存しない添字の値の置換で出力は不変」には、添字型 T の等号判定
    （`Function.update` を書くため）だけが要る。状態型 A には何も要らない。
  - 帰納法（`eq_of_changes_on`）も同じ。有限性は帰納の対象 R が `Finset` であることで
    足り、T 全体の有限性は要らない。依存台 `supp` を Finset として集める代わりに、
    「R の各元に本質的に依存しない」という点ごとの仮定に置く。
  - 表現可能 ⟹ S の外に依存元がない、は前章の必要十分版「追加元への非依存」を使う。
    具体版がその段で `supp_extendRule`（一点反転検査を経由）を使うので、同じ手順を保つため
    ここでも状態側の写像 ν と「各元と異なる元が ν の値に一意」を要求する。
    直接（制限が一致するから値が一致する）示せば ν は落とせるが、それは別の論法になるので採らない。
  - S の外に依存元がない ⟹ 基準値延長で表せる、は R := univ \ S を Finset として取るために
    T の有限性が要り、延長のために基準値 base : A が要る。A の有限性・等号判定は要らない。
  - 逆写像を近傍 N' 上の局所規則で表す同値には、上の二つと前章の必要十分版の逆写像だけが要る。
    前章の逆写像の構成（`Fintype.choose`）が配位型 V → A の有限性と等号判定を要求するので、
    V と A の有限性・等号判定を仮定する。二値性は要らない。
  - 走査組数 |S|·|A|^{|S|} は前章の必要十分版をそのまま使う。
  - 二値状態、物理的名称、R / C は使わない。
-/
import CellularAutomata.NecSuf.InverseMapLocality
import CellularAutomata.NecSuf.RedundantNeighbor
import CellularAutomata.NecSuf.TimeExpansionDependency

namespace CellularAutomata.NecSuf.LocalRuleRepresentation

open CellularAutomata.NecSuf.EssentialDependency
open CellularAutomata.NecSuf.RedundantNeighbor
open CellularAutomata.NecSuf.TimeExpansionDependency
open CellularAutomata.NecSuf.InverseMapLocality
open CellularAutomata.NecSuf.ReversibilityFiniteDecidability

section General

variable {T A : Type} [DecidableEq T]

/-- 必要十分版の表現可能性。添字型の等号判定だけを使う（制限写像のため）。 -/
def Representable (S : Finset T) (g : (T → A) → A) : Prop :=
  ∃ h : (↥S → A) → A, ∀ y, g y = h (restrict S y)

/-- 一つの添字 w に本質的に依存しないなら、w の値だけを置換しても出力は変わらない。 -/
lemma eq_update_of_not_essential (g : (T → A) → A) (w : T)
    (hnot : ¬ EssentialDep g w) (y : T → A) (a : A) :
    g y = g (Function.update y w a) := by
  by_contra hne
  apply hnot
  refine ⟨y, Function.update y w a, ?_, hne⟩
  intro u hu
  simp [Function.update, hu]

/-- 有限集合 R 上の帰納法: R の外で一致し、R の各添字に依存しなければ出力は等しい。
    T の有限性は要らず、R が有限集合であることだけを使う。 -/
lemma eq_of_changes_on (g : (T → A) → A) (R : Finset T)
    (hR : ∀ w ∈ R, ¬ EssentialDep g w)
    (y y' : T → A) (hagrees : ∀ u, u ∉ R → y u = y' u) : g y = g y' := by
  induction R using Finset.induction_on generalizing y with
  | empty =>
      apply congrArg g
      funext u
      exact hagrees u (by simp)
  | @insert w R hw ih =>
      have hwNot : ¬ EssentialDep g w := hR w (by simp)
      let z : T → A := Function.update y w (y' w)
      calc
        g y = g z := eq_update_of_not_essential g w hwNot y (y' w)
        _ = g y' := by
          apply ih
          · intro u huR
            exact hR u (by simp [huR])
          · intro u huR
            by_cases huw : u = w
            · subst u
              simp [z]
            · simpa [z, Function.update, huw] using hagrees u (by simp [huR, huw])

/-- 表現可能なら S の外の添字に本質的に依存しない（前章の必要十分版の追加元への非依存）。 -/
theorem representable_implies_not_essentialDep_outside
    (nu : A → A) (uniqueAlternative : ∀ a b : A, b ≠ a ↔ b = nu a)
    (S : Finset T) (g : (T → A) → A) (hrep : Representable S g) :
    ∀ w, w ∉ S → ¬ EssentialDep g w := by
  obtain ⟨h, hg⟩ := hrep
  have hfun : g = extendRule S h := by
    funext y
    exact hg y
  intro w hw
  rw [hfun]
  exact no_essentialDep_on_added_element S nu uniqueAlternative h w hw

variable [Fintype T]

/-- S の外に依存元がなければ、基準値延長で表せる。T の有限性は R := univ \ S のために要る。 -/
theorem not_essentialDep_outside_implies_representation (base : A)
    (S : Finset T) (g : (T → A) → A)
    (hout : ∀ w, w ∉ S → ¬ EssentialDep g w) :
    ∀ y, g y = (g ∘ baseExtend S base) (restrict S y) := by
  intro y
  apply eq_of_changes_on g (Finset.univ \ S)
  · intro w hw
    exact hout w (Finset.mem_sdiff.mp hw).2
  · intro u hu
    have huS : u ∈ S := by
      by_contra hnot
      exact hu (Finset.mem_sdiff.mpr ⟨Finset.mem_univ u, hnot⟩)
    change y u = (if h : u ∈ S then restrict S y ⟨u, h⟩ else base)
    simp [huS, restrict]

/-- 表現可能性と「S の外に依存元がない」の同値。 -/
theorem representable_iff_not_essentialDep_outside
    (nu : A → A) (uniqueAlternative : ∀ a b : A, b ≠ a ↔ b = nu a) (base : A)
    (S : Finset T) (g : (T → A) → A) :
    Representable S g ↔ ∀ w, w ∉ S → ¬ EssentialDep g w := by
  constructor
  · exact representable_implies_not_essentialDep_outside nu uniqueAlternative S g
  · intro hout
    exact ⟨g ∘ baseExtend S base,
      not_essentialDep_outside_implies_representation base S g hout⟩

end General

section Inverse

variable {V A : Type} [Fintype V] [DecidableEq V] [Fintype A] [DecidableEq A]
variable (F : (V → A) → (V → A))

/-- 近傍 N' 上で逆写像を表す局所規則の族。 -/
def inverseLocalRule (base : A) (hinj : Injective F) (N' : V → Finset V)
    (v : V) : (↥(N' v) → A) → A :=
  inverseCellMap F hinj v ∘ baseExtend (N' v) base

/-- 単射な F の逆写像が近傍 N' 上の局所規則の族で書ける ⟺ 各 v で (F^{-1})_v が N'(v) の外に
    依存元をもたない。 -/
theorem exists_inverse_ca_iff_not_essentialDep_outside
    (nu : A → A) (uniqueAlternative : ∀ a b : A, b ≠ a ↔ b = nu a) (base : A)
    (hinj : Injective F) (N' : V → Finset V) :
    (∃ f' : (v : V) → (↥(N' v) → A) → A, globalMap N' f' = inverseMap F hinj) ↔
      ∀ v u, u ∉ N' v → ¬ EssentialDep (inverseCellMap F hinj v) u := by
  constructor
  · rintro ⟨f', hmap⟩ v
    apply representable_implies_not_essentialDep_outside nu uniqueAlternative (N' v)
      (inverseCellMap F hinj v)
    refine ⟨f' v, ?_⟩
    intro z
    change inverseMap F hinj z v = f' v (restrict (N' v) z)
    exact congrFun (congrFun hmap z) v |>.symm
  · intro hout
    refine ⟨inverseLocalRule F base hinj N', ?_⟩
    funext z v
    change (inverseCellMap F hinj v ∘ baseExtend (N' v) base) (restrict (N' v) z) =
      inverseMap F hinj z v
    exact (not_essentialDep_outside_implies_representation base (N' v)
      (inverseCellMap F hinj v) (hout v) z).symm

omit [DecidableEq A] in
/-- 走査する組 (u, z) ∈ V × A^V の総数は |V|·|A|^{|V|}（前章の必要十分版）。 -/
theorem card_minimal_neighborhood_scan_pairs :
    Fintype.card (V × (V → A)) = Fintype.card V * Fintype.card A ^ Fintype.card V :=
  card_inverse_scan_pairs

end Inverse

end CellularAutomata.NecSuf.LocalRuleRepresentation
