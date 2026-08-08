/-
定義「2 つの軌道にまたがる順序づけられた対の全体」「置換で送ってから順序を見た、またがる対の全体」
「2 つの軌道にまたがる転倒対の全体」と主張
「軌道を保つ置換はまたがる順序づけられた対の個数を変えない」
「2 つの相異なる軌道にまたがる転倒対の個数は偶数である」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.CrossOrbitInversions`）の証明が実際に使っているのは
次だけである。証明手順は具体版と同じ（同じ Υ、同じ J_1・J_2 への分け方、同じ sw）。

  主張                          使っている性質
  card_pairs_image_eq           `φ` と `φ⁻¹` が O を O へ、O' を O' へ写すことだけ。
                                **関係 `lt` については何も要求しない**（順序である必要すらない）。
  card_crossInv_eq_two_mul      上に加えて (a) O と O' が交わらないこと、
                                (b) `lt` の非対称性、(c) 相異なる 2 点が `lt` で比較できること、
                                (d) P が `lt` で順序づけられた対をちょうど集めていること。

削れなかった仮定と、その理由。

1. `hφO` / `hφO'` / `hφinvO` / `hφinvO'`。Υ が O × O' の上の全単射であることに要る。
   **`φ` の単射性は使っていない**（使うのは `φ` と `φ⁻¹` の往復だけである）。
   O の有限性から「O へ写すこと」だけで逆向きを出すこともできるが、そうすると有限性が
   仮定に入るので、4 つを並べて有限性を落とした（具体版は両方を別々に持っている）。
2. `hdisj : ∀ a, a ∈ O → a ∈ O' → False`。**これが「軌道が相異なる」ことの中身である。**
   `φ p.1 ≠ φ p.2` を出す段（J_1 の同定）と `q.1 ≠ q.2` を出す段（sw の逆向き）に要る。
   落とすと三分律を当てられず、J_1 = F \ F_φ が成り立たない。
3. `hasymm : ∀ a b, lt a b → ¬ lt b a`。J_1 ⊆ F \ F_φ と sw の像が F を外れることに要る。
4. `htotal : ∀ a b, a ≠ b → lt a b ∨ lt b a`。逆向きの包含に要る。
   **推移律は使っていない。** `lt` が線形順序である必要はなく、非対称かつ相異なる 2 点で
   比較できる関係であればよい。
5. `hP : ∀ p, p ∈ P ↔ lt p.1 p.2`。転倒対の台を `lt` で順序づけられた対の全体に固定する。
   これは「`lt` で順序づけられた対の全体が有限集合である」ことを要求している
   （具体版では ι が有限なので自動）。

具体版との差で言えば、行配位であること・巡回シフト `S` があること・O が軌道であること・
`Fintype ι` はいずれも使っていない。すなわちこの 2 主張は「交わらない 2 つの有限集合」と
「それらを保つ置換」と「非対称で相異なる 2 点を比較できる関係」についての言明であって、
軌道の理論にも順序集合の理論にも属さない。

mathlib の `Equiv.Perm.sign` / `Finset.sum_involution` / 群作用の軌道の一般論は引いていない。
使ったのは `Finset.card_nbij'` と、有限集合の差と共通部分の個数の基本補題だけである。

住処: ここに ℝ / ℂ は現れない（添字は一般の型、個数は ℕ）。
-/
import Mathlib.Data.Finset.Prod
import Mathlib.Data.Finset.Card
import Mathlib.Logic.Equiv.Defs
import Mathlib.GroupTheory.Perm.Basic
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {ι : Type*} [DecidableEq ι]

