/-
章「同型の証明」の節「行列環からクリフォード代数への準同型」の必要十分版。具体版
`Isomorphism/HomomorphismFromMatrixAlgebra/HomomorphismFromMatrixAlgebra.lean` と同じ def と同じ calc の行のまま、
係数 ℂ を型の変数 K に、-1_ℂ を K の元 n に替える。K には演算の記号 +・·・0・1・- だけを与え、使う性質は仮定として渡す。
本文のラベルと宣言の対応は具体版の冒頭の表と同じである（宣言の名前も同じ）。

主張ごとに使う K の性質（どの主張も、Cl(V,q) と Mat_{P_M}(K) の K の上の代数を作るための章「クリフォード代数」の仮定
`CliffordLaws K n` を持つ。下に書くのは、行の中でその欄から使う性質と、足す仮定である）:
  ℰ_{S,T} の定義、Ψ の定義            `CliffordLaws K n` のほかに足さない（行が無い）
  ℰ_{S,T} ℰ_{U,R} = δ_{T,U} ∗ ℰ_{S,R}   a + (-a) = 0（hneg。真空で挟んだ元の主張を引くため）。行の中は代数の公理だけ
  Ψ が線型                             乗法の交換法則（(ハ) の 1 · ρ = ρ · 1）、0 + 0 = 0 と a · 0 = 0（和のスカラー倍）
  Ψ(E_{S,T}) = ℰ_{S,T}                 乗法の交換法則（(イ) の δ_{S,S'} · δ_{T,T'} の入れ替え）、1 · a = a（(ハ)）、
                                       0 + 0 = 0（デルタで一項を取り出す主張）
  Ψ(E_{S,T} E_{U,R}) = Ψ(E_{S,T}) Ψ(E_{U,R})
                                       a + (-a) = 0（ℰ の積の規則を引くため）、0 と 1 がどの元とも交換すること（行列単位の積の規則）
  Ψ が K-代数の準同型                  a + (-a) = 0（1 の分解と行列単位どうしの積の主張を引くため）、0 + 0 = 0、
                                       0 と 1 がどの元とも交換すること（行列の行列単位による分解）

分かったこと:
- 乗法の交換法則のうち行の中で使うのは、Ψ が線型であることの 1 · ρ = ρ · 1 と、Ψ(E_{S,T}) の δ_{S,S'} · δ_{T,T'} の入れ替えだけである。
  δ の値は 0 か 1 なので後者は 0 と 1 の交換で足り、前者も 1 と ρ の交換で足りる。ただし行列環が K の上の代数であることが
  交換法則を要するので（`NecSuf/ComplexMatrixAlgebra/MatrixAlgebra/Algebra.lean`）、主張全体は交換法則を外せない。
- 2 の可逆性と平方根は、どの主張も使わない。本文の前提 M ∈ ℤ_{≥1} も、どの主張も使わない（M = 0 でも同じ証明が通る）。

