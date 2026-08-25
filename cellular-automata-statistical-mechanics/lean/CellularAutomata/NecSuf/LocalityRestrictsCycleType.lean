/-
章「局所性による巡回型の制限」の必要十分版。
具体版は CellularAutomata/LocalityRestrictsCycleType.lean。

具体版の証明が実際に使っているのは次の三つだけであり、それぞれ独立した段に分けてある。

  第一段（成分ごとの写像への分解）
    近傍が一点 N(v) = {v} である舞台の大域写像は、成分ごとの写像の族 g : V → A → A から
    (P g)(y)(v) = g v (y v) として定まる写像である。その単射性が各成分の単射性と同値であることに
    要るのは、添字型の等号判定 DecidableEq V だけである。
    状態集合が 2 元であること、添字型が有限であること、延長用の基準値（具体版の ι）は要らない。

  第二段（状態集合が 2 元であること）
    2 元集合上の単射な自己写像が対合であることに要るのは、元数が 2 であることだけである。
    値が 0 か 1 という具体的な名前も、舞台も、近傍も要らない。

  第三段（対合の巡回型）
    有限台上の対合の巡回型の元が 2 以下であることに要るのは、台の有限性と等号判定だけである。
    台が配位型 A^V の形であること、元数が 2 の冪であることは要らない。

削れなかった仮定と、その必要な理由。

  * DecidableEq V（第一段）: 単射性の必要条件を示す段で、注目する成分 v でだけ値が異なる証人配位
    を作るために、u = v かどうかの場合分けが要る。
  * Fintype A, DecidableEq A, card A = 2（第二段）: 有限性は単射から全射を出す段で、元数 2 は
    置換の群の元数が 2 であることから 2 乗が恒等になることを出す段で要る。
  * Fintype X, DecidableEq X（第三段）: 単射な自己写像を有限置換として読む段と、
    有限多重集合としての巡回型を取る段で要る（必要十分版
    NecSuf/ReversibleGlobalMapCycleType.lean と同じ理由）。

具体版で使っていた基準値延長写像 ι は、必要条件の証人配位を「注目する成分の外では定数」に取れば
不要になる。これは具体版が過剰な構造（状態集合の基準値）を要求していたことの指摘であり、
必要十分版の検査としての本体である。

証明手順は具体版と同じ順序（成分ごとの分解 → 単射性の同値 → 対合性 → 巡回型の分類 →
実現しない分割の提示）で並べ、論法を差し替えていない。
有限集合・自然数・有限多重集合だけで閉じ、R / C は現れない。
-/

import CellularAutomata.NecSuf.ReversibleGlobalMapCycleType

namespace CellularAutomata.NecSuf.LocalityRestrictsCycleType

open CellularAutomata.NecSuf.ReversibleGlobalMapCycleType

/-! ### 第一段: 成分ごとの写像への分解 -/

variable {V A : Type}

/-- 成分ごとの写像の族が定める、関数型 `V → A` 上の写像（具体版の `globalMap selfNbhd f` に対応）。
    近傍・局所真理値表・舞台は要らず、成分ごとの写像の族だけで書ける。 -/
def productMap (g : V → A → A) : (V → A) → (V → A) := fun y v => g v (y v)

@[simp]
theorem productMap_apply (g : V → A → A) (y : V → A) (v : V) :
    productMap g y v = g v (y v) := rfl

/-- `claim_self_neighborhood_injective_iff_pointwise_bijective` の必要十分版。
    成分写像から定まる写像が単射であることと、全ての成分写像が単射であることは同値である。
    証人配位は注目する成分の外で定数に取れるので、具体版の基準値延長写像 ι は要らない。 -/
