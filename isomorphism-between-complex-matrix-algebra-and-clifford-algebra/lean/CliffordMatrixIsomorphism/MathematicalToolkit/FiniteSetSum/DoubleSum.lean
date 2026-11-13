/-
節「有限集合の上の和」のうち、二重和の順序の入れ替えの具体版。人手証明と 1 対 1 に対応させる。

  本文のラベル                                        このファイル
  claim_interchange_of_double_sum_over_finite_sets    sumOverFiniteSet_interchange

本文の三つの部分和を、選んだ番号付け (n, e)・(n', e') について次で書く（k ∈ {1,…,n}、l ∈ {1,…,n'}）。
  行の部分和 B^k_{m'}            証明の中の `B k m'`（l ↦ v_{e(k),e'(l)}・λ_{e(k),e'(l)} の族の L_{m'}）
  列の部分和 C^l_m               証明の中の `C l m`  （k ↦ v_{e(k),e'(l)}・λ_{e(k),e'(l)} の族の L_m）
  列の部分和の部分和 D_{m,m'}    証明の中の `D m m'` （l ↦ C^l_m と係数 1_ℂ の族の L_{m'}）
  外側の部分和 R_m               証明の中の `R m`    （k ↦ s_{e(k)} と係数 1_ℂ の族の L_m）
どれも `ℕ` の族の線型結合の部分和（`partialLinearCombination`）として書くので、本文の漸化式は `rfl` と
`numberedFamily_of_le`（{1,…,n} の中で族の値を開く）で得る。

必要十分版は `NecSuf/MathematicalToolkit/FiniteSetSum/DoubleSum.lean`、導出版は `FiniteSetSumFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.FiniteSetSum.SumOverFiniteSet

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

universe u w w'

variable {V : Type u}

/-- 本文 `claim_interchange_of_double_sum_over_finite_sets`：s_x := Σ_{y∈Y} λ_{x,y} ·_V v_{x,y}、
t_y := Σ_{x∈X} λ_{x,y} ·_V v_{x,y} について Σ_{x∈X} 1_ℂ ·_V s_x = Σ_{y∈Y} 1_ℂ ·_V t_y。 -/
theorem sumOverFiniteSet_interchange (S : ComplexVectorSpace V) {X : Type w} {Y : Type w'}
    (hX : IsFiniteSet X) (hY : IsFiniteSet Y) (c : X → Y → ℂ) (v : X → Y → V) :
    sumOverFiniteSet S hX (fun _ => 1) (fun x => sumOverFiniteSet S hY (c x) (v x))
      = sumOverFiniteSet S hY (fun _ => 1)
          (fun y => sumOverFiniteSet S hX (fun x => c x y) (fun x => v x y)) := by
  obtain ⟨n, e, he⟩ := id hX
  obtain ⟨n', e', he'⟩ := id hY
  -- a_{k,l} := λ_{e(k),e'(l)} ·_V v_{e(k),e'(l)}
  let a : Idx n → Idx n' → V := fun k l => S.smul (c (e k) (e' l)) (v (e k) (e' l))
  -- 行の部分和 B^k_{m'}
  let B : Idx n → ℕ → V := fun k =>
    partialLinearCombination S (numberedFamily e' (c (e k)) 0) (numberedFamily e' (v (e k)) S.zero)
  -- 列の部分和 C^l_m
  let C : Idx n' → ℕ → V := fun l =>
    partialLinearCombination S (numberedFamily e (fun x => c x (e' l)) 0)
      (numberedFamily e (fun x => v x (e' l)) S.zero)
  -- 列の部分和の部分和 D_{m,m'}
  let D : ℕ → ℕ → V := fun m =>
    partialLinearCombination S (numberedFamily e' (fun _ => (1 : ℂ)) 0)
      (extendFamily (fun l => C l m) S.zero)
  -- B と C と D の漸化式（{1,…,n}・{1,…,n'} の中で族の値を開く）
  have hBstep : ∀ (k : Idx n) (m' : ℕ) (h1 : 1 ≤ m' + 1) (h2 : m' + 1 ≤ n'),
      B k (m' + 1) = S.add (B k m') (a k ⟨m' + 1, h1, h2⟩) := by
    intro k m' h1 h2
    show S.add (B k m') (S.smul (numberedFamily e' (c (e k)) 0 (m' + 1))
        (numberedFamily e' (v (e k)) S.zero (m' + 1))) = S.add (B k m') (a k ⟨m' + 1, h1, h2⟩)
    rw [numberedFamily_of_le e' (c (e k)) 0 (m' + 1) h1 h2,
      numberedFamily_of_le e' (v (e k)) S.zero (m' + 1) h1 h2]
  have hCstep : ∀ (l : Idx n') (m : ℕ) (h1 : 1 ≤ m + 1) (h2 : m + 1 ≤ n),
      C l (m + 1) = S.add (C l m) (a ⟨m + 1, h1, h2⟩ l) := by
    intro l m h1 h2
    show S.add (C l m) (S.smul (numberedFamily e (fun x => c x (e' l)) 0 (m + 1))
        (numberedFamily e (fun x => v x (e' l)) S.zero (m + 1))) = S.add (C l m) (a ⟨m + 1, h1, h2⟩ l)
    rw [numberedFamily_of_le e (fun x => c x (e' l)) 0 (m + 1) h1 h2,
      numberedFamily_of_le e (fun x => v x (e' l)) S.zero (m + 1) h1 h2]
  have hDstep : ∀ (m m' : ℕ) (h1 : 1 ≤ m' + 1) (h2 : m' + 1 ≤ n'),
      D m (m' + 1) = S.add (D m m') (S.smul 1 (C ⟨m' + 1, h1, h2⟩ m)) := by
    intro m m' h1 h2
    show S.add (D m m') (S.smul (numberedFamily e' (fun _ => (1 : ℂ)) 0 (m' + 1))
        (extendFamily (fun l => C l m) S.zero (m' + 1)))
      = S.add (D m m') (S.smul 1 (C ⟨m' + 1, h1, h2⟩ m))
    rw [numberedFamily_of_le e' (fun _ => (1 : ℂ)) 0 (m' + 1) h1 h2,
      extendFamily_of_le (fun l => C l m) S.zero (m' + 1) h1 h2]
  -- s_{e(k)} = B^k_{n'}、t_{e'(l)} = C^l_n
  have hsB : ∀ k : Idx n, sumOverFiniteSet S hY (c (e k)) (v (e k)) = B k n' :=
    fun k => sumOverFiniteSet_eq S hY (c (e k)) (v (e k)) n' e' he'
  have htC : ∀ l : Idx n',
      sumOverFiniteSet S hX (fun x => c x (e' l)) (fun x => v x (e' l)) = C l n :=
    fun l => sumOverFiniteSet_eq S hX _ _ n e he
  -- （D_{0,m'} = 0_V）
  have hD0 : ∀ m' : ℕ, m' ≤ n' → D 0 m' = S.zero := by
    intro m'
    induction m' with
    | zero => intro _; rfl
    | succ m' ih =>
      intro hm'
      calc D 0 (m' + 1) = S.add (D 0 m') (S.smul 1 (C ⟨m' + 1, by omega, hm'⟩ 0)) :=
            hDstep 0 m' (by omega) hm'
        _ = S.add S.zero (S.smul 1 (C ⟨m' + 1, by omega, hm'⟩ 0)) := by rw [ih (by omega)]
        _ = S.add S.zero (S.smul 1 S.zero) := rfl
        _ = S.add S.zero S.zero := by rw [S.one_smul S.zero]
        _ = S.zero := S.add_zero S.zero
  -- （D_{m-1,m'} +_V B^m_{m'} = D_{m,m'}）m = p + 1 ∈ {1,…,n}
  have hDB : ∀ (p : ℕ) (hp1 : 1 ≤ p + 1) (hpn : p + 1 ≤ n) (m' : ℕ), m' ≤ n' →
      S.add (D p m') (B ⟨p + 1, hp1, hpn⟩ m') = D (p + 1) m' := by
    intro p hp1 hpn m'
    induction m' with
    | zero =>
      intro _
      calc S.add (D p 0) (B ⟨p + 1, hp1, hpn⟩ 0) = S.add S.zero S.zero := rfl
        _ = S.zero := S.add_zero S.zero
        _ = D (p + 1) 0 := rfl
    | succ m' ih =>
      intro hm'
      have h1 : 1 ≤ m' + 1 := by omega
      calc S.add (D p (m' + 1)) (B ⟨p + 1, hp1, hpn⟩ (m' + 1))
          = S.add (S.add (D p m') (S.smul 1 (C ⟨m' + 1, h1, hm'⟩ p)))
              (S.add (B ⟨p + 1, hp1, hpn⟩ m') (a ⟨p + 1, hp1, hpn⟩ ⟨m' + 1, h1, hm'⟩)) := by
            rw [hDstep p m' h1 hm', hBstep ⟨p + 1, hp1, hpn⟩ m' h1 hm']
        _ = S.add (D p m') (S.add (S.smul 1 (C ⟨m' + 1, h1, hm'⟩ p))
              (S.add (B ⟨p + 1, hp1, hpn⟩ m') (a ⟨p + 1, hp1, hpn⟩ ⟨m' + 1, h1, hm'⟩))) := by
            rw [S.add_assoc (D p m') (S.smul 1 (C ⟨m' + 1, h1, hm'⟩ p))
              (S.add (B ⟨p + 1, hp1, hpn⟩ m') (a ⟨p + 1, hp1, hpn⟩ ⟨m' + 1, h1, hm'⟩))]
        _ = S.add (D p m') (S.add (S.add (S.smul 1 (C ⟨m' + 1, h1, hm'⟩ p))
              (B ⟨p + 1, hp1, hpn⟩ m')) (a ⟨p + 1, hp1, hpn⟩ ⟨m' + 1, h1, hm'⟩)) := by
            rw [S.add_assoc (S.smul 1 (C ⟨m' + 1, h1, hm'⟩ p)) (B ⟨p + 1, hp1, hpn⟩ m')
              (a ⟨p + 1, hp1, hpn⟩ ⟨m' + 1, h1, hm'⟩)]
        _ = S.add (D p m') (S.add (S.add (B ⟨p + 1, hp1, hpn⟩ m')
              (S.smul 1 (C ⟨m' + 1, h1, hm'⟩ p))) (a ⟨p + 1, hp1, hpn⟩ ⟨m' + 1, h1, hm'⟩)) := by
            rw [S.add_comm (S.smul 1 (C ⟨m' + 1, h1, hm'⟩ p)) (B ⟨p + 1, hp1, hpn⟩ m')]
        _ = S.add (D p m') (S.add (B ⟨p + 1, hp1, hpn⟩ m')
              (S.add (S.smul 1 (C ⟨m' + 1, h1, hm'⟩ p)) (a ⟨p + 1, hp1, hpn⟩ ⟨m' + 1, h1, hm'⟩))) := by
            rw [S.add_assoc (B ⟨p + 1, hp1, hpn⟩ m') (S.smul 1 (C ⟨m' + 1, h1, hm'⟩ p))
              (a ⟨p + 1, hp1, hpn⟩ ⟨m' + 1, h1, hm'⟩)]
        _ = S.add (S.add (D p m') (B ⟨p + 1, hp1, hpn⟩ m'))
              (S.add (S.smul 1 (C ⟨m' + 1, h1, hm'⟩ p)) (a ⟨p + 1, hp1, hpn⟩ ⟨m' + 1, h1, hm'⟩)) := by
            rw [S.add_assoc (D p m') (B ⟨p + 1, hp1, hpn⟩ m')
              (S.add (S.smul 1 (C ⟨m' + 1, h1, hm'⟩ p)) (a ⟨p + 1, hp1, hpn⟩ ⟨m' + 1, h1, hm'⟩))]
        _ = S.add (D (p + 1) m')
              (S.add (S.smul 1 (C ⟨m' + 1, h1, hm'⟩ p)) (a ⟨p + 1, hp1, hpn⟩ ⟨m' + 1, h1, hm'⟩)) := by
            rw [ih (by omega)]
        _ = S.add (D (p + 1) m')
              (S.add (C ⟨m' + 1, h1, hm'⟩ p) (a ⟨p + 1, hp1, hpn⟩ ⟨m' + 1, h1, hm'⟩)) := by
            rw [S.one_smul (C ⟨m' + 1, h1, hm'⟩ p)]
        _ = S.add (D (p + 1) m') (C ⟨m' + 1, h1, hm'⟩ (p + 1)) := by
            rw [hCstep ⟨m' + 1, h1, hm'⟩ p hp1 hpn]
        _ = S.add (D (p + 1) m') (S.smul 1 (C ⟨m' + 1, h1, hm'⟩ (p + 1))) := by
            rw [S.one_smul (C ⟨m' + 1, h1, hm'⟩ (p + 1))]
        _ = D (p + 1) (m' + 1) := (hDstep (p + 1) m' h1 hm').symm
  -- （外側の部分和）R_m := k ↦ s_{e(k)} と係数 1_ℂ の族の L_m。R_m = D_{m,n'}
  let R : ℕ → V := partialLinearCombination S (numberedFamily e (fun _ => (1 : ℂ)) 0)
    (numberedFamily e (fun x => sumOverFiniteSet S hY (c x) (v x)) S.zero)
  have hRD : ∀ m : ℕ, m ≤ n → R m = D m n' := by
    intro m
    induction m with
    | zero => intro _; exact (hD0 n' le_rfl).symm
    | succ m ih =>
      intro hm
      have h1 : 1 ≤ m + 1 := by omega
      calc R (m + 1)
          = S.add (R m) (S.smul (numberedFamily e (fun _ => (1 : ℂ)) 0 (m + 1))
              (numberedFamily e (fun x => sumOverFiniteSet S hY (c x) (v x)) S.zero (m + 1))) := rfl
        _ = S.add (R m) (S.smul 1 (sumOverFiniteSet S hY (c (e ⟨m + 1, h1, hm⟩))
              (v (e ⟨m + 1, h1, hm⟩)))) := by
            rw [numberedFamily_of_le e (fun _ => (1 : ℂ)) 0 (m + 1) h1 hm,
              numberedFamily_of_le e (fun x => sumOverFiniteSet S hY (c x) (v x)) S.zero (m + 1) h1 hm]
        _ = S.add (D m n') (S.smul 1 (sumOverFiniteSet S hY (c (e ⟨m + 1, h1, hm⟩))
              (v (e ⟨m + 1, h1, hm⟩)))) := by rw [ih (by omega)]
        _ = S.add (D m n') (sumOverFiniteSet S hY (c (e ⟨m + 1, h1, hm⟩)) (v (e ⟨m + 1, h1, hm⟩))) := by
            rw [S.one_smul]
        _ = S.add (D m n') (B ⟨m + 1, h1, hm⟩ n') := by rw [hsB ⟨m + 1, h1, hm⟩]
        _ = D (m + 1) n' := hDB m h1 hm n' le_rfl
  -- D_{n,n'} の族 l ↦ C^l_n は、族 l ↦ t_{e'(l)} と 1,…,n' で一致する
  have hCt : ∀ l : ℕ, 1 ≤ l → l ≤ n' →
      S.smul (numberedFamily e' (fun _ => (1 : ℂ)) 0 l) (extendFamily (fun l => C l n) S.zero l)
        = S.smul (numberedFamily e' (fun _ => (1 : ℂ)) 0 l)
            (numberedFamily e' (fun y => sumOverFiniteSet S hX (fun x => c x y) (fun x => v x y))
              S.zero l) := by
    intro l hl1 hln
    rw [extendFamily_of_le (fun l => C l n) S.zero l hl1 hln,
      numberedFamily_of_le e' (fun y => sumOverFiniteSet S hX (fun x => c x y) (fun x => v x y))
        S.zero l hl1 hln, htC ⟨l, hl1, hln⟩]
  calc sumOverFiniteSet S hX (fun _ => 1) (fun x => sumOverFiniteSet S hY (c x) (v x))
      = linearCombination S n (numberedFamily e (fun _ => (1 : ℂ)) 0)
          (numberedFamily e (fun x => sumOverFiniteSet S hY (c x) (v x)) S.zero) :=
        sumOverFiniteSet_eq S hX _ _ n e he
    _ = R n := rfl
    _ = D n n' := hRD n le_rfl
    _ = linearCombination S n' (numberedFamily e' (fun _ => (1 : ℂ)) 0)
          (extendFamily (fun l => C l n) S.zero) := rfl
    _ = linearCombination S n' (numberedFamily e' (fun _ => (1 : ℂ)) 0)
          (numberedFamily e' (fun y => sumOverFiniteSet S hX (fun x => c x y) (fun x => v x y))
            S.zero) :=
        linearCombination_eq_of_terms_eq S n' _ _ _ _ hCt
    _ = sumOverFiniteSet S hY (fun _ => 1)
          (fun y => sumOverFiniteSet S hX (fun x => c x y) (fun x => v x y)) :=
        (sumOverFiniteSet_eq S hY _ _ n' e' he').symm

end CliffordMatrixIsomorphism.ComplexVectorSpace
