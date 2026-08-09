/-
定義「最小元で向きを付けた軌道の順序対の全体」と主張
「向きを付けた相異なる軌道の対が与えるまたがる転倒対は交わらない」
「またぐ転倒対の全体は、向きを付けた軌道の対にわたる合併である」
「またぐ転倒対の全体の個数は偶数である」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.OrientedOrbitPairs`）の証明が実際に使っているのは
次だけである。証明手順は具体版と同じ（同じ場合分け、同じ両包含、同じ 4 段の数え上げ）。

  主張                    使っている性質
  crossInv_disjoint       「族の元に属する点にはその元が指定されていること」（`huniq`）と、
                          `D` が向きについて非対称であること（`hDasymm`）だけ。
                          **最小元も順序 `lt` も使っていない。**
  crossInv_eq_biUnion     上に加えて「各点にその点を含む族の元が 1 つ指定されていること」
                          （`hself` / `horbMem`）、`D` の元の 2 成分が相異なること（`hDne`）、
                          相異なる 2 元の順序対の一方が `D` に属すること（`hDtotal`）。
  card_biUnion_eq_two_mul 上に加えて、前のセクションの対ごとの偶数性が要求するもの
                          （`lt` の非対称性・相異なる 2 点の比較可能性・台 `P` の同定・
                          族の元が互いに素であること・`φ` と `φ⁻¹` が族の元を保つこと）。

削れなかった仮定と、その理由。

1. `huniq : ∀ O ∈ 𝒪, ∀ a ∈ O, orb a = O`。`J` の元からその 2 成分の属する族の元を
   読み取る段に要る。これが無いと `J_φ(O,O')` の元が「どの対から来たか」を復元できず、
   交わらないことも合併も言えない。
2. `hDasymm : ∀ q ∈ D, (q.2, q.1) ∉ D`。**`D` から取り出しているのはこれだけである。**
   人手証明が最小元で向きを付けたのは、この非対称性を作るためであって、最小元そのものは
   ここでは使わない。したがって必要十分版は最小元を仮定に持たない
   （`μ` の定義も、順序 `lt` が最小元を持つことも要らない）。
3. `hDne : ∀ q ∈ D, q.1 ≠ q.2`。合併の ⊃ の向き（`orb p.1 ≠ orb p.2` を出す段）と、
   対ごとの偶数性を当てる段に要る。
4. `hDtotal`。合併の ⊂ の向きに要る。これが無いと、またぐ対のうち `D` に対応する対を
   持たないものが取り残される。
5. `hself` / `horbMem`。⊂ の向きで、`p.1` の属する族の元として `orb p.1` を取る段に要る。

具体版との差で言えば、次はいずれも使っていない。

* 族の元が軌道であること・巡回シフトがあること・行配位であること。
* `D` が「最小元の順序」で定まっていること（上の 2）。`D` は非対称で、相異なる 2 元の
  順序対のちょうど一方を含む任意の集合でよい。
* `Fintype ι`。ただし `card_biUnion_eq_two_mul` は前のセクションの偶数性を引くので、
  そちらと同じ事情で `hP` と `htotal` から型の有限性が導ける
  （導けることと、インスタンスとして仮定していることは別である。前のセクションの
  ファイル冒頭の「型の有限性についての注意」を見よ）。

`φ` を `Equiv.Perm ι` で受けているのは、前のセクションの `crossInv` の型がそうだからである。
`crossInv_disjoint` と `crossInv_eq_biUnion` の証明そのものは `φ` の往復を使っておらず、
`lt (φ p.2) (φ p.1)` という形でしか `φ` に触れていない。

mathlib の群作用の軌道の一般論・`Finset.sum_involution` は引いていない。
使ったのは `Finset.card_biUnion`（人手証明の「互いに素な族の合併の個数は個数の和」）と
`Finset.mul_sum`（人手証明の「有限和の分配則」）だけである。

住処: ここに ℝ / ℂ は現れない（添字は一般の型、個数は ℕ）。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.InversionOrbitDecomposition

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

variable {ι : Type*} [DecidableEq ι]
variable {lt : ι → ι → Prop} [DecidableRel lt] {φ : Equiv.Perm ι} {P : Finset (ι × ι)}
  {orb : ι → Finset ι} {𝒪 : Finset (Finset ι)} {D : Finset (Finset ι × Finset ι)}

/-- `J_φ(O,O')` の元から、その 2 成分の属する族の元を読み取る（人手証明の
「`claim_row_config_orbit_mem_eq` により `(O(τ),O(τ'))` は `(O,O')` か `(O',O)` である」）。 -/
theorem orb_pair_eq_of_mem_crossInv (huniq : ∀ O ∈ 𝒪, ∀ a ∈ O, orb a = O)
    {q : Finset ι × Finset ι} (hq1 : q.1 ∈ 𝒪) (hq2 : q.2 ∈ 𝒪) {p : ι × ι}
    (hp : p ∈ crossInv lt φ P q.1 q.2) :
    (orb p.1, orb p.2) = q ∨ (orb p.1, orb p.2) = (q.2, q.1) := by
  rcases (mem_crossInv.mp hp).2.1 with ⟨h1, h2⟩ | ⟨h1, h2⟩
  · exact Or.inl (Prod.ext (huniq _ hq1 _ h1) (huniq _ hq2 _ h2))
  · exact Or.inr (Prod.ext (huniq _ hq2 _ h1) (huniq _ hq1 _ h2))

/-- 人手証明の主張「向きを付けた相異なる軌道の対が与えるまたがる転倒対は交わらない」。

`D` から取り出しているのは非対称性 `hDasymm` だけであり、最小元も順序も使っていない。 -/
theorem crossInv_disjoint (huniq : ∀ O ∈ 𝒪, ∀ a ∈ O, orb a = O)
    (hDsub : ∀ q ∈ D, q.1 ∈ 𝒪 ∧ q.2 ∈ 𝒪) (hDasymm : ∀ q ∈ D, (q.2, q.1) ∉ D)
    {q₁ q₂ : Finset ι × Finset ι} (h₁ : q₁ ∈ D) (h₂ : q₂ ∈ D) (hne : q₁ ≠ q₂) :
    Disjoint (crossInv lt φ P q₁.1 q₁.2) (crossInv lt φ P q₂.1 q₂.2) := by
  classical
  refine Finset.disjoint_left.mpr ?_
  intro p hp₁ hp₂
  obtain ⟨hq₁1, hq₁2⟩ := hDsub q₁ h₁
  obtain ⟨hq₂1, hq₂2⟩ := hDsub q₂ h₂
  -- 人手証明の 2 つの場合（(O(τ),O(τ')) が (O,O') か (O',O) か）を両方の対について取る。
  rcases orb_pair_eq_of_mem_crossInv huniq hq₁1 hq₁2 hp₁ with e₁ | e₁ <;>
    rcases orb_pair_eq_of_mem_crossInv huniq hq₂1 hq₂2 hp₂ with e₂ | e₂
  · exact hne (e₁ ▸ e₂ ▸ rfl)
  · -- q₁ = (q₂.2, q₂.1) なので、q₂ ∈ D と両立しない。
    exact hDasymm q₂ h₂ (by rw [← e₂, e₁]; exact h₁)
  · -- 上と左右が入れ替わっただけである。
    exact hDasymm q₁ h₁ (by rw [← e₁, e₂]; exact h₂)
  · exact hne (by
      have : (q₁.2, q₁.1) = (q₂.2, q₂.1) := by rw [← e₁, e₂]
      exact Prod.ext (congrArg Prod.snd this) (congrArg Prod.fst this))

/-- 人手証明の主張「またぐ転倒対の全体は、向きを付けた軌道の対にわたる合併である」。

人手証明どおり両包含で示す。個数ではなく集合の等号である。 -/
theorem crossInv_eq_biUnion (hself : ∀ a : ι, a ∈ orb a) (horbMem : ∀ a : ι, orb a ∈ 𝒪)
    (huniq : ∀ O ∈ 𝒪, ∀ a ∈ O, orb a = O)
    (hDsub : ∀ q ∈ D, q.1 ∈ 𝒪 ∧ q.2 ∈ 𝒪) (hDne : ∀ q ∈ D, q.1 ≠ q.2)
    (hDtotal : ∀ O ∈ 𝒪, ∀ O' ∈ 𝒪, O ≠ O' → (O, O') ∈ D ∨ (O', O) ∈ D) :
    crossOrbitInversionPairs lt φ P orb = D.biUnion fun q => crossInv lt φ P q.1 q.2 := by
  classical
  ext p
  simp only [crossOrbitInversionPairs, Finset.mem_filter, mem_inversionPairs,
    Finset.mem_biUnion]
  constructor
  · -- 左辺が右辺に含まれること。O := orb p.1、O' := orb p.2 を取る。
    rintro ⟨⟨hP, hinv⟩, hneorb⟩
    rcases hDtotal _ (horbMem p.1) _ (horbMem p.2) hneorb with hD | hD
    · exact ⟨(orb p.1, orb p.2), hD,
        mem_crossInv.mpr ⟨hP, Or.inl ⟨hself p.1, hself p.2⟩, hinv⟩⟩
    · exact ⟨(orb p.2, orb p.1), hD,
        mem_crossInv.mpr ⟨hP, Or.inr ⟨hself p.1, hself p.2⟩, hinv⟩⟩
  · -- 右辺が左辺に含まれること。
    rintro ⟨q, hq, hp⟩
    obtain ⟨hq1, hq2⟩ := hDsub q hq
    obtain ⟨hP, -, hinv⟩ := mem_crossInv.mp hp
    refine ⟨⟨hP, hinv⟩, ?_⟩
    -- 2 成分の属する族の元は q の 2 成分であり、それらは相異なる。
    rcases orb_pair_eq_of_mem_crossInv huniq hq1 hq2 hp with e | e
    · intro hcon
      exact hDne q hq (by
        have h1 : orb p.1 = q.1 := congrArg Prod.fst e
        have h2 : orb p.2 = q.2 := congrArg Prod.snd e
        rw [← h1, ← h2, hcon])
    · intro hcon
      exact hDne q hq (by
        have h1 : orb p.1 = q.2 := congrArg Prod.fst e
        have h2 : orb p.2 = q.1 := congrArg Prod.snd e
        rw [← h1, ← h2, hcon])

/-- 人手証明の主張「またぐ転倒対の全体の個数は偶数である」。

人手証明の 4 段（合併・互いに素・対ごとの偶数性・有限和の分配則）をそのまま辿る。 -/
theorem card_biUnion_eq_two_mul
    (hasymm : ∀ a b : ι, lt a b → ¬ lt b a) (htotal : ∀ a b : ι, a ≠ b → lt a b ∨ lt b a)
    (hP : ∀ p : ι × ι, p ∈ P ↔ lt p.1 p.2)
    (hdisj : ∀ O ∈ 𝒪, ∀ O' ∈ 𝒪, O ≠ O' → ∀ a : ι, a ∈ O → a ∈ O' → False)
    (hφ : ∀ O ∈ 𝒪, ∀ a ∈ O, φ a ∈ O) (hφinv : ∀ O ∈ 𝒪, ∀ a ∈ O, φ⁻¹ a ∈ O)
    (hself : ∀ a : ι, a ∈ orb a) (horbMem : ∀ a : ι, orb a ∈ 𝒪)
    (huniq : ∀ O ∈ 𝒪, ∀ a ∈ O, orb a = O)
    (hDsub : ∀ q ∈ D, q.1 ∈ 𝒪 ∧ q.2 ∈ 𝒪) (hDne : ∀ q ∈ D, q.1 ≠ q.2)
    (hDasymm : ∀ q ∈ D, (q.2, q.1) ∉ D)
    (hDtotal : ∀ O ∈ 𝒪, ∀ O' ∈ 𝒪, O ≠ O' → (O, O') ∈ D ∨ (O', O) ∈ D) :
    (crossOrbitInversionPairs lt φ P orb).card
      = 2 * ∑ q ∈ D, (crossPairs lt q.1 q.2 \ crossPairsImage lt φ q.1 q.2).card := by
  classical
  rw [crossInv_eq_biUnion hself horbMem huniq hDsub hDne hDtotal,
    Finset.card_biUnion (fun q₁ h₁ q₂ h₂ hne =>
      crossInv_disjoint huniq hDsub hDasymm h₁ h₂ hne)]
  -- 有限和の分配則（2 倍を和の外へ出す）。2 * x = x + x として和を 2 本に割る。
  rw [two_mul, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl ?_
  intro q hq
  obtain ⟨hq1, hq2⟩ := hDsub q hq
  rw [← two_mul]
  exact card_crossInv_eq_two_mul hasymm htotal
    (fun a ha ha' => hdisj _ hq1 _ hq2 (hDne q hq) a ha ha')
    (fun a ha => hφ _ hq1 a ha) (fun a ha => hφ _ hq2 a ha)
    (fun a ha => hφinv _ hq1 a ha) (fun a ha => hφinv _ hq2 a ha) hP

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