theorem productMap_injective_iff [DecidableEq V] (g : V → A → A) :
    Function.Injective (productMap g) ↔ ∀ v : V, Function.Injective (g v) := by
  classical
  constructor
  · -- 全体が単射 ⇒ 各成分が単射。v でだけ値が異なる二つの配位を作る。
    intro hP v a a' ha
    set x : V → A := fun _ => a with hxdef
    set x' : V → A := fun u => if u = v then a' else a with hx'def
    have hxv : x v = a := rfl
    have hx'v : x' v = a' := by simp [hx'def]
    have hP' : productMap g x = productMap g x' := by
      funext u
      rw [productMap_apply, productMap_apply]
      by_cases huv : u = v
      · subst huv
        rw [hxv, hx'v]
        exact ha
      · simp [hxdef, hx'def, huv]
    have hxx' := hP hP'
    calc a = x v := hxv.symm
      _ = x' v := by rw [hxx']
      _ = a' := hx'v
  · -- 各成分が単射 ⇒ 全体が単射。
    intro hg y y' hyy
    funext v
    have := congrArg (fun z => z v) hyy
    rw [productMap_apply, productMap_apply] at this
    exact hg v this

/-- `claim_self_neighborhood_involution` の必要十分版の骨格。
    各成分写像が対合なら、成分写像から定まる写像も対合である。 -/
theorem productMap_involution (g : V → A → A) (hg : ∀ (v : V) (a : A), g v (g v a) = a)
    (y : V → A) : productMap g (productMap g y) = y := by
  funext v
  rw [productMap_apply, productMap_apply]
  exact hg v (y v)

/-! ### 第二段: 状態集合が 2 元であること -/

/-- `selfRule_eq_id_or_neg` の必要十分版。
    元数 2 の有限型上の単射な自己写像は対合である。値が 0 か 1 という名前は使わない。
    具体版は g = id または g = ν という形で場合分けしたが、対合性はどちらの場合にも共通で、
    以降で使うのは対合性だけである。 -/
theorem involution_of_injective_of_card_two {A : Type} [Fintype A] [DecidableEq A]
    (hA : Fintype.card A = 2) {g : A → A} (hg : Function.Injective g) (a : A) :
    g (g a) = a := by
  classical
  have hbij : Function.Bijective g :=
    (Fintype.bijective_iff_injective_and_card g).2 ⟨hg, rfl⟩
  set σ : Equiv.Perm A := Equiv.ofBijective g hbij with hσ
  have hcardPerm : Fintype.card (Equiv.Perm A) = 2 := by
    rw [Fintype.card_perm, hA]
    decide
  have hpow : σ ^ Fintype.card (Equiv.Perm A) = 1 := pow_card_eq_one
  rw [hcardPerm] at hpow
  have := congrArg (fun τ : Equiv.Perm A => τ a) hpow
  simpa [pow_two, hσ, Equiv.ofBijective] using this

/-! ### 第三段: 有限台上の対合の巡回型 -/

variable {X : Type} [Fintype X] [DecidableEq X]

/-- 有限台上の対合の巡回型の元は 2 以下である。
    台が配位型であること、元数が 2 の冪であることは使わない。 -/
theorem cycleType_le_two (F : InjSelfMap X) (hinv : ∀ x : X, F.1 (F.1 x) = x)
    {n : ℕ} (hn : n ∈ cycleType F) : n ≤ 2 := by
  classical
  set σ := toPerm F with hσ
  have hpow : σ ^ 2 = 1 := by
    apply Equiv.ext
    intro x
    simpa [hσ, pow_two] using hinv x
  have htype := Equiv.Perm.cycleType_of_pow_prime_eq_one (p := 2) hpow
  rw [cycleType] at hn
  rcases Multiset.mem_add.1 hn with hmain | hone
  · rw [htype] at hmain
    have := Multiset.eq_of_mem_replicate hmain
    omega
  · have := Multiset.eq_of_mem_replicate hone
    omega

/-- `eight_cycle_not_realized` の必要十分版。
    台の元数が 3 以上なら、台全体を一周する巡回型は対合では実現しない。 -/
theorem cycleType_ne_singleton_card (F : InjSelfMap X) (hinv : ∀ x : X, F.1 (F.1 x) = x)
    (h3 : 3 ≤ Fintype.card X) :
    cycleType F ≠ ({Fintype.card X} : Multiset ℕ) := by
  intro heq
  have hmem : Fintype.card X ∈ cycleType F := by
    rw [heq]
    exact Multiset.mem_singleton_self _
  have := cycleType_le_two F hinv hmem
  omega

/-- `realizedCycleTypes_selfNbhd_proper` の必要十分版。
    対合が実現する巡回型の集合は、台の元数の正の自然数への分割全体の真部分集合である。 -/
theorem involutionCycleTypes_ssubset_partitions (h3 : 3 ≤ Fintype.card X) :
    {m : Multiset ℕ | ∃ F : InjSelfMap X, (∀ x : X, F.1 (F.1 x) = x) ∧ cycleType F = m} ⊂
      {m : Multiset ℕ | (∀ n ∈ m, 1 ≤ n) ∧ m.sum = Fintype.card X} := by
  apply Set.ssubset_iff_subset_ne.mpr
  constructor
  · rintro m ⟨F, -, rfl⟩
    exact ⟨fun n hn => cycleType_members_positive F hn, cycleType_sum F⟩
  · intro heq
    have hmem : ({Fintype.card X} : Multiset ℕ) ∈
        {m : Multiset ℕ | (∀ n ∈ m, 1 ≤ n) ∧ m.sum = Fintype.card X} := by
      refine ⟨fun n hn => ?_, by simp⟩
      rw [Multiset.mem_singleton.1 hn]
      omega
    rw [← heq] at hmem
    obtain ⟨F, hinv, hct⟩ := hmem
    exact cycleType_ne_singleton_card F hinv h3 hct

end CellularAutomata.NecSuf.LocalityRestrictsCycleType