/-- 人手証明の `F(O,O')`。関係 `lt` は順序である必要すらない。 -/
def crossPairs (lt : ι → ι → Prop) [DecidableRel lt] (O O' : Finset ι) : Finset (ι × ι) :=
  (O ×ˢ O').filter fun p => lt p.1 p.2

/-- 人手証明の `F_φ(O,O')`。 -/
def crossPairsImage (lt : ι → ι → Prop) [DecidableRel lt] (φ : Equiv.Perm ι)
    (O O' : Finset ι) : Finset (ι × ι) :=
  (O ×ˢ O').filter fun p => lt (φ p.1) (φ p.2)

/-- 人手証明の `J_φ(O,O')`。台 `P` は `lt` で順序づけられた対の全体を与える。 -/
def crossInv (lt : ι → ι → Prop) [DecidableRel lt] (φ : Equiv.Perm ι) (P : Finset (ι × ι))
    (O O' : Finset ι) : Finset (ι × ι) :=
  P.filter fun p => ((p.1 ∈ O ∧ p.2 ∈ O') ∨ (p.1 ∈ O' ∧ p.2 ∈ O)) ∧ lt (φ p.2) (φ p.1)

variable {lt : ι → ι → Prop} [DecidableRel lt] {φ : Equiv.Perm ι} {O O' : Finset ι}

omit [DecidableEq ι] in
lemma mem_crossPairs {p : ι × ι} :
    p ∈ crossPairs lt O O' ↔ (p.1 ∈ O ∧ p.2 ∈ O') ∧ lt p.1 p.2 := by
  simp [crossPairs, Finset.mem_filter, Finset.mem_product, and_assoc]

omit [DecidableEq ι] in
lemma mem_crossPairsImage {p : ι × ι} :
    p ∈ crossPairsImage lt φ O O' ↔ (p.1 ∈ O ∧ p.2 ∈ O') ∧ lt (φ p.1) (φ p.2) := by
  simp [crossPairsImage, Finset.mem_filter, Finset.mem_product, and_assoc]

lemma mem_crossInv {P : Finset (ι × ι)} {p : ι × ι} :
    p ∈ crossInv lt φ P O O'
      ↔ p ∈ P ∧ ((p.1 ∈ O ∧ p.2 ∈ O') ∨ (p.1 ∈ O' ∧ p.2 ∈ O)) ∧ lt (φ p.2) (φ p.1) := by
  simp [crossInv, Finset.mem_filter]

omit [DecidableEq ι] in
/-- 人手証明の主張「軌道を保つ置換はまたがる順序づけられた対の個数を変えない」の本体。

`φ` と `φ⁻¹` が 2 つの集合を保つことしか使わない。関係 `lt` には何も要求しない。
相等の判定 `DecidableEq ι` すら要らない（`omit` で外してある）。 -/
theorem card_pairs_image_eq
    (hφO : ∀ a ∈ O, φ a ∈ O) (hφO' : ∀ a ∈ O', φ a ∈ O')
    (hφinvO : ∀ a ∈ O, φ⁻¹ a ∈ O) (hφinvO' : ∀ a ∈ O', φ⁻¹ a ∈ O') :
    (crossPairsImage lt φ O O').card = (crossPairs lt O O').card := by
  classical
  refine Finset.card_nbij' (fun p => (φ p.1, φ p.2)) (fun p => (φ⁻¹ p.1, φ⁻¹ p.2)) ?_ ?_ ?_ ?_
  · intro p hp
    simp only [Finset.mem_coe, mem_crossPairsImage] at hp
    simp only [Finset.mem_coe, mem_crossPairs]
    exact ⟨⟨hφO _ hp.1.1, hφO' _ hp.1.2⟩, hp.2⟩
  · intro p hp
    simp only [Finset.mem_coe, mem_crossPairs] at hp
    simp only [Finset.mem_coe, mem_crossPairsImage]
    refine ⟨⟨hφinvO _ hp.1.1, hφinvO' _ hp.1.2⟩, ?_⟩
    simpa using hp.2
  · intro p _
    simp
  · intro p _
    simp

section Distinct

variable {P : Finset (ι × ι)}

/-- 人手証明の `J_1`。 -/
def crossInvLeft (lt : ι → ι → Prop) [DecidableRel lt] (φ : Equiv.Perm ι) (P : Finset (ι × ι))
    (O O' : Finset ι) : Finset (ι × ι) :=
  (crossInv lt φ P O O').filter fun p => p.1 ∈ O ∧ p.2 ∈ O'

/-- 人手証明の `J_2`。 -/
def crossInvRight (lt : ι → ι → Prop) [DecidableRel lt] (φ : Equiv.Perm ι) (P : Finset (ι × ι))
    (O O' : Finset ι) : Finset (ι × ι) :=
  (crossInv lt φ P O O').filter fun p => p.1 ∈ O' ∧ p.2 ∈ O

/-- 人手証明の「J_1 = F \ F_φ」。 -/
theorem crossInvLeft_eq_sdiff
    (hasymm : ∀ a b : ι, lt a b → ¬ lt b a) (htotal : ∀ a b : ι, a ≠ b → lt a b ∨ lt b a)
    (hdisj : ∀ a : ι, a ∈ O → a ∈ O' → False)
    (hφO : ∀ a ∈ O, φ a ∈ O) (hφO' : ∀ a ∈ O', φ a ∈ O')
    (hP : ∀ p : ι × ι, p ∈ P ↔ lt p.1 p.2) :
    crossInvLeft lt φ P O O' = crossPairs lt O O' \ crossPairsImage lt φ O O' := by
  classical
  ext p
  simp only [crossInvLeft, Finset.mem_filter, Finset.mem_sdiff, mem_crossInv, mem_crossPairs,
    mem_crossPairsImage, hP]
  constructor
  · rintro ⟨⟨hlt, -, hinv⟩, hmem⟩
    exact ⟨⟨hmem, hlt⟩, fun h => hasymm _ _ hinv h.2⟩
  · rintro ⟨⟨hmem, hlt⟩, hnot⟩
    have hne : φ p.1 ≠ φ p.2 := by
      intro h
      exact hdisj (φ p.1) (hφO _ hmem.1) (h ▸ hφO' _ hmem.2)
    have hinv : lt (φ p.2) (φ p.1) := by
      rcases htotal _ _ hne with h | h
      · exact absurd ⟨hmem, h⟩ hnot
      · exact h
    exact ⟨⟨hlt, Or.inl hmem, hinv⟩, hmem⟩

/-- 人手証明の「sw が J_2 を F_φ \ F の上へ写す」。

この段は `φ` が集合を保つことを使わない（使うのは O と O' が交わらないことだけである）。 -/
theorem card_crossInvRight
    (hasymm : ∀ a b : ι, lt a b → ¬ lt b a) (htotal : ∀ a b : ι, a ≠ b → lt a b ∨ lt b a)
    (hdisj : ∀ a : ι, a ∈ O → a ∈ O' → False)
    (hP : ∀ p : ι × ι, p ∈ P ↔ lt p.1 p.2) :
    (crossInvRight lt φ P O O').card
      = (crossPairsImage lt φ O O' \ crossPairs lt O O').card := by
  classical
  refine Finset.card_nbij' Prod.swap Prod.swap ?_ ?_ ?_ ?_
  · intro p hp
    simp only [Finset.mem_coe, crossInvRight, Finset.mem_filter, mem_crossInv, hP] at hp
    obtain ⟨⟨hlt, -, hinv⟩, hmem⟩ := hp
    simp only [Finset.mem_coe, Finset.mem_sdiff, mem_crossPairsImage, mem_crossPairs, Prod.swap]
    exact ⟨⟨⟨hmem.2, hmem.1⟩, hinv⟩, fun h => hasymm _ _ hlt h.2⟩
  · intro q hq
    simp only [Finset.mem_coe, Finset.mem_sdiff, mem_crossPairsImage, mem_crossPairs] at hq
    obtain ⟨⟨hmem, himg⟩, hnot⟩ := hq
    have hne : q.1 ≠ q.2 := fun h => hdisj q.1 hmem.1 (h ▸ hmem.2)
    have hlt : lt q.2 q.1 := by
      rcases htotal _ _ hne with h | h
      · exact absurd ⟨hmem, h⟩ hnot
      · exact h
    simp only [Finset.mem_coe, crossInvRight, Finset.mem_filter, mem_crossInv, hP, Prod.swap]
    exact ⟨⟨hlt, Or.inr ⟨hmem.2, hmem.1⟩, himg⟩, ⟨hmem.2, hmem.1⟩⟩
  · intro p _
    simp
  · intro q _
    simp

/-- 人手証明の準備の第三「|F \ F_φ| = |F_φ \ F|」。 -/
theorem card_sdiff_eq_card_sdiff
    (hφO : ∀ a ∈ O, φ a ∈ O) (hφO' : ∀ a ∈ O', φ a ∈ O')
    (hφinvO : ∀ a ∈ O, φ⁻¹ a ∈ O) (hφinvO' : ∀ a ∈ O', φ⁻¹ a ∈ O') :
    (crossPairs lt O O' \ crossPairsImage lt φ O O').card
      = (crossPairsImage lt φ O O' \ crossPairs lt O O').card := by
  classical
  have hcard := card_pairs_image_eq (lt := lt) hφO hφO' hφinvO hφinvO'
  have h1 := Finset.card_sdiff_add_card_inter (crossPairs lt O O') (crossPairsImage lt φ O O')
  have h2 := Finset.card_sdiff_add_card_inter (crossPairsImage lt φ O O') (crossPairs lt O O')
  rw [Finset.inter_comm] at h2
  omega

/-- 人手証明の主張「2 つの相異なる軌道にまたがる転倒対の個数は偶数である」。 -/
theorem card_crossInv_eq_two_mul
    (hasymm : ∀ a b : ι, lt a b → ¬ lt b a) (htotal : ∀ a b : ι, a ≠ b → lt a b ∨ lt b a)
    (hdisj : ∀ a : ι, a ∈ O → a ∈ O' → False)
    (hφO : ∀ a ∈ O, φ a ∈ O) (hφO' : ∀ a ∈ O', φ a ∈ O')
    (hφinvO : ∀ a ∈ O, φ⁻¹ a ∈ O) (hφinvO' : ∀ a ∈ O', φ⁻¹ a ∈ O')
    (hP : ∀ p : ι × ι, p ∈ P ↔ lt p.1 p.2) :
    (crossInv lt φ P O O').card
      = 2 * (crossPairs lt O O' \ crossPairsImage lt φ O O').card := by
  classical
  have hright : crossInvRight lt φ P O O'
      = (crossInv lt φ P O O').filter (fun p => ¬ (p.1 ∈ O ∧ p.2 ∈ O')) := by
    ext p
    simp only [crossInvRight, Finset.mem_filter, mem_crossInv]
    constructor
    · rintro ⟨hJ, hp⟩
      refine ⟨hJ, ?_⟩
      rintro ⟨hpO, -⟩
      exact hdisj p.1 hpO hp.1
    · rintro ⟨hJ, hnot⟩
      exact ⟨hJ, hJ.2.1.resolve_left hnot⟩
  have hsplit : (crossInv lt φ P O O').card
      = (crossInvLeft lt φ P O O').card + (crossInvRight lt φ P O O').card := by
    rw [crossInvLeft, hright]
    exact (Finset.card_filter_add_card_filter_not
      (s := crossInv lt φ P O O') (p := fun p => p.1 ∈ O ∧ p.2 ∈ O')).symm
  rw [hsplit, crossInvLeft_eq_sdiff hasymm htotal hdisj hφO hφO' hP,
    card_crossInvRight hasymm htotal hdisj hP,
    ← card_sdiff_eq_card_sdiff hφO hφO' hφinvO hφinvO']
  ring

end Distinct

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
