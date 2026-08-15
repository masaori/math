/-
章「逆写像の局所性」の必要十分版。

具体版（CellularAutomata.InverseMapLocality）と同じ順序で、単射な自己写像の逆写像の存在一意、
逆写像の構成、F(F^{-1} z) = z と F^{-1}(F y) = y、逆写像の各添字での値写像とその本質的依存の
一点反転による判定と有限決定、走査組数を示す。

必要な構造の検査結果:
  - 逆写像の存在一意には、型 X 上の自己写像 F : X → X が単射であることと X の有限性だけが要る。
    存在（全射性）は前章の必要十分版「単射 ⟺ 全射」（有限集合の個数の数え上げ）から、
    一意性は単射性からそのまま従う。セル・近傍・局所規則・二値性は要らない。
  - 逆写像を実際に一つ選ぶ構成（`Fintype.choose`）には X の等号判定が要る。
    具体版と同じ構成に固定するためここでも要求する（古典的な選択で済ませれば落とせるが、
    具体版と同じ手順を保つ）。F(F^{-1} z) = z と F^{-1}(F y) = y はこの構成の性質と単射性だけを使う。
  - 各添字での値写像 (F^{-1})_v は、X が写像型 S → A であることだけを使う。
    その本質的依存の一点反転による判定は前々章の必要十分版そのもの（添字型の等号判定と、
    状態型上で「各元と異なる元が入れ替え写像の値に一意」）で、有限決定には S・A の有限性と
    A の等号判定を追加する。ここでは依存述語を `Finset` として集めず、点ごとの命題に留める。
  - 走査組数 |S|·|A|^{|S|} は前々章の必要十分版をそのまま使う。
  - 反例（5 元舞台と規則 45）は一つの具体的対象であり、必要十分版の対象外である。
    具体版の一般部分（存在一意・恒等・依存台の判定・走査組数）が特殊化として得られることを
    具体版側の導出定理で示す。
  - 二値状態、セル、近傍、局所規則、物理的名称、R / C は使わない。
-/
import Mathlib.Data.Fintype.Inv
import CellularAutomata.NecSuf.EssentialDependency
import CellularAutomata.NecSuf.ReversibilityFiniteDecidability

namespace CellularAutomata.NecSuf.InverseMapLocality

open CellularAutomata.NecSuf.EssentialDependency
open CellularAutomata.NecSuf.ReversibilityFiniteDecidability

section General

variable {X : Type} [Fintype X] (F : X → X)

/-- 逆写像の前段: F が単射なら、各 z について F x = z を満たす x が存在し（全射性、
    前章の必要十分版「単射 ⟺ 全射」）、かつ一意である（単射性）。有限性以外は要らない。 -/
theorem exists_unique_preimage (hinj : Injective F) (z : X) :
    ∃! x : X, F x = z := by
  have hsurj : Surjective F := (injective_iff_surjective F).mp hinj
  have hz : z ∈ image F := by
    unfold Surjective at hsurj
    rw [hsurj]; exact Finset.mem_univ z
  obtain ⟨x, hx⟩ := (mem_image F z).mp hz
  refine ⟨x, hx, ?_⟩
  intro x' hx'
  exact hinj x' x (hx'.trans hx.symm)

variable [DecidableEq X]

/-- 逆写像 F^{-1}。z に対して F x = z を満たす一意な x を選ぶ。選ぶ操作にだけ等号判定が要る。 -/
def inverseMap (hinj : Injective F) (z : X) : X :=
  Fintype.choose (fun x => F x = z) (exists_unique_preimage F hinj z)

/-- F(F^{-1} z) = z。 -/
theorem map_inverseMap (hinj : Injective F) (z : X) : F (inverseMap F hinj z) = z :=
  Fintype.choose_spec (fun x => F x = z) (exists_unique_preimage F hinj z)

/-- F^{-1}(F x) = x（F x = F x を満たす元の一意性、すなわち単射性）。 -/
theorem inverseMap_map (hinj : Injective F) (x : X) : inverseMap F hinj (F x) = x :=
  hinj _ _ (map_inverseMap F hinj (F x))

end General

section Pointwise

variable {S A : Type} [Fintype S] [Fintype A] [DecidableEq S] [DecidableEq A]
variable (F : (S → A) → (S → A))

/-- 逆写像の v での値写像 (F^{-1})_v。X が写像型 S → A であることだけを使う。 -/
def inverseCellMap (hinj : Injective F) (v : S) : (S → A) → A :=
  fun z => inverseMap F hinj z v

/-- (F^{-1})_v の u への本質的依存は一点反転検査と同値（前々章の必要十分版）。
    状態側に要るのは「各元と異なる元が入れ替え写像の値に一意」だけである。 -/
theorem essentialDep_inverseCellMap_iff_flip
    (nu : A → A) (uniqueAlternative : ∀ a b : A, b ≠ a ↔ b = nu a)
    (hinj : Injective F) (v u : S) :
    EssentialDep (inverseCellMap F hinj v) u ↔
      ∃ z : S → A, inverseCellMap F hinj v z ≠ inverseCellMap F hinj v (flip nu u z) :=
  essentialDep_iff_flip nu uniqueAlternative (inverseCellMap F hinj v) u

/-- (F^{-1})_v の u への本質的依存の有限決定（前々章の必要十分版の判定を適用）。 -/
def essentialDepInverseCellMapDecidable
    (nu : A → A) (uniqueAlternative : ∀ a b : A, b ≠ a ↔ b = nu a)
    (hinj : Injective F) (v u : S) :
    Decidable (EssentialDep (inverseCellMap F hinj v) u) :=
  essentialDepDecidable nu uniqueAlternative (inverseCellMap F hinj v) u

omit [DecidableEq A] in
/-- 走査する組 (u, z) ∈ S × A^S の総数は |S|·|A|^{|S|}（前々章の必要十分版）。 -/
theorem card_inverse_scan_pairs :
    Fintype.card (S × (S → A)) = Fintype.card S * Fintype.card A ^ Fintype.card S :=
  card_scan_pairs

end Pointwise

end CellularAutomata.NecSuf.InverseMapLocality
