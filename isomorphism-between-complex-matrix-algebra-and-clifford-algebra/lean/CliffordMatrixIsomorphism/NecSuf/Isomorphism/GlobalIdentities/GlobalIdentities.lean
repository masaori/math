/-
章「同型の証明」の節「クリフォード代数の中の大域的な等式」の必要十分版。具体版
`Isomorphism/GlobalIdentities/GlobalIdentities.lean` と同じ def と同じ calc の行のまま、係数 ℂ を型の変数 K に、
-1_ℂ を K の元 n に替える。K には演算の記号 +・·・0・1・- だけを与え、使う性質は仮定として渡す。
本文のラベルと宣言の対応は具体版の冒頭の表と同じである（宣言の名前も同じ）。

主張ごとに使う K の性質（部分集合の和の主張を除き、どの主張もクリフォード代数 Cl(V,q) を作るための
章「クリフォード代数」の仮定 `CliffordLaws K n` を持つ）:
  a†_{U,≤m}・P_{≤m}・Q^{T,U}_m・u^S_i の定義、a†_{U,≤m} と P_{≤m} の分解、a†_{U,≤M} = a†_U、P_{≤M} = P、
  Q^{T,U}_M = (P (a_T a†_U)) P、a_{T,≤m} a†_{U,≤m} の分解
                                   `CliffordLaws K n` のほかに足さない（行が使うのは代数の公理だけ）
  ほかのクリフォード代数の中の主張  a + (-a) = 0（生成元の反交換関係と平方が零であることを引くため）。
                                   行の中で使う K の性質は、0 + 0 = 0（零のスカラー倍・零との積）・1 + n = 0 と n · n = 1
                                   （反交換する二元の入れ替えと (-1_ℂ)·(-1_ℂ) = 1_ℂ。a_i と a†_j a_j の交換だけ）
  部分集合の和の主張（一般の K-代数 B）
                                   0 + 0 = 0 だけ（右から掛ける写像が線型結合を線型結合へ移すことを引くため）

分かったこと:
- 部分集合の和の主張は、B の乗法の交換法則も、K の乗法の性質も使わない。使う K の性質は 0 + 0 = 0 だけで、
  それも線型写像が線型結合を移す主張（`IsLinearMap.map_linearCombination`）の仮定から来る。
- 1 の分解の主張の行が K について使うのは、生成元の反交換関係 a_i a†_i + a†_i a_i = δ_{i,i} ∗ 1 と、δ_{i,i} = 1 だけである
  （δ_{i,i} = 1 は定義どおり。行の中に K の計算は無い）。
- 本文の前提 M ∈ ℤ_{≥1} は、どの主張も使わない。部分集合の和の主張の M と m ≤ M は、帰納法の仮定へ渡すだけで
  式変形の行には現れない（g・h を ℕ 全体の上の族にしたので、上限 M は要らない。主張の文には本文どおり残す）。

