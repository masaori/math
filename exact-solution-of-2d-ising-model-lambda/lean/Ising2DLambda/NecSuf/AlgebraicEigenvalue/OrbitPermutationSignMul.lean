/-
主張「軌道の上の全単射の符号は合成について乗法的である」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.OrbitPermutationSignMul`）の証明が実際に
使っているのは次だけである。証明手順は具体版と同じ（準備の第一〜第三、3 つの部分集合、
各対での偶数性、2 つの式変形、という同じ順序で進む）。

  使っている性質                なぜ削れないか
  `hasymm`                      準備の第二（並べ直した対がちょうど 1 通りに決まること）と、
                                各対での偶数性の第 1 の場合で使う。
  `htotal`                      同じ 2 か所で、相異なる 2 点が比較できることとして使う。
                                この 2 つが人手証明の言う「三分律」の中身である。
  `hclosed` / `hclosed'`        並べ直しの写像が台の中へ入ること。人手証明では
                                「`ψ₂` の値が `O` に属する」ことから出しているが、
                                この段が要求するのは台についての閉じ方だけである。
  `hround` / `hround'`          並べ直しの写像が全単射であること（両向きの往復）。
  `hne₂` / `hne₁₂`              各対での偶数性の場合分けで、2 つの値が相異なることとして使う。
                                人手証明は `ψ₂`・`ψ₁∘ψ₂` の単射性から出しているが、
                                要るのは台の対についての相異なることだけである。

**推移律は仮定していない。** 人手証明が使うのは三分律だけであり、それをさらに
非対称性（`hasymm`）と全順序性（`htotal`）の 2 つへ分けて受け取っている。
足さずに通ることが「使っていない」ことの検査になっている。

削れたもの: 台の型の有限性（`Fintype α`）、台が `F(O,O)` の形であること、台の対が
`lt` で順序づけられていること、写像が全体で単射・全射であること、写像の値が軌道に属すること。
とくに、姉妹の必要十分版 `PermutationSign.lean` は台を `univ` から作っていて
`Fintype α` を要求していたが、台を勝手な `Finset (α × α)` に取り替えるとこの仮定は消える。

値の側は `ℤ` に固定してある（人手証明が `ℤ` の中の等式として述べているため）。

mathlib の `Equiv.Perm.sign` は引かない（引くと転倒数で定めるという定義そのものが消える）。

住処: ここに ℝ / ℂ は現れない（数え上げは ℕ、符号は ℤ）。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitPermutationSignValues
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

variable {α : Type*} (lt : α → α → Prop) [DecidableRel lt]

/-- 人手証明の写像 `srt_ψ`。`g` の像の 2 成分を `lt` について並べ直した対を返す。 -/
noncomputable def sortPair (g : α → α) (p : α × α) : α × α :=
  if lt (g p.1) (g p.2) then (g p.1, g p.2) else (g p.2, g p.1)

variable {lt}

/-- 「属するときだけ `-1` を掛けた有限積は `(-1)` の個数乗」（人手証明の第 3 の等号）。 -/
lemma prod_ite_neg_one_on {β : Type*} (s : Finset β) (q : β → Prop) [DecidablePred q] :
    (∏ p ∈ s, if q p then (-1 : ℤ) else 1) = (-1) ^ (s.filter q).card := by
  rw [prod_ite, prod_const, prod_const_one, mul_one]

/-- 人手証明の `|C| = inv_O(ψ₁)`。並べ直しの写像で数え直しても転倒数は変わらない。

要るのは、並べ直しの写像が台の中へ入ること（`hclosed`・`hclosed'`）と、
両向きの往復が恒等写像であること（`hround`・`hround'`）だけである。 -/
theorem inversionCountOn_eq_card_sortPair {s : Finset (α × α)} {g₁ g₂ g₂' : α → α}
    (hclosed : ∀ p ∈ s, sortPair lt g₂ p ∈ s)
    (hclosed' : ∀ p ∈ s, sortPair lt g₂' p ∈ s)
    (hround : ∀ p ∈ s, sortPair lt g₂' (sortPair lt g₂ p) = p)
    (hround' : ∀ p ∈ s, sortPair lt g₂ (sortPair lt g₂' p) = p) :
    inversionCountOn lt s g₁
      = (s.filter fun p =>
          lt (g₁ (sortPair lt g₂ p).2) (g₁ (sortPair lt g₂ p).1)).card := by
  rw [inversionCountOn]
  refine card_nbij' (sortPair lt g₂') (sortPair lt g₂) ?_ ?_ ?_ ?_
  · intro q hq
    simp only [coe_filter, Set.mem_setOf_eq] at hq ⊢
    refine ⟨hclosed' q hq.1, ?_⟩
    rw [hround' q hq.1]
    exact hq.2
  · intro p hp
    simp only [coe_filter, Set.mem_setOf_eq] at hp ⊢
    exact ⟨hclosed p hp.1, hp.2⟩
  · intro q hq
    simp only [coe_filter, Set.mem_setOf_eq] at hq
    exact hround' q hq.1
  · intro p hp
    simp only [coe_filter, Set.mem_setOf_eq] at hp
    exact hround p hp.1

/-- 人手証明の「各対について `A, B, C` のうち属するものの個数は偶数である」。

属するときだけ `-1` を掛けた 3 つぶんの積が `1` になる、と書いてある。 -/
theorem parity_at_pair_on {s : Finset (α × α)} {g₁ g₂ : α → α}
    (hasymm : ∀ a b : α, lt a b → ¬ lt b a)
    (htotal : ∀ a b : α, a ≠ b → lt a b ∨ lt b a)
    (hne₂ : ∀ p ∈ s, g₂ p.1 ≠ g₂ p.2)
    (hne₁₂ : ∀ p ∈ s, g₁ (g₂ p.1) ≠ g₁ (g₂ p.2))
    {p : α × α} (hp : p ∈ s) :
    (if lt (g₁ (g₂ p.2)) (g₁ (g₂ p.1)) then (-1 : ℤ) else 1)
        * (if lt (g₁ (sortPair lt g₂ p).2) (g₁ (sortPair lt g₂ p).1) then (-1 : ℤ) else 1)
        * (if lt (g₂ p.2) (g₂ p.1) then (-1 : ℤ) else 1) = 1 := by
  have h₂ : g₂ p.1 ≠ g₂ p.2 := hne₂ p hp
  have h₁₂ : g₁ (g₂ p.1) ≠ g₁ (g₂ p.2) := hne₁₂ p hp
  by_cases h : lt (g₂ p.1) (g₂ p.2)
  · -- ψ₂(τ) ≺ ψ₂(τ') の場合。B に属さず、A の条件と C の条件が同じ。
    have hB : ¬ lt (g₂ p.2) (g₂ p.1) := hasymm _ _ h
    by_cases hA : lt (g₁ (g₂ p.2)) (g₁ (g₂ p.1))
    · simp [sortPair, h, hB, hA]
    · simp [sortPair, h, hB, hA]
  · -- ψ₂(τ') ≺ ψ₂(τ) の場合。B に属し、A と C はちょうど一方。
    have hB : lt (g₂ p.2) (g₂ p.1) := by
      rcases htotal _ _ h₂ with h' | h'
      · exact absurd h' h
      · exact h'
    by_cases hA : lt (g₁ (g₂ p.2)) (g₁ (g₂ p.1))
    · have hC : ¬ lt (g₁ (g₂ p.1)) (g₁ (g₂ p.2)) := hasymm _ _ hA
      simp [sortPair, h, hB, hA, hC]
    · have hC : lt (g₁ (g₂ p.1)) (g₁ (g₂ p.2)) := by
        rcases htotal _ _ h₁₂ with h' | h'
        · exact h'
        · exact absurd h' hA
      simp [sortPair, h, hB, hA, hC]

/-- 人手証明の乗法性の必要十分版。 -/
theorem signOn_comp {s : Finset (α × α)} {g₁ g₂ g₂' : α → α}
    (hasymm : ∀ a b : α, lt a b → ¬ lt b a)
    (htotal : ∀ a b : α, a ≠ b → lt a b ∨ lt b a)
    (hclosed : ∀ p ∈ s, sortPair lt g₂ p ∈ s)
    (hclosed' : ∀ p ∈ s, sortPair lt g₂' p ∈ s)
    (hround : ∀ p ∈ s, sortPair lt g₂' (sortPair lt g₂ p) = p)
    (hround' : ∀ p ∈ s, sortPair lt g₂ (sortPair lt g₂' p) = p)
    (hne₂ : ∀ p ∈ s, g₂ p.1 ≠ g₂ p.2)
    (hne₁₂ : ∀ p ∈ s, g₁ (g₂ p.1) ≠ g₁ (g₂ p.2)) :
    signOn lt s (fun a => g₁ (g₂ a)) = signOn lt s g₁ * signOn lt s g₂ := by
  -- 3 つの符号の積が 1 であること（人手証明の 1 つめの式変形）。
  have hprod : signOn lt s (fun a => g₁ (g₂ a)) * signOn lt s g₁ * signOn lt s g₂ = 1 := by
    rw [signOn, signOn, signOn,
      inversionCountOn_eq_card_sortPair (g₁ := g₁) hclosed hclosed' hround hround']
    simp only [inversionCountOn]
    rw [← prod_ite_neg_one_on s fun p => lt (g₁ (g₂ p.2)) (g₁ (g₂ p.1)),
      ← prod_ite_neg_one_on s fun p =>
        lt (g₁ (sortPair lt g₂ p).2) (g₁ (sortPair lt g₂ p).1),
      ← prod_ite_neg_one_on s fun p => lt (g₂ p.2) (g₂ p.1),
      ← prod_mul_distrib, ← prod_mul_distrib]
    rw [prod_congr rfl fun p hp => parity_at_pair_on hasymm htotal hne₂ hne₁₂ hp,
      prod_const_one]
  -- 両辺に sgn(ψ₁) sgn(ψ₂) を掛ける（人手証明の 2 つめの式変形）。
  calc signOn lt s (fun a => g₁ (g₂ a))
      = signOn lt s (fun a => g₁ (g₂ a)) * 1 * 1 := by ring
    _ = signOn lt s (fun a => g₁ (g₂ a)) * (signOn lt s g₁ * signOn lt s g₁)
          * (signOn lt s g₂ * signOn lt s g₂) := by
        rw [signOn_mul_self lt s g₁, signOn_mul_self lt s g₂]
    _ = (signOn lt s (fun a => g₁ (g₂ a)) * signOn lt s g₁ * signOn lt s g₂)
          * (signOn lt s g₁ * signOn lt s g₂) := by ring
    _ = 1 * (signOn lt s g₁ * signOn lt s g₂) := by rw [hprod]
    _ = signOn lt s g₁ * signOn lt s g₂ := by ring

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
