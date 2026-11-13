/-
節「有限集合の上の和」のうち、線型結合の番号の付け替えについての二つの主張の具体版。人手証明と 1 対 1 に対応させる。

  本文のラベル                                         このファイル
  claim_moving_term_of_linear_combination_to_last      moveIndex（ρ_j）・partialLinearCombination_moveTermToLast（帰納法の主張）・
                                                       linearCombination_moveTermToLast
  claim_reindexing_linear_combination_by_bijection     linearCombination_reindex

番号付けた族は `ℕ → V` で表す（`Definitions.lean` の約束）。第 j 項を除いて詰めた族 x̃_k := x_{ρ_j(k)} は
`fun k => x (moveIndex j k)` である。本文は m ∈ {0,…,n} について帰納法の主張を示すが、
L_m は m > n でも同じ式で定まり、示す等式もそのまま成り立つので、m の範囲を制限しない。

本文の付け替えの主張の写像 σ:{1,…,n}→{1,…,n'} は `Idx n → Idx n'`、左辺の族 k ↦ y_{σ(k)} は
`numberedFamily σ (fun i => y i.1) 0_V`（`Numbering.lean`）である。
残りの族 ŷ_i := y_i、μ̂_i := μ_i は `ℕ` の族としては y・μ そのものなので、本文の「L̂_m = L_m」は `rfl` になる。

必要十分版は `NecSuf/MathematicalToolkit/FiniteSetSum/Reindexing.lean`、導出版は `FiniteSetSumFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexVectorSpace.LinearCombination
import CliffordMatrixIsomorphism.MathematicalToolkit.FiniteSetSum.Numbering

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

universe u

variable {V : Type u}

/-- 本文 `claim_moving_term_of_linear_combination_to_last` の写像 ρ_j：k < j なら k、k ≥ j なら k + 1。 -/
def moveIndex (j k : ℕ) : ℕ := if k < j then k else k + 1

theorem moveIndex_of_lt {j k : ℕ} (h : k < j) : moveIndex j k = k := if_pos h

theorem moveIndex_of_ge {j k : ℕ} (h : ¬ k < j) : moveIndex j k = k + 1 := if_neg h

/-- 本文 `claim_moving_term_of_linear_combination_to_last` の帰納法の主張：
m < j なら L_m = L̃_m、m ≥ j なら L_m = L̃_{m-1} +_V (λ_j ·_V x_j)。 -/
theorem partialLinearCombination_moveTermToLast (S : ComplexVectorSpace V) (c : ℕ → ℂ) (x : ℕ → V)
    (j : ℕ) (hj : 1 ≤ j) (m : ℕ) :
    partialLinearCombination S c x m
      = if m < j then
          partialLinearCombination S (fun k => c (moveIndex j k)) (fun k => x (moveIndex j k)) m
        else
          S.add (partialLinearCombination S (fun k => c (moveIndex j k)) (fun k => x (moveIndex j k))
            (m - 1)) (S.smul (c j) (x j)) := by
  induction m with
  | zero =>
    rw [if_pos (show 0 < j by omega)]
    calc partialLinearCombination S c x 0 = S.zero := rfl
      _ = partialLinearCombination S (fun k => c (moveIndex j k)) (fun k => x (moveIndex j k)) 0 :=
          rfl
  | succ m ih =>
    rcases Nat.lt_trichotomy (m + 1) j with hlt | heq | hgt
    · -- m < j のとき（本文の m は m + 1）
      have hm : m < j := by omega
      have hρ : moveIndex j (m + 1) = m + 1 := moveIndex_of_lt hlt
      rw [if_pos hlt]
      calc partialLinearCombination S c x (m + 1)
          = S.add (partialLinearCombination S c x m) (S.smul (c (m + 1)) (x (m + 1))) := rfl
        _ = S.add (partialLinearCombination S (fun k => c (moveIndex j k))
                (fun k => x (moveIndex j k)) m) (S.smul (c (m + 1)) (x (m + 1))) := by
              rw [ih, if_pos hm]
        _ = S.add (partialLinearCombination S (fun k => c (moveIndex j k))
                (fun k => x (moveIndex j k)) m)
              (S.smul (c (moveIndex j (m + 1))) (x (moveIndex j (m + 1)))) := by rw [hρ]
        _ = S.add (partialLinearCombination S (fun k => c (moveIndex j k))
                (fun k => x (moveIndex j k)) m)
              (S.smul ((fun k => c (moveIndex j k)) (m + 1))
                ((fun k => x (moveIndex j k)) (m + 1))) := rfl
        _ = partialLinearCombination S (fun k => c (moveIndex j k))
              (fun k => x (moveIndex j k)) (m + 1) := rfl
    · -- m = j のとき
      have hm : m < j := by omega
      rw [if_neg (by omega)]
      show partialLinearCombination S c x (m + 1)
        = S.add (partialLinearCombination S (fun k => c (moveIndex j k))
            (fun k => x (moveIndex j k)) m) (S.smul (c j) (x j))
      calc partialLinearCombination S c x (m + 1)
          = S.add (partialLinearCombination S c x m) (S.smul (c (m + 1)) (x (m + 1))) := rfl
        _ = S.add (partialLinearCombination S (fun k => c (moveIndex j k))
                (fun k => x (moveIndex j k)) m) (S.smul (c (m + 1)) (x (m + 1))) := by
              rw [ih, if_pos hm]
        _ = S.add (partialLinearCombination S (fun k => c (moveIndex j k))
                (fun k => x (moveIndex j k)) m) (S.smul (c j) (x j)) := by rw [heq]
    · -- m > j のとき。m - 1 ≥ j ≥ 1 なので m = p + 1 と書く
      obtain ⟨p, rfl⟩ : ∃ p : ℕ, m = p + 1 := ⟨m - 1, by omega⟩
      have hm : ¬ p + 1 < j := by omega
      have hρ : moveIndex j (p + 1) = p + 1 + 1 := moveIndex_of_ge hm
      rw [if_neg (by omega)]
      show partialLinearCombination S c x (p + 1 + 1)
        = S.add (partialLinearCombination S (fun k => c (moveIndex j k))
            (fun k => x (moveIndex j k)) (p + 1)) (S.smul (c j) (x j))
      rw [if_neg hm] at ih
      calc partialLinearCombination S c x (p + 1 + 1)
          = S.add (partialLinearCombination S c x (p + 1))
              (S.smul (c (p + 1 + 1)) (x (p + 1 + 1))) := rfl
        _ = S.add (S.add (partialLinearCombination S (fun k => c (moveIndex j k))
                  (fun k => x (moveIndex j k)) p) (S.smul (c j) (x j)))
              (S.smul (c (p + 1 + 1)) (x (p + 1 + 1))) := by rw [ih]; rfl
        _ = S.add (partialLinearCombination S (fun k => c (moveIndex j k))
                (fun k => x (moveIndex j k)) p)
              (S.add (S.smul (c j) (x j)) (S.smul (c (p + 1 + 1)) (x (p + 1 + 1)))) := by
              rw [S.add_assoc (partialLinearCombination S (fun k => c (moveIndex j k))
                (fun k => x (moveIndex j k)) p) (S.smul (c j) (x j))
                (S.smul (c (p + 1 + 1)) (x (p + 1 + 1)))]
        _ = S.add (partialLinearCombination S (fun k => c (moveIndex j k))
                (fun k => x (moveIndex j k)) p)
              (S.add (S.smul (c (p + 1 + 1)) (x (p + 1 + 1))) (S.smul (c j) (x j))) := by
              rw [S.add_comm (S.smul (c j) (x j)) (S.smul (c (p + 1 + 1)) (x (p + 1 + 1)))]
        _ = S.add (S.add (partialLinearCombination S (fun k => c (moveIndex j k))
                  (fun k => x (moveIndex j k)) p) (S.smul (c (p + 1 + 1)) (x (p + 1 + 1))))
              (S.smul (c j) (x j)) := by
              rw [S.add_assoc (partialLinearCombination S (fun k => c (moveIndex j k))
                (fun k => x (moveIndex j k)) p) (S.smul (c (p + 1 + 1)) (x (p + 1 + 1)))
                (S.smul (c j) (x j))]
        _ = S.add (S.add (partialLinearCombination S (fun k => c (moveIndex j k))
                  (fun k => x (moveIndex j k)) p)
                (S.smul (c (moveIndex j (p + 1))) (x (moveIndex j (p + 1)))))
              (S.smul (c j) (x j)) := by rw [hρ]
        _ = S.add (S.add (partialLinearCombination S (fun k => c (moveIndex j k))
                  (fun k => x (moveIndex j k)) p)
                (S.smul ((fun k => c (moveIndex j k)) (p + 1))
                  ((fun k => x (moveIndex j k)) (p + 1))))
              (S.smul (c j) (x j)) := rfl
        _ = S.add (partialLinearCombination S (fun k => c (moveIndex j k))
                (fun k => x (moveIndex j k)) (p + 1)) (S.smul (c j) (x j)) := rfl

/-- 本文 `claim_moving_term_of_linear_combination_to_last`：
Σ_{k=1}^{n} λ_k ·_V x_k = (Σ_{k=1}^{n-1} λ̃_k ·_V x̃_k) +_V (λ_j ·_V x_j)（1 ≤ j ≤ n）。帰納法の m = n。 -/
theorem linearCombination_moveTermToLast (S : ComplexVectorSpace V) (n : ℕ) (c : ℕ → ℂ) (x : ℕ → V)
    (j : ℕ) (hj1 : 1 ≤ j) (hjn : j ≤ n) :
    linearCombination S n c x
      = S.add (linearCombination S (n - 1) (fun k => c (moveIndex j k)) (fun k => x (moveIndex j k)))
          (S.smul (c j) (x j)) := by
  have h := partialLinearCombination_moveTermToLast S c x j hj1 n
  rw [if_neg (Nat.not_lt_of_ge hjn)] at h
  exact h

/-- 本文 `claim_reindexing_linear_combination_by_bijection`：(n, σ) が {1,…,n'} の番号付けなら
Σ_{k=1}^{n} μ_{σ(k)} ·_V y_{σ(k)} = Σ_{i=1}^{n'} μ_i ·_V y_i。命題 Q(n) を n の帰納法で示す。 -/
theorem linearCombination_reindex (S : ComplexVectorSpace V) (n : ℕ) :
    ∀ (n' : ℕ) (y : ℕ → V) (μ : ℕ → ℂ) (σ : Idx n → Idx n'), IsNumbering n σ →
      linearCombination S n (numberedFamily σ (fun i => μ i.1) 0)
          (numberedFamily σ (fun i => y i.1) S.zero)
        = linearCombination S n' μ y := by
  induction n with
  | zero =>
    intro n' y μ σ hσ
    -- n' ≥ 1 なら 1 ∈ {1,…,n'} の逆像が空集合 {1,…,0} に要るので、n' = 0
    have hn' : n' = 0 := by
      rcases Nat.eq_zero_or_pos n' with h | h
      · exact h
      · obtain ⟨k, _⟩ := hσ.surjective ⟨1, le_refl 1, h⟩
        exact absurd k.2 (by omega)
    subst hn'
    calc linearCombination S 0 (numberedFamily σ (fun i => μ i.1) 0)
          (numberedFamily σ (fun i => y i.1) S.zero) = S.zero := rfl
      _ = linearCombination S 0 μ y := rfl
  | succ n ih =>
    intro n' y μ σ hσ
    -- （n' ≥ 1）σ(1) ∈ {1,…,n'}
    have hn'pos : 1 ≤ n' := le_trans (σ ⟨1, le_refl 1, by omega⟩).2.1 (σ ⟨1, le_refl 1, by omega⟩).2.2
    obtain ⟨p, rfl⟩ : ∃ p : ℕ, n' = p + 1 := ⟨n' - 1, by omega⟩
    -- （j の定義）j := σ^{-1}(n')、σ(j) = n'
    set jj : Idx (n + 1) := hσ.inv ⟨p + 1, by omega, le_refl _⟩ with hjj
    have hσj : σ jj = ⟨p + 1, by omega, le_refl _⟩ := hσ.apply_inv _
    set j : ℕ := jj.1 with hj
    have hj1 : 1 ≤ j := jj.2.1
    have hjn : j ≤ n + 1 := jj.2.2
    -- （ρ_j の値の範囲）k ∈ {1,…,n} なら ρ_j(k) ∈ {1,…,n+1}
    have hρrange : ∀ k : Idx n, 1 ≤ moveIndex j k.1 ∧ moveIndex j k.1 ≤ n + 1 := by
      intro k
      unfold moveIndex
      split_ifs <;> omega
    -- （ρ_j は値 j をとらない）
    have hρne : ∀ k : Idx n, moveIndex j k.1 ≠ j := by
      intro k
      unfold moveIndex
      split_ifs <;> omega
    -- （ρ_j は単射）
    have hρinj : ∀ k l : Idx n, moveIndex j k.1 = moveIndex j l.1 → k = l := by
      intro k l h
      apply Subtype.ext
      unfold moveIndex at h
      split_ifs at h <;> omega
    -- （τ の定義）τ(k) := σ(ρ_j(k)) ∈ {1,…,n'-1}
    have hτrange : ∀ k : Idx n, 1 ≤ (σ ⟨moveIndex j k.1, hρrange k⟩).1
        ∧ (σ ⟨moveIndex j k.1, hρrange k⟩).1 ≤ p := by
      intro k
      refine ⟨(σ ⟨moveIndex j k.1, hρrange k⟩).2.1, ?_⟩
      have hle := (σ ⟨moveIndex j k.1, hρrange k⟩).2.2
      rcases Nat.lt_or_ge (σ ⟨moveIndex j k.1, hρrange k⟩).1 (p + 1) with h | h
      · omega
      · exfalso
        have heqσ : σ ⟨moveIndex j k.1, hρrange k⟩ = σ jj := by
          rw [hσj]; exact Subtype.ext (by simp only; omega)
        have := congrArg Subtype.val (hσ.injective _ _ heqσ)
        exact hρne k this
    let τ : Idx n → Idx p := fun k => ⟨(σ ⟨moveIndex j k.1, hρrange k⟩).1, hτrange k⟩
    -- （τ は単射）
    have hτinj : ∀ k l : Idx n, τ k = τ l → k = l := by
      intro k l h
      have h0 : (τ k).1 = (τ l).1 := congrArg Subtype.val h
      have h1 : σ ⟨moveIndex j k.1, hρrange k⟩ = σ ⟨moveIndex j l.1, hρrange l⟩ := Subtype.ext h0
      have h2 := congrArg Subtype.val (hσ.injective _ _ h1)
      exact hρinj k l h2
    -- （τ は全射）
    have hτsurj : ∀ i : Idx p, ∃ k : Idx n, τ k = i := by
      intro i
      obtain ⟨l, hl⟩ := hσ.surjective ⟨i.1, i.2.1, by omega⟩
      have hlj : l.1 ≠ j := by
        intro h
        have : l = jj := Subtype.ext h
        rw [this, hσj] at hl
        have := congrArg Subtype.val hl
        simp only at this
        omega
      rcases Nat.lt_or_gt_of_ne hlj with h | h
      · refine ⟨⟨l.1, l.2.1, by omega⟩, ?_⟩
        have hρ : moveIndex j l.1 = l.1 := moveIndex_of_lt h
        apply Subtype.ext
        show (σ ⟨moveIndex j l.1, _⟩).1 = i.1
        have : (⟨moveIndex j l.1, hρrange ⟨l.1, l.2.1, by omega⟩⟩ : Idx (n + 1)) = l :=
          Subtype.ext hρ
        rw [this, hl]
      · refine ⟨⟨l.1 - 1, by omega, by omega⟩, ?_⟩
        have hρ : moveIndex j (l.1 - 1) = l.1 := by
          rw [moveIndex_of_ge (by omega)]; omega
        apply Subtype.ext
        show (σ ⟨moveIndex j (l.1 - 1), _⟩).1 = i.1
        have : (⟨moveIndex j (l.1 - 1), hρrange ⟨l.1 - 1, by omega, by omega⟩⟩ : Idx (n + 1)) = l :=
          Subtype.ext hρ
        rw [this, hl]
    -- （帰納法の仮定を当てる条件）(n, τ) は {1,…,n'-1} の番号付け
    have hτ : IsNumbering n τ := ⟨hτinj, hτsurj⟩
    -- （残りの族）ŷ_{τ(k)} = y_{σ(ρ_j(k))}、μ̂_{τ(k)} = μ_{σ(ρ_j(k))}（ŷ := y、μ̂ := μ）
    have hterms : ∀ k : ℕ, 1 ≤ k → k ≤ n →
        S.smul (numberedFamily σ (fun i => μ i.1) 0 (moveIndex j k))
            (numberedFamily σ (fun i => y i.1) S.zero (moveIndex j k))
          = S.smul (numberedFamily τ (fun i => μ i.1) 0 k)
              (numberedFamily τ (fun i => y i.1) S.zero k) := by
      intro k hk1 hkn
      have hr := hρrange ⟨k, hk1, hkn⟩
      rw [numberedFamily_of_le σ (fun i => μ i.1) 0 (moveIndex j k) hr.1 hr.2,
        numberedFamily_of_le σ (fun i => y i.1) S.zero (moveIndex j k) hr.1 hr.2,
        numberedFamily_of_le τ (fun i => μ i.1) 0 k hk1 hkn,
        numberedFamily_of_le τ (fun i => y i.1) S.zero k hk1 hkn]
    -- c j = μ_{σ(j)}、x j = y_{σ(j)}
    have hcj : numberedFamily σ (fun i => μ i.1) 0 j = μ (σ jj).1 :=
      numberedFamily_of_le σ (fun i => μ i.1) 0 j hj1 hjn
    have hxj : numberedFamily σ (fun i => y i.1) S.zero j = y (σ jj).1 :=
      numberedFamily_of_le σ (fun i => y i.1) S.zero j hj1 hjn
    calc linearCombination S (n + 1) (numberedFamily σ (fun i => μ i.1) 0)
          (numberedFamily σ (fun i => y i.1) S.zero)
        = S.add (linearCombination S n
              (fun k => numberedFamily σ (fun i => μ i.1) 0 (moveIndex j k))
              (fun k => numberedFamily σ (fun i => y i.1) S.zero (moveIndex j k)))
            (S.smul (numberedFamily σ (fun i => μ i.1) 0 j)
              (numberedFamily σ (fun i => y i.1) S.zero j)) :=
          linearCombination_moveTermToLast S (n + 1) _ _ j hj1 hjn
      _ = S.add (linearCombination S n (numberedFamily τ (fun i => μ i.1) 0)
              (numberedFamily τ (fun i => y i.1) S.zero))
            (S.smul (numberedFamily σ (fun i => μ i.1) 0 j)
              (numberedFamily σ (fun i => y i.1) S.zero j)) := by
          rw [linearCombination_eq_of_terms_eq S n _ _ _ _ hterms]
      _ = S.add (linearCombination S p μ y)
            (S.smul (numberedFamily σ (fun i => μ i.1) 0 j)
              (numberedFamily σ (fun i => y i.1) S.zero j)) := by
          rw [ih p y μ τ hτ]
      _ = S.add (linearCombination S p μ y) (S.smul (μ (σ jj).1) (y (σ jj).1)) := by
          rw [hcj, hxj]
      _ = S.add (linearCombination S p μ y) (S.smul (μ (p + 1)) (y (p + 1))) := by
          rw [hσj]
      _ = partialLinearCombination S μ y (p + 1) := rfl
      _ = linearCombination S (p + 1) μ y := rfl

end CliffordMatrixIsomorphism.ComplexVectorSpace
