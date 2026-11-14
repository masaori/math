/-
章「同型の証明」の、生成作用素の行列・消滅作用素の行列の反交換関係の具体版。人手証明と 1 対 1 に対応させる。

  本文のラベル                                                        このファイル
  claim_creation_operator_matrices_anticommute                        entry_creationMatrix_mul_creationMatrix（（⋆））・
                                                                      creationMatrices_anticommute
  claim_annihilation_operator_matrices_anticommute                    entry_annihilationMatrix_mul_annihilationMatrix（（⋆））・
                                                                      annihilationMatrices_anticommute
  claim_creation_and_annihilation_operator_matrices_anticommute       entry_smul_one（（♭））・
                                                                      entry_creationMatrix_mul_annihilationMatrix（（⋆_1））・
                                                                      entry_annihilationMatrix_mul_creationMatrix（（⋆_2））・
                                                                      creationMatrix_annihilationMatrix_anticommute

表し方:
- 本文の場合分けの式（（⋆）・（⋆_1）・（⋆_2））は、条件が成り立つときと成り立たないときの含意の組（∧）で書く。
- 本文の δ_{i,j}（集合 {1,…,M} の二元のクロネッカーのデルタ）は、{1,…,M}（`Idx M`）の二元 ⟨i, hi⟩・⟨j, hj⟩ の
  `kroneckerDelta` で書く。
- 条件 C_{k,l}(S,U)（`creationCond`）、本文が「和集合の定義」「P_M の元の等しさ」で示す条件の同値（C_{i,j} と C_{j,i}、
  D_1・D_2 と i = j・i ≠ j の場合の条件）、i ∉ S' と（♯）は、ℂ を含まないので `IndexSetOperations.lean` に置く。
- 本文の「S = S' ∪ {i}」「U = S' ∪ {j}」を一つの項に当てる行は、その項の等式を `show … from by rw […]` で作って書き換える
  （S' は S から作るので、S をすべて書き換えると S' まで変わるため）。
- 生成と消滅の反交換関係の i = j の場合は、j を i に置き換えずに i = j を仮定 hij として持ち、本文の「(∵ j = i)」の行を
  `rw [← hij]` の行として置く。D_1・D_2 の言い換え（集合の条件の同値）だけは、`IndexSetOperations.lean` の j = i を代入した形を引くために
  その証明の中で j を i に置き換える。