導出版は `Isomorphism/GlobalIdentities/GlobalIdentitiesFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.LocalIdentities.LocalIdentities
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.PowerSetNumbering.BinaryNumbering
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.FiniteSetSum.SumOverFiniteSet

namespace CliffordMatrixIsomorphism.NecSuf.AlgebraOver

open CliffordMatrixIsomorphism.NecSuf.VectorSpace
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra

universe v uK

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K] {B : Type v}

open Classical in
/-- 本文 `claim_sum_over_subsets_of_selected_products_is_product_of_sums` の必要十分版 の v^S_i：i ∈ S なら g_i、i ∉ S なら h_i。 -/
noncomputable def selectedFactorBySubset (g h : ℕ → B) (S : Set ℕ) (i : ℕ) : B :=
  if i ∈ S then g i else h i

theorem selectedFactorBySubset_of_mem {g h : ℕ → B} {S : Set ℕ} {i : ℕ} (hi : i ∈ S) :
    selectedFactorBySubset g h S i = g i := if_pos hi

theorem selectedFactorBySubset_of_not_mem {g h : ℕ → B} {S : Set ℕ} {i : ℕ} (hi : i ∉ S) :
    selectedFactorBySubset g h S i = h i := if_neg hi

/-- 本文 `claim_sum_over_subsets_of_selected_products_is_product_of_sums` の必要十分版：
Σ_{k=1}^{2^m} 1_ℂ ∗_B ∏_{B,i=1}^{m} v^{e_m(k)}_i = ∏_{B,i=1}^{m} (h_i +_B g_i)（m ∈ {0,…,M}）。
F_m(S) := ∏_{B,i=1}^{m} v^S_i、Π_m := ∏_{B,i=1}^{m} (h_i +_B g_i) と置き、m の帰納法で示す。 -/
theorem linearCombination_selectedProducts_eq (SB : AlgebraOver K B) (h00 : (0 : K) + 0 = 0) (M : ℕ) (g h : ℕ → B) :
    ∀ m : ℕ, m ≤ M →
      linearCombination SB.toVectorSpace (twoPower m) (fun _ => 1)
          (numberedFamily (binaryNumbering m) (fun S => orderedProduct SB m (selectedFactorBySubset g h S.1)) SB.zero)
        = orderedProduct SB m (fun i => SB.add (h i) (g i)) := by
  let S := SB.toVectorSpace
  let F : ℕ → Set ℕ → B := fun m T => orderedProduct SB m (selectedFactorBySubset g h T)
  let Pr : ℕ → B := fun m => orderedProduct SB m (fun i => SB.add (h i) (g i))
  intro m
  induction m with
  | zero =>
    intro _
    -- m = 0：2^0 = 1、F_0(e_0(1)) = 1_B
    calc linearCombination S (twoPower 0) (fun _ => 1)
          (numberedFamily (binaryNumbering 0) (fun T => F 0 T.1) SB.zero)
        = SB.add SB.zero (SB.smul 1 (numberedFamily (binaryNumbering 0) (fun T => F 0 T.1) SB.zero 1)) := rfl
      _ = SB.add SB.zero (SB.smul 1 SB.one) := by
          rw [numberedFamily_of_le (binaryNumbering 0) (fun T => F 0 T.1) SB.zero 1 le_rfl le_rfl]
          rfl
      _ = SB.add SB.zero SB.one := by rw [SB.one_smul SB.one]
      _ = SB.add SB.one SB.zero := SB.add_comm _ _
      _ = SB.one := SB.add_zero SB.one
      _ = Pr 0 := rfl
  | succ m ih =>
    intro hm
    let n := twoPower m
    let X : ℕ → B := numberedFamily (binaryNumbering (m + 1)) (fun T => F (m + 1) T.1) SB.zero
    let Y : ℕ → B := numberedFamily (binaryNumbering m) (fun T => F m T.1) SB.zero
    -- （イ）k ∈ {1,…,n} なら F_{m+1}(e_{m+1}(k)) = F_m(e_m(k)) ·_B h_{m+1}
    have hfirst : ∀ k : ℕ, 1 ≤ k → k ≤ n → SB.smul 1 (X k) = SB.smul 1 (SB.mul (Y k) (h (m + 1))) := by
      intro k hk1 hkn
      have hk2 : k ≤ twoPower (m + 1) := by rw [twoPower_succ]; omega
      let kk : Idx (twoPower (m + 1)) := ⟨k, hk1, hk2⟩
      have hnot : m + 1 ∉ (binaryNumbering (m + 1) kk).1 := not_mem_binaryNumbering_succ_of_le m kk hkn
      have heq : (binaryNumbering (m + 1) kk).1 = (binaryNumbering m ⟨k, hk1, hkn⟩).1 :=
        binaryNumbering_succ_of_le m kk hkn
      have hX : X k = F (m + 1) (binaryNumbering (m + 1) kk).1 :=
        numberedFamily_of_le (binaryNumbering (m + 1)) (fun T => F (m + 1) T.1) SB.zero k hk1 hk2
      have hY : Y k = F m (binaryNumbering m ⟨k, hk1, hkn⟩).1 :=
        numberedFamily_of_le (binaryNumbering m) (fun T => F m T.1) SB.zero k hk1 hkn
      have hstep : F (m + 1) (binaryNumbering (m + 1) kk).1 = SB.mul (Y k) (h (m + 1)) := calc
        F (m + 1) (binaryNumbering (m + 1) kk).1
            = SB.mul (F m (binaryNumbering (m + 1) kk).1)
                (selectedFactorBySubset g h (binaryNumbering (m + 1) kk).1 (m + 1)) := rfl
        _ = SB.mul (F m (binaryNumbering (m + 1) kk).1) (h (m + 1)) := by
            rw [selectedFactorBySubset_of_not_mem hnot]
        _ = SB.mul (F m (binaryNumbering m ⟨k, hk1, hkn⟩).1) (h (m + 1)) := by rw [heq]
        _ = SB.mul (Y k) (h (m + 1)) := by rw [hY]
      rw [hX, hstep]
    -- （ロ）j ∈ {1,…,n} なら F_{m+1}(e_{m+1}(n+j)) = F_m(e_m(j)) ·_B g_{m+1}
    have hsecond : ∀ j : ℕ, 1 ≤ j → j ≤ n →
        SB.smul 1 (X (n + j)) = SB.smul 1 (SB.mul (Y j) (g (m + 1))) := by
      intro j hj1 hjn
      have hk2 : n + j ≤ twoPower (m + 1) := by rw [twoPower_succ]; omega
      let kk : Idx (twoPower (m + 1)) := ⟨n + j, by omega, hk2⟩
      have hgt : ¬ kk.1 ≤ twoPower m := by show ¬ n + j ≤ n; omega
      have hidx : (⟨kk.1 - twoPower m, sub_twoPower_mem kk hgt⟩ : Idx (twoPower m)) = ⟨j, hj1, hjn⟩ :=
        Subtype.ext (by show n + j - n = j; omega)
      have hmem : m + 1 ∈ (binaryNumbering (m + 1) kk).1 := mem_binaryNumbering_succ_of_gt m kk hgt
      have hiff : ∀ t : ℕ, t ≤ m → (t ∈ (binaryNumbering (m + 1) kk).1 ↔ t ∈ (binaryNumbering m ⟨j, hj1, hjn⟩).1) := by
        intro t ht
        rw [← hidx]
        exact mem_binaryNumbering_succ_iff_of_gt m kk hgt t ht
      have hX : X (n + j) = F (m + 1) (binaryNumbering (m + 1) kk).1 :=
        numberedFamily_of_le (binaryNumbering (m + 1)) (fun T => F (m + 1) T.1) SB.zero (n + j) (by omega) hk2
      have hY : Y j = F m (binaryNumbering m ⟨j, hj1, hjn⟩).1 :=
        numberedFamily_of_le (binaryNumbering m) (fun T => F m T.1) SB.zero j hj1 hjn
      -- 各 i ∈ {1,…,m} で v^{e_{m+1}(n+j)}_i = v^{e_m(j)}_i
      have hv : ∀ i : ℕ, 1 ≤ i → i ≤ m →
          selectedFactorBySubset g h (binaryNumbering (m + 1) kk).1 i
            = selectedFactorBySubset g h (binaryNumbering m ⟨j, hj1, hjn⟩).1 i := by
        intro i _ him
        by_cases hi : i ∈ (binaryNumbering m ⟨j, hj1, hjn⟩).1
        · rw [selectedFactorBySubset_of_mem ((hiff i him).2 hi), selectedFactorBySubset_of_mem hi]
        · rw [selectedFactorBySubset_of_not_mem (fun h' => hi ((hiff i him).1 h')),
            selectedFactorBySubset_of_not_mem hi]
      have hstep : F (m + 1) (binaryNumbering (m + 1) kk).1 = SB.mul (Y j) (g (m + 1)) := calc
        F (m + 1) (binaryNumbering (m + 1) kk).1
            = SB.mul (F m (binaryNumbering (m + 1) kk).1)
                (selectedFactorBySubset g h (binaryNumbering (m + 1) kk).1 (m + 1)) := rfl
        _ = SB.mul (F m (binaryNumbering (m + 1) kk).1) (g (m + 1)) := by
            rw [selectedFactorBySubset_of_mem hmem]
        _ = SB.mul (F m (binaryNumbering m ⟨j, hj1, hjn⟩).1) (g (m + 1)) := by
            rw [show F m (binaryNumbering (m + 1) kk).1 = F m (binaryNumbering m ⟨j, hj1, hjn⟩).1 from
              orderedProduct_congr SB m _ _ hv]
        _ = SB.mul (Y j) (g (m + 1)) := by rw [hY]
      rw [hX, hstep]
    -- （ハ）右から r を掛ける写像は線型写像なので、Σ 1 ∗ (X_k · r) = (Σ 1 ∗ X_k) · r
    have hright : ∀ r : B,
        linearCombination S n (fun _ => 1) (fun k => SB.mul (Y k) r)
          = SB.mul (linearCombination S n (fun _ => 1) Y) r := fun r =>
      ((rightMul_isLinearMap SB r).map_linearCombination h00 n (fun _ => 1) Y).symm
    calc linearCombination S (twoPower (m + 1)) (fun _ => 1) X
        = linearCombination S (n + n) (fun _ => 1) X := by rw [twoPower_succ m]
      _ = SB.add (linearCombination S n (fun _ => 1) X)
            (linearCombination S n (fun _ => 1) (fun j => X (n + j))) :=
          linearCombination_split S n n X (fun _ => 1)
      _ = SB.add (linearCombination S n (fun _ => 1) (fun k => SB.mul (Y k) (h (m + 1))))
            (linearCombination S n (fun _ => 1) (fun j => X (n + j))) := by
          rw [linearCombination_eq_of_terms_eq S n X (fun k => SB.mul (Y k) (h (m + 1))) _ _ hfirst]
      _ = SB.add (linearCombination S n (fun _ => 1) (fun k => SB.mul (Y k) (h (m + 1))))
            (linearCombination S n (fun _ => 1) (fun j => SB.mul (Y j) (g (m + 1)))) := by
          rw [linearCombination_eq_of_terms_eq S n (fun j => X (n + j)) (fun j => SB.mul (Y j) (g (m + 1))) _ _
            hsecond]
      _ = SB.add (SB.mul (linearCombination S n (fun _ => 1) Y) (h (m + 1)))
            (SB.mul (linearCombination S n (fun _ => 1) Y) (g (m + 1))) := by
          rw [hright (h (m + 1)), hright (g (m + 1))]
      _ = SB.add (SB.mul (Pr m) (h (m + 1))) (SB.mul (Pr m) (g (m + 1))) := by
          rw [show linearCombination S n (fun _ => 1) Y = Pr m from ih (by omega)]
      _ = SB.mul (Pr m) (SB.add (h (m + 1)) (g (m + 1))) := (SB.left_distrib _ _ _).symm
      _ = Pr (m + 1) := rfl

end CliffordMatrixIsomorphism.NecSuf.AlgebraOver

namespace CliffordMatrixIsomorphism.NecSuf.Clifford.SplitData

open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.NecSuf.AlgebraOver
open CliffordMatrixIsomorphism.NecSuf.VectorSpace

universe u uK

noncomputable section

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K] [Neg K] {n : K} (C : CliffordLaws K n)
  {W : Type u} (D : SplitData K W)

/-! ### 消滅と生成の積の交換と冪等性 -/

/-- 本文 `claim_annihilation_generator_commutes_with_other_number_reversed_pair` の必要十分版：
i ≠ j なら a_i (a†_j a_j) = (a†_j a_j) a_i。 -/
theorem annihilation_commute_reversedPair (hneg : ∀ a : K, a + -a = 0) {i j : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) (hj : 1 ≤ j ∧ j ≤ D.M) (hij : i ≠ j) :
    ((D.space C).cliffordAlgebra C).mul (D.annihilation C i) (((D.space C).cliffordAlgebra C).mul (D.creation C j) (D.annihilation C j))
      = ((D.space C).cliffordAlgebra C).mul (((D.space C).cliffordAlgebra C).mul (D.creation C j) (D.annihilation C j)) (D.annihilation C i) := by
  let A := ((D.space C).cliffordAlgebra C)
  -- 準備：a_i a†_j + a†_j a_i = 0_A
  have hprep : A.add (A.mul (D.annihilation C i) (D.creation C j)) (A.mul (D.creation C j) (D.annihilation C i))
      = A.zero := calc
    A.add (A.mul (D.annihilation C i) (D.creation C j)) (A.mul (D.creation C j) (D.annihilation C i))
        = A.smul (kroneckerDelta i j) A.one := D.annihilation_creation_anticommute C hneg i j hi.1 hi.2 hj.1 hj.2
    _ = A.smul 0 A.one := by rw [kroneckerDelta, if_neg hij]
    _ = A.zero := AlgebraOver.zero_smul_eq_zero A C.congruence.zero_add_zero A.one
  calc A.mul (D.annihilation C i) (A.mul (D.creation C j) (D.annihilation C j))
      = A.mul (A.mul (D.annihilation C i) (D.creation C j)) (D.annihilation C j) := (A.mul_assoc _ _ _).symm
    _ = A.mul (A.smul n (A.mul (D.creation C j) (D.annihilation C i))) (D.annihilation C j) := by
        rw [mul_eq_neg_one_smul_swap C.congruence.zero_add_zero n C.congruence.one_add_n A (D.annihilation C i) (D.creation C j) hprep]
    _ = A.smul n (A.mul (A.mul (D.creation C j) (D.annihilation C i)) (D.annihilation C j)) :=
        (A.smul_mul_left _ _ _).symm
    _ = A.smul n (A.mul (D.creation C j) (A.mul (D.annihilation C i) (D.annihilation C j))) := by
        rw [A.mul_assoc (D.creation C j) (D.annihilation C i) (D.annihilation C j)]
    _ = A.smul n (A.mul (D.creation C j) (A.smul n (A.mul (D.annihilation C j) (D.annihilation C i)))) := by
        rw [mul_eq_neg_one_smul_swap C.congruence.zero_add_zero n C.congruence.one_add_n A (D.annihilation C i) (D.annihilation C j) (D.annihilation_anticommute C hneg i j)]
    _ = A.smul n (A.smul n (A.mul (D.creation C j) (A.mul (D.annihilation C j) (D.annihilation C i)))) := by
        rw [← A.smul_mul_right n (D.creation C j) (A.mul (D.annihilation C j) (D.annihilation C i))]
    _ = A.smul (n * n) (A.mul (D.creation C j) (A.mul (D.annihilation C j) (D.annihilation C i))) :=
        (A.smul_assoc _ _ _).symm
    _ = A.smul 1 (A.mul (D.creation C j) (A.mul (D.annihilation C j) (D.annihilation C i))) := by
        rw [C.congruence.n_mul_n]
    _ = A.mul (D.creation C j) (A.mul (D.annihilation C j) (D.annihilation C i)) := A.one_smul _
    _ = A.mul (A.mul (D.creation C j) (D.annihilation C j)) (D.annihilation C i) := (A.mul_assoc _ _ _).symm

/-- 本文 `claim_vacuum_factors_with_different_numbers_commute` の必要十分版：i ≠ j なら x_i x_j = x_j x_i。 -/
theorem vacuumFactor_commute (hneg : ∀ a : K, a + -a = 0) {i j : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) (hj : 1 ≤ j ∧ j ≤ D.M) (hij : i ≠ j) :
    ((D.space C).cliffordAlgebra C).mul (D.vacuumFactor C i) (D.vacuumFactor C j)
      = ((D.space C).cliffordAlgebra C).mul (D.vacuumFactor C j) (D.vacuumFactor C i) := by
  let A := ((D.space C).cliffordAlgebra C)
  calc A.mul (D.vacuumFactor C i) (D.vacuumFactor C j)
      = A.mul (A.mul (D.annihilation C i) (D.creation C i)) (D.vacuumFactor C j) := rfl
    _ = A.mul (D.annihilation C i) (A.mul (D.creation C i) (D.vacuumFactor C j)) := A.mul_assoc _ _ _
    _ = A.mul (D.annihilation C i) (A.mul (D.vacuumFactor C j) (D.creation C i)) := by
        rw [D.creation_commute_vacuumFactor C hneg hi hj hij]
    _ = A.mul (A.mul (D.annihilation C i) (D.vacuumFactor C j)) (D.creation C i) := (A.mul_assoc _ _ _).symm
    _ = A.mul (A.mul (D.vacuumFactor C j) (D.annihilation C i)) (D.creation C i) := by
        rw [D.annihilation_commute_vacuumFactor C hneg hi hj hij]
    _ = A.mul (D.vacuumFactor C j) (A.mul (D.annihilation C i) (D.creation C i)) := A.mul_assoc _ _ _
    _ = A.mul (D.vacuumFactor C j) (D.vacuumFactor C i) := rfl

/-- 本文 `claim_vacuum_factor_times_annihilation_generator_is_annihilation_generator` の必要十分版：x_i a_i = a_i。 -/
theorem vacuumFactor_mul_annihilation (hneg : ∀ a : K, a + -a = 0) {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    ((D.space C).cliffordAlgebra C).mul (D.vacuumFactor C i) (D.annihilation C i) = D.annihilation C i := by
  let A := ((D.space C).cliffordAlgebra C)
  let a := D.annihilation C i
  let c := D.creation C i
  calc A.mul (D.vacuumFactor C i) a
      = A.mul (A.mul a c) a := rfl
    _ = A.mul a (A.mul c a) := A.mul_assoc _ _ _
    _ = A.add (A.mul a (A.mul c a)) A.zero := (A.add_zero _).symm
    _ = A.add A.zero (A.mul a (A.mul c a)) := A.add_comm _ _
    _ = A.add (A.mul A.zero c) (A.mul a (A.mul c a)) := by rw [zero_mul_eq_zero C.congruence.zero_add_zero A c]
    _ = A.add (A.mul (A.mul a a) c) (A.mul a (A.mul c a)) := by rw [D.annihilation_mul_self C hneg i]
    _ = A.add (A.mul a (A.mul a c)) (A.mul a (A.mul c a)) := by rw [A.mul_assoc a a c]
    _ = A.mul a (A.add (A.mul a c) (A.mul c a)) := (A.left_distrib _ _ _).symm
    _ = A.mul a (A.smul (kroneckerDelta i i) A.one) := by
        rw [D.annihilation_creation_anticommute C hneg i i hi.1 hi.2 hi.1 hi.2]
    _ = A.mul a (A.smul 1 A.one) := by rw [kroneckerDelta, if_pos rfl]
    _ = A.mul a A.one := by rw [A.one_smul A.one]
    _ = a := A.mul_one a

/-- 本文 `claim_creation_generator_times_vacuum_factor_is_creation_generator` の必要十分版：a†_i x_i = a†_i。 -/
theorem creation_mul_vacuumFactor (hneg : ∀ a : K, a + -a = 0) {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    ((D.space C).cliffordAlgebra C).mul (D.creation C i) (D.vacuumFactor C i) = D.creation C i := by
  let A := ((D.space C).cliffordAlgebra C)
  let a := D.annihilation C i
  let c := D.creation C i
  calc A.mul c (D.vacuumFactor C i)
      = A.mul c (A.mul a c) := rfl
    _ = A.mul (A.mul c a) c := (A.mul_assoc _ _ _).symm
    _ = A.add (A.mul (A.mul c a) c) A.zero := (A.add_zero _).symm
    _ = A.add A.zero (A.mul (A.mul c a) c) := A.add_comm _ _
    _ = A.add (A.mul a A.zero) (A.mul (A.mul c a) c) := by rw [mul_zero_eq_zero C.congruence.zero_add_zero A a]
    _ = A.add (A.mul a (A.mul c c)) (A.mul (A.mul c a) c) := by rw [D.creation_mul_self C hneg i]
    _ = A.add (A.mul (A.mul a c) c) (A.mul (A.mul c a) c) := by rw [A.mul_assoc a c c]
    _ = A.mul (A.add (A.mul a c) (A.mul c a)) c := (A.right_distrib _ _ _).symm
    _ = A.mul (A.smul (kroneckerDelta i i) A.one) c := by
        rw [D.annihilation_creation_anticommute C hneg i i hi.1 hi.2 hi.1 hi.2]
    _ = A.mul (A.smul 1 A.one) c := by rw [kroneckerDelta, if_pos rfl]
    _ = A.mul A.one c := by rw [A.one_smul A.one]
    _ = c := A.one_mul c

/-- 本文 `claim_vacuum_factor_is_idempotent` の必要十分版：x_i x_i = x_i。 -/
theorem vacuumFactor_mul_self (hneg : ∀ a : K, a + -a = 0) {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    ((D.space C).cliffordAlgebra C).mul (D.vacuumFactor C i) (D.vacuumFactor C i) = D.vacuumFactor C i := by
  let A := ((D.space C).cliffordAlgebra C)
  calc A.mul (D.vacuumFactor C i) (D.vacuumFactor C i)
      = A.mul (D.vacuumFactor C i) (A.mul (D.annihilation C i) (D.creation C i)) := rfl
    _ = A.mul (A.mul (D.vacuumFactor C i) (D.annihilation C i)) (D.creation C i) := (A.mul_assoc _ _ _).symm
    _ = A.mul (D.annihilation C i) (D.creation C i) := by rw [D.vacuumFactor_mul_annihilation C hneg hi]
    _ = D.vacuumFactor C i := rfl

/-! ### 番号が m 以下の部分 -/

/-- 本文 `def_initial_ordered_product_of_selected_creation_generators` の必要十分版：a†_{U,≤m} := ∏_{A,t=1}^{m} y^U_t。 -/
def initialCreationProduct (U : PowerSet D.M) (m : ℕ) : (D.space C).Cl C :=
  AlgebraOver.orderedProduct ((D.space C).cliffordAlgebra C) m (D.selectedCreationFactor C U)

/-- 本文 `claim_initial_ordered_creation_product_splits_off_last_number` の必要十分版：
a†_{U,≤m} = a†_{U,≤m-1} ·_A y^U_m（本文の m を Lean では m + 1 と書く）。 -/
theorem initialCreationProduct_succ (U : PowerSet D.M) (m : ℕ) :
    D.initialCreationProduct C U (m + 1)
      = ((D.space C).cliffordAlgebra C).mul (D.initialCreationProduct C U m) (D.selectedCreationFactor C U (m + 1)) :=
  calc D.initialCreationProduct C U (m + 1)
      = AlgebraOver.orderedProduct ((D.space C).cliffordAlgebra C) (m + 1) (D.selectedCreationFactor C U) := rfl
    -- Π_{m+1} = Π_m ·_A y^U_{m+1}（def_ordered_product_in_algebra）
    _ = ((D.space C).cliffordAlgebra C).mul (AlgebraOver.orderedProduct ((D.space C).cliffordAlgebra C) m (D.selectedCreationFactor C U))
          (D.selectedCreationFactor C U (m + 1)) := rfl
    _ = ((D.space C).cliffordAlgebra C).mul (D.initialCreationProduct C U m) (D.selectedCreationFactor C U (m + 1)) := rfl

/-- 本文 `claim_initial_ordered_creation_product_up_to_last_number_is_whole_product` の必要十分版：a†_{U,≤M} = a†_U。 -/
theorem initialCreationProduct_last (U : PowerSet D.M) :
    D.initialCreationProduct C U D.M = D.orderedCreationProduct C U :=
  calc D.initialCreationProduct C U D.M
      = AlgebraOver.orderedProduct ((D.space C).cliffordAlgebra C) D.M (D.selectedCreationFactor C U) := rfl
    _ = D.orderedCreationProduct C U := rfl

/-- 本文 `def_initial_part_of_vacuum_element` の必要十分版：P_{≤m} := ∏_{A,i=1}^{m} x_i。 -/
def initialVacuumPart (m : ℕ) : (D.space C).Cl C :=
  AlgebraOver.orderedProduct ((D.space C).cliffordAlgebra C) m (D.vacuumFactor C)

/-- 本文 `claim_initial_part_of_vacuum_element_splits_off_last_factor` の必要十分版：P_{≤m} = P_{≤m-1} ·_A x_m
（本文の m を Lean では m + 1 と書く）。 -/
theorem initialVacuumPart_succ (m : ℕ) :
    D.initialVacuumPart C (m + 1) = ((D.space C).cliffordAlgebra C).mul (D.initialVacuumPart C m) ((D.vacuumFactor C) (m + 1)) :=
  calc D.initialVacuumPart C (m + 1)
      = AlgebraOver.orderedProduct ((D.space C).cliffordAlgebra C) (m + 1) (D.vacuumFactor C) := rfl
    -- Π_{m+1} = Π_m ·_A x_{m+1}（def_ordered_product_in_algebra）
    _ = ((D.space C).cliffordAlgebra C).mul (AlgebraOver.orderedProduct ((D.space C).cliffordAlgebra C) m (D.vacuumFactor C))
          ((D.vacuumFactor C) (m + 1)) := rfl
    _ = ((D.space C).cliffordAlgebra C).mul (D.initialVacuumPart C m) ((D.vacuumFactor C) (m + 1)) := rfl

/-- 本文 `claim_initial_part_of_vacuum_element_up_to_last_number_is_vacuum_element` の必要十分版：P_{≤M} = P。 -/
theorem initialVacuumPart_last : D.initialVacuumPart C D.M = (D.vacuumElement C) :=
  calc D.initialVacuumPart C D.M
      = AlgebraOver.orderedProduct ((D.space C).cliffordAlgebra C) D.M (D.vacuumFactor C) := rfl
    _ = (D.vacuumElement C) := rfl

/-- 本文 `def_vacuum_sandwich_of_initial_parts` の必要十分版：Q^{T,U}_m := (P_{≤m} ·_A (a_{T,≤m} ·_A a†_{U,≤m})) ·_A P_{≤m}。 -/
def vacuumSandwich (T U : PowerSet D.M) (m : ℕ) : (D.space C).Cl C :=
  ((D.space C).cliffordAlgebra C).mul
    (((D.space C).cliffordAlgebra C).mul (D.initialVacuumPart C m)
      (((D.space C).cliffordAlgebra C).mul (D.initialReverseAnnihilationProduct C T m) (D.initialCreationProduct C U m)))
    (D.initialVacuumPart C m)

/-- 本文 `claim_vacuum_sandwich_up_to_last_number_is_vacuum_element_sandwich` の必要十分版：Q^{T,U}_M = (P (a_T a†_U)) P。 -/
theorem vacuumSandwich_last (T U : PowerSet D.M) :
    D.vacuumSandwich C T U D.M
      = ((D.space C).cliffordAlgebra C).mul
          (((D.space C).cliffordAlgebra C).mul (D.vacuumElement C)
            (((D.space C).cliffordAlgebra C).mul (D.reverseOrderedAnnihilationProduct C T) (D.orderedCreationProduct C U)))
          (D.vacuumElement C) := by
  let A := ((D.space C).cliffordAlgebra C)
  calc D.vacuumSandwich C T U D.M
      = A.mul (A.mul (D.initialVacuumPart C D.M)
          (A.mul (D.initialReverseAnnihilationProduct C T D.M) (D.initialCreationProduct C U D.M)))
          (D.initialVacuumPart C D.M) := rfl
    _ = A.mul (A.mul (D.initialVacuumPart C D.M)
          (A.mul (D.reverseOrderedAnnihilationProduct C T) (D.initialCreationProduct C U D.M)))
          (D.initialVacuumPart C D.M) := by rw [D.initialReverseAnnihilationProduct_last C T]
    _ = A.mul (A.mul (D.initialVacuumPart C D.M)
          (A.mul (D.reverseOrderedAnnihilationProduct C T) (D.orderedCreationProduct C U)))
          (D.initialVacuumPart C D.M) := by rw [D.initialCreationProduct_last C U]
    _ = A.mul (A.mul (D.vacuumElement C)
          (A.mul (D.reverseOrderedAnnihilationProduct C T) (D.orderedCreationProduct C U)))
          (D.vacuumElement C) := by rw [D.initialVacuumPart_last C]

/-- 本文 `claim_vacuum_factor_commutes_with_lower_initial_parts` の必要十分版：
x_m (a_{T,≤m-1} a†_{U,≤m-1}) = (a_{T,≤m-1} a†_{U,≤m-1}) x_m（本文の m を Lean では m + 1 と書く）。 -/
theorem vacuumFactor_commute_initialParts (hneg : ∀ a : K, a + -a = 0) (T U : PowerSet D.M) {m : ℕ} (hm : m + 1 ≤ D.M) :
    ((D.space C).cliffordAlgebra C).mul ((D.vacuumFactor C) (m + 1))
        (((D.space C).cliffordAlgebra C).mul (D.initialReverseAnnihilationProduct C T m) (D.initialCreationProduct C U m))
      = ((D.space C).cliffordAlgebra C).mul
          (((D.space C).cliffordAlgebra C).mul (D.initialReverseAnnihilationProduct C T m) (D.initialCreationProduct C U m))
          ((D.vacuumFactor C) (m + 1)) := by
  let A := ((D.space C).cliffordAlgebra C)
  let x := (D.vacuumFactor C) (m + 1)
  let α := D.initialReverseAnnihilationProduct C T m
  let κ := D.initialCreationProduct C U m
  have hmM : 1 ≤ m + 1 ∧ m + 1 ≤ D.M := ⟨Nat.succ_pos m, hm⟩
  -- x_m は α の因子 z^T_{m-k}（k ∈ {1,…,m-1}）と交換する
  have hα : A.mul x α = A.mul α x := by
    apply commute_orderedProduct A x m (fun k => D.selectedAnnihilationFactor C T (m + 1 - k))
    intro k hk1 hkm
    show A.mul x (D.selectedAnnihilationFactor C T (m + 1 - k)) = A.mul (D.selectedAnnihilationFactor C T (m + 1 - k)) x
    by_cases ht : m + 1 - k ∈ T.1
    · rw [D.selectedAnnihilationFactor_of_mem C ht]
      exact (D.annihilation_commute_vacuumFactor C hneg ⟨by omega, by omega⟩ hmM (by omega)).symm
    · rw [D.selectedAnnihilationFactor_of_not_mem C ht, A.mul_one x, A.one_mul x]
  -- x_m は κ の因子 y^U_t（t ∈ {1,…,m-1}）と交換する
  have hκ : A.mul x κ = A.mul κ x := by
    apply commute_orderedProduct A x m (D.selectedCreationFactor C U)
    intro t ht1 htm
    by_cases ht : t ∈ U.1
    · rw [D.selectedCreationFactor_of_mem C ht]
      exact (D.creation_commute_vacuumFactor C hneg ⟨ht1, by omega⟩ hmM (by omega)).symm
    · rw [D.selectedCreationFactor_of_not_mem C ht, A.mul_one x, A.one_mul x]
  calc A.mul x (A.mul α κ)
      = A.mul (A.mul x α) κ := (A.mul_assoc _ _ _).symm
    _ = A.mul (A.mul α x) κ := by rw [hα]
    _ = A.mul α (A.mul x κ) := A.mul_assoc _ _ _
    _ = A.mul α (A.mul κ x) := by rw [hκ]
    _ = A.mul (A.mul α κ) x := (A.mul_assoc _ _ _).symm

/-- 三つの場合の主張の証明が共通に置く準備（イ）：P_{≤m} = P' ·_A x と x ·_A P' = P' ·_A x
（P' := P_{≤m-1}、x := x_m。本文の m を Lean では m + 1 と書く）。 -/
theorem vacuumFactor_commute_initialVacuumPart (hneg : ∀ a : K, a + -a = 0) {m : ℕ} (hm : m + 1 ≤ D.M) :
    ((D.space C).cliffordAlgebra C).mul ((D.vacuumFactor C) (m + 1)) (D.initialVacuumPart C m)
      = ((D.space C).cliffordAlgebra C).mul (D.initialVacuumPart C m) ((D.vacuumFactor C) (m + 1)) := by
  apply commute_orderedProduct ((D.space C).cliffordAlgebra C) ((D.vacuumFactor C) (m + 1)) m (D.vacuumFactor C)
  intro j hj1 hjm
  exact D.vacuumFactor_commute C hneg ⟨Nat.succ_pos m, hm⟩ ⟨hj1, by omega⟩ (by omega)

/-- 三つの場合の主張の証明が共通に置く準備（ハ）：a_{T,≤m} ·_A a†_{U,≤m} = z ·_A (G ·_A y)
（z := z^T_m、y := y^U_m、G := a_{T,≤m-1} ·_A a†_{U,≤m-1}。本文の m を Lean では m + 1 と書く）。 -/
theorem initialParts_mul_succ (T U : PowerSet D.M) (m : ℕ) :
    ((D.space C).cliffordAlgebra C).mul (D.initialReverseAnnihilationProduct C T (m + 1)) (D.initialCreationProduct C U (m + 1))
      = ((D.space C).cliffordAlgebra C).mul (D.selectedAnnihilationFactor C T (m + 1))
          (((D.space C).cliffordAlgebra C).mul
            (((D.space C).cliffordAlgebra C).mul (D.initialReverseAnnihilationProduct C T m) (D.initialCreationProduct C U m))
            (D.selectedCreationFactor C U (m + 1))) := by
  let A := ((D.space C).cliffordAlgebra C)
  let z := D.selectedAnnihilationFactor C T (m + 1)
  let y := D.selectedCreationFactor C U (m + 1)
  let α := D.initialReverseAnnihilationProduct C T m
  let κ := D.initialCreationProduct C U m
  calc A.mul (D.initialReverseAnnihilationProduct C T (m + 1)) (D.initialCreationProduct C U (m + 1))
      = A.mul (A.mul z α) (D.initialCreationProduct C U (m + 1)) := by
        rw [D.initialReverseAnnihilationProduct_succ C T m]
    _ = A.mul (A.mul z α) (A.mul κ y) := by rw [D.initialCreationProduct_succ C U m]
    _ = A.mul z (A.mul α (A.mul κ y)) := A.mul_assoc _ _ _
    _ = A.mul z (A.mul (A.mul α κ) y) := by rw [A.mul_assoc α κ y]

/-- 本文 `claim_vacuum_sandwich_vanishes_when_last_number_is_in_exactly_one_subset` の必要十分版：
m がちょうど一方に入るなら Q^{T,U}_m = 0_A（本文の m を Lean では m + 1 と書く）。 -/
theorem vacuumSandwich_succ_of_exactlyOne (hneg : ∀ a : K, a + -a = 0) (T U : PowerSet D.M) {m : ℕ} (hm : m + 1 ≤ D.M)
    (h : (m + 1 ∈ T.1 ∧ m + 1 ∉ U.1) ∨ (m + 1 ∉ T.1 ∧ m + 1 ∈ U.1)) :
    D.vacuumSandwich C T U (m + 1) = ((D.space C).cliffordAlgebra C).zero := by
  let A := ((D.space C).cliffordAlgebra C)
  let x := (D.vacuumFactor C) (m + 1)
  let P' := D.initialVacuumPart C m
  let G := A.mul (D.initialReverseAnnihilationProduct C T m) (D.initialCreationProduct C U m)
  let am := D.annihilation C (m + 1)
  let cm := D.creation C (m + 1)
  -- （イ）
  have hP : D.initialVacuumPart C (m + 1) = A.mul P' x := D.initialVacuumPart_succ C m
  have hxP : A.mul x P' = A.mul P' x := D.vacuumFactor_commute_initialVacuumPart C hneg hm
  -- （ロ）
  have hxG : A.mul x G = A.mul G x := D.vacuumFactor_commute_initialParts C hneg T U hm
  -- （ハ）
  have hzy := D.initialParts_mul_succ C T U m
  rcases h with ⟨hT, hU⟩ | ⟨hT, hU⟩
  · -- m ∈ T かつ m ∉ U：z = a_m、y = 1_A
    have hprod : A.mul (D.initialReverseAnnihilationProduct C T (m + 1)) (D.initialCreationProduct C U (m + 1))
        = A.mul am G := by
      rw [hzy, D.selectedAnnihilationFactor_of_mem C hT, D.selectedCreationFactor_of_not_mem C hU, A.mul_one G]
    have hax : A.mul am x = A.zero := calc
      A.mul am x = A.mul am (A.mul am cm) := rfl
      _ = A.mul (A.mul am am) cm := (A.mul_assoc _ _ _).symm
      _ = A.mul A.zero cm := by rw [D.annihilation_mul_self C hneg (m + 1)]
      _ = A.zero := zero_mul_eq_zero C.congruence.zero_add_zero A cm
    calc D.vacuumSandwich C T U (m + 1)
        = A.mul (A.mul (D.initialVacuumPart C (m + 1)) (A.mul am G)) (D.initialVacuumPart C (m + 1)) := by
          rw [vacuumSandwich, hprod]
      _ = A.mul (A.mul (A.mul P' x) (A.mul am G)) (A.mul P' x) := by rw [hP]
      _ = A.mul (A.mul P' (A.mul x (A.mul am G))) (A.mul P' x) := by rw [A.mul_assoc P' x (A.mul am G)]
      _ = A.mul (A.mul P' (A.mul (A.mul x am) G)) (A.mul P' x) := by rw [A.mul_assoc x am G]
      _ = A.mul (A.mul P' (A.mul am G)) (A.mul P' x) := by
          rw [D.vacuumFactor_mul_annihilation C hneg ⟨Nat.succ_pos m, hm⟩]
      _ = A.mul P' (A.mul (A.mul am G) (A.mul P' x)) := A.mul_assoc _ _ _
      _ = A.mul P' (A.mul (A.mul am G) (A.mul x P')) := by rw [hxP]
      _ = A.mul P' (A.mul am (A.mul G (A.mul x P'))) := by rw [A.mul_assoc am G (A.mul x P')]
      _ = A.mul P' (A.mul am (A.mul (A.mul G x) P')) := by rw [A.mul_assoc G x P']
      _ = A.mul P' (A.mul am (A.mul (A.mul x G) P')) := by rw [hxG]
      _ = A.mul P' (A.mul am (A.mul x (A.mul G P'))) := by rw [A.mul_assoc x G P']
      _ = A.mul P' (A.mul (A.mul am x) (A.mul G P')) := by rw [A.mul_assoc am x (A.mul G P')]
      _ = A.mul P' (A.mul A.zero (A.mul G P')) := by rw [hax]
      _ = A.mul P' A.zero := by rw [zero_mul_eq_zero C.congruence.zero_add_zero A (A.mul G P')]
      _ = A.zero := mul_zero_eq_zero C.congruence.zero_add_zero A P'
  · -- m ∉ T かつ m ∈ U：z = 1_A、y = a†_m
    have hprod : A.mul (D.initialReverseAnnihilationProduct C T (m + 1)) (D.initialCreationProduct C U (m + 1))
        = A.mul G cm := by
      rw [hzy, D.selectedAnnihilationFactor_of_not_mem C hT, D.selectedCreationFactor_of_mem C hU, A.one_mul]
    have hxc : A.mul x cm = A.zero := calc
      A.mul x cm = A.mul (A.mul am cm) cm := rfl
      _ = A.mul am (A.mul cm cm) := A.mul_assoc _ _ _
      _ = A.mul am A.zero := by rw [D.creation_mul_self C hneg (m + 1)]
      _ = A.zero := mul_zero_eq_zero C.congruence.zero_add_zero A am
    calc D.vacuumSandwich C T U (m + 1)
        = A.mul (A.mul (D.initialVacuumPart C (m + 1)) (A.mul G cm)) (D.initialVacuumPart C (m + 1)) := by
          rw [vacuumSandwich, hprod]
      _ = A.mul (A.mul (A.mul P' x) (A.mul G cm)) (A.mul P' x) := by rw [hP]
      _ = A.mul (A.mul P' (A.mul x (A.mul G cm))) (A.mul P' x) := by rw [A.mul_assoc P' x (A.mul G cm)]
      _ = A.mul (A.mul P' (A.mul (A.mul x G) cm)) (A.mul P' x) := by rw [A.mul_assoc x G cm]
      _ = A.mul (A.mul P' (A.mul (A.mul G x) cm)) (A.mul P' x) := by rw [hxG]
      _ = A.mul (A.mul P' (A.mul G (A.mul x cm))) (A.mul P' x) := by rw [A.mul_assoc G x cm]
      _ = A.mul (A.mul P' (A.mul G A.zero)) (A.mul P' x) := by rw [hxc]
      _ = A.mul (A.mul P' A.zero) (A.mul P' x) := by rw [mul_zero_eq_zero C.congruence.zero_add_zero A G]
      _ = A.mul A.zero (A.mul P' x) := by rw [mul_zero_eq_zero C.congruence.zero_add_zero A P']
      _ = A.zero := zero_mul_eq_zero C.congruence.zero_add_zero A _

/-- 本文 `claim_vacuum_sandwich_when_last_number_is_in_neither_subset` の必要十分版：
m ∉ T かつ m ∉ U なら Q^{T,U}_m = Q^{T,U}_{m-1} ·_A x_m（本文の m を Lean では m + 1 と書く）。 -/
theorem vacuumSandwich_succ_of_neither (hneg : ∀ a : K, a + -a = 0) (T U : PowerSet D.M) {m : ℕ} (hm : m + 1 ≤ D.M)
    (hT : m + 1 ∉ T.1) (hU : m + 1 ∉ U.1) :
    D.vacuumSandwich C T U (m + 1) = ((D.space C).cliffordAlgebra C).mul (D.vacuumSandwich C T U m) ((D.vacuumFactor C) (m + 1)) := by
  let A := ((D.space C).cliffordAlgebra C)
  let x := (D.vacuumFactor C) (m + 1)
  let P' := D.initialVacuumPart C m
  let G := A.mul (D.initialReverseAnnihilationProduct C T m) (D.initialCreationProduct C U m)
  have hP : D.initialVacuumPart C (m + 1) = A.mul P' x := D.initialVacuumPart_succ C m
  have hxP : A.mul x P' = A.mul P' x := D.vacuumFactor_commute_initialVacuumPart C hneg hm
  have hxG : A.mul x G = A.mul G x := D.vacuumFactor_commute_initialParts C hneg T U hm
  -- z = 1_A、y = 1_A
  have hprod : A.mul (D.initialReverseAnnihilationProduct C T (m + 1)) (D.initialCreationProduct C U (m + 1)) = G := by
    rw [D.initialParts_mul_succ C T U m, D.selectedAnnihilationFactor_of_not_mem C hT,
      D.selectedCreationFactor_of_not_mem C hU, A.one_mul, A.mul_one G]
  calc D.vacuumSandwich C T U (m + 1)
      = A.mul (A.mul (D.initialVacuumPart C (m + 1)) G) (D.initialVacuumPart C (m + 1)) := by
        rw [vacuumSandwich, hprod]
    _ = A.mul (A.mul (A.mul P' x) G) (A.mul P' x) := by rw [hP]
    _ = A.mul (A.mul P' (A.mul x G)) (A.mul P' x) := by rw [A.mul_assoc P' x G]
    _ = A.mul (A.mul P' (A.mul G x)) (A.mul P' x) := by rw [hxG]
    _ = A.mul (A.mul (A.mul P' G) x) (A.mul P' x) := by rw [A.mul_assoc P' G x]
    _ = A.mul (A.mul (A.mul P' G) x) (A.mul x P') := by rw [hxP]
    _ = A.mul (A.mul P' G) (A.mul x (A.mul x P')) := A.mul_assoc _ _ _
    _ = A.mul (A.mul P' G) (A.mul (A.mul x x) P') := by rw [A.mul_assoc x x P']
    _ = A.mul (A.mul P' G) (A.mul x P') := by rw [D.vacuumFactor_mul_self C hneg ⟨Nat.succ_pos m, hm⟩]
    _ = A.mul (A.mul P' G) (A.mul P' x) := by rw [hxP]
    _ = A.mul (A.mul (A.mul P' G) P') x := (A.mul_assoc _ _ _).symm
    _ = A.mul (D.vacuumSandwich C T U m) ((D.vacuumFactor C) (m + 1)) := rfl

/-- 本文 `claim_vacuum_sandwich_when_last_number_is_in_both_subsets` の必要十分版：
m ∈ T かつ m ∈ U なら Q^{T,U}_m = a_m ·_A (Q^{T,U}_{m-1} ·_A a†_m)（本文の m を Lean では m + 1 と書く）。 -/
theorem vacuumSandwich_succ_of_both (hneg : ∀ a : K, a + -a = 0) (T U : PowerSet D.M) {m : ℕ} (hm : m + 1 ≤ D.M)
    (hT : m + 1 ∈ T.1) (hU : m + 1 ∈ U.1) :
    D.vacuumSandwich C T U (m + 1)
      = ((D.space C).cliffordAlgebra C).mul (D.annihilation C (m + 1))
          (((D.space C).cliffordAlgebra C).mul (D.vacuumSandwich C T U m) (D.creation C (m + 1))) := by
  let A := ((D.space C).cliffordAlgebra C)
  let x := (D.vacuumFactor C) (m + 1)
  let P' := D.initialVacuumPart C m
  let G := A.mul (D.initialReverseAnnihilationProduct C T m) (D.initialCreationProduct C U m)
  let am := D.annihilation C (m + 1)
  let cm := D.creation C (m + 1)
  have hmM : 1 ≤ m + 1 ∧ m + 1 ≤ D.M := ⟨Nat.succ_pos m, hm⟩
  -- （イ）
  have hP : D.initialVacuumPart C (m + 1) = A.mul P' x := D.initialVacuumPart_succ C m
  -- （ロ）a_m P' = P' a_m、a†_m P' = P' a†_m
  have haP : A.mul am P' = A.mul P' am := by
    apply commute_orderedProduct A am m (D.vacuumFactor C)
    intro j hj1 hjm
    exact D.annihilation_commute_vacuumFactor C hneg hmM ⟨hj1, by omega⟩ (by omega)
  have hcP : A.mul cm P' = A.mul P' cm := by
    apply commute_orderedProduct A cm m (D.vacuumFactor C)
    intro j hj1 hjm
    exact D.creation_commute_vacuumFactor C hneg hmM ⟨hj1, by omega⟩ (by omega)
  -- （ハ）z = a_m、y = a†_m
  have hprod : A.mul (D.initialReverseAnnihilationProduct C T (m + 1)) (D.initialCreationProduct C U (m + 1))
      = A.mul am (A.mul G cm) := by
    rw [D.initialParts_mul_succ C T U m, D.selectedAnnihilationFactor_of_mem C hT, D.selectedCreationFactor_of_mem C hU]
  calc D.vacuumSandwich C T U (m + 1)
      = A.mul (A.mul (D.initialVacuumPart C (m + 1)) (A.mul am (A.mul G cm))) (D.initialVacuumPart C (m + 1)) := by
        rw [vacuumSandwich, hprod]
    _ = A.mul (A.mul (A.mul P' x) (A.mul am (A.mul G cm))) (A.mul P' x) := by rw [hP]
    _ = A.mul (A.mul P' (A.mul x (A.mul am (A.mul G cm)))) (A.mul P' x) := by
        rw [A.mul_assoc P' x (A.mul am (A.mul G cm))]
    _ = A.mul (A.mul P' (A.mul (A.mul x am) (A.mul G cm))) (A.mul P' x) := by
        rw [A.mul_assoc x am (A.mul G cm)]
    _ = A.mul (A.mul P' (A.mul am (A.mul G cm))) (A.mul P' x) := by rw [D.vacuumFactor_mul_annihilation C hneg hmM]
    _ = A.mul (A.mul (A.mul P' am) (A.mul G cm)) (A.mul P' x) := by rw [A.mul_assoc P' am (A.mul G cm)]
    _ = A.mul (A.mul (A.mul am P') (A.mul G cm)) (A.mul P' x) := by rw [haP]
    _ = A.mul (A.mul am (A.mul P' (A.mul G cm))) (A.mul P' x) := by rw [A.mul_assoc am P' (A.mul G cm)]
    _ = A.mul am (A.mul (A.mul P' (A.mul G cm)) (A.mul P' x)) := A.mul_assoc _ _ _
    _ = A.mul am (A.mul (A.mul (A.mul P' G) cm) (A.mul P' x)) := by rw [A.mul_assoc P' G cm]
    _ = A.mul am (A.mul (A.mul P' G) (A.mul cm (A.mul P' x))) := by rw [A.mul_assoc (A.mul P' G) cm (A.mul P' x)]
    _ = A.mul am (A.mul (A.mul P' G) (A.mul (A.mul cm P') x)) := by rw [A.mul_assoc cm P' x]
    _ = A.mul am (A.mul (A.mul P' G) (A.mul (A.mul P' cm) x)) := by rw [hcP]
    _ = A.mul am (A.mul (A.mul P' G) (A.mul P' (A.mul cm x))) := by rw [A.mul_assoc P' cm x]
    _ = A.mul am (A.mul (A.mul P' G) (A.mul P' cm)) := by rw [D.creation_mul_vacuumFactor C hneg hmM]
    _ = A.mul am (A.mul (A.mul (A.mul P' G) P') cm) := by rw [A.mul_assoc (A.mul P' G) P' cm]
    _ = A.mul am (A.mul (D.vacuumSandwich C T U m) cm) := rfl

/-- 本文 `claim_vacuum_sandwich_of_agreeing_initial_parts_is_initial_vacuum_part` の必要十分版：
すべての t ∈ {1,…,m} で t ∈ T ⟺ t ∈ U なら Q^{T,U}_m = P_{≤m}（m ∈ {0,…,M}）。 -/
theorem vacuumSandwich_of_agree (hneg : ∀ a : K, a + -a = 0) (T U : PowerSet D.M) :
    ∀ m : ℕ, m ≤ D.M → (∀ t : ℕ, 1 ≤ t → t ≤ m → (t ∈ T.1 ↔ t ∈ U.1)) →
      D.vacuumSandwich C T U m = D.initialVacuumPart C m := by
  let A := ((D.space C).cliffordAlgebra C)
  intro m
  induction m with
  | zero =>
    intro _ _
    -- a_{T,≤0} = 1_A、a†_{U,≤0} = 1_A、P_{≤0} = 1_A（空の番号順の積）
    have ha : D.initialReverseAnnihilationProduct C T 0 = A.one := rfl
    have hc : D.initialCreationProduct C U 0 = A.one := rfl
    have hP : D.initialVacuumPart C 0 = A.one := rfl
    calc D.vacuumSandwich C T U 0
        = A.mul (A.mul (D.initialVacuumPart C 0)
            (A.mul (D.initialReverseAnnihilationProduct C T 0) (D.initialCreationProduct C U 0)))
            (D.initialVacuumPart C 0) := rfl
      _ = A.mul (A.mul A.one (A.mul A.one A.one)) A.one := by rw [ha, hc, hP]
      _ = A.mul (A.mul A.one A.one) A.one := by rw [A.one_mul (A.mul A.one A.one)]
      _ = A.mul A.one A.one := congrArg (fun t => A.mul t A.one) (A.one_mul A.one)
      _ = A.one := A.one_mul A.one
      _ = D.initialVacuumPart C 0 := hP.symm
  | succ m ih =>
    intro hm hagree
    let P' := D.initialVacuumPart C m
    let x := (D.vacuumFactor C) (m + 1)
    have hmM : 1 ≤ m + 1 ∧ m + 1 ≤ D.M := ⟨Nat.succ_pos m, hm⟩
    have hih : D.vacuumSandwich C T U m = P' :=
      ih (by omega) fun t ht1 htm => hagree t ht1 (by omega)
    have hP : D.initialVacuumPart C (m + 1) = A.mul P' x := D.initialVacuumPart_succ C m
    by_cases hT : m + 1 ∈ T.1
    · -- m ∈ T かつ m ∈ U
      have hU : m + 1 ∈ U.1 := (hagree (m + 1) hmM.1 le_rfl).1 hT
      have hcP : A.mul (D.creation C (m + 1)) P' = A.mul P' (D.creation C (m + 1)) := by
        apply commute_orderedProduct A (D.creation C (m + 1)) m (D.vacuumFactor C)
        intro j hj1 hjm
        exact D.creation_commute_vacuumFactor C hneg hmM ⟨hj1, by omega⟩ (by omega)
      have hxP : A.mul x P' = A.mul P' x := D.vacuumFactor_commute_initialVacuumPart C hneg hm
      calc D.vacuumSandwich C T U (m + 1)
          = A.mul (D.annihilation C (m + 1)) (A.mul (D.vacuumSandwich C T U m) (D.creation C (m + 1))) :=
            D.vacuumSandwich_succ_of_both C hneg T U hm hT hU
        _ = A.mul (D.annihilation C (m + 1)) (A.mul P' (D.creation C (m + 1))) := by rw [hih]
        _ = A.mul (D.annihilation C (m + 1)) (A.mul (D.creation C (m + 1)) P') := by rw [hcP]
        _ = A.mul (A.mul (D.annihilation C (m + 1)) (D.creation C (m + 1))) P' := (A.mul_assoc _ _ _).symm
        _ = A.mul x P' := rfl
        _ = A.mul P' x := hxP
        _ = D.initialVacuumPart C (m + 1) := hP.symm
    · -- m ∉ T かつ m ∉ U
      have hU : m + 1 ∉ U.1 := fun h => hT ((hagree (m + 1) hmM.1 le_rfl).2 h)
      calc D.vacuumSandwich C T U (m + 1)
          = A.mul (D.vacuumSandwich C T U m) x := D.vacuumSandwich_succ_of_neither C hneg T U hm hT hU
        _ = A.mul P' x := by rw [hih]
        _ = D.initialVacuumPart C (m + 1) := hP.symm

/-- 本文 `claim_vacuum_sandwich_of_disagreeing_initial_parts_is_zero` の必要十分版：
「t ∈ T かつ t ∉ U」か「t ∉ T かつ t ∈ U」を満たす t ∈ {1,…,m} があれば Q^{T,U}_m = 0_A（m ∈ {0,…,M}）。 -/
theorem vacuumSandwich_of_disagree (hneg : ∀ a : K, a + -a = 0) (T U : PowerSet D.M) :
    ∀ m : ℕ, m ≤ D.M → (∃ t : ℕ, 1 ≤ t ∧ t ≤ m ∧ ((t ∈ T.1 ∧ t ∉ U.1) ∨ (t ∉ T.1 ∧ t ∈ U.1))) →
      D.vacuumSandwich C T U m = ((D.space C).cliffordAlgebra C).zero := by
  let A := ((D.space C).cliffordAlgebra C)
  intro m
  induction m with
  | zero =>
    -- {1,…,0} は空集合なので、条件を満たす t は無い
    intro _ ⟨t, ht1, ht0, _⟩
    omega
  | succ m ih =>
    intro hm ⟨t, ht1, htm, ht⟩
    by_cases htm' : t = m + 1
    · -- t = m
      rw [htm'] at ht
      exact D.vacuumSandwich_succ_of_exactlyOne C hneg T U hm ht
    · -- t ≠ m：帰納法の仮定により Q^{T,U}_{m-1} = 0_A
      have hih : D.vacuumSandwich C T U m = A.zero := ih (by omega) ⟨t, ht1, by omega, ht⟩
      by_cases hT : m + 1 ∈ T.1 <;> by_cases hU : m + 1 ∈ U.1
      · -- 両方に入る
        calc D.vacuumSandwich C T U (m + 1)
            = A.mul (D.annihilation C (m + 1)) (A.mul (D.vacuumSandwich C T U m) (D.creation C (m + 1))) :=
              D.vacuumSandwich_succ_of_both C hneg T U hm hT hU
          _ = A.mul (D.annihilation C (m + 1)) (A.mul A.zero (D.creation C (m + 1))) := by rw [hih]
          _ = A.mul (D.annihilation C (m + 1)) A.zero := by rw [zero_mul_eq_zero C.congruence.zero_add_zero A (D.creation C (m + 1))]
          _ = A.zero := mul_zero_eq_zero C.congruence.zero_add_zero A _
      · -- ちょうど一方に入る
        exact D.vacuumSandwich_succ_of_exactlyOne C hneg T U hm (Or.inl ⟨hT, hU⟩)
      · exact D.vacuumSandwich_succ_of_exactlyOne C hneg T U hm (Or.inr ⟨hT, hU⟩)
      · -- どちらにも入らない
        calc D.vacuumSandwich C T U (m + 1)
            = A.mul (D.vacuumSandwich C T U m) ((D.vacuumFactor C) (m + 1)) :=
              D.vacuumSandwich_succ_of_neither C hneg T U hm hT hU
          _ = A.mul A.zero ((D.vacuumFactor C) (m + 1)) := by rw [hih]
          _ = A.zero := zero_mul_eq_zero C.congruence.zero_add_zero A _

open Classical in
/-- 本文 `claim_vacuum_element_sandwich_of_annihilation_and_creation_products` の必要十分版：
(P ·_A (a_T ·_A a†_U)) ·_A P = δ_{T,U} ∗_A P。 -/
theorem vacuumElement_sandwich (hneg : ∀ a : K, a + -a = 0) (T U : PowerSet D.M) :
    ((D.space C).cliffordAlgebra C).mul
        (((D.space C).cliffordAlgebra C).mul (D.vacuumElement C)
          (((D.space C).cliffordAlgebra C).mul (D.reverseOrderedAnnihilationProduct C T) (D.orderedCreationProduct C U)))
        (D.vacuumElement C)
      = ((D.space C).cliffordAlgebra C).smul (kroneckerDelta T U) (D.vacuumElement C) := by
  let A := ((D.space C).cliffordAlgebra C)
  by_cases hTU : T = U
  · -- T = U：すべての t で t ∈ T ⟺ t ∈ U
    have hagree : ∀ t : ℕ, 1 ≤ t → t ≤ D.M → (t ∈ T.1 ↔ t ∈ U.1) := fun t _ _ => by rw [hTU]
    calc A.mul (A.mul (D.vacuumElement C)
          (A.mul (D.reverseOrderedAnnihilationProduct C T) (D.orderedCreationProduct C U))) (D.vacuumElement C)
        = D.vacuumSandwich C T U D.M := (D.vacuumSandwich_last C T U).symm
      _ = D.initialVacuumPart C D.M := D.vacuumSandwich_of_agree C hneg T U D.M le_rfl hagree
      _ = (D.vacuumElement C) := D.initialVacuumPart_last C
      _ = A.smul 1 (D.vacuumElement C) := (A.one_smul _).symm
      _ = A.smul (kroneckerDelta T U) (D.vacuumElement C) := by rw [kroneckerDelta, if_pos hTU]
  · -- T ≠ U：t ∈ T と t ∈ U が同値でない t ∈ {1,…,M} がある（集合の等しさの対偶）
    have hdis : ∃ t : ℕ, 1 ≤ t ∧ t ≤ D.M ∧ ((t ∈ T.1 ∧ t ∉ U.1) ∨ (t ∉ T.1 ∧ t ∈ U.1)) := by
      by_contra hno
      apply hTU
      apply PowerSet.ext
      intro t ht1 htM
      constructor
      · intro hT
        by_contra hU
        exact hno ⟨t, ht1, htM, Or.inl ⟨hT, hU⟩⟩
      · intro hU
        by_contra hT
        exact hno ⟨t, ht1, htM, Or.inr ⟨hT, hU⟩⟩
    calc A.mul (A.mul (D.vacuumElement C)
          (A.mul (D.reverseOrderedAnnihilationProduct C T) (D.orderedCreationProduct C U))) (D.vacuumElement C)
        = D.vacuumSandwich C T U D.M := (D.vacuumSandwich_last C T U).symm
      _ = A.zero := D.vacuumSandwich_of_disagree C hneg T U D.M le_rfl hdis
      _ = A.smul 0 (D.vacuumElement C) := (AlgebraOver.zero_smul_eq_zero A C.congruence.zero_add_zero _).symm
      _ = A.smul (kroneckerDelta T U) (D.vacuumElement C) := by rw [kroneckerDelta, if_neg hTU]

/-! ### 1 の分解 -/

open Classical in
/-- 本文 `def_selected_number_factor_of_split_clifford_algebra` の必要十分版：u^S_i := a†_i ·_A a_i（i ∈ S）、a_i ·_A a†_i（i ∉ S）。 -/
def selectedNumberFactor (S : PowerSet D.M) (i : ℕ) : (D.space C).Cl C :=
  if i ∈ S.1 then ((D.space C).cliffordAlgebra C).mul (D.creation C i) (D.annihilation C i)
  else ((D.space C).cliffordAlgebra C).mul (D.annihilation C i) (D.creation C i)

/-- 本文 `claim_creation_vacuum_annihilation_factor_of_one_number` の必要十分版：(y^S_i ·_A x_i) ·_A z^S_i = u^S_i。 -/
theorem creation_vacuum_annihilation_factor (hneg : ∀ a : K, a + -a = 0) (S : PowerSet D.M) {i : ℕ} (hi : 1 ≤ i ∧ i ≤ D.M) :
    ((D.space C).cliffordAlgebra C).mul
        (((D.space C).cliffordAlgebra C).mul (D.selectedCreationFactor C S i) (D.vacuumFactor C i))
        (D.selectedAnnihilationFactor C S i)
      = D.selectedNumberFactor C S i := by
  let A := ((D.space C).cliffordAlgebra C)
  by_cases hiS : i ∈ S.1
  · -- i ∈ S：y^S_i = a†_i、z^S_i = a_i
    calc A.mul (A.mul (D.selectedCreationFactor C S i) (D.vacuumFactor C i)) (D.selectedAnnihilationFactor C S i)
        = A.mul (A.mul (D.creation C i) (D.vacuumFactor C i)) (D.annihilation C i) := by
          rw [D.selectedCreationFactor_of_mem C hiS, D.selectedAnnihilationFactor_of_mem C hiS]
      _ = A.mul (D.creation C i) (D.annihilation C i) := by rw [D.creation_mul_vacuumFactor C hneg hi]
      _ = D.selectedNumberFactor C S i := (if_pos hiS).symm
  · -- i ∉ S：y^S_i = z^S_i = 1_A
    calc A.mul (A.mul (D.selectedCreationFactor C S i) (D.vacuumFactor C i)) (D.selectedAnnihilationFactor C S i)
        = A.mul (A.mul A.one (D.vacuumFactor C i)) A.one := by
          rw [D.selectedCreationFactor_of_not_mem C hiS, D.selectedAnnihilationFactor_of_not_mem C hiS]
      _ = A.mul (D.vacuumFactor C i) A.one := by rw [A.one_mul (D.vacuumFactor C i)]
      _ = D.vacuumFactor C i := A.mul_one _
      _ = A.mul (D.annihilation C i) (D.creation C i) := rfl
      _ = D.selectedNumberFactor C S i := (if_neg hiS).symm

/-- 本文 `claim_initial_parts_of_creation_vacuum_annihilation_product_is_product_of_number_factors` の必要十分版：
(a†_{S,≤m} ·_A P_{≤m}) ·_A a_{S,≤m} = ∏_{A,i=1}^{m} u^S_i（m ∈ {0,…,M}）。 -/
theorem initialParts_product_eq_orderedProduct (hneg : ∀ a : K, a + -a = 0) (S : PowerSet D.M) :
    ∀ m : ℕ, m ≤ D.M →
      ((D.space C).cliffordAlgebra C).mul
          (((D.space C).cliffordAlgebra C).mul (D.initialCreationProduct C S m) (D.initialVacuumPart C m))
          (D.initialReverseAnnihilationProduct C S m)
        = AlgebraOver.orderedProduct ((D.space C).cliffordAlgebra C) m (D.selectedNumberFactor C S) := by
  let A := ((D.space C).cliffordAlgebra C)
  intro m
  induction m with
  | zero =>
    intro _
    have hc : D.initialCreationProduct C S 0 = A.one := rfl
    have hP : D.initialVacuumPart C 0 = A.one := rfl
    have ha : D.initialReverseAnnihilationProduct C S 0 = A.one := rfl
    calc A.mul (A.mul (D.initialCreationProduct C S 0) (D.initialVacuumPart C 0)) (D.initialReverseAnnihilationProduct C S 0)
        = A.mul (A.mul A.one A.one) A.one := by rw [hc, hP, ha]
      _ = A.mul A.one A.one := congrArg (fun t => A.mul t A.one) (A.one_mul A.one)
      _ = A.one := A.one_mul A.one
      _ = AlgebraOver.orderedProduct A 0 (D.selectedNumberFactor C S) := rfl
  | succ m ih =>
    intro hm
    let κ := D.initialCreationProduct C S m
    let P' := D.initialVacuumPart C m
    let α := D.initialReverseAnnihilationProduct C S m
    let x := (D.vacuumFactor C) (m + 1)
    let y := D.selectedCreationFactor C S (m + 1)
    let z := D.selectedAnnihilationFactor C S (m + 1)
    let u := D.selectedNumberFactor C S (m + 1)
    have hmM : 1 ≤ m + 1 ∧ m + 1 ≤ D.M := ⟨Nat.succ_pos m, hm⟩
    -- （イ）y ·_A P' = P' ·_A y
    have hyP : A.mul y P' = A.mul P' y := by
      apply commute_orderedProduct A y m (D.vacuumFactor C)
      intro j hj1 hjm
      show A.mul (D.selectedCreationFactor C S (m + 1)) (D.vacuumFactor C j)
        = A.mul (D.vacuumFactor C j) (D.selectedCreationFactor C S (m + 1))
      by_cases hmS : m + 1 ∈ S.1
      · rw [D.selectedCreationFactor_of_mem C hmS]
        exact D.creation_commute_vacuumFactor C hneg hmM ⟨hj1, by omega⟩ (by omega)
      · rw [D.selectedCreationFactor_of_not_mem C hmS, A.one_mul, A.mul_one]
    -- （ロ）u ·_A α = α ·_A u
    have huα : A.mul u α = A.mul α u := by
      apply commute_orderedProduct A u m (fun k => D.selectedAnnihilationFactor C S (m + 1 - k))
      intro k hk1 hkm
      show A.mul u (D.selectedAnnihilationFactor C S (m + 1 - k)) = A.mul (D.selectedAnnihilationFactor C S (m + 1 - k)) u
      have ht : 1 ≤ m + 1 - k ∧ m + 1 - k ≤ D.M := ⟨by omega, by omega⟩
      have htm : m + 1 - k ≠ m + 1 := by omega
      by_cases htS : m + 1 - k ∈ S.1
      · rw [D.selectedAnnihilationFactor_of_mem C htS]
        by_cases hmS : m + 1 ∈ S.1
        · rw [show u = A.mul (D.creation C (m + 1)) (D.annihilation C (m + 1)) from if_pos hmS]
          exact (D.annihilation_commute_reversedPair C hneg ht hmM htm).symm
        · rw [show u = A.mul (D.annihilation C (m + 1)) (D.creation C (m + 1)) from if_neg hmS]
          exact (D.annihilation_commute_vacuumFactor C hneg ht hmM htm).symm
      · rw [D.selectedAnnihilationFactor_of_not_mem C htS, A.mul_one, A.one_mul]
    calc A.mul (A.mul (D.initialCreationProduct C S (m + 1)) (D.initialVacuumPart C (m + 1)))
          (D.initialReverseAnnihilationProduct C S (m + 1))
        = A.mul (A.mul (A.mul κ y) (D.initialVacuumPart C (m + 1))) (D.initialReverseAnnihilationProduct C S (m + 1)) := by
          rw [D.initialCreationProduct_succ C S m]
      _ = A.mul (A.mul (A.mul κ y) (A.mul P' x)) (D.initialReverseAnnihilationProduct C S (m + 1)) := by
          rw [D.initialVacuumPart_succ C m]
      _ = A.mul (A.mul (A.mul κ y) (A.mul P' x)) (A.mul z α) := by
          rw [D.initialReverseAnnihilationProduct_succ C S m]
      _ = A.mul (A.mul κ (A.mul y (A.mul P' x))) (A.mul z α) := by rw [A.mul_assoc κ y (A.mul P' x)]
      _ = A.mul (A.mul κ (A.mul (A.mul y P') x)) (A.mul z α) := by rw [A.mul_assoc y P' x]
      _ = A.mul (A.mul κ (A.mul (A.mul P' y) x)) (A.mul z α) := by rw [hyP]
      _ = A.mul (A.mul κ (A.mul P' (A.mul y x))) (A.mul z α) := by rw [A.mul_assoc P' y x]
      _ = A.mul (A.mul (A.mul κ P') (A.mul y x)) (A.mul z α) := by rw [A.mul_assoc κ P' (A.mul y x)]
      _ = A.mul (A.mul κ P') (A.mul (A.mul y x) (A.mul z α)) := A.mul_assoc _ _ _
      _ = A.mul (A.mul κ P') (A.mul (A.mul (A.mul y x) z) α) := by rw [A.mul_assoc (A.mul y x) z α]
      _ = A.mul (A.mul κ P') (A.mul u α) := by rw [D.creation_vacuum_annihilation_factor C hneg S hmM]
      _ = A.mul (A.mul κ P') (A.mul α u) := by rw [huα]
      _ = A.mul (A.mul (A.mul κ P') α) u := (A.mul_assoc _ _ _).symm
      _ = A.mul (AlgebraOver.orderedProduct A m (D.selectedNumberFactor C S)) u := by rw [ih (by omega)]
      _ = AlgebraOver.orderedProduct A (m + 1) (D.selectedNumberFactor C S) := rfl

/-- 本文 `claim_decomposition_of_unity_in_split_clifford_algebra` の必要十分版：
Σ_{S∈P_M} 1_ℂ ∗_A ((a†_S ·_A P) ·_A a_S) = 1_A。 -/
theorem decomposition_of_unity (hneg : ∀ a : K, a + -a = 0) :
    sumOverFiniteSet ((D.space C).cliffordAlgebra C).toVectorSpace (isFiniteSet_powerSet D.M) (fun _ => 1)
        (fun S => ((D.space C).cliffordAlgebra C).mul
          (((D.space C).cliffordAlgebra C).mul (D.orderedCreationProduct C S) (D.vacuumElement C))
          (D.reverseOrderedAnnihilationProduct C S))
      = ((D.space C).cliffordAlgebra C).one := by
  let A := ((D.space C).cliffordAlgebra C)
  let SV := A.toVectorSpace
  let g : ℕ → (D.space C).Cl C := fun i => A.mul (D.creation C i) (D.annihilation C i)
  let h : ℕ → (D.space C).Cl C := fun i => A.mul (D.annihilation C i) (D.creation C i)
  let Fu : PowerSet D.M → (D.space C).Cl C := fun S => AlgebraOver.orderedProduct A D.M (D.selectedNumberFactor C S)
  -- （イ）(a†_S P) a_S = ∏ u^S_i
  have hI : ∀ S : PowerSet D.M,
      A.mul (A.mul (D.orderedCreationProduct C S) (D.vacuumElement C)) (D.reverseOrderedAnnihilationProduct C S) = Fu S := by
    intro S
    calc A.mul (A.mul (D.orderedCreationProduct C S) (D.vacuumElement C)) (D.reverseOrderedAnnihilationProduct C S)
        = A.mul (A.mul (D.initialCreationProduct C S D.M) (D.vacuumElement C)) (D.reverseOrderedAnnihilationProduct C S) := by
          rw [D.initialCreationProduct_last C S]
      _ = A.mul (A.mul (D.initialCreationProduct C S D.M) (D.initialVacuumPart C D.M))
            (D.reverseOrderedAnnihilationProduct C S) := by rw [D.initialVacuumPart_last C]
      _ = A.mul (A.mul (D.initialCreationProduct C S D.M) (D.initialVacuumPart C D.M))
            (D.initialReverseAnnihilationProduct C S D.M) := by rw [D.initialReverseAnnihilationProduct_last C S]
      _ = Fu S := D.initialParts_product_eq_orderedProduct C hneg S D.M le_rfl
  -- （ロ）v^S_i = u^S_i（g_i := a†_i a_i、h_i := a_i a†_i）
  have hII : ∀ S : PowerSet D.M, AlgebraOver.orderedProduct A D.M (selectedFactorBySubset g h S.1) = Fu S :=
    fun S => rfl
  -- （ハ）a_i a†_i + a†_i a_i = 1_A
  have hIII : ∀ i : ℕ, 1 ≤ i → i ≤ D.M → A.add (h i) (g i) = A.one := by
    intro i hi1 hiM
    calc A.add (h i) (g i)
        = A.smul (kroneckerDelta i i) A.one := D.annihilation_creation_anticommute C hneg i i hi1 hiM hi1 hiM
      _ = A.smul 1 A.one := by rw [kroneckerDelta, if_pos rfl]
      _ = A.one := A.one_smul A.one
  -- （ニ）すべての因子が 1_A の番号順の積は 1_A
  have hIV : ∀ m : ℕ, AlgebraOver.orderedProduct A m (fun _ => A.one) = A.one := by
    intro m
    induction m with
    | zero => rfl
    | succ m ih => calc
        AlgebraOver.orderedProduct A (m + 1) (fun _ => A.one)
            = A.mul (AlgebraOver.orderedProduct A m (fun _ => A.one)) A.one := rfl
        _ = AlgebraOver.orderedProduct A m (fun _ => A.one) := A.mul_one _
        _ = A.one := ih
  calc sumOverFiniteSet SV (isFiniteSet_powerSet D.M) (fun _ => 1)
        (fun S => A.mul (A.mul (D.orderedCreationProduct C S) (D.vacuumElement C)) (D.reverseOrderedAnnihilationProduct C S))
      = sumOverFiniteSet SV (isFiniteSet_powerSet D.M) (fun _ => 1) Fu :=
        sumOverFiniteSet_congr SV _ _ _ _ _ fun S => by rw [hI S]
    -- 番号付け (2^M, e_M) で開く（def_sum_over_finite_set）
    _ = linearCombination SV (twoPower D.M) (fun _ => 1) (numberedFamily (binaryNumbering D.M) Fu A.zero) := by
        rw [sumOverFiniteSet_eq SV _ _ _ (twoPower D.M) (binaryNumbering D.M) (binaryNumbering_isNumbering D.M)]
        apply linearCombination_eq_of_terms_eq
        intro k hk1 hk2
        rw [numberedFamily_of_le (binaryNumbering D.M) (fun _ => (1 : K)) 0 k hk1 hk2]
        rfl
    _ = linearCombination SV (twoPower D.M) (fun _ => 1)
          (numberedFamily (binaryNumbering D.M)
            (fun S => AlgebraOver.orderedProduct A D.M (selectedFactorBySubset g h S.1)) A.zero) := by
        rw [show (fun S : PowerSet D.M => AlgebraOver.orderedProduct A D.M (selectedFactorBySubset g h S.1)) = Fu
          from funext hII]
    _ = AlgebraOver.orderedProduct A D.M (fun i => A.add (h i) (g i)) :=
        linearCombination_selectedProducts_eq A C.congruence.zero_add_zero D.M g h D.M le_rfl
    _ = AlgebraOver.orderedProduct A D.M (fun _ => A.one) := orderedProduct_congr A D.M _ _ hIII
    _ = A.one := hIV D.M

end

end CliffordMatrixIsomorphism.NecSuf.Clifford.SplitData
