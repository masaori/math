/-
章「複素行列環」の、番号付けによる行列の添字の付け替えとその逆の必要十分版。具体版
`ComplexMatrixAlgebra/MatrixReindexing/Reindexing.lean` と同じ def と同じ calc の行で、係数 ℂ を型の変数 K に替えて書く。
和は K を自分自身の上の線型空間にした `coefficientsVec L`（具体版の ℂ^vec。証明の中では S と書く）の中の和である。

  本文のラベル                                                              このファイル                                使う K の性質
  def_reindexing_of_matrices_by_numbering                                   reindexMatrix・entry_reindexMatrix          なし（K の演算も使わない）
  def_reindexing_of_matrices_by_inverse_numbering                           inverseReindexMatrix・                      なし（K の演算も使わない）
                                                                            entry_inverseReindexMatrix
  claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism         reindexMatrix_add・reindexMatrix_mul・      四つの等式はなし（積の等式は
                                                                            reindexMatrix_one・reindexMatrix_smul・     積を定める L を引数にとるだけ）。
                                                                            reindexMatrix_isAlgebraHomomorphism         準同型であることは、二つの代数を
                                                                                                                        作る L・乗法の交換法則・a · 0 = 0
  claim_inverse_reindexing_after_reindexing_of_matrices_is_identity         inverseReindexMatrix_reindexMatrix          なし（K の演算も使わない）
  claim_reindexing_after_inverse_reindexing_of_matrices_is_identity         reindexMatrix_inverseReindexMatrix          なし（K の演算も使わない）
  claim_reindexing_of_matrices_by_inverse_numbering_is_algebra_homomorphism inverseReindexMatrix_add・…_mul・…_one・    ν_e の主張と同じ
                                                                            …_smul・inverseReindexMatrix_isAlgebraHomomorphism

分かったこと:
- 添字の付け替えが加法・乗法・単位元・スカラー倍を保つことは、係数の公理を一つも使わない。どの行も、成分を e で付け替える定義、
  番号付けで和を開くこと（`sumOverFiniteSet_eq`、係数の公理を使わない）、項ごとに等しい線型結合が等しいこと
  （`linearCombination_eq_of_terms_eq`、同じく使わない）、e の単射性だけで書ける。
- 「ℂ-代数の準同型である」という主張に L・乗法の交換法則・a · 0 = 0 が現れるのは、行列の集合を代数にする
  `matricesAlgebra`（`MatrixAlgebra/Algebra.lean`）がそれを要るからで、付け替えの証明が使うからではない。
- 二つの付け替えが互いの逆であることは、K に演算の記号すら要らない（行列は写像 X × X → K で、付け替えは添字に e・e^{-1} を合成するだけ）。
-/
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.MatrixAlgebra.Algebra

namespace CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra

open CliffordMatrixIsomorphism.NecSuf.VectorSpace
open CliffordMatrixIsomorphism.NecSuf.AlgebraOver

universe u uK

variable {K : Type uK} {X : Type u}

/-- 本文 `def_reindexing_of_matrices_by_numbering` の必要十分版：ν_e(F)_{k,l} := F_{e(k),e(l)}。 -/
def reindexMatrix {n : ℕ} (e : Idx n → X) (F : Mat K X) : Mat K (Idx n) := fun p =>
  Mat.entry F (e p.1) (e p.2)

theorem entry_reindexMatrix {n : ℕ} (e : Idx n → X) (F : Mat K X) (k l : Idx n) :
    Mat.entry (reindexMatrix e F) k l = Mat.entry F (e k) (e l) := rfl

/-- 本文 `def_reindexing_of_matrices_by_inverse_numbering` の必要十分版：μ_e(G)_{x,y} := G_{e^{-1}(x),e^{-1}(y)}。 -/
noncomputable def inverseReindexMatrix {n : ℕ} {e : Idx n → X} (he : IsNumbering n e)
    (G : Mat K (Idx n)) : Mat K X := fun p =>
  Mat.entry G (he.inv p.1) (he.inv p.2)