必要十分版は `NecSuf/Isomorphism/CreationOperatorMatrices/Anticommutation.lean`、導出版は `CreationMatricesFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.Isomorphism.CreationOperatorMatrices.CreationMatrices

namespace CliffordMatrixIsomorphism.Isomorphism

open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexVectorSpace

/-! ### 生成作用素の行列どうしの反交換関係 -/

/-- 本文 `claim_creation_operator_matrices_anticommute` の（⋆）：
(c_k · c_l)_{S,U} = ς(N_k(U ∪ {l})) ·_ℂ ς(N_l(U))（C_{k,l}(S,U)）、0_ℂ（成り立たない）。 -/
theorem entry_creationMatrix_mul_creationMatrix {M k l : ℕ} (hk : 1 ≤ k ∧ k ≤ M)
    (hl : 1 ≤ l ∧ l ≤ M) (S U : PowerSet M) :
    (creationCond hk hl S U →
        Mat.entry (Mat.mul (isFiniteSet_powerSet M) (creationMatrix M k hk) (creationMatrix M l hl)) S U
          = sign (countBelow (unionSingleton U l hl) k) * sign (countBelow U l))
      ∧ (¬creationCond hk hl S U →
        Mat.entry (Mat.mul (isFiniteSet_powerSet M) (creationMatrix M k hk) (creationMatrix M l hl)) S U
          = 0) := by
  let hX := isFiniteSet_powerSet M
  by_cases hlU : l ∈ U.1
  · -- l ∈ U のとき。C_{k,l}(S,U) は成り立たない。
    exact ⟨fun hC => absurd hlU hC.2.1,
      fun _ => (entry_mul_creationMatrix hl (creationMatrix M k hk) S U).2 hlU⟩
  · -- l ∉ U のとき。列の添字を U ∪ {l} としたときの c_k の条件は C_{k,l}(S,U) と同値。
    have hiff : (k ∉ (unionSingleton U l hl).1 ∧ S = unionSingleton (unionSingleton U l hl) k hk)
        ↔ creationCond hk hl S U := by
      constructor
      · rintro ⟨hkUl, hS⟩
        refine ⟨fun h => hkUl ((mem_unionSingleton_iff U l hl k).2 (Or.inl h)), hlU,
          fun h => hkUl ((mem_unionSingleton_iff U l hl k).2 (Or.inr h)), hS⟩
      · rintro ⟨hkU, _, hkl, hS⟩
        refine ⟨fun h => ?_, hS⟩
        rcases (mem_unionSingleton_iff U l hl k).1 h with h' | h'
        · exact hkU h'
        · exact hkl h'
    constructor
    · intro hC
      calc Mat.entry (Mat.mul hX (creationMatrix M k hk) (creationMatrix M l hl)) S U
          = Mat.entry (creationMatrix M k hk) S (unionSingleton U l hl) * sign (countBelow U l) :=
            (entry_mul_creationMatrix hl (creationMatrix M k hk) S U).1 hlU
        _ = sign (countBelow (unionSingleton U l hl) k) * sign (countBelow U l) := by
            rw [creationMatrix_entry_of_cond hk (hiff.2 hC)]
    · intro hC
      calc Mat.entry (Mat.mul hX (creationMatrix M k hk) (creationMatrix M l hl)) S U
          = Mat.entry (creationMatrix M k hk) S (unionSingleton U l hl) * sign (countBelow U l) :=
            (entry_mul_creationMatrix hl (creationMatrix M k hk) S U).1 hlU
        _ = 0 * sign (countBelow U l) := by
            rw [creationMatrix_entry_of_not_cond hk (fun h => hC (hiff.1 h))]
        _ = 0 := zero_mul (sign (countBelow U l))

/-- 本文 `claim_creation_operator_matrices_anticommute`：c_i · c_j + c_j · c_i = 0（i = j も含む）。 -/
theorem creationMatrices_anticommute {M i j : ℕ} (hi : 1 ≤ i ∧ i ≤ M) (hj : 1 ≤ j ∧ j ≤ M) :
    Mat.add (Mat.mul (isFiniteSet_powerSet M) (creationMatrix M i hi) (creationMatrix M j hj))
        (Mat.mul (isFiniteSet_powerSet M) (creationMatrix M j hj) (creationMatrix M i hi))
      = Mat.zero := Mat.ext fun S U => by
  let hX := isFiniteSet_powerSet M
  by_cases hC : creationCond hi hj S U
  · -- C_{i,j}(S,U) が成り立つとき。
    have hC' : creationCond hj hi S U := (creationCond_comm hi hj S U).1 hC
    obtain ⟨hiU, hjU, hij, _⟩ := id hC
    rcases Nat.lt_or_gt_of_ne hij with hlt | hgt
    · -- i < j のとき。
      calc Mat.entry (Mat.add (Mat.mul hX (creationMatrix M i hi) (creationMatrix M j hj))
              (Mat.mul hX (creationMatrix M j hj) (creationMatrix M i hi))) S U
          = Mat.entry (Mat.mul hX (creationMatrix M i hi) (creationMatrix M j hj)) S U
              + Mat.entry (Mat.mul hX (creationMatrix M j hj) (creationMatrix M i hi)) S U := rfl
        _ = sign (countBelow (unionSingleton U j hj) i) * sign (countBelow U j)
              + sign (countBelow (unionSingleton U i hi) j) * sign (countBelow U i) := by
            rw [(entry_creationMatrix_mul_creationMatrix hi hj S U).1 hC,
              (entry_creationMatrix_mul_creationMatrix hj hi S U).1 hC']
        _ = sign (countBelow U i) * sign (countBelow U j)
              + sign (countBelow (unionSingleton U i hi) j) * sign (countBelow U i) := by
            rw [(countBelow_unionSingleton U j hj hjU i hi.1 hi.2).2 (Nat.le_of_lt hlt)]
        _ = sign (countBelow U i) * sign (countBelow U j)
              + sign (countBelow U j + 1) * sign (countBelow U i) := by
            rw [(countBelow_unionSingleton U i hi hiU j hj.1 hj.2).1 hlt]
        _ = sign (countBelow U i) * sign (countBelow U j)
              + ((-1) * sign (countBelow U j)) * sign (countBelow U i) := rfl
        _ = sign (countBelow U i) * sign (countBelow U j)
              + (-1) * (sign (countBelow U j) * sign (countBelow U i)) := by
            rw [_root_.mul_assoc (-1 : ℂ) (sign (countBelow U j)) (sign (countBelow U i))]
        _ = sign (countBelow U i) * sign (countBelow U j)
              + (-1) * (sign (countBelow U i) * sign (countBelow U j)) := by
            rw [mul_comm (sign (countBelow U j)) (sign (countBelow U i))]
        _ = 1 * (sign (countBelow U i) * sign (countBelow U j))
              + (-1) * (sign (countBelow U i) * sign (countBelow U j)) := by
            rw [one_mul (sign (countBelow U i) * sign (countBelow U j))]
        _ = (1 + (-1)) * (sign (countBelow U i) * sign (countBelow U j)) :=
            (add_mul (1 : ℂ) (-1) (sign (countBelow U i) * sign (countBelow U j))).symm
        _ = 0 * (sign (countBelow U i) * sign (countBelow U j)) := by rw [add_neg_cancel (1 : ℂ)]
        _ = 0 := zero_mul (sign (countBelow U i) * sign (countBelow U j))
        _ = Mat.entry (Mat.zero : Mat (PowerSet M)) S U := rfl
    · -- j < i のとき。
      calc Mat.entry (Mat.add (Mat.mul hX (creationMatrix M i hi) (creationMatrix M j hj))
              (Mat.mul hX (creationMatrix M j hj) (creationMatrix M i hi))) S U
          = Mat.entry (Mat.mul hX (creationMatrix M i hi) (creationMatrix M j hj)) S U
              + Mat.entry (Mat.mul hX (creationMatrix M j hj) (creationMatrix M i hi)) S U := rfl
        _ = sign (countBelow (unionSingleton U j hj) i) * sign (countBelow U j)
              + sign (countBelow (unionSingleton U i hi) j) * sign (countBelow U i) := by
            rw [(entry_creationMatrix_mul_creationMatrix hi hj S U).1 hC,
              (entry_creationMatrix_mul_creationMatrix hj hi S U).1 hC']
        _ = sign (countBelow U i + 1) * sign (countBelow U j)
              + sign (countBelow (unionSingleton U i hi) j) * sign (countBelow U i) := by
            rw [(countBelow_unionSingleton U j hj hjU i hi.1 hi.2).1 hgt]
        _ = sign (countBelow U i + 1) * sign (countBelow U j)
              + sign (countBelow U j) * sign (countBelow U i) := by
            rw [(countBelow_unionSingleton U i hi hiU j hj.1 hj.2).2 (Nat.le_of_lt hgt)]
        _ = ((-1) * sign (countBelow U i)) * sign (countBelow U j)
              + sign (countBelow U j) * sign (countBelow U i) := rfl
        _ = (-1) * (sign (countBelow U i) * sign (countBelow U j))
              + sign (countBelow U j) * sign (countBelow U i) := by
            rw [_root_.mul_assoc (-1 : ℂ) (sign (countBelow U i)) (sign (countBelow U j))]
        _ = (-1) * (sign (countBelow U i) * sign (countBelow U j))
              + sign (countBelow U i) * sign (countBelow U j) := by
            rw [mul_comm (sign (countBelow U j)) (sign (countBelow U i))]
        _ = (-1) * (sign (countBelow U i) * sign (countBelow U j))
              + 1 * (sign (countBelow U i) * sign (countBelow U j)) := by
            rw [one_mul (sign (countBelow U i) * sign (countBelow U j))]
        _ = ((-1) + 1) * (sign (countBelow U i) * sign (countBelow U j)) :=
            (add_mul (-1 : ℂ) 1 (sign (countBelow U i) * sign (countBelow U j))).symm
        _ = (1 + (-1)) * (sign (countBelow U i) * sign (countBelow U j)) := by
            rw [add_comm (-1 : ℂ) 1]
        _ = 0 * (sign (countBelow U i) * sign (countBelow U j)) := by rw [add_neg_cancel (1 : ℂ)]
        _ = 0 := zero_mul (sign (countBelow U i) * sign (countBelow U j))
        _ = Mat.entry (Mat.zero : Mat (PowerSet M)) S U := rfl
  · -- C_{i,j}(S,U) が成り立たないとき。C_{j,i}(S,U) も成り立たない。
    have hC' : ¬creationCond hj hi S U := fun h => hC ((creationCond_comm hi hj S U).2 h)
    calc Mat.entry (Mat.add (Mat.mul hX (creationMatrix M i hi) (creationMatrix M j hj))
            (Mat.mul hX (creationMatrix M j hj) (creationMatrix M i hi))) S U
        = Mat.entry (Mat.mul hX (creationMatrix M i hi) (creationMatrix M j hj)) S U
            + Mat.entry (Mat.mul hX (creationMatrix M j hj) (creationMatrix M i hi)) S U := rfl
      _ = 0 + 0 := by
          rw [(entry_creationMatrix_mul_creationMatrix hi hj S U).2 hC,
            (entry_creationMatrix_mul_creationMatrix hj hi S U).2 hC']
      _ = 0 := add_zero (0 : ℂ)
      _ = Mat.entry (Mat.zero : Mat (PowerSet M)) S U := rfl

/-! ### 消滅作用素の行列どうしの反交換関係 -/

/-- 本文 `claim_annihilation_operator_matrices_anticommute` の（⋆）：(c_k^T · c_l^T)_{S,U} = (c_l · c_k)_{U,S}。 -/
theorem entry_annihilationMatrix_mul_annihilationMatrix {M k l : ℕ} (hk : 1 ≤ k ∧ k ≤ M)
    (hl : 1 ≤ l ∧ l ≤ M) (S U : PowerSet M) :
    Mat.entry (Mat.mul (isFiniteSet_powerSet M) (annihilationMatrix M k hk) (annihilationMatrix M l hl)) S U
      = Mat.entry (Mat.mul (isFiniteSet_powerSet M) (creationMatrix M l hl) (creationMatrix M k hk)) U S := by
  let V := complexNumbersVectorSpace
  let hX := isFiniteSet_powerSet M
  -- 準備：(c_k^T)_{S,T} ·_{ℂ^vec} (c_l^T)_{T,U} = (c_l)_{U,T} ·_{ℂ^vec} (c_k)_{T,S}
  have hterm : ∀ T : PowerSet M,
      V.smul (Mat.entry (annihilationMatrix M k hk) S T) (Mat.entry (annihilationMatrix M l hl) T U)
        = V.smul (Mat.entry (creationMatrix M l hl) U T) (Mat.entry (creationMatrix M k hk) T S) :=
    fun T => calc
    V.smul (Mat.entry (annihilationMatrix M k hk) S T) (Mat.entry (annihilationMatrix M l hl) T U)
        = Mat.entry (annihilationMatrix M k hk) S T * Mat.entry (annihilationMatrix M l hl) T U := rfl
    _ = Mat.entry (creationMatrix M k hk) T S * Mat.entry (creationMatrix M l hl) U T := rfl
    _ = Mat.entry (creationMatrix M l hl) U T * Mat.entry (creationMatrix M k hk) T S :=
        mul_comm (Mat.entry (creationMatrix M k hk) T S) (Mat.entry (creationMatrix M l hl) U T)
    _ = V.smul (Mat.entry (creationMatrix M l hl) U T) (Mat.entry (creationMatrix M k hk) T S) := rfl
  calc Mat.entry (Mat.mul hX (annihilationMatrix M k hk) (annihilationMatrix M l hl)) S U
      = sumOverFiniteSet V hX (fun T => Mat.entry (annihilationMatrix M k hk) S T)
          (fun T => Mat.entry (annihilationMatrix M l hl) T U) := rfl
    _ = sumOverFiniteSet V hX (fun T => Mat.entry (creationMatrix M l hl) U T)
          (fun T => Mat.entry (creationMatrix M k hk) T S) :=
        sumOverFiniteSet_congr V hX _ _ _ _ hterm
    _ = Mat.entry (Mat.mul hX (creationMatrix M l hl) (creationMatrix M k hk)) U S := rfl

/-- 本文 `claim_annihilation_operator_matrices_anticommute`：c_i^T · c_j^T + c_j^T · c_i^T = 0（i = j も含む）。 -/
theorem annihilationMatrices_anticommute {M i j : ℕ} (hi : 1 ≤ i ∧ i ≤ M) (hj : 1 ≤ j ∧ j ≤ M) :
    Mat.add (Mat.mul (isFiniteSet_powerSet M) (annihilationMatrix M i hi) (annihilationMatrix M j hj))
        (Mat.mul (isFiniteSet_powerSet M) (annihilationMatrix M j hj) (annihilationMatrix M i hi))
      = Mat.zero := Mat.ext fun S U => by
  let hX := isFiniteSet_powerSet M
  calc Mat.entry (Mat.add (Mat.mul hX (annihilationMatrix M i hi) (annihilationMatrix M j hj))
          (Mat.mul hX (annihilationMatrix M j hj) (annihilationMatrix M i hi))) S U
      = Mat.entry (Mat.mul hX (annihilationMatrix M i hi) (annihilationMatrix M j hj)) S U
          + Mat.entry (Mat.mul hX (annihilationMatrix M j hj) (annihilationMatrix M i hi)) S U := rfl
    _ = Mat.entry (Mat.mul hX (creationMatrix M j hj) (creationMatrix M i hi)) U S
          + Mat.entry (Mat.mul hX (creationMatrix M i hi) (creationMatrix M j hj)) U S := by
        rw [entry_annihilationMatrix_mul_annihilationMatrix hi hj S U,
          entry_annihilationMatrix_mul_annihilationMatrix hj hi S U]
    _ = Mat.entry (Mat.mul hX (creationMatrix M i hi) (creationMatrix M j hj)) U S
          + Mat.entry (Mat.mul hX (creationMatrix M j hj) (creationMatrix M i hi)) U S :=
        add_comm _ _
    _ = Mat.entry (Mat.add (Mat.mul hX (creationMatrix M i hi) (creationMatrix M j hj))
          (Mat.mul hX (creationMatrix M j hj) (creationMatrix M i hi))) U S := rfl
    _ = Mat.entry (Mat.zero : Mat (PowerSet M)) U S := by rw [creationMatrices_anticommute hi hj]
    _ = 0 := rfl
    _ = Mat.entry (Mat.zero : Mat (PowerSet M)) S U := rfl

/-! ### 生成作用素の行列と消滅作用素の行列の反交換関係 -/

/-- 本文 `claim_creation_and_annihilation_operator_matrices_anticommute` の（♭）：
(δ_{i,j} ∗ 1)_{S,U} = δ_{i,j} ·_ℂ δ_{S,U}。 -/
theorem entry_smul_one {M : ℕ} (d : ℂ) (S U : PowerSet M) :
    Mat.entry (Mat.smul d (Mat.one : Mat (PowerSet M))) S U = d * kroneckerDelta S U :=
  calc Mat.entry (Mat.smul d (Mat.one : Mat (PowerSet M))) S U
      = d * Mat.entry (Mat.one : Mat (PowerSet M)) S U := rfl
    _ = d * kroneckerDelta S U := rfl

/-- 本文 `claim_creation_and_annihilation_operator_matrices_anticommute` の（⋆_1）：条件 D_1 を
「i ∈ S かつ j ∉ S' かつ U = S' ∪ {j}」として、(c_i · c_j^T)_{S,U} = ς(N_i(S')) ·_ℂ ς(N_j(S'))（D_1）、0_ℂ（成り立たない）。 -/
theorem entry_creationMatrix_mul_annihilationMatrix {M i j : ℕ} (hi : 1 ≤ i ∧ i ≤ M)
    (hj : 1 ≤ j ∧ j ≤ M) (S U : PowerSet M) :
    ((i ∈ S.1 ∧ j ∉ (removeIndex S i).1 ∧ U = unionSingleton (removeIndex S i) j hj) →
        Mat.entry (Mat.mul (isFiniteSet_powerSet M) (creationMatrix M i hi) (annihilationMatrix M j hj)) S U
          = sign (countBelow (removeIndex S i) i) * sign (countBelow (removeIndex S i) j))
      ∧ (¬(i ∈ S.1 ∧ j ∉ (removeIndex S i).1 ∧ U = unionSingleton (removeIndex S i) j hj) →
        Mat.entry (Mat.mul (isFiniteSet_powerSet M) (creationMatrix M i hi) (annihilationMatrix M j hj)) S U
          = 0) := by
  let hX := isFiniteSet_powerSet M
  let S' := removeIndex S i
  by_cases hiS : i ∈ S.1
  · -- i ∈ S のとき。行の添字 U・列の添字 S' の c_j の条件は、i ∈ S のもとで D_1 と同値。
    constructor
    · intro hD
      calc Mat.entry (Mat.mul hX (creationMatrix M i hi) (annihilationMatrix M j hj)) S U
          = sign (countBelow S' i) * Mat.entry (annihilationMatrix M j hj) S' U :=
            (entry_creationMatrix_mul hi (annihilationMatrix M j hj) S U).1 hiS
        _ = sign (countBelow S' i) * Mat.entry (creationMatrix M j hj) U S' := rfl
        _ = sign (countBelow S' i) * sign (countBelow S' j) := by
            rw [creationMatrix_entry_of_cond hj ⟨hD.2.1, hD.2.2⟩]
    · intro hD
      calc Mat.entry (Mat.mul hX (creationMatrix M i hi) (annihilationMatrix M j hj)) S U
          = sign (countBelow S' i) * Mat.entry (annihilationMatrix M j hj) S' U :=
            (entry_creationMatrix_mul hi (annihilationMatrix M j hj) S U).1 hiS
        _ = sign (countBelow S' i) * Mat.entry (creationMatrix M j hj) U S' := rfl
        _ = sign (countBelow S' i) * 0 := by
            rw [creationMatrix_entry_of_not_cond hj (fun h => hD ⟨hiS, h.1, h.2⟩)]
        _ = 0 := mul_zero (sign (countBelow S' i))
  · -- i ∉ S のとき。D_1 は成り立たない。
    exact ⟨fun hD => absurd hD.1 hiS,
      fun _ => (entry_creationMatrix_mul hi (annihilationMatrix M j hj) S U).2 hiS⟩

/-- 本文 `claim_creation_and_annihilation_operator_matrices_anticommute` の（⋆_2）：条件 D_2 を
「i ∉ U かつ j ∉ S かつ U ∪ {i} = S ∪ {j}」として、(c_j^T · c_i)_{S,U} = ς(N_j(S)) ·_ℂ ς(N_i(U))（D_2）、0_ℂ（成り立たない）。 -/
theorem entry_annihilationMatrix_mul_creationMatrix {M i j : ℕ} (hi : 1 ≤ i ∧ i ≤ M)
    (hj : 1 ≤ j ∧ j ≤ M) (S U : PowerSet M) :
    ((i ∉ U.1 ∧ j ∉ S.1 ∧ unionSingleton U i hi = unionSingleton S j hj) →
        Mat.entry (Mat.mul (isFiniteSet_powerSet M) (annihilationMatrix M j hj) (creationMatrix M i hi)) S U
          = sign (countBelow S j) * sign (countBelow U i))
      ∧ (¬(i ∉ U.1 ∧ j ∉ S.1 ∧ unionSingleton U i hi = unionSingleton S j hj) →
        Mat.entry (Mat.mul (isFiniteSet_powerSet M) (annihilationMatrix M j hj) (creationMatrix M i hi)) S U
          = 0) := by
  let hX := isFiniteSet_powerSet M
  by_cases hiU : i ∈ U.1
  · -- i ∈ U のとき。D_2 は成り立たない。
    exact ⟨fun hD => absurd hiU hD.1,
      fun _ => (entry_mul_creationMatrix hi (annihilationMatrix M j hj) S U).2 hiU⟩
  · -- i ∉ U のとき。行の添字 U ∪ {i}・列の添字 S の c_j の条件は、i ∉ U のもとで D_2 と同値。
    constructor
    · intro hD
      calc Mat.entry (Mat.mul hX (annihilationMatrix M j hj) (creationMatrix M i hi)) S U
          = Mat.entry (annihilationMatrix M j hj) S (unionSingleton U i hi) * sign (countBelow U i) :=
            (entry_mul_creationMatrix hi (annihilationMatrix M j hj) S U).1 hiU
        _ = Mat.entry (creationMatrix M j hj) (unionSingleton U i hi) S * sign (countBelow U i) := rfl
        _ = sign (countBelow S j) * sign (countBelow U i) := by
            rw [creationMatrix_entry_of_cond hj ⟨hD.2.1, hD.2.2⟩]
    · intro hD
      calc Mat.entry (Mat.mul hX (annihilationMatrix M j hj) (creationMatrix M i hi)) S U
          = Mat.entry (annihilationMatrix M j hj) S (unionSingleton U i hi) * sign (countBelow U i) :=
            (entry_mul_creationMatrix hi (annihilationMatrix M j hj) S U).1 hiU
        _ = Mat.entry (creationMatrix M j hj) (unionSingleton U i hi) S * sign (countBelow U i) := rfl
        _ = 0 * sign (countBelow U i) := by
            rw [creationMatrix_entry_of_not_cond hj (fun h => hD ⟨hiU, h.1, h.2⟩)]
        _ = 0 := zero_mul (sign (countBelow U i))

/-- 本文 `claim_creation_and_annihilation_operator_matrices_anticommute`：
c_i · c_j^T + c_j^T · c_i = δ_{i,j} ∗ 1。 -/
theorem creationMatrix_annihilationMatrix_anticommute {M i j : ℕ} (hi : 1 ≤ i ∧ i ≤ M)
    (hj : 1 ≤ j ∧ j ≤ M) :
    Mat.add (Mat.mul (isFiniteSet_powerSet M) (creationMatrix M i hi) (annihilationMatrix M j hj))
        (Mat.mul (isFiniteSet_powerSet M) (annihilationMatrix M j hj) (creationMatrix M i hi))
      = Mat.smul (kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M)) Mat.one := Mat.ext fun S U => by
  let hX := isFiniteSet_powerSet M
  let S' := removeIndex S i
  have hstar1 := entry_creationMatrix_mul_annihilationMatrix hi hj S U
  have hstar2 := entry_annihilationMatrix_mul_creationMatrix hi hj S U
  by_cases hij : i = j
  · -- i = j のとき。δ_{i,j} = 1_ℂ。
    have hδ : kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M) = (1 : ℂ) := if_pos (Subtype.ext hij)
    -- D_1・D_2 の言い換え（本文の「j = i ∉ S' はつねに成り立ち」「j = i なので i ∉ S」の段）。
    -- 集合の条件の同値は j = i を代入した形で `IndexSetOperations.lean` に置いてあるので、ここでだけ j を i に置き換えて引く。
    have hD1 : (i ∈ S.1 ∧ j ∉ (removeIndex S i).1 ∧ U = unionSingleton (removeIndex S i) j hj)
        ↔ (i ∈ S.1 ∧ U = S) := by
      subst hij
      exact cond1_iff_of_eq hj S U
    have hD2 : (i ∉ U.1 ∧ j ∉ S.1 ∧ unionSingleton U i hi = unionSingleton S j hj) ↔ (i ∉ S.1 ∧ U = S) := by
      subst hij
      exact cond2_iff_of_eq hi hj S U
    by_cases hUS : U = S
    · by_cases hiS : i ∈ S.1
      · -- U = S かつ i ∈ S。D_1 は成り立ち、D_2 は成り立たない。
        calc Mat.entry (Mat.add (Mat.mul hX (creationMatrix M i hi) (annihilationMatrix M j hj))
                (Mat.mul hX (annihilationMatrix M j hj) (creationMatrix M i hi))) S U
            = Mat.entry (Mat.mul hX (creationMatrix M i hi) (annihilationMatrix M j hj)) S U
                + Mat.entry (Mat.mul hX (annihilationMatrix M j hj) (creationMatrix M i hi)) S U := rfl
          _ = sign (countBelow S' i) * sign (countBelow S' j)
                + Mat.entry (Mat.mul hX (annihilationMatrix M j hj) (creationMatrix M i hi)) S U := by
              rw [hstar1.1 (hD1.2 ⟨hiS, hUS⟩)]
          _ = sign (countBelow S' i) * sign (countBelow S' j) + 0 := by
              rw [hstar2.2 (fun h => (hD2.1 h).1 hiS)]
          _ = sign (countBelow S' i) * sign (countBelow S' i) + 0 := by rw [← hij]
          _ = 1 + 0 := by rw [sign_mul_self (countBelow S' i)]
          _ = 1 := add_zero (1 : ℂ)
          _ = 1 * 1 := (mul_one (1 : ℂ)).symm
          _ = kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M) * 1 := by rw [hδ]
          _ = kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M) * kroneckerDelta S U := by
              rw [show kroneckerDelta S U = (1 : ℂ) from if_pos hUS.symm]
          _ = Mat.entry (Mat.smul (kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M))
                (Mat.one : Mat (PowerSet M))) S U := (entry_smul_one _ S U).symm
      · -- U = S かつ i ∉ S。D_1 は成り立たず、D_2 は成り立つ。
        calc Mat.entry (Mat.add (Mat.mul hX (creationMatrix M i hi) (annihilationMatrix M j hj))
                (Mat.mul hX (annihilationMatrix M j hj) (creationMatrix M i hi))) S U
            = Mat.entry (Mat.mul hX (creationMatrix M i hi) (annihilationMatrix M j hj)) S U
                + Mat.entry (Mat.mul hX (annihilationMatrix M j hj) (creationMatrix M i hi)) S U := rfl
          _ = 0 + Mat.entry (Mat.mul hX (annihilationMatrix M j hj) (creationMatrix M i hi)) S U := by
              rw [hstar1.2 (fun h => hiS (hD1.1 h).1)]
          _ = 0 + sign (countBelow S j) * sign (countBelow U i) := by
              rw [hstar2.1 (hD2.2 ⟨hiS, hUS⟩)]
          _ = 0 + sign (countBelow S i) * sign (countBelow U i) := by rw [← hij]
          _ = 0 + sign (countBelow S i) * sign (countBelow S i) := by rw [hUS]
          _ = 0 + 1 := by rw [sign_mul_self (countBelow S i)]
          _ = 1 := zero_add (1 : ℂ)
          _ = 1 * 1 := (mul_one (1 : ℂ)).symm
          _ = kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M) * 1 := by rw [hδ]
          _ = kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M) * kroneckerDelta S U := by
              rw [show kroneckerDelta S U = (1 : ℂ) from if_pos hUS.symm]
          _ = Mat.entry (Mat.smul (kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M))
                (Mat.one : Mat (PowerSet M))) S U := (entry_smul_one _ S U).symm
    · -- U ≠ S。D_1 も D_2 も成り立たない。
      calc Mat.entry (Mat.add (Mat.mul hX (creationMatrix M i hi) (annihilationMatrix M j hj))
              (Mat.mul hX (annihilationMatrix M j hj) (creationMatrix M i hi))) S U
          = Mat.entry (Mat.mul hX (creationMatrix M i hi) (annihilationMatrix M j hj)) S U
              + Mat.entry (Mat.mul hX (annihilationMatrix M j hj) (creationMatrix M i hi)) S U := rfl
        _ = 0 + Mat.entry (Mat.mul hX (annihilationMatrix M j hj) (creationMatrix M i hi)) S U := by
            rw [hstar1.2 (fun h => hUS (hD1.1 h).2)]
        _ = 0 + 0 := by rw [hstar2.2 (fun h => hUS (hD2.1 h).2)]
        _ = 0 := add_zero (0 : ℂ)
        _ = 1 * 0 := (mul_zero (1 : ℂ)).symm
        _ = kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M) * 0 := by rw [hδ]
        _ = kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M) * kroneckerDelta S U := by
            rw [show kroneckerDelta S U = (0 : ℂ) from if_neg (fun h => hUS h.symm)]
        _ = Mat.entry (Mat.smul (kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M))
              (Mat.one : Mat (PowerSet M))) S U := (entry_smul_one _ S U).symm
  · -- i ≠ j のとき。δ_{i,j} = 0_ℂ。
    have hδ : kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M) = (0 : ℂ) :=
      if_neg (fun h => hij (congrArg Subtype.val h))
    have hD1 := cond1_iff_of_ne hj hij S U
    have hD2 := cond2_iff_of_ne hi hj hij S U
    by_cases hD : i ∈ S.1 ∧ j ∉ S.1 ∧ U = unionSingleton S' j hj
    · -- D が成り立つとき。D_1 も D_2 も成り立つ。
      obtain ⟨hiS, _, hU⟩ := id hD
      have hsharp : S = unionSingleton S' i hi := (unionSingleton_removeIndex hi hiS).symm
      have hiS' : i ∉ S'.1 := notMem_removeIndex S i
      have hjS' : j ∉ S'.1 := (hD1.2 hD).2.1
      let α := sign (countBelow S' i)
      let β := sign (countBelow S' j)
      rcases Nat.lt_or_gt_of_ne hij with hlt | hgt
      · -- i < j のとき。
        calc Mat.entry (Mat.add (Mat.mul hX (creationMatrix M i hi) (annihilationMatrix M j hj))
                (Mat.mul hX (annihilationMatrix M j hj) (creationMatrix M i hi))) S U
            = Mat.entry (Mat.mul hX (creationMatrix M i hi) (annihilationMatrix M j hj)) S U
                + Mat.entry (Mat.mul hX (annihilationMatrix M j hj) (creationMatrix M i hi)) S U := rfl
          _ = sign (countBelow S' i) * sign (countBelow S' j)
                + Mat.entry (Mat.mul hX (annihilationMatrix M j hj) (creationMatrix M i hi)) S U := by
              rw [hstar1.1 (hD1.2 hD)]
          _ = sign (countBelow S' i) * sign (countBelow S' j)
                + sign (countBelow S j) * sign (countBelow U i) := by
              rw [hstar2.1 (hD2.2 hD)]
          _ = α * β + sign (countBelow S j) * sign (countBelow U i) := rfl
          _ = α * β + sign (countBelow (unionSingleton S' i hi) j) * sign (countBelow U i) := by
              rw [show countBelow S j = countBelow (unionSingleton S' i hi) j from by rw [← hsharp]]
          _ = α * β + sign (countBelow (unionSingleton S' i hi) j)
                * sign (countBelow (unionSingleton S' j hj) i) := by
              rw [show countBelow U i = countBelow (unionSingleton S' j hj) i from by rw [hU]]
          _ = α * β + sign (countBelow S' j + 1) * sign (countBelow (unionSingleton S' j hj) i) := by
              rw [(countBelow_unionSingleton S' i hi hiS' j hj.1 hj.2).1 hlt]
          _ = α * β + sign (countBelow S' j + 1) * sign (countBelow S' i) := by
              rw [(countBelow_unionSingleton S' j hj hjS' i hi.1 hi.2).2 (Nat.le_of_lt hlt)]
          _ = α * β + ((-1) * sign (countBelow S' j)) * sign (countBelow S' i) := rfl
          _ = α * β + ((-1) * β) * α := rfl
          _ = α * β + (-1) * (β * α) := by rw [_root_.mul_assoc (-1 : ℂ) β α]
          _ = α * β + (-1) * (α * β) := by rw [mul_comm β α]
          _ = 1 * (α * β) + (-1) * (α * β) := by rw [one_mul (α * β)]
          _ = (1 + (-1)) * (α * β) := (add_mul (1 : ℂ) (-1) (α * β)).symm
          _ = 0 * (α * β) := by rw [add_neg_cancel (1 : ℂ)]
          _ = 0 := zero_mul (α * β)
          _ = 0 * kroneckerDelta S U := (zero_mul (kroneckerDelta S U)).symm
          _ = kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M) * kroneckerDelta S U := by rw [hδ]
          _ = Mat.entry (Mat.smul (kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M))
                (Mat.one : Mat (PowerSet M))) S U := (entry_smul_one _ S U).symm
      · -- j < i のとき。
        calc Mat.entry (Mat.add (Mat.mul hX (creationMatrix M i hi) (annihilationMatrix M j hj))
                (Mat.mul hX (annihilationMatrix M j hj) (creationMatrix M i hi))) S U
            = Mat.entry (Mat.mul hX (creationMatrix M i hi) (annihilationMatrix M j hj)) S U
                + Mat.entry (Mat.mul hX (annihilationMatrix M j hj) (creationMatrix M i hi)) S U := rfl
          _ = sign (countBelow S' i) * sign (countBelow S' j)
                + Mat.entry (Mat.mul hX (annihilationMatrix M j hj) (creationMatrix M i hi)) S U := by
              rw [hstar1.1 (hD1.2 hD)]
          _ = sign (countBelow S' i) * sign (countBelow S' j)
                + sign (countBelow S j) * sign (countBelow U i) := by
              rw [hstar2.1 (hD2.2 hD)]
          _ = α * β + sign (countBelow S j) * sign (countBelow U i) := rfl
          _ = α * β + sign (countBelow (unionSingleton S' i hi) j) * sign (countBelow U i) := by
              rw [show countBelow S j = countBelow (unionSingleton S' i hi) j from by rw [← hsharp]]
          _ = α * β + sign (countBelow (unionSingleton S' i hi) j)
                * sign (countBelow (unionSingleton S' j hj) i) := by
              rw [show countBelow U i = countBelow (unionSingleton S' j hj) i from by rw [hU]]
          _ = α * β + sign (countBelow S' j) * sign (countBelow (unionSingleton S' j hj) i) := by
              rw [(countBelow_unionSingleton S' i hi hiS' j hj.1 hj.2).2 (Nat.le_of_lt hgt)]
          _ = α * β + sign (countBelow S' j) * sign (countBelow S' i + 1) := by
              rw [(countBelow_unionSingleton S' j hj hjS' i hi.1 hi.2).1 hgt]
          _ = α * β + sign (countBelow S' j) * ((-1) * sign (countBelow S' i)) := rfl
          _ = α * β + β * ((-1) * α) := rfl
          _ = α * β + ((-1) * α) * β := by rw [mul_comm β ((-1) * α)]
          _ = α * β + (-1) * (α * β) := by rw [_root_.mul_assoc (-1 : ℂ) α β]
          _ = 1 * (α * β) + (-1) * (α * β) := by rw [one_mul (α * β)]
          _ = (1 + (-1)) * (α * β) := (add_mul (1 : ℂ) (-1) (α * β)).symm
          _ = 0 * (α * β) := by rw [add_neg_cancel (1 : ℂ)]
          _ = 0 := zero_mul (α * β)
          _ = 0 * kroneckerDelta S U := (zero_mul (kroneckerDelta S U)).symm
          _ = kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M) * kroneckerDelta S U := by rw [hδ]
          _ = Mat.entry (Mat.smul (kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M))
                (Mat.one : Mat (PowerSet M))) S U := (entry_smul_one _ S U).symm
    · -- D が成り立たないとき。D_1 も D_2 も成り立たない。
      calc Mat.entry (Mat.add (Mat.mul hX (creationMatrix M i hi) (annihilationMatrix M j hj))
              (Mat.mul hX (annihilationMatrix M j hj) (creationMatrix M i hi))) S U
          = Mat.entry (Mat.mul hX (creationMatrix M i hi) (annihilationMatrix M j hj)) S U
              + Mat.entry (Mat.mul hX (annihilationMatrix M j hj) (creationMatrix M i hi)) S U := rfl
        _ = 0 + Mat.entry (Mat.mul hX (annihilationMatrix M j hj) (creationMatrix M i hi)) S U := by
            rw [hstar1.2 (fun h => hD (hD1.1 h))]
        _ = 0 + 0 := by rw [hstar2.2 (fun h => hD (hD2.1 h))]
        _ = 0 := add_zero (0 : ℂ)
        _ = 0 * kroneckerDelta S U := (zero_mul (kroneckerDelta S U)).symm
        _ = kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M) * kroneckerDelta S U := by rw [hδ]
        _ = Mat.entry (Mat.smul (kroneckerDelta (⟨i, hi⟩ : Idx M) (⟨j, hj⟩ : Idx M))
              (Mat.one : Mat (PowerSet M))) S U := (entry_smul_one _ S U).symm

end CliffordMatrixIsomorphism.Isomorphism
