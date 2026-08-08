/-
定義「置換の転倒対の全体」「軌道の上の全単射の転倒数」「軌道をまたぐ転倒対の全体」と主張
「1 つの軌道の中の転倒対の個数は、制限の転倒数である」
「転倒数は、軌道ごとの転倒数の和と、またぐ転倒対の個数の和である」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.InversionOrbitDecomposition`）の証明が
実際に使っているのは次だけである。証明手順は具体版と同じ
（同じ Inv^= / Inv^≠ への分け方、同じ A(O) への分け方、同じ 3 段の数え上げ）。

  主張                          使っている性質
  inner_eq_filter_crossPairs    台 P が `lt` で順序づけられた対をちょうど集めていることだけ。
                                **写像にも関係 `lt` にも何も要求しない**。
  inversion_count_decomposition 「各点にその点を含む族の元が 1 つ指定されていること」と
                                「族の元に属する点にはその元が指定されていること」だけ。

削れなかった仮定と、その理由。

1. `hP : ∀ p, p ∈ P ↔ lt p.1 p.2`。inner の主張だけに要る。台を取り替える主張なので、
   台が何であるかを言わないと述べられない。
2. `hself : ∀ a, a ∈ orb a` と `horbMem : ∀ a, orb a ∈ 𝒪`。Inv^= を A(O) たちへ分ける
   ⊂ の向きに要る（p.1 の属する族の元として `orb p.1` を取る）。
3. `huniq : ∀ O ∈ 𝒪, ∀ a ∈ O, orb a = O`。⊃ の向きと、A(O) たちが互いに素であることに要る。
   **これが人手証明の「軌道の元の軌道はもとの軌道に等しい」と「相異なる 2 つの軌道は
   互いに素」の 2 主張を 1 つにまとめたものである**（前のセクションの貼り合わせと同じ形）。

具体版との差で言えば、次はいずれも使っていない。

* 写像 `f` が単射・全射であること。`f` は `lt (f p.2) (f p.1)` の形でしか現れず、
  置換である必要がない（`Equiv.Perm` ではなく `ι → ι` で仮定してある）。
* 関係 `lt` の性質。非対称性も三分律も推移律も**一つも使っていない**。
  すなわちこの分解は順序の理論に属さず、「対の集合を述語で分ける」だけの言明である。
* 族の元が軌道であること・巡回シフトがあること・`Fintype ι`。
  型の有限性はインスタンスとして要らず、`P` と `𝒪` が `Finset` であることだけで足りる
  （前のセクションの偶数性と違い、ここでは `lt` の全体性を仮定しないので、
  仮定から型の有限性が導かれることもない）。

mathlib の `Equiv.Perm.sign` と群作用の軌道の一般論は引いていない。
使ったのは `Finset.filter_card_add_filter_neg_card_eq_card`（人手証明の「述語で 2 つに分ける」）と
`Finset.card_biUnion`（人手証明の「互いに素な族の合併の個数は個数の和」）だけである。

住処: ここに ℝ / ℂ は現れない（添字は一般の型、個数は ℕ）。
-/
import Mathlib.Data.Finset.Prod
import Mathlib.Data.Finset.Card
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.CrossOrbitInversions

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

variable {ι : Type*} [DecidableEq ι]

/-- 人手証明の `Inv(φ)`。`f` は `lt (f p.2) (f p.1)` の形でしか現れないので、
置換ではなく写像で受ける（必要十分版なので、使っていない構造を仮定に残さない）。 -/
def inversionPairs (lt : ι → ι → Prop) [DecidableRel lt] (f : ι → ι) (P : Finset (ι × ι)) :
    Finset (ι × ι) :=
  P.filter fun p => lt (f p.2) (f p.1)

/-- 人手証明の `A(O)`（1 つの族の元の中に収まる転倒対）。 -/
def innerInversionPairs (lt : ι → ι → Prop) [DecidableRel lt] (f : ι → ι) (P : Finset (ι × ι))
    (O : Finset ι) : Finset (ι × ι) :=
  (inversionPairs lt f P).filter fun p => p.1 ∈ O ∧ p.2 ∈ O

/-- 人手証明の `Inv^≠(φ)`。`orb a` は点 `a` に指定された族の元。 -/
def crossOrbitInversionPairs (lt : ι → ι → Prop) [DecidableRel lt] (f : ι → ι)
    (P : Finset (ι × ι)) (orb : ι → Finset ι) : Finset (ι × ι) :=
  (inversionPairs lt f P).filter fun p => orb p.1 ≠ orb p.2

/-- 人手証明の `Inv^=(φ)`（証明の中だけで使う記号）。 -/
def sameOrbitInversionPairs (lt : ι → ι → Prop) [DecidableRel lt] (f : ι → ι)
    (P : Finset (ι × ι)) (orb : ι → Finset ι) : Finset (ι × ι) :=
  (inversionPairs lt f P).filter fun p => orb p.1 = orb p.2

variable {lt : ι → ι → Prop} [DecidableRel lt] {f : ι → ι} {P : Finset (ι × ι)}
  {orb : ι → Finset ι} {𝒪 : Finset (Finset ι)}

omit [DecidableEq ι] in
lemma mem_inversionPairs {p : ι × ι} :
    p ∈ inversionPairs lt f P ↔ p ∈ P ∧ lt (f p.2) (f p.1) := by
  simp [inversionPairs, Finset.mem_filter]

/-- 人手証明の主張「1 つの軌道の中の転倒対の個数は、制限の転倒数である」の本体。

人手証明が示しているのは**集合の等号**であり、個数はそこから取る。したがってここでも
個数の一致ではなく集合の等号を述べる（1 対 1 対応を作るのではない）。

要求するのは `hP` だけで、`f` にも `lt` にも `O` にも何も要求しない。
右辺の `crossPairs lt O O` は前のセクション（`CrossOrbitInversions`）の `F(O,O)` である。 -/
theorem inner_eq_filter_crossPairs (hP : ∀ p : ι × ι, p ∈ P ↔ lt p.1 p.2) (O : Finset ι) :
    innerInversionPairs lt f P O
      = (crossPairs lt O O).filter fun p => lt (f p.2) (f p.1) := by
  classical
  ext p
  simp only [innerInversionPairs, Finset.mem_filter, mem_inversionPairs, hP, mem_crossPairs]
  -- 左辺は「τ ≺ τ' かつ f で入れ替わる かつ τ,τ' ∈ O」、右辺は「τ,τ' ∈ O かつ τ ≺ τ' かつ
  -- f で入れ替わる」であり、条件の並べ替えにすぎない。
  tauto

/-- 人手証明の Step 1「Inv(φ) は Inv^=(φ) と Inv^≠(φ) へ分かれる」。 -/
theorem card_same_add_card_cross (lt : ι → ι → Prop) [DecidableRel lt] (f : ι → ι)
    (P : Finset (ι × ι)) (orb : ι → Finset ι) :
    (sameOrbitInversionPairs lt f P orb).card + (crossOrbitInversionPairs lt f P orb).card
      = (inversionPairs lt f P).card := by
  classical
  rw [sameOrbitInversionPairs, crossOrbitInversionPairs]
  exact Finset.card_filter_add_card_filter_not (s := inversionPairs lt f P)
    (p := fun p : ι × ι => orb p.1 = orb p.2)

/-- 人手証明の Step 2 の ⊂ と ⊃「Inv^=(φ) は A(O) たちの合併である」。 -/
theorem sameOrbit_eq_biUnion (hself : ∀ a : ι, a ∈ orb a) (horbMem : ∀ a : ι, orb a ∈ 𝒪)
    (huniq : ∀ O ∈ 𝒪, ∀ a ∈ O, orb a = O) :
    sameOrbitInversionPairs lt f P orb = 𝒪.biUnion (innerInversionPairs lt f P) := by
  classical
  ext p
  simp only [sameOrbitInversionPairs, innerInversionPairs, Finset.mem_filter,
    Finset.mem_biUnion]
  constructor
  · -- ⊂: O := orb p.1 を取る。
    rintro ⟨hinv, hsame⟩
    exact ⟨orb p.1, horbMem p.1, hinv, hself p.1, hsame ▸ hself p.2⟩
  · -- ⊃: huniq を 2 度当てる。
    rintro ⟨O, hO, hinv, h1, h2⟩
    exact ⟨hinv, by rw [huniq O hO p.1 h1, huniq O hO p.2 h2]⟩

/-- 人手証明の Step 2 の「A(O) たちは互いに素である」。 -/
theorem innerInversionPairs_pairwiseDisjoint (huniq : ∀ O ∈ 𝒪, ∀ a ∈ O, orb a = O) :
    ∀ O₁ ∈ 𝒪, ∀ O₂ ∈ 𝒪, O₁ ≠ O₂ →
      Disjoint (innerInversionPairs lt f P O₁) (innerInversionPairs lt f P O₂) := by
  classical
  intro O₁ hO₁ O₂ hO₂ hne
  refine Finset.disjoint_left.mpr ?_
  intro p hp₁ hp₂
  simp only [innerInversionPairs, Finset.mem_filter] at hp₁ hp₂
  -- p.1 が両方に属するので、指定された族の元が一意であることから O₁ = O₂ となり矛盾。
  exact hne ((huniq O₁ hO₁ p.1 hp₁.2.1).symm.trans (huniq O₂ hO₂ p.1 hp₂.2.1))

/-- 人手証明の主張「転倒数は、軌道ごとの転倒数の和と、またぐ転倒対の個数の和である」。

人手証明の Step 3 の 3 つの等号をそのまま並べる。 -/
theorem inversion_count_decomposition (hself : ∀ a : ι, a ∈ orb a) (horbMem : ∀ a : ι, orb a ∈ 𝒪)
    (huniq : ∀ O ∈ 𝒪, ∀ a ∈ O, orb a = O) :
    (inversionPairs lt f P).card
      = (∑ O ∈ 𝒪, (innerInversionPairs lt f P O).card)
        + (crossOrbitInversionPairs lt f P orb).card := by
  classical
  have hsplit := card_same_add_card_cross lt f P orb
  have hsame : (sameOrbitInversionPairs lt f P orb).card
      = ∑ O ∈ 𝒪, (innerInversionPairs lt f P O).card := by
    rw [sameOrbit_eq_biUnion hself horbMem huniq]
    exact Finset.card_biUnion (innerInversionPairs_pairwiseDisjoint huniq)
  omega

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