theorem entry_inverseReindexMatrix {n : ℕ} {e : Idx n → X} (he : IsNumbering n e)
    (G : Mat K (Idx n)) (x y : X) :
    Mat.entry (inverseReindexMatrix he G) x y = Mat.entry G (he.inv x) (he.inv y) := rfl

/-! ### ν_e は代数の準同型である -/

/-- 本文 `claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism` の必要十分版：加法を保つこと。 -/
theorem reindexMatrix_add [Add K] {n : ℕ} (e : Idx n → X) (F G : Mat K X) :
    reindexMatrix e (Mat.add F G) = Mat.add (reindexMatrix e F) (reindexMatrix e G) :=
  Mat.ext fun k l => calc
    Mat.entry (reindexMatrix e (Mat.add F G)) k l
        = Mat.entry (Mat.add F G) (e k) (e l) := rfl
    _ = Mat.entry F (e k) (e l) + Mat.entry G (e k) (e l) := rfl
    _ = Mat.entry (reindexMatrix e F) k l + Mat.entry (reindexMatrix e G) k l := rfl
    _ = Mat.entry (Mat.add (reindexMatrix e F) (reindexMatrix e G)) k l := rfl

/-- 本文 `claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism` の必要十分版：乗法を保つこと。
L は積を定めるためだけに引数にとる（行の中では使わない）。 -/
theorem reindexMatrix_mul [Add K] [Mul K] [One K] [Zero K] (L : ValuedMapsLaws K)
    (hX : IsFiniteSet X) {n : ℕ} {e : Idx n → X} (he : IsNumbering n e) (F G : Mat K X) :
    reindexMatrix e (Mat.mul L hX F G)
      = Mat.mul L (isFiniteSet_idx n) (reindexMatrix e F) (reindexMatrix e G) :=
  Mat.ext fun k l => by
    -- 各 j で ν_e の定義：F_{e(k),e(j)} ·_{K^vec} G_{e(j),e(l)} = ν_e(F)_{k,j} ·_{K^vec} ν_e(G)_{j,l}
    have hterms : ∀ j : ℕ, 1 ≤ j → j ≤ n →
        (coefficientsVec L).smul (numberedFamily e (fun z => Mat.entry F (e k) z) 0 j)
            (numberedFamily e (fun z => Mat.entry G z (e l)) (coefficientsVec L).zero j)
          = (coefficientsVec L).smul
              (numberedFamily (fun i : Idx n => i) (fun i => Mat.entry (reindexMatrix e F) k i) 0 j)
              (numberedFamily (fun i : Idx n => i) (fun i => Mat.entry (reindexMatrix e G) i l)
                (coefficientsVec L).zero j) := by
      intro j hj1 hjn
      rw [numberedFamily_of_le e (fun z => Mat.entry F (e k) z) 0 j hj1 hjn,
        numberedFamily_of_le e (fun z => Mat.entry G z (e l)) (coefficientsVec L).zero j hj1 hjn,
        numberedFamily_of_le (fun i : Idx n => i) (fun i => Mat.entry (reindexMatrix e F) k i) 0 j hj1 hjn,
        numberedFamily_of_le (fun i : Idx n => i) (fun i => Mat.entry (reindexMatrix e G) i l)
          (coefficientsVec L).zero j hj1 hjn]
      rfl
    exact calc
      Mat.entry (reindexMatrix e (Mat.mul L hX F G)) k l
          = Mat.entry (Mat.mul L hX F G) (e k) (e l) := rfl
      _ = sumOverFiniteSet (coefficientsVec L) hX (fun z => Mat.entry F (e k) z)
            (fun z => Mat.entry G z (e l)) := rfl
      -- 本文 def_sum_over_finite_set を番号付け (n, e) で
      _ = linearCombination (coefficientsVec L) n
            (numberedFamily e (fun z => Mat.entry F (e k) z) 0)
            (numberedFamily e (fun z => Mat.entry G z (e l)) (coefficientsVec L).zero) :=
          sumOverFiniteSet_eq (coefficientsVec L) hX _ _ n e he
      -- 各 j で本文 def_reindexing_of_matrices_by_numbering。本文 claim_linear_combinations_with_equal_terms_are_equal
      _ = linearCombination (coefficientsVec L) n
            (numberedFamily (fun i : Idx n => i) (fun i => Mat.entry (reindexMatrix e F) k i) 0)
            (numberedFamily (fun i : Idx n => i) (fun i => Mat.entry (reindexMatrix e G) i l)
              (coefficientsVec L).zero) :=
          linearCombination_eq_of_terms_eq (coefficientsVec L) n _ _ _ _ hterms
      -- 本文 def_sum_over_finite_set を番号付け (n, id_n) で、右辺から左辺へ読む
      _ = sumOverFiniteSet (coefficientsVec L) (isFiniteSet_idx n)
            (fun i => Mat.entry (reindexMatrix e F) k i) (fun i => Mat.entry (reindexMatrix e G) i l) :=
          (sumOverFiniteSet_eq (coefficientsVec L) (isFiniteSet_idx n) _ _ n (fun i : Idx n => i)
            (isNumbering_id n)).symm
      _ = Mat.entry (Mat.mul L (isFiniteSet_idx n) (reindexMatrix e F) (reindexMatrix e G)) k l := rfl