導出版は `Isomorphism/HomomorphismFromMatrixAlgebra/HomomorphismFromMatrixAlgebraFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.GlobalIdentities.GlobalIdentities
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.HomomorphismToMatrixAlgebra.HomomorphismToMatrixAlgebra
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.MatrixUnits.MatrixUnits
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.MatrixAlgebra.Product

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

/-- 本文 `def_matrix_unit_element_of_split_clifford_algebra` の必要十分版：ℰ_{S,T} := (a†_S ·_A P) ·_A a_T。 -/
def matrixUnitElement (S T : PowerSet D.M) : (D.space C).Cl C :=
  ((D.space C).cliffordAlgebra C).mul
    (((D.space C).cliffordAlgebra C).mul (D.orderedCreationProduct C S) (D.vacuumElement C))
    (D.reverseOrderedAnnihilationProduct C T)

/-- 本文 `claim_product_of_matrix_unit_elements_of_split_clifford_algebra` の必要十分版：
ℰ_{S,T} ·_A ℰ_{U,R} = δ_{T,U} ∗_A ℰ_{S,R}。 -/
theorem matrixUnitElement_mul (hneg : ∀ a : K, a + -a = 0) (S T U R : PowerSet D.M) :
    ((D.space C).cliffordAlgebra C).mul (D.matrixUnitElement C S T) (D.matrixUnitElement C U R)
      = ((D.space C).cliffordAlgebra C).smul (kroneckerDelta T U) (D.matrixUnitElement C S R) := by
  let A := (D.space C).cliffordAlgebra C
  let cS := D.orderedCreationProduct C S
  let cU := D.orderedCreationProduct C U
  let aT := D.reverseOrderedAnnihilationProduct C T
  let aR := D.reverseOrderedAnnihilationProduct C R
  let P := D.vacuumElement C
  calc A.mul (D.matrixUnitElement C S T) (D.matrixUnitElement C U R)
      = A.mul (A.mul (A.mul cS P) aT) (A.mul (A.mul cU P) aR) := rfl
    _ = A.mul (A.mul cS P) (A.mul aT (A.mul (A.mul cU P) aR)) := A.mul_assoc _ _ _
    _ = A.mul (A.mul cS P) (A.mul (A.mul aT (A.mul cU P)) aR) := by rw [A.mul_assoc aT (A.mul cU P) aR]
    _ = A.mul (A.mul cS P) (A.mul (A.mul (A.mul aT cU) P) aR) := by rw [A.mul_assoc aT cU P]
    _ = A.mul (A.mul (A.mul cS P) (A.mul (A.mul aT cU) P)) aR := (A.mul_assoc _ _ _).symm
    _ = A.mul (A.mul cS (A.mul P (A.mul (A.mul aT cU) P))) aR := by rw [A.mul_assoc cS P]
    _ = A.mul (A.mul cS (A.mul (A.mul P (A.mul aT cU)) P)) aR := by rw [A.mul_assoc P (A.mul aT cU) P]
    _ = A.mul (A.mul cS (A.smul (kroneckerDelta T U) P)) aR := by rw [D.vacuumElement_sandwich C hneg T U]
    _ = A.mul (A.smul (kroneckerDelta T U) (A.mul cS P)) aR := by rw [A.smul_mul_right]
    _ = A.smul (kroneckerDelta T U) (A.mul (A.mul cS P) aR) := (A.smul_mul_left _ _ _).symm
    _ = A.smul (kroneckerDelta T U) (D.matrixUnitElement C S R) := rfl

/-- 本文 `def_homomorphism_from_matrix_algebra_to_clifford_algebra` の必要十分版：
Ψ(F) := Σ_{S∈P_M} 1 ∗_A (Σ_{T∈P_M} F_{S,T} ∗_A ℰ_{S,T})。 -/
def homomorphismFromMatrix (F : Mat K (PowerSet D.M)) : (D.space C).Cl C :=
  sumOverFiniteSet ((D.space C).cliffordAlgebra C).toVectorSpace (isFiniteSet_powerSet D.M) (fun _ => 1)
    (fun S => sumOverFiniteSet ((D.space C).cliffordAlgebra C).toVectorSpace (isFiniteSet_powerSet D.M)
      (fun T => Mat.entry F S T) (fun T => D.matrixUnitElement C S T))

/-- 本文 `claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_linear_map` の必要十分版。 -/
theorem homomorphismFromMatrix_isLinearMap :
    IsLinearMap (matricesVectorSpace C.valuedMaps (PowerSet D.M)) ((D.space C).cliffordAlgebra C).toVectorSpace
      (D.homomorphismFromMatrix C) := by
  let A := (D.space C).cliffordAlgebra C
  let Av := A.toVectorSpace
  let hX := isFiniteSet_powerSet D.M
  let E := D.matrixUnitElement C
  have h00 : (0 : K) + 0 = 0 := C.uniqueness.add_zero 0
  constructor
  · intro F G
    -- （イ）
    have hI : ∀ S : PowerSet D.M,
        sumOverFiniteSet Av hX (fun T => Mat.entry F S T + Mat.entry G S T) (E S)
          = Av.add (sumOverFiniteSet Av hX (fun T => Mat.entry F S T) (E S))
              (sumOverFiniteSet Av hX (fun T => Mat.entry G S T) (E S)) := fun S =>
      (sumOverFiniteSet_add_of_same_family Av hX (E S) _ _).symm
    calc D.homomorphismFromMatrix C ((matricesVectorSpace C.valuedMaps (PowerSet D.M)).add F G)
        = sumOverFiniteSet Av hX (fun _ => 1)
            (fun S => sumOverFiniteSet Av hX (fun T => Mat.entry (Mat.add F G) S T) (E S)) := rfl
      _ = sumOverFiniteSet Av hX (fun _ => 1)
            (fun S => sumOverFiniteSet Av hX (fun T => Mat.entry F S T + Mat.entry G S T) (E S)) :=
          sumOverFiniteSet_double_congr Av hX hX _ _ _ _ fun _ _ => rfl
      _ = sumOverFiniteSet Av hX (fun _ => 1)
            (fun S => Av.add (sumOverFiniteSet Av hX (fun T => Mat.entry F S T) (E S))
              (sumOverFiniteSet Av hX (fun T => Mat.entry G S T) (E S))) :=
          sumOverFiniteSet_congr Av hX _ _ _ _ fun S => by rw [hI S]
      _ = Av.add (sumOverFiniteSet Av hX (fun _ => 1)
              (fun S => sumOverFiniteSet Av hX (fun T => Mat.entry F S T) (E S)))
            (sumOverFiniteSet Av hX (fun _ => 1)
              (fun S => sumOverFiniteSet Av hX (fun T => Mat.entry G S T) (E S))) :=
          (sumOverFiniteSet_add_of_same_coefficients Av hX _ _ _).symm
      _ = Av.add (D.homomorphismFromMatrix C F) (D.homomorphismFromMatrix C G) := rfl
  · intro ρ F
    -- （ロ）
    have hII : ∀ S : PowerSet D.M,
        sumOverFiniteSet Av hX (fun T => ρ * Mat.entry F S T) (E S)
          = Av.smul ρ (sumOverFiniteSet Av hX (fun T => Mat.entry F S T) (E S)) := fun S =>
      (smul_sumOverFiniteSet Av h00 C.uniqueness.mul_zero hX (E S) _ ρ).symm
    -- （ハ）1 ∗ (ρ ∗ a) = (ρ · 1) ∗ a：乗法の交換法則（1 · ρ = ρ · 1）を使う
    have hIII : ∀ a : (D.space C).Cl C, Av.smul 1 (Av.smul ρ a) = Av.smul (ρ * 1) a := fun a => calc
      Av.smul 1 (Av.smul ρ a) = Av.smul (1 * ρ) a := (Av.smul_assoc 1 ρ a).symm
      _ = Av.smul (ρ * 1) a := by rw [C.mul_comm 1 ρ]
    calc D.homomorphismFromMatrix C ((matricesVectorSpace C.valuedMaps (PowerSet D.M)).smul ρ F)
        = sumOverFiniteSet Av hX (fun _ => 1)
            (fun S => sumOverFiniteSet Av hX (fun T => Mat.entry (Mat.smul ρ F) S T) (E S)) := rfl
      _ = sumOverFiniteSet Av hX (fun _ => 1)
            (fun S => sumOverFiniteSet Av hX (fun T => ρ * Mat.entry F S T) (E S)) :=
          sumOverFiniteSet_double_congr Av hX hX _ _ _ _ fun _ _ => rfl
      _ = sumOverFiniteSet Av hX (fun _ => 1)
            (fun S => Av.smul ρ (sumOverFiniteSet Av hX (fun T => Mat.entry F S T) (E S))) :=
          sumOverFiniteSet_congr Av hX _ _ _ _ fun S => by rw [hII S]
      _ = sumOverFiniteSet Av hX (fun _ => ρ * 1)
            (fun S => sumOverFiniteSet Av hX (fun T => Mat.entry F S T) (E S)) :=
          sumOverFiniteSet_congr Av hX _ _ _ _ fun S => hIII _
      _ = Av.smul ρ (sumOverFiniteSet Av hX (fun _ => 1)
            (fun S => sumOverFiniteSet Av hX (fun T => Mat.entry F S T) (E S))) :=
          (smul_sumOverFiniteSet Av h00 C.uniqueness.mul_zero hX _ _ ρ).symm
      _ = Av.smul ρ (D.homomorphismFromMatrix C F) := rfl

/-- 本文 `claim_homomorphism_from_matrix_algebra_to_clifford_algebra_on_matrix_unit` の必要十分版：Ψ(E_{S,T}) = ℰ_{S,T}。 -/
theorem homomorphismFromMatrix_matrixUnit (S T : PowerSet D.M) :
    D.homomorphismFromMatrix C (matrixUnit S T) = D.matrixUnitElement C S T := by
  let A := (D.space C).cliffordAlgebra C
  let Av := A.toVectorSpace
  let hX := isFiniteSet_powerSet D.M
  let E := D.matrixUnitElement C
  have h00 : (0 : K) + 0 = 0 := C.uniqueness.add_zero 0
  -- （イ）：乗法の交換法則（δ_{S,S'} · δ_{T,T'} の入れ替え）を使う
  have hI : ∀ S' T' : PowerSet D.M,
      Av.smul (Mat.entry (matrixUnit S T : Mat K (PowerSet D.M)) S' T') (E S' T')
        = Av.smul (kroneckerDelta T T') (Av.smul (kroneckerDelta S S') (E S' T')) := fun S' T' => calc
    Av.smul (Mat.entry (matrixUnit S T : Mat K (PowerSet D.M)) S' T') (E S' T')
        = Av.smul ((kroneckerDelta S S' : K) * kroneckerDelta T T') (E S' T') := rfl
    _ = Av.smul ((kroneckerDelta T T' : K) * kroneckerDelta S S') (E S' T') := by
        rw [C.mul_comm (kroneckerDelta S S') (kroneckerDelta T T')]
    _ = Av.smul (kroneckerDelta T T') (Av.smul (kroneckerDelta S S') (E S' T')) := Av.smul_assoc _ _ _
  -- （ロ）
  have hII : ∀ S' : PowerSet D.M,
      sumOverFiniteSet Av hX (fun T' => (kroneckerDelta T T' : K))
          (fun T' => Av.smul (kroneckerDelta S S') (E S' T'))
        = Av.smul (kroneckerDelta S S') (E S' T) := fun S' =>
    sumOverFiniteSet_kroneckerDelta Av h00 hX (fun T' => Av.smul (kroneckerDelta S S') (E S' T')) T
  -- （ハ）：1 · a = a を使う
  have hIII : ∀ S' : PowerSet D.M,
      Av.smul 1 (Av.smul (kroneckerDelta S S') (E S' T)) = Av.smul (kroneckerDelta S S') (E S' T) :=
    fun S' => calc
    Av.smul 1 (Av.smul (kroneckerDelta S S') (E S' T)) = Av.smul (1 * (kroneckerDelta S S' : K)) (E S' T) :=
        (Av.smul_assoc _ _ _).symm
    _ = Av.smul (kroneckerDelta S S') (E S' T) := by rw [C.uniqueness.one_mul]
  calc D.homomorphismFromMatrix C (matrixUnit S T)
      = sumOverFiniteSet Av hX (fun _ => 1)
          (fun S' => sumOverFiniteSet Av hX
            (fun T' => Mat.entry (matrixUnit S T : Mat K (PowerSet D.M)) S' T') (E S')) := rfl
    _ = sumOverFiniteSet Av hX (fun _ => 1)
          (fun S' => sumOverFiniteSet Av hX (fun T' => (kroneckerDelta T T' : K))
            (fun T' => Av.smul (kroneckerDelta S S') (E S' T'))) :=
        sumOverFiniteSet_double_congr Av hX hX _ _ _ _ hI
    _ = sumOverFiniteSet Av hX (fun _ => 1) (fun S' => Av.smul (kroneckerDelta S S') (E S' T)) :=
        sumOverFiniteSet_congr Av hX _ _ _ _ fun S' => by rw [hII S']
    _ = sumOverFiniteSet Av hX (fun S' => (kroneckerDelta S S' : K)) (fun S' => E S' T) :=
        sumOverFiniteSet_congr Av hX _ _ _ _ hIII
    _ = E S T := sumOverFiniteSet_kroneckerDelta Av h00 hX (fun S' => E S' T) S

/-- 本文 `claim_homomorphism_from_matrix_algebra_to_clifford_algebra_preserves_product_of_matrix_units` の必要十分版。 -/
theorem homomorphismFromMatrix_mul_matrixUnit (hneg : ∀ a : K, a + -a = 0) (S T U R : PowerSet D.M) :
    D.homomorphismFromMatrix C ((D.matrixAlgebra C).mul (matrixUnit S T) (matrixUnit U R))
      = ((D.space C).cliffordAlgebra C).mul (D.homomorphismFromMatrix C (matrixUnit S T))
          (D.homomorphismFromMatrix C (matrixUnit U R)) := by
  let A := (D.space C).cliffordAlgebra C
  calc D.homomorphismFromMatrix C ((D.matrixAlgebra C).mul (matrixUnit S T) (matrixUnit U R))
      = D.homomorphismFromMatrix C (Mat.smul (kroneckerDelta T U) (matrixUnit S R)) := by
        rw [show (D.matrixAlgebra C).mul (matrixUnit S T) (matrixUnit U R)
          = Mat.smul (kroneckerDelta T U) (matrixUnit S R : Mat K (PowerSet D.M))
          from matrixUnit_mul_matrixUnit C.valuedMaps (fun a => C.mul_comm 0 a) (fun a => C.mul_comm 1 a)
            (isFiniteSet_powerSet D.M) S T U R]
    _ = A.smul (kroneckerDelta T U) (D.homomorphismFromMatrix C (matrixUnit S R)) :=
        (D.homomorphismFromMatrix_isLinearMap C).map_smul _ _
    _ = A.smul (kroneckerDelta T U) (D.matrixUnitElement C S R) := by
        rw [D.homomorphismFromMatrix_matrixUnit C S R]
    _ = A.mul (D.matrixUnitElement C S T) (D.matrixUnitElement C U R) :=
        (D.matrixUnitElement_mul C hneg S T U R).symm
    _ = A.mul (D.homomorphismFromMatrix C (matrixUnit S T)) (D.homomorphismFromMatrix C (matrixUnit U R)) := by
        rw [D.homomorphismFromMatrix_matrixUnit C S T, D.homomorphismFromMatrix_matrixUnit C U R]

/-- 本文 `claim_homomorphism_from_matrix_algebra_to_clifford_algebra_is_algebra_homomorphism` の必要十分版。 -/
theorem homomorphismFromMatrix_isHom (hneg : ∀ a : K, a + -a = 0) :
    IsAlgebraHomomorphism (D.matrixAlgebra C) ((D.space C).cliffordAlgebra C) (D.homomorphismFromMatrix C) := by
  let A := (D.space C).cliffordAlgebra C
  let Av := A.toVectorSpace
  let B := D.matrixAlgebra C
  let Bv := B.toVectorSpace
  let hX := isFiniteSet_powerSet D.M
  let E := D.matrixUnitElement C
  let Ψ := D.homomorphismFromMatrix C
  have h00 : (0 : K) + 0 = 0 := C.uniqueness.add_zero 0
  have hΨ : IsLinearMap Bv Av Ψ := D.homomorphismFromMatrix_isLinearMap C
  -- （イ）乗法の単位元
  have hdelta : ∀ S : PowerSet D.M,
      sumOverFiniteSet Av hX (fun T => (kroneckerDelta S T : K)) (E S) = E S S :=
    fun S => sumOverFiniteSet_kroneckerDelta Av h00 hX (E S) S
  have hone : Ψ B.one = A.one := calc
    Ψ B.one = sumOverFiniteSet Av hX (fun _ => 1)
          (fun S => sumOverFiniteSet Av hX
            (fun T => Mat.entry (Mat.one : Mat K (PowerSet D.M)) S T) (E S)) := rfl
    _ = sumOverFiniteSet Av hX (fun _ => 1)
          (fun S => sumOverFiniteSet Av hX (fun T => (kroneckerDelta S T : K)) (E S)) :=
        sumOverFiniteSet_double_congr Av hX hX _ _ _ _ fun _ _ => rfl
    _ = sumOverFiniteSet Av hX (fun _ => 1) (fun S => E S S) :=
        sumOverFiniteSet_congr Av hX _ _ _ _ fun S => by rw [hdelta S]
    _ = sumOverFiniteSet Av hX (fun _ => 1)
          (fun S => A.mul (A.mul (D.orderedCreationProduct C S) (D.vacuumElement C))
            (D.reverseOrderedAnnihilationProduct C S)) :=
        sumOverFiniteSet_congr Av hX _ _ _ _ fun _ => rfl
    _ = A.one := D.decomposition_of_unity C hneg
  -- 行列の行列単位による分解
  have hdecomp : ∀ G : Mat K (PowerSet D.M), G = sumOverFiniteSet Bv hX (fun _ => 1)
      (fun S' => sumOverFiniteSet Bv hX (fun T' => Mat.entry G S' T') (fun T' => matrixUnit S' T')) :=
    fun G => eq_double_sum_entry_smul_matrixUnit C.valuedMaps (fun a => C.mul_comm 0 a)
      (fun a => C.mul_comm 1 a) hX G
  -- （ロ）行列単位を左に置いた積
  have hleft : ∀ (S T : PowerSet D.M) (G : Mat K (PowerSet D.M)),
      Ψ (B.mul (matrixUnit S T) G) = A.mul (Ψ (matrixUnit S T)) (Ψ G) := by
    intro S T G
    have hL := leftMul_isLinearMap B (matrixUnit S T)
    have hL' := leftMul_isLinearMap A (Ψ (matrixUnit S T))
    calc Ψ (B.mul (matrixUnit S T) G)
        = Ψ (B.mul (matrixUnit S T) (sumOverFiniteSet Bv hX (fun _ => 1)
            (fun S' => sumOverFiniteSet Bv hX (fun T' => Mat.entry G S' T') (fun T' => matrixUnit S' T')))) := by
          rw [← hdecomp G]
      _ = Ψ (sumOverFiniteSet Bv hX (fun _ => 1)
            (fun S' => sumOverFiniteSet Bv hX (fun T' => Mat.entry G S' T')
              (fun T' => B.mul (matrixUnit S T) (matrixUnit S' T')))) := by
          rw [hL.map_double_sumOverFiniteSet h00 hX hX]
      _ = sumOverFiniteSet Av hX (fun _ => 1)
            (fun S' => sumOverFiniteSet Av hX (fun T' => Mat.entry G S' T')
              (fun T' => Ψ (B.mul (matrixUnit S T) (matrixUnit S' T')))) :=
          hΨ.map_double_sumOverFiniteSet h00 hX hX _ _
      _ = sumOverFiniteSet Av hX (fun _ => 1)
            (fun S' => sumOverFiniteSet Av hX (fun T' => Mat.entry G S' T')
              (fun T' => A.mul (Ψ (matrixUnit S T)) (Ψ (matrixUnit S' T')))) :=
          sumOverFiniteSet_double_congr Av hX hX _ _ _ _ fun S' T' =>
            congrArg (Av.smul (Mat.entry G S' T')) (D.homomorphismFromMatrix_mul_matrixUnit C hneg S T S' T')
      _ = A.mul (Ψ (matrixUnit S T)) (sumOverFiniteSet Av hX (fun _ => 1)
            (fun S' => sumOverFiniteSet Av hX (fun T' => Mat.entry G S' T') (fun T' => Ψ (matrixUnit S' T')))) :=
          (hL'.map_double_sumOverFiniteSet h00 hX hX _ _).symm
      _ = A.mul (Ψ (matrixUnit S T)) (Ψ (sumOverFiniteSet Bv hX (fun _ => 1)
            (fun S' => sumOverFiniteSet Bv hX (fun T' => Mat.entry G S' T') (fun T' => matrixUnit S' T')))) := by
          rw [hΨ.map_double_sumOverFiniteSet h00 hX hX]
      _ = A.mul (Ψ (matrixUnit S T)) (Ψ G) := by rw [← hdecomp G]
  -- （ハ）乗法
  have hmul : ∀ F G : Mat K (PowerSet D.M), Ψ (B.mul F G) = A.mul (Ψ F) (Ψ G) := by
    intro F G
    have hR := rightMul_isLinearMap B G
    have hR' := rightMul_isLinearMap A (Ψ G)
    calc Ψ (B.mul F G)
        = Ψ (B.mul (sumOverFiniteSet Bv hX (fun _ => 1)
            (fun S => sumOverFiniteSet Bv hX (fun T => Mat.entry F S T) (fun T => matrixUnit S T))) G) := by
          rw [← hdecomp F]
      _ = Ψ (sumOverFiniteSet Bv hX (fun _ => 1)
            (fun S => sumOverFiniteSet Bv hX (fun T => Mat.entry F S T) (fun T => B.mul (matrixUnit S T) G))) := by
          rw [hR.map_double_sumOverFiniteSet h00 hX hX]
      _ = sumOverFiniteSet Av hX (fun _ => 1)
            (fun S => sumOverFiniteSet Av hX (fun T => Mat.entry F S T) (fun T => Ψ (B.mul (matrixUnit S T) G))) :=
          hΨ.map_double_sumOverFiniteSet h00 hX hX _ _
      _ = sumOverFiniteSet Av hX (fun _ => 1)
            (fun S => sumOverFiniteSet Av hX (fun T => Mat.entry F S T)
              (fun T => A.mul (Ψ (matrixUnit S T)) (Ψ G))) :=
          sumOverFiniteSet_double_congr Av hX hX _ _ _ _ fun S T => by rw [hleft S T G]
      _ = A.mul (sumOverFiniteSet Av hX (fun _ => 1)
            (fun S => sumOverFiniteSet Av hX (fun T => Mat.entry F S T) (fun T => Ψ (matrixUnit S T)))) (Ψ G) :=
          (hR'.map_double_sumOverFiniteSet h00 hX hX _ _).symm
      _ = A.mul (Ψ (sumOverFiniteSet Bv hX (fun _ => 1)
            (fun S => sumOverFiniteSet Bv hX (fun T => Mat.entry F S T) (fun T => matrixUnit S T)))) (Ψ G) := by
          rw [hΨ.map_double_sumOverFiniteSet h00 hX hX]
      _ = A.mul (Ψ F) (Ψ G) := by rw [← hdecomp F]
  exact ⟨⟨hΨ.map_add, hmul, hone⟩, hΨ⟩

end

end CliffordMatrixIsomorphism.NecSuf.Clifford.SplitData
