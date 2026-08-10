/-
主張「互換の軌道への制限の符号は $-1$ である」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.OrbitTranspositionSign`）の証明が実際に
使っているのは次だけである。証明手順は具体版と同じ（同じ両包含、同じ 7 つの場合分け、
同じ数え上げ、同じ指数法則の計算）。

  主張                                使っている性質
  inversionSetOn_transposition        `lt` の非対称性と推移律、および `α` の相等が決定できること
  inversionCountOn_transposition      同上（数え上げは有限集合の合併の個数の加法性）
  signOn_transposition                同上＋整数の指数法則

削れなかった仮定と、その理由は次のとおりである。

1. 非対称性 `hasymm`。7 つの場合分けのうち 4 つ（起こらない場合）がこれで潰れる。
   また `lt a b → a ≠ b` もこれから出る（`a = b` なら `lt a a` と `¬ lt a a` が同時に立つ）。
   **三分律の残りの結論（全順序性）は使っていない。**
2. 推移律 `htrans`。「τb ≺ τ' かつ τa ≺ τb ならば τa ≺ τ'」を使う場合が 2 つある。
   非対称性だけでは潰せないので残った。
3. `DecidableEq α`（互換の定義そのものが場合分けなので要る）と `DecidableRel lt`
   （転倒対の集合を `Finset.filter` で作るので要る）。

**使っていないもの**: 台 `s` が軌道であること、`s` が巡回シフトで閉じていること、
`α` の有限性、`lt` の全順序性、行配位であること、格子の形。

値の側は `ℤ` に固定してある（人手証明が `ℤ` の中の等式として述べているため）。
mathlib の `Equiv.Perm.sign` / `Equiv.swap` の符号の一般論は引かない
（引くと人手証明の数え上げがまるごと消える）。

住処: ここに ℝ / ℂ は現れない（数え上げは ℕ、符号は ℤ）。
-/
import Mathlib.Data.Finset.Prod
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitTransposition
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitPermutationSignValues

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

variable {α : Type*} [DecidableEq α] (lt : α → α → Prop) [DecidableRel lt]

/-- 人手証明の `F(O,O)` を、台を勝手な `Finset α` に取り替えたもの。 -/
noncomputable def orderedPairsOn (s : Finset α) : Finset (α × α) :=
  (s ×ˢ s).filter fun p => lt p.1 p.2

/-- 人手証明の `Inv_O(ψ)` を、台を勝手な `Finset α` に取り替えたもの。 -/
noncomputable def inversionSetOn (s : Finset α) (g : α → α) : Finset (α × α) :=
  (orderedPairsOn lt s).filter fun p => lt (g p.2) (g p.1)

/-- 人手証明の `M`。 -/
noncomputable def betweenOn (s : Finset α) (a b : α) : Finset α :=
  s.filter fun x => lt a x ∧ lt x b

/-- 人手証明の `A`。 -/
noncomputable def leftPairsOn (s : Finset α) (a b : α) : Finset (α × α) :=
  (betweenOn lt s a b).image fun x => (a, x)

/-- 人手証明の `B`。 -/
noncomputable def rightPairsOn (s : Finset α) (a b : α) : Finset (α × α) :=
  (betweenOn lt s a b).image fun x => (x, b)

theorem mem_betweenOn {s : Finset α} {a b x : α} :
    x ∈ betweenOn lt s a b ↔ x ∈ s ∧ lt a x ∧ lt x b := by
  simp [betweenOn]

theorem mem_inversionSetOn {s : Finset α} {g : α → α} {p : α × α} :
    p ∈ inversionSetOn lt s g ↔
      (p.1 ∈ s ∧ p.2 ∈ s ∧ lt p.1 p.2) ∧ lt (g p.2) (g p.1) := by
  simp [inversionSetOn, orderedPairsOn, Finset.mem_filter, Finset.mem_product, and_assoc]

/-- 非対称性から出る相異性。人手証明が三分律から引いている `τ ≺ τ' → τ ≠ τ'` に対応する。 -/
theorem ne_of_lt_of_asymm (hasymm : ∀ x y : α, lt x y → ¬ lt y x) {x y : α}
    (h : lt x y) : x ≠ y := by
  intro hxy
  exact hasymm x y h (hxy ▸ h)

/-- 人手証明の集合の等号 `Inv_O(ψ) = A ∪ B ∪ C`（両包含・7 つの場合分け）。 -/
theorem inversionSetOn_transposition {s : Finset α} {a b : α}
    (hasymm : ∀ x y : α, lt x y → ¬ lt y x)
    (htrans : ∀ x y z : α, lt x y → lt y z → lt x z)
    (ha : a ∈ s) (hb : b ∈ s) (hab : lt a b) :
    inversionSetOn lt s (transpositionOn a b)
      = leftPairsOn lt s a b ∪ rightPairsOn lt s a b ∪ {(a, b)} := by
  have hba : b ≠ a := fun h => (ne_of_lt_of_asymm lt hasymm hab) h.symm
  ext p
  obtain ⟨x, y⟩ := p
  constructor
  · intro hp
    rw [mem_inversionSetOn] at hp
    obtain ⟨⟨hx, hy, hlt⟩, hinv⟩ := hp
    by_cases hxa : x = a
    · subst hxa
      by_cases hyb : y = b
      · subst hyb
        simp
      · have hyx : y ≠ x := fun h => (ne_of_lt_of_asymm lt hasymm hlt) h.symm
        have h1 : transpositionOn x b x = b := by simp [transpositionOn]
        have h2 : transpositionOn x b y = y := by simp [transpositionOn, hyx, hyb]
        rw [h1, h2] at hinv
        have hmem : y ∈ betweenOn lt s x b := (mem_betweenOn lt).mpr ⟨hy, hlt, hinv⟩
        exact Finset.mem_union_left _
          (Finset.mem_union_left _ (Finset.mem_image.mpr ⟨y, hmem, rfl⟩))
    · by_cases hxb : x = b
      · subst hxb
        have hyx : y ≠ x := fun h => (ne_of_lt_of_asymm lt hasymm hlt) h.symm
        by_cases hya : y = a
        · subst hya
          exact absurd hlt (hasymm _ _ hab)
        · have h1 : transpositionOn a x x = a := by simp [transpositionOn, hxa]
          have h2 : transpositionOn a x y = y := by simp [transpositionOn, hya, hyx]
          rw [h1, h2] at hinv
          exact absurd (htrans _ _ _ hab hlt) (hasymm _ _ hinv)
      · by_cases hyb : y = b
        · subst hyb
          have h1 : transpositionOn a y x = x := by simp [transpositionOn, hxa, hxb]
          have h2 : transpositionOn a y y = a := by
            simp [transpositionOn, fun h : y = a => hba h]
          rw [h1, h2] at hinv
          have hmem : x ∈ betweenOn lt s a y := (mem_betweenOn lt).mpr ⟨hx, hinv, hlt⟩
          exact Finset.mem_union_left _
            (Finset.mem_union_right _ (Finset.mem_image.mpr ⟨x, hmem, rfl⟩))
        · by_cases hya : y = a
          · subst hya
            have h1 : transpositionOn y b x = x := by simp [transpositionOn, hxa, hxb]
            have h2 : transpositionOn y b y = b := by simp [transpositionOn]
            rw [h1, h2] at hinv
            exact absurd (htrans _ _ _ hlt hab) (hasymm _ _ hinv)
          · have h1 : transpositionOn a b x = x := by simp [transpositionOn, hxa, hxb]
            have h2 : transpositionOn a b y = y := by simp [transpositionOn, hya, hyb]
            rw [h1, h2] at hinv
            exact absurd hinv (hasymm _ _ hlt)
  · intro hp
    simp only [Finset.mem_union, Finset.mem_singleton, leftPairsOn, rightPairsOn,
      Finset.mem_image] at hp
    rcases hp with (⟨σ, hσ, hσeq⟩ | ⟨σ, hσ, hσeq⟩) | hCmem
    · obtain ⟨hσs, haσ, hσb⟩ := (mem_betweenOn lt).mp hσ
      rw [← hσeq, mem_inversionSetOn]
      refine ⟨⟨ha, hσs, haσ⟩, ?_⟩
      have hσa : σ ≠ a := fun h => (ne_of_lt_of_asymm lt hasymm haσ) h.symm
      have h1 : transpositionOn a b a = b := by simp [transpositionOn]
      have h2 : transpositionOn a b σ = σ := by
        simp [transpositionOn, ne_of_lt_of_asymm lt hasymm hσb, hσa]
      simp only [h1, h2]
      exact hσb
    · obtain ⟨hσs, haσ, hσb⟩ := (mem_betweenOn lt).mp hσ
      rw [← hσeq, mem_inversionSetOn]
      refine ⟨⟨hσs, hb, hσb⟩, ?_⟩
      have hσa : σ ≠ a := fun h => (ne_of_lt_of_asymm lt hasymm haσ) h.symm
      have h1 : transpositionOn a b σ = σ := by
        simp [transpositionOn, ne_of_lt_of_asymm lt hasymm hσb, hσa]
      have h2 : transpositionOn a b b = a := by simp [transpositionOn, hba]
      simp only [h1, h2]
      exact haσ
    · rw [hCmem, mem_inversionSetOn]
      refine ⟨⟨ha, hb, hab⟩, ?_⟩
      have h1 : transpositionOn a b a = b := by simp [transpositionOn]
      have h2 : transpositionOn a b b = a := by simp [transpositionOn, hba]
      simp only [h1, h2]
      exact hab

theorem leftPairsOn_card {s : Finset α} {a b : α} :
    (leftPairsOn lt s a b).card = (betweenOn lt s a b).card :=
  Finset.card_image_of_injective _ (fun _ _ h => congrArg Prod.snd h)

theorem rightPairsOn_card {s : Finset α} {a b : α} :
    (rightPairsOn lt s a b).card = (betweenOn lt s a b).card :=
  Finset.card_image_of_injective _ (fun _ _ h => congrArg Prod.fst h)

/-- 第一の主張の必要十分版。`inv(t) = 2|M| + 1` である。 -/
theorem inversionCountOn_transposition {s : Finset α} {a b : α}
    (hasymm : ∀ x y : α, lt x y → ¬ lt y x)
    (htrans : ∀ x y z : α, lt x y → lt y z → lt x z)
    (ha : a ∈ s) (hb : b ∈ s) (hab : lt a b) :
    inversionCountOn lt (orderedPairsOn lt s) (transpositionOn a b)
      = 2 * (betweenOn lt s a b).card + 1 := by
  classical
  have hAB : Disjoint (leftPairsOn lt s a b) (rightPairsOn lt s a b) := by
    rw [Finset.disjoint_left]
    intro p hpA hpB
    simp only [leftPairsOn, rightPairsOn, Finset.mem_image] at hpA hpB
    obtain ⟨σ, _, hσeq⟩ := hpA
    obtain ⟨σ', hσ', hσ'eq⟩ := hpB
    obtain ⟨_, haσ', _⟩ := (mem_betweenOn lt).mp hσ'
    have h1 : p.1 = a := by rw [← hσeq]
    have h2 : p.1 = σ' := by rw [← hσ'eq]
    exact (ne_of_lt_of_asymm lt hasymm haσ') (h2.symm.trans h1).symm
  have hC : Disjoint (leftPairsOn lt s a b ∪ rightPairsOn lt s a b)
      ({(a, b)} : Finset (α × α)) := by
    rw [Finset.disjoint_right]
    intro p hp hpU
    simp only [Finset.mem_singleton] at hp
    subst hp
    simp only [Finset.mem_union, leftPairsOn, rightPairsOn, Finset.mem_image] at hpU
    rcases hpU with ⟨σ, hσ, hσeq⟩ | ⟨σ, hσ, hσeq⟩
    · obtain ⟨_, _, hσb⟩ := (mem_betweenOn lt).mp hσ
      exact (ne_of_lt_of_asymm lt hasymm hσb) (congrArg Prod.snd hσeq)
    · obtain ⟨_, haσ, _⟩ := (mem_betweenOn lt).mp hσ
      exact (ne_of_lt_of_asymm lt hasymm haσ) (congrArg Prod.fst hσeq).symm
  calc inversionCountOn lt (orderedPairsOn lt s) (transpositionOn a b)
      = (inversionSetOn lt s (transpositionOn a b)).card := rfl
    _ = (leftPairsOn lt s a b ∪ rightPairsOn lt s a b ∪ {(a, b)}).card := by
        rw [inversionSetOn_transposition lt hasymm htrans ha hb hab]
    _ = (leftPairsOn lt s a b ∪ rightPairsOn lt s a b).card + 1 := by
        rw [Finset.card_union_of_disjoint hC, Finset.card_singleton]
    _ = (leftPairsOn lt s a b).card + (rightPairsOn lt s a b).card + 1 := by
        rw [Finset.card_union_of_disjoint hAB]
    _ = (betweenOn lt s a b).card + (betweenOn lt s a b).card + 1 := by
        rw [leftPairsOn_card, rightPairsOn_card]
    _ = 2 * (betweenOn lt s a b).card + 1 := by ring

/-- 第二の主張の必要十分版。`sgn(t) = -1` である。 -/
theorem signOn_transposition {s : Finset α} {a b : α}
    (hasymm : ∀ x y : α, lt x y → ¬ lt y x)
    (htrans : ∀ x y z : α, lt x y → lt y z → lt x z)
    (ha : a ∈ s) (hb : b ∈ s) (hab : lt a b) :
    signOn lt (orderedPairsOn lt s) (transpositionOn a b) = -1 := by
  have hcount := inversionCountOn_transposition lt hasymm htrans ha hb hab
  calc signOn lt (orderedPairsOn lt s) (transpositionOn a b)
      = (-1 : ℤ) ^ inversionCountOn lt (orderedPairsOn lt s) (transpositionOn a b) := rfl
    _ = (-1 : ℤ) ^ (2 * (betweenOn lt s a b).card + 1) := by rw [hcount]
    _ = ((-1 : ℤ) ^ 2) ^ (betweenOn lt s a b).card * (-1 : ℤ) ^ 1 := by
        rw [pow_add, pow_mul]
    _ = 1 ^ (betweenOn lt s a b).card * (-1 : ℤ) := by norm_num
    _ = -1 := by simp

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