/-- 本文 `claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism` の必要十分版：乗法の単位元を保つこと。 -/
theorem reindexMatrix_one [Zero K] [One K] [DecidableEq X] {n : ℕ} {e : Idx n → X}
    (he : IsNumbering n e) :
    reindexMatrix e (Mat.one : Mat K X) = (Mat.one : Mat K (Idx n)) :=
  Mat.ext fun k l => by
    have hiff : e k = e l ↔ k = l := ⟨he.injective k l, fun h => by rw [h]⟩
    exact calc
      Mat.entry (reindexMatrix e (Mat.one : Mat K X)) k l
          = Mat.entry (Mat.one : Mat K X) (e k) (e l) := rfl
      _ = (kroneckerDelta (e k) (e l) : K) := rfl
      -- e(k) = e(l) と k = l は同値。本文 def_kronecker_delta
      _ = (kroneckerDelta k l : K) := by
          unfold kroneckerDelta
          by_cases h : k = l
          · rw [if_pos (hiff.2 h), if_pos h]
          · rw [if_neg (fun h' => h (hiff.1 h')), if_neg h]
      _ = Mat.entry (Mat.one : Mat K (Idx n)) k l := rfl

/-- 本文 `claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism` の必要十分版：スカラー倍を保つこと。 -/
theorem reindexMatrix_smul [Mul K] {n : ℕ} (e : Idx n → X) (l : K) (F : Mat K X) :
    reindexMatrix e (Mat.smul l F) = Mat.smul l (reindexMatrix e F) :=
  Mat.ext fun k k' => calc
    Mat.entry (reindexMatrix e (Mat.smul l F)) k k'
        = Mat.entry (Mat.smul l F) (e k) (e k') := rfl
    _ = l * Mat.entry F (e k) (e k') := rfl
    _ = l * Mat.entry (reindexMatrix e F) k k' := rfl
    _ = Mat.entry (Mat.smul l (reindexMatrix e F)) k k' := rfl

/-- 本文 `claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism` の必要十分版：
ν_e : Mat_X(K) → Mat_{1,…,n}(K) は代数の準同型である。L・hcomm・hmul0 は二つの代数を作るためだけに要る。 -/
theorem reindexMatrix_isAlgebraHomomorphism [Add K] [Mul K] [One K] [Zero K] (L : ValuedMapsLaws K)
    (hcomm : ∀ a b : K, a * b = b * a) (hmul0 : ∀ a : K, a * 0 = 0) (hX : IsFiniteSet X)
    [DecidableEq X] {n : ℕ} {e : Idx n → X} (he : IsNumbering n e) :
    IsAlgebraHomomorphism (matricesAlgebra L hcomm hmul0 hX)
      (matricesAlgebra L hcomm hmul0 (isFiniteSet_idx n)) (reindexMatrix e) where
  isRingHomomorphism :=
    { map_add := reindexMatrix_add e
      map_mul := reindexMatrix_mul L hX he
      map_one := reindexMatrix_one he }
  isLinearMap :=
    { map_add := reindexMatrix_add e
      map_smul := reindexMatrix_smul e }

/-! ### ν_e と μ_e は互いの逆である -/

/-- 本文 `claim_inverse_reindexing_after_reindexing_of_matrices_is_identity` の必要十分版：μ_e(ν_e(F)) = F。 -/
theorem inverseReindexMatrix_reindexMatrix {n : ℕ} {e : Idx n → X} (he : IsNumbering n e)
    (F : Mat K X) : inverseReindexMatrix he (reindexMatrix e F) = F :=
  Mat.ext fun x y => calc
    Mat.entry (inverseReindexMatrix he (reindexMatrix e F)) x y
        = Mat.entry (reindexMatrix e F) (he.inv x) (he.inv y) := rfl
    _ = Mat.entry F (e (he.inv x)) (e (he.inv y)) := rfl
    -- e(e^{-1}(u)) = u を u := x, y に。本文 def_numbering_of_finite_set
    _ = Mat.entry F x y := by rw [he.apply_inv x, he.apply_inv y]

/-- 本文 `claim_reindexing_after_inverse_reindexing_of_matrices_is_identity` の必要十分版：ν_e(μ_e(G)) = G。 -/
theorem reindexMatrix_inverseReindexMatrix {n : ℕ} {e : Idx n → X} (he : IsNumbering n e)
    (G : Mat K (Idx n)) : reindexMatrix e (inverseReindexMatrix he G) = G :=
  Mat.ext fun k l => calc
    Mat.entry (reindexMatrix e (inverseReindexMatrix he G)) k l
        = Mat.entry (inverseReindexMatrix he G) (e k) (e l) := rfl
    _ = Mat.entry G (he.inv (e k)) (he.inv (e l)) := rfl
    -- e^{-1}(e(j)) = j を j := k, l に。本文 def_numbering_of_finite_set
    _ = Mat.entry G k l := by rw [he.inv_apply k, he.inv_apply l]

/-! ### μ_e は代数の準同型である -/

/-- 本文 `claim_reindexing_of_matrices_by_inverse_numbering_is_algebra_homomorphism` の必要十分版：加法を保つこと。 -/
theorem inverseReindexMatrix_add [Add K] {n : ℕ} {e : Idx n → X} (he : IsNumbering n e)
    (G H : Mat K (Idx n)) :
    inverseReindexMatrix he (Mat.add G H)
      = Mat.add (inverseReindexMatrix he G) (inverseReindexMatrix he H) := calc
  inverseReindexMatrix he (Mat.add G H)
      = inverseReindexMatrix he
          (Mat.add (reindexMatrix e (inverseReindexMatrix he G))
            (reindexMatrix e (inverseReindexMatrix he H))) := by
        rw [reindexMatrix_inverseReindexMatrix he G, reindexMatrix_inverseReindexMatrix he H]
  _ = inverseReindexMatrix he
        (reindexMatrix e (Mat.add (inverseReindexMatrix he G) (inverseReindexMatrix he H))) := by
        rw [reindexMatrix_add e (inverseReindexMatrix he G) (inverseReindexMatrix he H)]
  _ = Mat.add (inverseReindexMatrix he G) (inverseReindexMatrix he H) :=
        inverseReindexMatrix_reindexMatrix he _

/-- 本文 `claim_reindexing_of_matrices_by_inverse_numbering_is_algebra_homomorphism` の必要十分版：乗法を保つこと。 -/
theorem inverseReindexMatrix_mul [Add K] [Mul K] [One K] [Zero K] (L : ValuedMapsLaws K)
    (hX : IsFiniteSet X) {n : ℕ} {e : Idx n → X} (he : IsNumbering n e) (G H : Mat K (Idx n)) :
    inverseReindexMatrix he (Mat.mul L (isFiniteSet_idx n) G H)
      = Mat.mul L hX (inverseReindexMatrix he G) (inverseReindexMatrix he H) := calc
  inverseReindexMatrix he (Mat.mul L (isFiniteSet_idx n) G H)
      = inverseReindexMatrix he
          (Mat.mul L (isFiniteSet_idx n) (reindexMatrix e (inverseReindexMatrix he G))
            (reindexMatrix e (inverseReindexMatrix he H))) := by
        rw [reindexMatrix_inverseReindexMatrix he G, reindexMatrix_inverseReindexMatrix he H]
  _ = inverseReindexMatrix he
        (reindexMatrix e (Mat.mul L hX (inverseReindexMatrix he G) (inverseReindexMatrix he H))) := by
        rw [reindexMatrix_mul L hX he (inverseReindexMatrix he G) (inverseReindexMatrix he H)]
  _ = Mat.mul L hX (inverseReindexMatrix he G) (inverseReindexMatrix he H) :=
        inverseReindexMatrix_reindexMatrix he _

/-- 本文 `claim_reindexing_of_matrices_by_inverse_numbering_is_algebra_homomorphism` の必要十分版：乗法の単位元を保つこと。 -/
theorem inverseReindexMatrix_one [Zero K] [One K] [DecidableEq X] {n : ℕ} {e : Idx n → X}
    (he : IsNumbering n e) :
    inverseReindexMatrix he (Mat.one : Mat K (Idx n)) = (Mat.one : Mat K X) := calc
  inverseReindexMatrix he (Mat.one : Mat K (Idx n))
      = inverseReindexMatrix he (reindexMatrix e (Mat.one : Mat K X)) := by
        rw [reindexMatrix_one he]
  _ = (Mat.one : Mat K X) := inverseReindexMatrix_reindexMatrix he _

/-- 本文 `claim_reindexing_of_matrices_by_inverse_numbering_is_algebra_homomorphism` の必要十分版：スカラー倍を保つこと。 -/
theorem inverseReindexMatrix_smul [Mul K] {n : ℕ} {e : Idx n → X} (he : IsNumbering n e) (l : K)
    (G : Mat K (Idx n)) :
    inverseReindexMatrix he (Mat.smul l G) = Mat.smul l (inverseReindexMatrix he G) := calc
  inverseReindexMatrix he (Mat.smul l G)
      = inverseReindexMatrix he (Mat.smul l (reindexMatrix e (inverseReindexMatrix he G))) := by
        rw [reindexMatrix_inverseReindexMatrix he G]
  _ = inverseReindexMatrix he (reindexMatrix e (Mat.smul l (inverseReindexMatrix he G))) := by
        rw [reindexMatrix_smul e l (inverseReindexMatrix he G)]
  _ = Mat.smul l (inverseReindexMatrix he G) := inverseReindexMatrix_reindexMatrix he _

/-- 本文 `claim_reindexing_of_matrices_by_inverse_numbering_is_algebra_homomorphism` の必要十分版：
μ_e : Mat_{1,…,n}(K) → Mat_X(K) は代数の準同型である。L・hcomm・hmul0 は二つの代数を作るためだけに要る。 -/
theorem inverseReindexMatrix_isAlgebraHomomorphism [Add K] [Mul K] [One K] [Zero K]
    (L : ValuedMapsLaws K) (hcomm : ∀ a b : K, a * b = b * a) (hmul0 : ∀ a : K, a * 0 = 0)
    (hX : IsFiniteSet X) [DecidableEq X] {n : ℕ} {e : Idx n → X} (he : IsNumbering n e) :
    IsAlgebraHomomorphism (matricesAlgebra L hcomm hmul0 (isFiniteSet_idx n))
      (matricesAlgebra L hcomm hmul0 hX) (inverseReindexMatrix he) where
  isRingHomomorphism :=
    { map_add := inverseReindexMatrix_add he
      map_mul := inverseReindexMatrix_mul L hX he
      map_one := inverseReindexMatrix_one he }
  isLinearMap :=
    { map_add := inverseReindexMatrix_add he
      map_smul := inverseReindexMatrix_smul he }

end CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra
