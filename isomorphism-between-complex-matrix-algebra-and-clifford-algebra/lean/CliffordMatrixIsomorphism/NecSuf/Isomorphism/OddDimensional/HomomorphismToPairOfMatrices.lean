/-
章「同型の証明」の節「系：奇数次元の二次空間」のうち、一つの次元を足した空間から行列の組への写像 φ'、
奇数次元のクリフォード代数から行列環の直積への準同型 Φ' と、Φ' ∘ j・Φ'(g) の値の必要十分版。具体版
`Isomorphism/OddDimensional/HomomorphismToPairOfMatrices.lean` と同じ def・calc の行を、係数 ℂ を型の変数 K に、
-1_ℂ を K の元 n に替えて書く（Φ'(g) の第二成分は n ∗_B Φ(ε)）。
本文のラベルと宣言の対応は具体版の冒頭の表と同じである（宣言の名前も同じ）。

どの宣言も、Cl(V,q)・Cl(V',q')・Mat_{P_M}(K) を K の上の代数にするための章「クリフォード代数」の仮定 `CliffordLaws K n` と、
Φ を普遍性から得るための a + (-a) = 0（`hneg`）を持つ。φ' の -_ℂ t は K の記号 `Neg` の -t である。
そのほかに行の中で `CliffordLaws K n` の欄から使う K の性質:

  mapToPairOfMatrices_isLinearMap               -(t + t') = -t + -t'（加法の結合法則・交換法則・a + 0 = a・0 + a = a と hneg から導く
                                                `neg_add_eq`）、-(λ·t) = λ·(-t)（左分配法則・a · 0 = 0 と hneg から導く `mul_neg_eq_neg_mul`）
  mapToPairOfMatrices_mul_self                  (-t)·(-t) = t·t（左右の分配法則・a · 0 = 0・0 · a = 0 と hneg から導く `neg_mul_neg_eq_mul`）、
                                                平方の主張に渡す 0 + 0 = 0・a · 0 = 0、Φ(0_A) = 0_B の 0 + 0 = 0
  existsUnique・homomorphismToPairOfMatrices    上の二つの主張を普遍性に渡すだけ（足さない）
  homomorphismToPairOfMatrices_oddInclusionHom  -0 = 0（0 + 0 = 0 と hneg から導く `neg_zero_eq_zero`）、0 ∗_B x = 0_B の 0 + 0 = 0
  homomorphismToPairOfMatrices_addedGenerator   -1 = n（1 + n = 0 と hneg から導く `neg_one_eq_n`）、Φ(γ(0_V)) = 0_B の 0 + 0 = 0

分かったこと:
- 主張は、係数について章「クリフォード代数」の仮定と a + (-a) = 0 のほかに何も足さない。本文が「ℂ の四則」とした行
  （-(t+t') = -t + -t'、-(λt) = λ(-t)、(-t)(-t) = tt、-0 = 0）と -1_ℂ の定義の行（-1 = n）は、どれもこの二つから導ける。
- K の乗法の交換法則は、行の中では使わない（(-t)(-t) = tt も左右の分配法則から出る）。代数を作るための
  `CliffordLaws` の欄としてだけ持つ。
- 2 の可逆性（1 + 1 ≠ 0）・½ の存在・平方根は、どの主張も使わない。φ' の二つの成分を t と -t で分けることは、
  1 + 1 で割ることを要しない（この節の後で冪等元を作るところで初めて ½ が要るかどうかが問われる）。
- 本文の前提 M ∈ ℤ_{≥1} は、どの主張も使わない（M = 0 でも同じ証明が通る）。
-/
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.OddDimensional.OddExtension
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.OddDimensional.ParityElement
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.OddDimensional.ProductOfAlgebras
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.HomomorphismToMatrixAlgebra.HomomorphismToMatrixAlgebra

namespace CliffordMatrixIsomorphism.NecSuf.Clifford.CliffordLaws

universe uK

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K] [Neg K] {n : K} (C : CliffordLaws K n)

include C

/-! ### 本文が「ℂ の四則」とした行を、章「クリフォード代数」の仮定と a + (-a) = 0 から導く -/

/-- a + b = 0 なら b = -a。 -/
theorem eq_neg_of_add_eq_zero (hneg : ∀ a : K, a + -a = 0) {a b : K} (h : a + b = 0) : b = -a := calc
  b = 0 + b := (C.uniqueness.zero_add b).symm
  _ = (-a + a) + b := by rw [C.uniqueness.add_comm (-a) a, hneg a]
  _ = -a + (a + b) := C.uniqueness.add_assoc (-a) a b
  _ = -a + 0 := by rw [h]
  _ = -a := C.uniqueness.add_zero (-a)

/-- -0 = 0。 -/
theorem neg_zero_eq_zero (hneg : ∀ a : K, a + -a = 0) : -(0 : K) = 0 :=
  (C.eq_neg_of_add_eq_zero hneg (C.uniqueness.zero_add 0)).symm

/-- -(a + b) = -a + -b。 -/
theorem neg_add_eq_neg_add_neg (hneg : ∀ a : K, a + -a = 0) (a b : K) : -(a + b) = -a + -b :=
  VectorSpace.neg_add_eq C.uniqueness.add_assoc C.uniqueness.add_comm hneg C.uniqueness.add_zero C.uniqueness.zero_add a b

/-- λ · (-t) = -(λ · t)。 -/
theorem mul_neg_eq_neg_mul (hneg : ∀ a : K, a + -a = 0) (l t : K) : l * -t = -(l * t) :=
  C.eq_neg_of_add_eq_zero hneg (calc
    l * t + l * -t = l * (t + -t) := (C.valuedMaps.left_distrib l t (-t)).symm
    _ = l * 0 := by rw [hneg t]
    _ = 0 := C.uniqueness.mul_zero l)

/-- (-t) · s = -(t · s)。 -/
theorem neg_mul_eq_neg_mul (hneg : ∀ a : K, a + -a = 0) (t s : K) : (-t) * s = -(t * s) :=
  C.eq_neg_of_add_eq_zero hneg (calc
    t * s + (-t) * s = (t + -t) * s := (C.uniqueness.right_distrib t (-t) s).symm
    _ = 0 * s := by rw [hneg t]
    _ = 0 := C.uniqueness.zero_mul s)

/-- (-t) · (-t) = t · t（乗法の交換法則を使わない）。 -/
theorem neg_mul_neg_eq_mul (hneg : ∀ a : K, a + -a = 0) (t : K) : (-t) * (-t) = t * t := calc
  (-t) * (-t) = -(t * -t) := C.neg_mul_eq_neg_mul hneg t (-t)
  _ = -(-(t * t)) := by rw [C.mul_neg_eq_neg_mul hneg t t]
  _ = t * t := (C.eq_neg_of_add_eq_zero hneg (by
        rw [C.uniqueness.add_comm (-(t * t)) (t * t)]; exact hneg (t * t))).symm

/-- -1 = n（-1_ℂ の定義の行。n は 1 + n = 0 を満たす）。 -/
theorem neg_one_eq_n (hneg : ∀ a : K, a + -a = 0) : -(1 : K) = n :=
  (C.eq_neg_of_add_eq_zero hneg C.congruence.one_add_n).symm

end CliffordMatrixIsomorphism.NecSuf.Clifford.CliffordLaws

namespace CliffordMatrixIsomorphism.NecSuf.Clifford.SplitData

open CliffordMatrixIsomorphism.NecSuf.Isomorphism
open CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.NecSuf.VectorSpace
open CliffordMatrixIsomorphism.NecSuf.AlgebraOver
open CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra (PowerSet isFiniteSet_powerSet)

universe u uK

noncomputable section

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K] [Neg K] {n : K} (C : CliffordLaws K n)
  {W : Type u} (D : SplitData K W)

/-! ### φ' と、それが線型であること・値の平方 -/

omit [Neg K] in
/-- 本文 `def_map_from_odd_extension_to_pair_of_matrices` の B × B の必要十分版：B := Mat_{P_M}(K) と B の直積。 -/
abbrev pairOfMatricesAlgebra : AlgebraOver K (Mat K (PowerSet D.M) × Mat K (PowerSet D.M)) :=
  productAlgebra (D.matrixAlgebra C) (D.matrixAlgebra C)

/-- 本文 `def_map_from_odd_extension_to_pair_of_matrices` の必要十分版：
φ'((v, t)) := (Φ(γ(v)) +_B t ∗_B Φ(ε), Φ(γ(v)) +_B (-t) ∗_B Φ(ε))。 -/
def mapToPairOfMatrices (hneg : ∀ a : K, a + -a = 0) (p : (W × DualSpace D.spaceW) × K) :
    Mat K (PowerSet D.M) × Mat K (PowerSet D.M) :=
  ((D.matrixAlgebra C).add (D.homomorphismToMatrix C hneg ((D.space C).γ C p.1))
      ((D.matrixAlgebra C).smul p.2 (D.homomorphismToMatrix C hneg (D.parityElement C))),
    (D.matrixAlgebra C).add (D.homomorphismToMatrix C hneg ((D.space C).γ C p.1))
      ((D.matrixAlgebra C).smul (-p.2) (D.homomorphismToMatrix C hneg (D.parityElement C))))

/-- 本文 `claim_map_from_odd_extension_to_pair_of_matrices_is_linear_map` の必要十分版。 -/
theorem mapToPairOfMatrices_isLinearMap (hneg : ∀ a : K, a + -a = 0) :
    IsLinearMap (D.oddSpace C).space (D.pairOfMatricesAlgebra C).toVectorSpace (D.mapToPairOfMatrices C hneg) := by
  let B := D.matrixAlgebra C
  let Φ := D.homomorphismToMatrix C hneg
  let γ := (D.space C).γ C
  let η := Φ (D.parityElement C)
  have hΞ := IsLinearMap.comp ((D.space C).γ_isLinearMap C) (D.homomorphismToMatrix_isHom C hneg).isLinearMap_underlying
  have hΞadd : ∀ v v' : W × DualSpace D.spaceW, Φ (γ ((D.space C).space.add v v')) = B.add (Φ (γ v)) (Φ (γ v')) :=
    fun v v' => hΞ.map_add v v'
  have hΞsmul : ∀ (l : K) (v : W × DualSpace D.spaceW), Φ (γ ((D.space C).space.smul l v)) = B.smul l (Φ (γ v)) :=
    fun l v => hΞ.map_smul l v
  refine ⟨fun p p' => ?_, fun l p => ?_⟩
  · -- 加法を保つこと
    calc D.mapToPairOfMatrices C hneg ((D.oddSpace C).space.add p p')
        = D.mapToPairOfMatrices C hneg ((D.space C).space.add p.1 p'.1, p.2 + p'.2) := rfl
      _ = (B.add (Φ (γ ((D.space C).space.add p.1 p'.1))) (B.smul (p.2 + p'.2) η),
            B.add (Φ (γ ((D.space C).space.add p.1 p'.1))) (B.smul (-(p.2 + p'.2)) η)) := rfl
      _ = (B.add (B.add (Φ (γ p.1)) (Φ (γ p'.1))) (B.smul (p.2 + p'.2) η),
            B.add (B.add (Φ (γ p.1)) (Φ (γ p'.1))) (B.smul (-(p.2 + p'.2)) η)) := by
          -- Ξ は加法を保つ。各成分に
          rw [hΞadd p.1 p'.1]
      _ = (B.add (B.add (Φ (γ p.1)) (Φ (γ p'.1))) (B.smul (p.2 + p'.2) η),
            B.add (B.add (Φ (γ p.1)) (Φ (γ p'.1))) (B.smul (-p.2 + -p'.2) η)) := by
          -- 「ℂ の四則」：-(t + t') = -t + -t'
          rw [C.neg_add_eq_neg_add_neg hneg p.2 p'.2]
      _ = (B.add (B.add (Φ (γ p.1)) (Φ (γ p'.1))) (B.add (B.smul p.2 η) (B.smul p'.2 η)),
            B.add (B.add (Φ (γ p.1)) (Φ (γ p'.1))) (B.add (B.smul (-p.2) η) (B.smul (-p'.2) η))) := by
          -- U_vec(B) のスカラーの加法についての分配法則。各成分に
          rw [B.add_smul p.2 p'.2 η, B.add_smul (-p.2) (-p'.2) η]
      _ = (B.add (B.add (Φ (γ p.1)) (B.smul p.2 η)) (B.add (Φ (γ p'.1)) (B.smul p'.2 η)),
            B.add (B.add (Φ (γ p.1)) (B.smul (-p.2) η)) (B.add (Φ (γ p'.1)) (B.smul (-p'.2) η))) := by
          -- claim_rearranging_sum_of_two_sums_in_vector_space を U_vec(B) に当てる。各成分に
          rw [show B.add (B.add (Φ (γ p.1)) (Φ (γ p'.1))) (B.add (B.smul p.2 η) (B.smul p'.2 η))
                = B.add (B.add (Φ (γ p.1)) (B.smul p.2 η)) (B.add (Φ (γ p'.1)) (B.smul p'.2 η)) from
              rearrange_sum_of_two_sums B.toVectorSpace _ _ _ _,
            show B.add (B.add (Φ (γ p.1)) (Φ (γ p'.1))) (B.add (B.smul (-p.2) η) (B.smul (-p'.2) η))
                = B.add (B.add (Φ (γ p.1)) (B.smul (-p.2) η)) (B.add (Φ (γ p'.1)) (B.smul (-p'.2) η)) from
              rearrange_sum_of_two_sums B.toVectorSpace _ _ _ _]
      _ = ProductAlgebra.add B B (B.add (Φ (γ p.1)) (B.smul p.2 η), B.add (Φ (γ p.1)) (B.smul (-p.2) η))
            (B.add (Φ (γ p'.1)) (B.smul p'.2 η), B.add (Φ (γ p'.1)) (B.smul (-p'.2) η)) := rfl
      _ = (D.pairOfMatricesAlgebra C).add (D.mapToPairOfMatrices C hneg p) (D.mapToPairOfMatrices C hneg p') := rfl
  · -- スカラー倍を保つこと
    calc D.mapToPairOfMatrices C hneg ((D.oddSpace C).space.smul l p)
        = D.mapToPairOfMatrices C hneg ((D.space C).space.smul l p.1, l * p.2) := rfl
      _ = (B.add (Φ (γ ((D.space C).space.smul l p.1))) (B.smul (l * p.2) η),
            B.add (Φ (γ ((D.space C).space.smul l p.1))) (B.smul (-(l * p.2)) η)) := rfl
      _ = (B.add (B.smul l (Φ (γ p.1))) (B.smul (l * p.2) η),
            B.add (B.smul l (Φ (γ p.1))) (B.smul (-(l * p.2)) η)) := by
          -- Ξ はスカラー倍を保つ。各成分に
          rw [hΞsmul l p.1]
      _ = (B.add (B.smul l (Φ (γ p.1))) (B.smul (l * p.2) η),
            B.add (B.smul l (Φ (γ p.1))) (B.smul (l * -p.2) η)) := by
          -- 「ℂ の四則」：-(λ t) = λ (-t)
          rw [C.mul_neg_eq_neg_mul hneg l p.2]
      _ = (B.add (B.smul l (Φ (γ p.1))) (B.smul l (B.smul p.2 η)),
            B.add (B.smul l (Φ (γ p.1))) (B.smul l (B.smul (-p.2) η))) := by
          -- U_vec(B) のスカラー倍の結合法則。各成分に
          rw [B.smul_assoc l p.2 η, B.smul_assoc l (-p.2) η]
      _ = (B.smul l (B.add (Φ (γ p.1)) (B.smul p.2 η)), B.smul l (B.add (Φ (γ p.1)) (B.smul (-p.2) η))) := by
          -- U_vec(B) のベクトルの加法についての分配法則。各成分に
          rw [← B.smul_add l (Φ (γ p.1)) (B.smul p.2 η), ← B.smul_add l (Φ (γ p.1)) (B.smul (-p.2) η)]
      _ = ProductAlgebra.smul B B l (B.add (Φ (γ p.1)) (B.smul p.2 η), B.add (Φ (γ p.1)) (B.smul (-p.2) η)) := rfl
      _ = (D.pairOfMatricesAlgebra C).smul l (D.mapToPairOfMatrices C hneg p) := rfl

/-- 本文 `claim_square_of_map_from_odd_extension_to_pair_of_matrices` の必要十分版。 -/
theorem mapToPairOfMatrices_mul_self (hneg : ∀ a : K, a + -a = 0) (p : (W × DualSpace D.spaceW) × K) :
    (D.pairOfMatricesAlgebra C).mul (D.mapToPairOfMatrices C hneg p) (D.mapToPairOfMatrices C hneg p)
      = (D.pairOfMatricesAlgebra C).smul ((D.oddSpace C).form p) (D.pairOfMatricesAlgebra C).one := by
  let A := (D.space C).cliffordAlgebra C
  let B := D.matrixAlgebra C
  let Φ := D.homomorphismToMatrix C hneg
  have hΦ := D.homomorphismToMatrix_isHom C hneg
  let X := Φ ((D.space C).γ C p.1)
  let Y := Φ (D.parityElement C)
  -- 準備の一つ目：X ·_B X = q(v) ∗_B 1_B
  have hX : B.mul X X = B.smul ((D.space C).form p.1) B.one := calc
    B.mul X X = Φ (A.mul ((D.space C).γ C p.1) ((D.space C).γ C p.1)) := (hΦ.map_mul _ _).symm
    _ = Φ (A.smul ((D.space C).form p.1) A.one) := by rw [(D.space C).γ_mul_self C hneg p.1]
    _ = B.smul ((D.space C).form p.1) (Φ A.one) := hΦ.map_smul _ _
    _ = B.smul ((D.space C).form p.1) B.one := by rw [show Φ A.one = B.one from hΦ.map_one]
  -- 準備の二つ目：Y ·_B Y = 1_B
  have hY : B.mul Y Y = B.one := calc
    B.mul Y Y = Φ (A.mul (D.parityElement C) (D.parityElement C)) := (hΦ.map_mul _ _).symm
    _ = Φ A.one := by rw [D.parityElement_mul_self C hneg]
    _ = B.one := hΦ.map_one
  -- 準備の三つ目：X ·_B Y +_B Y ·_B X = 0_B
  have hXY : B.add (B.mul X Y) (B.mul Y X) = B.zero := calc
    B.add (B.mul X Y) (B.mul Y X)
        = B.add (Φ (A.mul ((D.space C).γ C p.1) (D.parityElement C)))
            (Φ (A.mul (D.parityElement C) ((D.space C).γ C p.1))) := by
          rw [show B.mul X Y = Φ (A.mul ((D.space C).γ C p.1) (D.parityElement C)) from (hΦ.map_mul _ _).symm,
            show B.mul Y X = Φ (A.mul (D.parityElement C) ((D.space C).γ C p.1)) from (hΦ.map_mul _ _).symm]
    _ = Φ (A.add (A.mul ((D.space C).γ C p.1) (D.parityElement C)) (A.mul (D.parityElement C) ((D.space C).γ C p.1))) :=
          (hΦ.map_add _ _).symm
    _ = Φ A.zero := by rw [D.γ_anticommute_parityElement C hneg p.1]
    _ = B.zero := hΦ.isLinearMap_underlying.map_zero C.congruence.zero_add_zero
  have hsq := fun s => square_of_add_smul_of_anticommuting B X Y C.congruence.zero_add_zero C.uniqueness.mul_zero
    ((D.space C).form p.1) hX hY hXY s
  calc (D.pairOfMatricesAlgebra C).mul (D.mapToPairOfMatrices C hneg p) (D.mapToPairOfMatrices C hneg p)
      = ProductAlgebra.mul B B (B.add X (B.smul p.2 Y), B.add X (B.smul (-p.2) Y))
          (B.add X (B.smul p.2 Y), B.add X (B.smul (-p.2) Y)) := rfl
    _ = (B.mul (B.add X (B.smul p.2 Y)) (B.add X (B.smul p.2 Y)),
          B.mul (B.add X (B.smul (-p.2) Y)) (B.add X (B.smul (-p.2) Y))) := rfl
    _ = (B.smul ((D.space C).form p.1 + p.2 * p.2) B.one, B.smul ((D.space C).form p.1 + -p.2 * -p.2) B.one) := by
        -- s := t と s := -t で各成分に
        rw [hsq p.2, hsq (-p.2)]
    _ = (B.smul ((D.space C).form p.1 + p.2 * p.2) B.one, B.smul ((D.space C).form p.1 + p.2 * p.2) B.one) := by
        -- 「ℂ の四則」：(-t)(-t) = tt
        rw [C.neg_mul_neg_eq_mul hneg p.2]
    _ = ProductAlgebra.smul B B ((D.space C).form p.1 + p.2 * p.2) (B.one, B.one) := rfl
    _ = (D.pairOfMatricesAlgebra C).smul ((D.space C).form p.1 + p.2 * p.2) (D.pairOfMatricesAlgebra C).one := rfl
    _ = (D.pairOfMatricesAlgebra C).smul ((D.oddSpace C).form p) (D.pairOfMatricesAlgebra C).one := rfl

/-! ### Φ' -/

/-- 本文 `claim_existence_and_uniqueness_of_homomorphism_from_odd_clifford_algebra_to_pair_of_matrix_algebras` の必要十分版。
クリフォード代数の普遍性の必要十分版を A := B × B、線型写像 φ' に当てる。 -/
theorem existsUnique_homomorphismToPairOfMatrices (hneg : ∀ a : K, a + -a = 0) :
    ∃ Θ : (D.oddSpace C).Cl C → Mat K (PowerSet D.M) × Mat K (PowerSet D.M),
      (IsAlgebraHomomorphism ((D.oddSpace C).cliffordAlgebra C) (D.pairOfMatricesAlgebra C) Θ ∧
        ∀ x, Θ ((D.oddSpace C).γ C x) = D.mapToPairOfMatrices C hneg x) ∧
      ∀ Θ' : (D.oddSpace C).Cl C → Mat K (PowerSet D.M) × Mat K (PowerSet D.M),
        (IsAlgebraHomomorphism ((D.oddSpace C).cliffordAlgebra C) (D.pairOfMatricesAlgebra C) Θ' ∧
          ∀ x, Θ' ((D.oddSpace C).γ C x) = D.mapToPairOfMatrices C hneg x) → Θ' = Θ :=
  (D.oddSpace C).universalProperty C hneg (D.pairOfMatricesAlgebra C) (D.mapToPairOfMatrices C hneg)
    (D.mapToPairOfMatrices_isLinearMap C hneg) (D.mapToPairOfMatrices_mul_self C hneg)

/-- 本文 `def_homomorphism_from_odd_clifford_algebra_to_pair_of_matrix_algebras` の必要十分版：ただ一つの準同型 Φ'。 -/
def homomorphismToPairOfMatrices (hneg : ∀ a : K, a + -a = 0) :
    (D.oddSpace C).Cl C → Mat K (PowerSet D.M) × Mat K (PowerSet D.M) :=
  Classical.choose (D.existsUnique_homomorphismToPairOfMatrices C hneg)

/-- 本文 `def_homomorphism_from_odd_clifford_algebra_to_pair_of_matrix_algebras` の必要十分版：Φ' は代数の準同型である。 -/
theorem homomorphismToPairOfMatrices_isHom (hneg : ∀ a : K, a + -a = 0) :
    IsAlgebraHomomorphism ((D.oddSpace C).cliffordAlgebra C) (D.pairOfMatricesAlgebra C)
      (D.homomorphismToPairOfMatrices C hneg) :=
  (Classical.choose_spec (D.existsUnique_homomorphismToPairOfMatrices C hneg)).1.1

/-- 本文 `def_homomorphism_from_odd_clifford_algebra_to_pair_of_matrix_algebras` の必要十分版：Φ' ∘ γ' = φ'。 -/
theorem homomorphismToPairOfMatrices_γ (hneg : ∀ a : K, a + -a = 0) (x : (W × DualSpace D.spaceW) × K) :
    D.homomorphismToPairOfMatrices C hneg ((D.oddSpace C).γ C x) = D.mapToPairOfMatrices C hneg x :=
  (Classical.choose_spec (D.existsUnique_homomorphismToPairOfMatrices C hneg)).1.2 x

/-- 本文 `claim_homomorphism_to_pair_of_matrices_after_induced_homomorphism` の必要十分版：Φ'(j(a)) = (Φ(a), Φ(a))。 -/
theorem homomorphismToPairOfMatrices_oddInclusionHom (hneg : ∀ a : K, a + -a = 0) (a : (D.space C).Cl C) :
    D.homomorphismToPairOfMatrices C hneg (D.oddInclusionHom C hneg a)
      = (D.homomorphismToMatrix C hneg a, D.homomorphismToMatrix C hneg a) := by
  let B := D.matrixAlgebra C
  let Φ := D.homomorphismToMatrix C hneg
  let Φ' := D.homomorphismToPairOfMatrices C hneg
  let γ := (D.space C).γ C
  have hΔ : IsAlgebraHomomorphism ((D.space C).cliffordAlgebra C) (D.pairOfMatricesAlgebra C) (pairMap Φ Φ) :=
    pairMap_isHom (D.homomorphismToMatrix_isHom C hneg) (D.homomorphismToMatrix_isHom C hneg)
  have hcomp : IsAlgebraHomomorphism ((D.space C).cliffordAlgebra C) (D.pairOfMatricesAlgebra C)
      (fun x => Φ' (D.oddInclusionHom C hneg x)) :=
    IsAlgebraHomomorphism.comp (D.oddInclusionHom_isHom C hneg) (D.homomorphismToPairOfMatrices_isHom C hneg)
  have hγ : ∀ v : W × DualSpace D.spaceW, Φ' (D.oddInclusionHom C hneg (γ v)) = pairMap Φ Φ (γ v) :=
    fun v => calc
    Φ' (D.oddInclusionHom C hneg (γ v)) = Φ' ((D.oddSpace C).γ C (oddInclusion C.valuedMaps v)) := by
        rw [D.oddInclusionHom_γ C hneg v]
    _ = D.mapToPairOfMatrices C hneg (oddInclusion C.valuedMaps v) := D.homomorphismToPairOfMatrices_γ C hneg _
    _ = D.mapToPairOfMatrices C hneg (v, (coefficientsVec C.valuedMaps).zero) := rfl
    _ = D.mapToPairOfMatrices C hneg (v, 0) := rfl
    _ = (B.add (Φ (γ v)) (B.smul 0 (Φ (D.parityElement C))),
          B.add (Φ (γ v)) (B.smul (-0) (Φ (D.parityElement C)))) := rfl
    _ = (B.add (Φ (γ v)) (B.smul 0 (Φ (D.parityElement C))),
          B.add (Φ (γ v)) (B.smul 0 (Φ (D.parityElement C)))) := by
        -- 「ℂ の四則」：-0 = 0
        rw [C.neg_zero_eq_zero hneg]
    _ = (B.add (Φ (γ v)) B.zero, B.add (Φ (γ v)) B.zero) := by
        -- claim_zero_scalar_multiple_is_zero_vector を各成分に
        rw [show B.smul 0 (Φ (D.parityElement C)) = B.zero from
          AlgebraOver.zero_smul_eq_zero B C.congruence.zero_add_zero _]
    _ = (Φ (γ v), Φ (γ v)) := by
        -- U_vec(B) の加法の単位元。各成分に
        rw [B.add_zero (Φ (γ v))]
    _ = pairMap Φ Φ (γ v) := rfl
  calc Φ' (D.oddInclusionHom C hneg a)
      = pairMap Φ Φ a :=
        AlgebraOver.eq_of_agree_on_generators hcomp hΔ (Set.range γ) ((D.space C).γ_generates C)
          (fun _ ⟨v, hv⟩ => by rw [← hv]; exact hγ v) a
    _ = (Φ a, Φ a) := rfl

/-- 本文 `claim_homomorphism_to_pair_of_matrices_on_added_generator` の必要十分版：Φ'(g) = (Φ(ε), n ∗_B Φ(ε))。 -/
theorem homomorphismToPairOfMatrices_addedGenerator (hneg : ∀ a : K, a + -a = 0) :
    D.homomorphismToPairOfMatrices C hneg (D.addedGenerator C)
      = (D.homomorphismToMatrix C hneg (D.parityElement C),
          (D.matrixAlgebra C).smul n (D.homomorphismToMatrix C hneg (D.parityElement C))) := by
  let B := D.matrixAlgebra C
  let Φ := D.homomorphismToMatrix C hneg
  let γ := (D.space C).γ C
  let η := Φ (D.parityElement C)
  have h0 : Φ (γ (D.space C).space.zero) = B.zero :=
    (IsLinearMap.comp ((D.space C).γ_isLinearMap C)
      (D.homomorphismToMatrix_isHom C hneg).isLinearMap_underlying).map_zero C.congruence.zero_add_zero
  calc D.homomorphismToPairOfMatrices C hneg (D.addedGenerator C)
      = D.homomorphismToPairOfMatrices C hneg ((D.oddSpace C).γ C (D.addedUnitVector C)) := rfl
    _ = D.mapToPairOfMatrices C hneg (D.addedUnitVector C) := D.homomorphismToPairOfMatrices_γ C hneg _
    _ = D.mapToPairOfMatrices C hneg (oddSecondInclusion (D.space C).space 1) := rfl
    _ = D.mapToPairOfMatrices C hneg ((D.space C).space.zero, 1) := rfl
    _ = (B.add (Φ (γ (D.space C).space.zero)) (B.smul 1 η), B.add (Φ (γ (D.space C).space.zero)) (B.smul (-1) η)) := rfl
    _ = (B.add B.zero (B.smul 1 η), B.add B.zero (B.smul (-1) η)) := by
        -- Φ(γ(0_V)) = 0_B を二か所に
        rw [h0]
    _ = (B.add B.zero (B.smul 1 η), B.add B.zero (B.smul n η)) := by
        -- -1_ℂ の定義の行：-1 = n
        rw [C.neg_one_eq_n hneg]
    _ = (B.add (B.smul 1 η) B.zero, B.add (B.smul n η) B.zero) := by
        -- U_vec(B) の加法の交換法則。各成分に
        rw [B.add_comm B.zero (B.smul 1 η), B.add_comm B.zero (B.smul n η)]
    _ = (B.smul 1 η, B.smul n η) := by
        -- U_vec(B) の加法の単位元。各成分に
        rw [B.add_zero (B.smul 1 η), B.add_zero (B.smul n η)]
    _ = (η, B.smul n η) := by
        -- U_vec(B) のスカラー倍の単位元
        rw [B.one_smul η]

end

end CliffordMatrixIsomorphism.NecSuf.Clifford.SplitData
