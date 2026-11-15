/-
章「同型の証明」の節「系：奇数次元の二次空間」のうち、分裂した二次空間に一つの次元を足した空間 (V', q')、
第一成分への埋め込みが誘導する準同型 j、足した次元の単位の元 u とその像 g の必要十分版。具体版
`Isomorphism/OddDimensional/OddExtension.lean` と同じ def・calc の行を、係数 ℂ を型の変数 K に、-1_ℂ を K の元 n に替えて書く。
本文のラベルと宣言の対応は具体版の冒頭の表と同じである（宣言の名前も同じ）。具体版との違いは次の三つ。
- V' と q' と、q' についての五つの主張（偏極・二次形式・in'_1 が等長写像・q'(in'_2(1)) = 1・B_{q'}(in'_1(v), in'_2(1)) = 0）は、
  V := W ⊕ W^*、q := q_W に限らず、任意の K-線型空間 S と写像 q : V → K について書く（名前空間 `NecSuf.VectorSpace`）。
  K^vec は `coefficientsVec L`（L : `ValuedMapsLaws K`。K を自分自身の上の線型空間にする八つの性質）である。
  q が二次形式であることは、それを使う主張だけの仮定 `hq` にし、q'(in'_2(1)) = 1 には q の一つ目の条件 `hsmul` だけを置く。
- 基底 d'・A'・j・u・g は、必要十分版の前提の組 `SplitData K W` と `CliffordLaws K n` の上で書く（名前空間 `NecSuf.Clifford.SplitData`）。
- 具体版が `ring` 一行で済ませる「ℂ の四則」の行は、その行の中で K の公理を一つずつ当てる。-(a + b) = -a + -b は仮定に置かず、
  加法の結合法則・交換法則・a + (-a) = 0・a + 0 = a・0 + a = 0 から導く（`neg_add_eq`）。

主張ごとに使う K の性質（V' を線型空間にする L の八つの性質は、どの主張も持つ。下に書くのはそのほかに行の中で使う性質である）:

  unitFamily・linearCombination_unitFamily・unitFamily_isBasis
                                         a · 1 = a、0 + a = a（準備の式の 0 + λ_1 · 1 = λ_1）
  polarization_oddForm                   加法の結合法則・交換法則、a + (-a) = 0、a + 0 = a、0 + a = a（-(a+b) = -a + -b を導くため）、
                                         左右の分配法則（(t+t')·(t+t') の展開）。乗法の結合法則・交換法則は使わない
  oddForm_isQuadraticForm                上の性質、q が二次形式であること、乗法の結合法則と交換法則（(λt)(λt) = λ(λ(tt)) と
                                         t'(λt) = λ(t't) の行で、t と λ を入れ替える）
  oddForm_oddInclusion                   a · 0 = 0、a + 0 = a
  oddInclusion_isIsometry                上の二つの和と、in'_1 が線型であることの 0 + 0 = 0・a · 0 = 0
  oddForm_oddSecondInclusion_one         q の一つ目の条件 q(λ ·_V x) = λ(λ q(x)) だけ（二つ目の条件は使わない）、0 + 0 = 0・a · 0 = 0
                                         （λ ·_V 0_V = 0_V）、0 · a = 0、1 · 1 = 1、0 + a = a
  polarization_oddInclusion_oddSecondInclusion_one
                                         polarization_oddForm の性質、q が二次形式であること（B_q(v, •) が線型形式）、
                                         0 · a = 0、1 · 0 = 0、0 + 0 = 0、a + 0 = a
  oddSpace・oddInclusionHom・addedUnitVector・addedGenerator
                                         `CliffordLaws K n`（V を作るため）と、j を作るための a + (-a) = 0（等長写像が誘導する準同型の存在）
  oddInclusionHom_γ                      同じ
  addedGenerator_mul_self                `CliffordLaws K n` と a + (-a) = 0（γ'(u)² の計算と、q_W が二次形式であることの一つ目の条件）
  addedGenerator_anticommute             同じ（γ' の反交換子・q_W が二次形式であること・零のスカラー倍）

分かったこと:
- q' の主張のどれも、q が q_W であることを使わない。任意の二次形式 q に一つの次元を足した q' について同じ証明が通る。
- q'(in'_2(1)) = 1 は q の二次形式の条件のうち q(λ ·_V x) = λ(λ q(x)) だけを使い（q(0_V) = 0 を出すため）、
  偏極が線型であることは使わない。q' が二次形式であることの証明は q が二次形式であることの両方の条件を使う。
- q' が二次形式であることには K の乗法の交換法則が要る（足した成分 t·t の偏極 t·t' + t'·t をスカラー倍の行で λ の外へ出すため）。
  偏極の値そのもの（polarization_oddForm）は乗法の結合法則も交換法則も使わない。
- 2 の可逆性（1 + 1 ≠ 0）と平方根は、どの主張も使わない。足した次元の偏極は t·t' + t'·t のまま扱い、(1+1)·t·t' に書き換えない。
- 本文の前提 M ∈ ℤ_{≥1} は、どの主張も使わない（M = 0 でも同じ証明が通る）。
-/
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.GeneralEvenDimensional.InducedHomomorphism
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.GeneralEvenDimensional.OrthogonalBasis
import CliffordMatrixIsomorphism.NecSuf.CliffordAlgebra.SplitQuadraticSpace.Generators
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.ComplexVectorSpace.ComplexNumbersAsVectorSpace

namespace CliffordMatrixIsomorphism.NecSuf.VectorSpace

universe u uK

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K] [Neg K] {V : Type u}

omit [Neg K] in
/-- 本文 `def_family_of_unit_of_complex_numbers` の必要十分版：o(1) := 1。 -/
def unitFamily : ℕ → K := fun _ => 1

omit [Neg K] in
/-- 本文 `claim_family_of_unit_is_basis_of_complex_numbers` の証明の準備の式の必要十分版。 -/
theorem linearCombination_unitFamily (L : ValuedMapsLaws K) (hmul_one : ∀ a : K, a * 1 = a)
    (hzero_add : ∀ a : K, 0 + a = a) (c : ℕ → K) :
    linearCombination (coefficientsVec L) 1 c unitFamily = c 1 := calc
  linearCombination (coefficientsVec L) 1 c unitFamily
      = (coefficientsVec L).add (coefficientsVec L).zero ((coefficientsVec L).smul (c 1) (unitFamily 1)) := rfl
  _ = 0 + c 1 * unitFamily 1 := rfl
  _ = 0 + c 1 * 1 := rfl
  _ = c 1 := by rw [hmul_one (c 1), hzero_add (c 1)]

omit [Neg K] in
/-- 本文 `claim_family_of_unit_is_basis_of_complex_numbers` の必要十分版。 -/
theorem unitFamily_isBasis (L : ValuedMapsLaws K) (hmul_one : ∀ a : K, a * 1 = a)
    (hzero_add : ∀ a : K, 0 + a = a) : IsBasisFamily (coefficientsVec L) 1 unitFamily where
  linearlyIndependent := by
    intro c hc k hk1 hk
    have hk' : k = 1 := by omega
    subst hk'
    calc c 1 = linearCombination (coefficientsVec L) 1 c unitFamily :=
          (linearCombination_unitFamily L hmul_one hzero_add c).symm
      _ = (coefficientsVec L).zero := hc
      _ = 0 := rfl
  spans := fun t => ⟨fun _ => t, linearCombination_unitFamily L hmul_one hzero_add (fun _ => t)⟩

omit [One K] [Zero K] [Neg K] [Mul K] in
/-- K の中の (p + q) + (r + s) = (p + r) + (q + s)（加法の結合法則と交換法則だけ。「ℂ の四則」の行で使う）。 -/
theorem add_add_add_comm' (hassoc : ∀ a b c : K, (a + b) + c = a + (b + c)) (hcomm : ∀ a b : K, a + b = b + a)
    (p q r s : K) : (p + q) + (r + s) = (p + r) + (q + s) := calc
  (p + q) + (r + s) = p + (q + (r + s)) := by rw [hassoc p q (r + s)]
  _ = p + ((q + r) + s) := by rw [hassoc q r s]
  _ = p + ((r + q) + s) := by rw [hcomm q r]
  _ = p + (r + (q + s)) := by rw [hassoc r q s]
  _ = (p + r) + (q + s) := by rw [hassoc p r (q + s)]

omit [Mul K] [One K] in
/-- K の中の -(a + b) = -a + -b を、加法の結合法則・交換法則・a + (-a) = 0・a + 0 = a・0 + a = a から導く。 -/
theorem neg_add_eq (hassoc : ∀ a b c : K, (a + b) + c = a + (b + c)) (hcomm : ∀ a b : K, a + b = b + a)
    (hneg : ∀ a : K, a + -a = 0) (hadd_zero : ∀ a : K, a + 0 = a) (hzero_add : ∀ a : K, 0 + a = a)
    (a b : K) : -(a + b) = -a + -b := by
  have h0 : (a + b) + (-a + -b) = 0 := calc
    (a + b) + (-a + -b) = (a + -a) + (b + -b) := add_add_add_comm' hassoc hcomm a b (-a) (-b)
    _ = 0 + 0 := by rw [hneg a, hneg b]
    _ = 0 := hzero_add 0
  calc -(a + b) = -(a + b) + 0 := (hadd_zero _).symm
    _ = -(a + b) + ((a + b) + (-a + -b)) := by rw [h0]
    _ = (-(a + b) + (a + b)) + (-a + -b) := (hassoc _ _ _).symm
    _ = ((a + b) + -(a + b)) + (-a + -b) := by rw [hcomm (-(a + b)) (a + b)]
    _ = 0 + (-a + -b) := by rw [hneg (a + b)]
    _ = -a + -b := hzero_add _

/-! ### 一つの次元を足した空間 V' と q' -/

omit [Neg K] in
/-- 本文 `def_odd_dimensional_extension_of_split_quadratic_space` の V' := V ⊕ K^vec の必要十分版。 -/
abbrev oddVectorSpace (L : ValuedMapsLaws K) (S : VectorSpace K V) : VectorSpace K (V × K) :=
  directSumVectorSpace S (coefficientsVec L)

omit [Zero K] [Neg K] in
/-- 本文 `def_odd_dimensional_extension_of_split_quadratic_space` の q'((v, t)) := q(v) + t · t の必要十分版。 -/
def oddForm (q : V → K) (p : V × K) : K := q p.1 + p.2 * p.2

omit [Neg K] in
/-- 本文 `def_odd_dimensional_extension_of_split_quadratic_space` の in'_1 の必要十分版。 -/
def oddInclusion (L : ValuedMapsLaws K) : V → V × K := embedFirst (coefficientsVec L)

omit [Neg K] in
/-- 本文 `def_odd_dimensional_extension_of_split_quadratic_space` の in'_2 の必要十分版。 -/
def oddSecondInclusion (S : VectorSpace K V) : K → V × K := embedSecond S

/-- 本文 `claim_polarization_of_odd_extension_quadratic_form` の必要十分版。 -/
theorem polarization_oddForm (L : ValuedMapsLaws K) (hneg : ∀ a : K, a + -a = 0) (hzero_add : ∀ a : K, 0 + a = a)
    (S : VectorSpace K V) (q : V → K) (v v' : V) (t t' : K) :
    polarization (oddVectorSpace L S) (oddForm q) (v, t) (v', t')
      = polarization S q v v' + (t * t' + t' * t) := by
  have hna := neg_add_eq L.add_assoc L.add_comm hneg L.add_zero hzero_add
  -- 「ℂ の四則」の行：a := q(v +_V v')、b := q(v)、c := q(v')
  have harith : ∀ a b c : K, ((a + (t + t') * (t + t')) + -(b + t * t)) + -(c + t' * t')
      = ((a + -b) + -c) + (t * t' + t' * t) := fun a b c => calc
    ((a + (t + t') * (t + t')) + -(b + t * t)) + -(c + t' * t')
        = ((a + (t + t') * (t + t')) + (-b + -(t * t))) + (-c + -(t' * t')) := by
          rw [hna b (t * t), hna c (t' * t')]
    _ = ((a + -b) + ((t + t') * (t + t') + -(t * t))) + (-c + -(t' * t')) := by
          rw [add_add_add_comm' L.add_assoc L.add_comm a ((t + t') * (t + t')) (-b) (-(t * t))]
    _ = ((a + -b) + -c) + (((t + t') * (t + t') + -(t * t)) + -(t' * t')) := by
          rw [add_add_add_comm' L.add_assoc L.add_comm (a + -b) ((t + t') * (t + t') + -(t * t)) (-c) (-(t' * t'))]
    _ = ((a + -b) + -c) + ((((t + t') * t + (t + t') * t') + -(t * t)) + -(t' * t')) := by
          rw [L.left_distrib (t + t') t t']
    _ = ((a + -b) + -c) + ((((t * t + t' * t) + (t * t' + t' * t')) + -(t * t)) + -(t' * t')) := by
          rw [L.right_distrib t t' t, L.right_distrib t t' t']
    _ = ((a + -b) + -c) + (((t * t + (t' * t + (t * t' + t' * t'))) + -(t * t)) + -(t' * t')) := by
          rw [L.add_assoc (t * t) (t' * t) (t * t' + t' * t')]
    _ = ((a + -b) + -c) + ((((t' * t + (t * t' + t' * t')) + t * t) + -(t * t)) + -(t' * t')) := by
          rw [L.add_comm (t * t) (t' * t + (t * t' + t' * t'))]
    _ = ((a + -b) + -c) + (((t' * t + (t * t' + t' * t')) + (t * t + -(t * t))) + -(t' * t')) := by
          rw [L.add_assoc (t' * t + (t * t' + t' * t')) (t * t) (-(t * t))]
    _ = ((a + -b) + -c) + (((t' * t + (t * t' + t' * t')) + 0) + -(t' * t')) := by rw [hneg (t * t)]
    _ = ((a + -b) + -c) + ((t' * t + (t * t' + t' * t')) + -(t' * t')) := by
          rw [L.add_zero (t' * t + (t * t' + t' * t'))]
    _ = ((a + -b) + -c) + (((t' * t + t * t') + t' * t') + -(t' * t')) := by
          rw [L.add_assoc (t' * t) (t * t') (t' * t')]
    _ = ((a + -b) + -c) + ((t' * t + t * t') + (t' * t' + -(t' * t'))) := by
          rw [L.add_assoc (t' * t + t * t') (t' * t') (-(t' * t'))]
    _ = ((a + -b) + -c) + ((t' * t + t * t') + 0) := by rw [hneg (t' * t')]
    _ = ((a + -b) + -c) + (t' * t + t * t') := by rw [L.add_zero (t' * t + t * t')]
    _ = ((a + -b) + -c) + (t * t' + t' * t) := by rw [L.add_comm (t' * t) (t * t')]
  calc polarization (oddVectorSpace L S) (oddForm q) (v, t) (v', t')
      = (oddForm q ((oddVectorSpace L S).add (v, t) (v', t')) + -oddForm q (v, t)) + -oddForm q (v', t') := rfl
    _ = (oddForm q (S.add v v', (coefficientsVec L).add t t') + -oddForm q (v, t)) + -oddForm q (v', t') := rfl
    _ = (oddForm q (S.add v v', t + t') + -oddForm q (v, t)) + -oddForm q (v', t') := rfl
    _ = ((q (S.add v v') + (t + t') * (t + t')) + -(q v + t * t)) + -(q v' + t' * t') := rfl
    _ = ((q (S.add v v') + -q v) + -q v') + (t * t' + t' * t) := harith _ _ _
    _ = polarization S q v v' + (t * t' + t' * t) := rfl

/-- 本文 `claim_odd_extension_quadratic_form_is_quadratic_form` の必要十分版。 -/
theorem oddForm_isQuadraticForm (L : ValuedMapsLaws K) (hneg : ∀ a : K, a + -a = 0) (hzero_add : ∀ a : K, 0 + a = a)
    (hmul_comm : ∀ a b : K, a * b = b * a) (S : VectorSpace K V) (q : V → K) (hq : IsQuadraticForm S q) :
    IsQuadraticForm (oddVectorSpace L S) (oddForm q) where
  map_smul l p := calc
    oddForm q ((oddVectorSpace L S).smul l p) = oddForm q (S.smul l p.1, (coefficientsVec L).smul l p.2) := rfl
    _ = oddForm q (S.smul l p.1, l * p.2) := rfl
    _ = q (S.smul l p.1) + (l * p.2) * (l * p.2) := rfl
    _ = l * (l * q p.1) + (l * p.2) * (l * p.2) := by rw [hq.map_smul l p.1]
    _ = l * (l * (q p.1 + p.2 * p.2)) := by
        rw [L.mul_assoc l p.2 (l * p.2), ← L.mul_assoc p.2 l p.2, hmul_comm p.2 l, L.mul_assoc l p.2 p.2,
          ← L.left_distrib l (l * q p.1) (l * (p.2 * p.2)), ← L.left_distrib l (q p.1) (p.2 * p.2)]
    _ = l * (l * oddForm q p) := rfl
  polarization_isLinearForm y := {
    map_add := fun p₁ p₂ => calc
      polarization (oddVectorSpace L S) (oddForm q) ((oddVectorSpace L S).add p₁ p₂) y
          = polarization (oddVectorSpace L S) (oddForm q) (S.add p₁.1 p₂.1, p₁.2 + p₂.2) (y.1, y.2) := rfl
      _ = polarization S q (S.add p₁.1 p₂.1) y.1 + ((p₁.2 + p₂.2) * y.2 + y.2 * (p₁.2 + p₂.2)) :=
          polarization_oddForm L hneg hzero_add S q _ _ _ _
      _ = (polarization S q p₁.1 y.1 + polarization S q p₂.1 y.1) + ((p₁.2 + p₂.2) * y.2 + y.2 * (p₁.2 + p₂.2)) := by
          rw [(hq.polarization_isLinearForm y.1).map_add p₁.1 p₂.1]
      _ = (polarization S q p₁.1 y.1 + (p₁.2 * y.2 + y.2 * p₁.2))
            + (polarization S q p₂.1 y.1 + (p₂.2 * y.2 + y.2 * p₂.2)) := by
          rw [L.right_distrib p₁.2 p₂.2 y.2, L.left_distrib y.2 p₁.2 p₂.2,
            add_add_add_comm' L.add_assoc L.add_comm (p₁.2 * y.2) (p₂.2 * y.2) (y.2 * p₁.2) (y.2 * p₂.2),
            add_add_add_comm' L.add_assoc L.add_comm (polarization S q p₁.1 y.1) (polarization S q p₂.1 y.1)
              (p₁.2 * y.2 + y.2 * p₁.2) (p₂.2 * y.2 + y.2 * p₂.2)]
      _ = polarization (oddVectorSpace L S) (oddForm q) (p₁.1, p₁.2) (y.1, y.2)
            + polarization (oddVectorSpace L S) (oddForm q) (p₂.1, p₂.2) (y.1, y.2) := by
          rw [polarization_oddForm L hneg hzero_add S q p₁.1 y.1 p₁.2 y.2,
            polarization_oddForm L hneg hzero_add S q p₂.1 y.1 p₂.2 y.2]
    map_smul := fun l p => calc
      polarization (oddVectorSpace L S) (oddForm q) ((oddVectorSpace L S).smul l p) y
          = polarization (oddVectorSpace L S) (oddForm q) (S.smul l p.1, l * p.2) (y.1, y.2) := rfl
      _ = polarization S q (S.smul l p.1) y.1 + ((l * p.2) * y.2 + y.2 * (l * p.2)) :=
          polarization_oddForm L hneg hzero_add S q _ _ _ _
      _ = l * polarization S q p.1 y.1 + ((l * p.2) * y.2 + y.2 * (l * p.2)) := by
          rw [(hq.polarization_isLinearForm y.1).map_smul l p.1]
      _ = l * (polarization S q p.1 y.1 + (p.2 * y.2 + y.2 * p.2)) := by
          rw [L.mul_assoc l p.2 y.2, ← L.mul_assoc y.2 l p.2, hmul_comm y.2 l, L.mul_assoc l y.2 p.2,
            ← L.left_distrib l (p.2 * y.2) (y.2 * p.2),
            ← L.left_distrib l (polarization S q p.1 y.1) (p.2 * y.2 + y.2 * p.2)]
      _ = l * polarization (oddVectorSpace L S) (oddForm q) (p.1, p.2) (y.1, y.2) := by
          rw [polarization_oddForm L hneg hzero_add S q p.1 y.1 p.2 y.2] }

omit [Neg K] in
/-- 本文 `claim_embedding_into_first_component_of_odd_extension_is_isometry` の証明の式変形の必要十分版：q'(in'_1(v)) = q(v)。 -/
theorem oddForm_oddInclusion (L : ValuedMapsLaws K) (hmul_zero : ∀ a : K, a * 0 = 0) (q : V → K) (v : V) :
    oddForm q (oddInclusion L v) = q v := calc
  oddForm q (oddInclusion L v) = oddForm q (v, (coefficientsVec L).zero) := rfl
  _ = oddForm q (v, 0) := rfl
  _ = q v + 0 * 0 := rfl
  _ = q v := by rw [hmul_zero 0, L.add_zero (q v)]

/-- 本文 `claim_embedding_into_first_component_of_odd_extension_is_isometry` の必要十分版。 -/
theorem oddInclusion_isIsometry (L : ValuedMapsLaws K) (hneg : ∀ a : K, a + -a = 0) (hzero_add : ∀ a : K, 0 + a = a)
    (hmul_comm : ∀ a b : K, a * b = b * a) (hmul_zero : ∀ a : K, a * 0 = 0) (h00 : (0 : K) + 0 = 0)
    (S : VectorSpace K V) (q : V → K) (hq : IsQuadraticForm S q) :
    IsIsometry S (oddVectorSpace L S) q (oddForm q) (oddInclusion L) where
  isQuadraticForm := hq
  isQuadraticForm' := oddForm_isQuadraticForm L hneg hzero_add hmul_comm S q hq
  isLinearMap := embedFirst_isLinearMap S (coefficientsVec L) h00 hmul_zero
  map_form := oddForm_oddInclusion L hmul_zero q

omit [Neg K] in
/-- 本文 `claim_odd_extension_quadratic_form_at_added_unit_vector_is_one` の必要十分版。q について使うのは
二次形式の一つ目の条件 `hsmul` だけである。 -/
theorem oddForm_oddSecondInclusion_one (h00 : (0 : K) + 0 = 0) (hmul_zero : ∀ a : K, a * 0 = 0)
    (hzero_mul : ∀ a : K, 0 * a = 0) (hone_mul : ∀ a : K, 1 * a = a) (hzero_add : ∀ a : K, 0 + a = a)
    (S : VectorSpace K V) (q : V → K) (hsmul : ∀ (l : K) (x : V), q (S.smul l x) = l * (l * q x)) :
    oddForm q (oddSecondInclusion S 1) = 1 := calc
  oddForm q (oddSecondInclusion S 1) = oddForm q (S.zero, 1) := rfl
  _ = q S.zero + 1 * 1 := rfl
  _ = q (S.smul 0 S.zero) + 1 * 1 := by rw [smul_zero_eq_zero S h00 hmul_zero 0]
  _ = 0 * (0 * q S.zero) + 1 * 1 := by rw [hsmul 0 S.zero]
  _ = 1 := by rw [hzero_mul (0 * q S.zero), hone_mul 1, hzero_add 1]

/-- 本文 `claim_polarization_of_odd_extension_between_first_component_and_added_unit_vector_is_zero` の必要十分版。 -/
theorem polarization_oddInclusion_oddSecondInclusion_one (L : ValuedMapsLaws K) (hneg : ∀ a : K, a + -a = 0)
    (hzero_add : ∀ a : K, 0 + a = a) (hzero_mul : ∀ a : K, 0 * a = 0) (h00 : (0 : K) + 0 = 0)
    (S : VectorSpace K V) (q : V → K) (hq : IsQuadraticForm S q) (v : V) :
    polarization (oddVectorSpace L S) (oddForm q) (oddInclusion L v) (oddSecondInclusion S 1) = 0 := calc
  polarization (oddVectorSpace L S) (oddForm q) (oddInclusion L v) (oddSecondInclusion S 1)
      = polarization (oddVectorSpace L S) (oddForm q) (v, (coefficientsVec L).zero) (S.zero, 1) := rfl
  _ = polarization (oddVectorSpace L S) (oddForm q) (v, 0) (S.zero, 1) := rfl
  _ = polarization S q v S.zero + (0 * 1 + 1 * 0) := polarization_oddForm L hneg hzero_add S q v S.zero 0 1
  _ = polarization S q v S.zero := by rw [hzero_mul 1, L.one_mul 0, h00, L.add_zero (polarization S q v S.zero)]
  _ = 0 := (polarization_isLinearForm_right L.add_assoc L.add_comm S q hq v).map_zero h00 hzero_mul

end CliffordMatrixIsomorphism.NecSuf.VectorSpace

namespace CliffordMatrixIsomorphism.NecSuf.Clifford.SplitData

open CliffordMatrixIsomorphism.NecSuf.VectorSpace
open CliffordMatrixIsomorphism.NecSuf.AlgebraOver

universe u uK

noncomputable section

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K] [Neg K] {n : K} (C : CliffordLaws K n)
  {W : Type u} (D : SplitData K W)

/-- q_W は二次形式である（`claim_split_quadratic_form_is_quadratic_form` の必要十分版。a + (-a) = 0 を使う）。 -/
theorem space_form_isQuadraticForm (hneg : ∀ a : K, a + -a = 0) :
    IsQuadraticForm (D.space C).space (D.space C).form :=
  splitQuadraticForm_isQuadraticForm C.dualSpaceVectorSpaceLaws D.spaceW hneg

/-! ### 奇数次元の系で固定する記号 -/

/-- 本文 `def_basis_of_odd_extension` の d' の必要十分版。 -/
def oddBasis : ℕ → (W × DualSpace D.spaceW) × K :=
  concatenatedFamily (D.space C).space (coefficientsVec C.valuedMaps) (D.M + D.M) (D.space C).basis unitFamily

/-- 本文 `def_clifford_algebra_of_odd_extension` の (V', q') と基底 d' の組の必要十分版（A' は `D.oddSpace C` の Cl、
本文 `def_clifford_generator_map_of_odd_extension` の γ' はその γ）。
必要十分版の前提の組は「q は二次形式」の欄を持たないので、q' が二次形式であることはここでは引かない。 -/
def oddSpace : QuadraticSpaceWithBasis K ((W × DualSpace D.spaceW) × K) where
  space := oddVectorSpace C.valuedMaps (D.space C).space
  dim := (D.M + D.M) + 1
  basis := D.oddBasis C
  isBasis := concatenatedFamily_isBasisFamily (D.space C).space (coefficientsVec C.valuedMaps) (D.M + D.M) 1
    (D.space C).basis unitFamily C.congruence.zero_add_zero C.uniqueness.mul_zero (D.space C).isBasis
    (unitFamily_isBasis C.valuedMaps C.mul_one C.uniqueness.zero_add)
  form := oddForm (D.space C).form

/-! ### 誘導された準同型 j、u、g -/

omit [Neg K] in
/-- in'_1 は線型写像である（`claim_embedding_into_first_component_is_linear_map` の必要十分版）。 -/
theorem oddInclusion_isLinearMap :
    IsLinearMap (D.space C).space (D.oddSpace C).space (oddInclusion C.valuedMaps) :=
  embedFirst_isLinearMap (D.space C).space (coefficientsVec C.valuedMaps) C.congruence.zero_add_zero C.uniqueness.mul_zero

omit [Neg K] in
/-- q'(in'_1(v)) = q(v)（`claim_embedding_into_first_component_of_odd_extension_is_isometry` の式変形）。 -/
theorem oddSpace_form_oddInclusion (v : W × DualSpace D.spaceW) :
    (D.oddSpace C).form (oddInclusion C.valuedMaps v) = (D.space C).form v :=
  oddForm_oddInclusion C.valuedMaps C.uniqueness.mul_zero (D.space C).form v

/-- 本文 `def_induced_homomorphism_into_odd_extension_clifford_algebra` の必要十分版：j := Cl(in'_1)。
等長写像の仮定は、必要十分版の誘導される準同型と同じく、in'_1 が線型であることと q'(in'_1(v)) = q(v) の二つだけを渡す。 -/
def oddInclusionHom (hneg : ∀ a : K, a + -a = 0) : (D.space C).Cl C → (D.oddSpace C).Cl C :=
  QuadraticSpaceWithBasis.inducedHom C hneg (D.space C) (D.oddSpace C) (oddInclusion C.valuedMaps)
    (D.oddInclusion_isLinearMap C) (D.oddSpace_form_oddInclusion C)

/-- 本文 `def_induced_homomorphism_into_odd_extension_clifford_algebra` の必要十分版：j は K-代数の準同型である。 -/
theorem oddInclusionHom_isHom (hneg : ∀ a : K, a + -a = 0) :
    IsAlgebraHomomorphism ((D.space C).cliffordAlgebra C) ((D.oddSpace C).cliffordAlgebra C) (D.oddInclusionHom C hneg) :=
  QuadraticSpaceWithBasis.inducedHom_isHom C hneg (D.space C) (D.oddSpace C) (oddInclusion C.valuedMaps)
    (D.oddInclusion_isLinearMap C) (D.oddSpace_form_oddInclusion C)

/-- 本文 `claim_induced_homomorphism_into_odd_extension_after_generator_map` の必要十分版。 -/
theorem oddInclusionHom_γ (hneg : ∀ a : K, a + -a = 0) (v : W × DualSpace D.spaceW) :
    D.oddInclusionHom C hneg ((D.space C).γ C v) = (D.oddSpace C).γ C (oddInclusion C.valuedMaps v) := calc
  D.oddInclusionHom C hneg ((D.space C).γ C v)
      = QuadraticSpaceWithBasis.inducedHom C hneg (D.space C) (D.oddSpace C) (oddInclusion C.valuedMaps)
          (D.oddInclusion_isLinearMap C) (D.oddSpace_form_oddInclusion C) ((D.space C).γ C v) := rfl
  _ = (D.oddSpace C).γ C (oddInclusion C.valuedMaps v) :=
      QuadraticSpaceWithBasis.inducedHom_γ C hneg (D.space C) (D.oddSpace C) (oddInclusion C.valuedMaps)
        (D.oddInclusion_isLinearMap C) (D.oddSpace_form_oddInclusion C) v

omit [Neg K] in
/-- 本文 `def_added_unit_vector_of_odd_extension` の必要十分版：u := in'_2(1)。 -/
def addedUnitVector : (W × DualSpace D.spaceW) × K := oddSecondInclusion (D.space C).space 1

/-- 本文 `def_added_generator_of_odd_extension_clifford_algebra` の必要十分版：g := γ'(u)。 -/
def addedGenerator : (D.oddSpace C).Cl C := (D.oddSpace C).γ C (D.addedUnitVector C)

/-- 本文 `claim_square_of_added_generator_is_one` の必要十分版。 -/
theorem addedGenerator_mul_self (hneg : ∀ a : K, a + -a = 0) :
    ((D.oddSpace C).cliffordAlgebra C).mul (D.addedGenerator C) (D.addedGenerator C)
      = ((D.oddSpace C).cliffordAlgebra C).one := by
  let A' := (D.oddSpace C).cliffordAlgebra C
  calc A'.mul (D.addedGenerator C) (D.addedGenerator C)
      = A'.mul ((D.oddSpace C).γ C (D.addedUnitVector C)) ((D.oddSpace C).γ C (D.addedUnitVector C)) := rfl
    _ = A'.smul ((D.oddSpace C).form (D.addedUnitVector C)) A'.one :=
        (D.oddSpace C).γ_mul_self C hneg (D.addedUnitVector C)
    _ = A'.smul (oddForm (D.space C).form (oddSecondInclusion (D.space C).space 1)) A'.one := rfl
    _ = A'.smul 1 A'.one := by
        rw [oddForm_oddSecondInclusion_one C.congruence.zero_add_zero C.uniqueness.mul_zero C.uniqueness.zero_mul
          C.uniqueness.one_mul C.uniqueness.zero_add (D.space C).space (D.space C).form
          (D.space_form_isQuadraticForm C hneg).map_smul]
    _ = A'.one := A'.one_smul _

/-- 本文 `claim_added_generator_anticommutes_with_image_of_split_space` の必要十分版。 -/
theorem addedGenerator_anticommute (hneg : ∀ a : K, a + -a = 0) (v : W × DualSpace D.spaceW) :
    ((D.oddSpace C).cliffordAlgebra C).add
        (((D.oddSpace C).cliffordAlgebra C).mul (D.addedGenerator C) (D.oddInclusionHom C hneg ((D.space C).γ C v)))
        (((D.oddSpace C).cliffordAlgebra C).mul (D.oddInclusionHom C hneg ((D.space C).γ C v)) (D.addedGenerator C))
      = ((D.oddSpace C).cliffordAlgebra C).zero := by
  let A' := (D.oddSpace C).cliffordAlgebra C
  let Q' := D.oddSpace C
  calc A'.add (A'.mul (D.addedGenerator C) (D.oddInclusionHom C hneg ((D.space C).γ C v)))
        (A'.mul (D.oddInclusionHom C hneg ((D.space C).γ C v)) (D.addedGenerator C))
      = A'.add (A'.mul (D.addedGenerator C) (Q'.γ C (oddInclusion C.valuedMaps v)))
          (A'.mul (Q'.γ C (oddInclusion C.valuedMaps v)) (D.addedGenerator C)) := by
        rw [D.oddInclusionHom_γ C hneg v]
    _ = A'.add (A'.mul (Q'.γ C (D.addedUnitVector C)) (Q'.γ C (oddInclusion C.valuedMaps v)))
          (A'.mul (Q'.γ C (oddInclusion C.valuedMaps v)) (Q'.γ C (D.addedUnitVector C))) := rfl
    _ = A'.smul (polarization Q'.space Q'.form (D.addedUnitVector C) (oddInclusion C.valuedMaps v)) A'.one :=
        Q'.γ_anticommutator C hneg (D.addedUnitVector C) (oddInclusion C.valuedMaps v)
    _ = A'.smul (polarization Q'.space Q'.form (oddInclusion C.valuedMaps v) (D.addedUnitVector C)) A'.one := by
        rw [polarization_symm C.uniqueness.add_assoc C.uniqueness.add_comm Q'.space Q'.form (D.addedUnitVector C)
          (oddInclusion C.valuedMaps v)]
    _ = A'.smul (polarization (oddVectorSpace C.valuedMaps (D.space C).space) (oddForm (D.space C).form)
          (oddInclusion C.valuedMaps v) (oddSecondInclusion (D.space C).space 1)) A'.one := rfl
    _ = A'.smul 0 A'.one := by
        rw [polarization_oddInclusion_oddSecondInclusion_one C.valuedMaps hneg C.uniqueness.zero_add
          C.uniqueness.zero_mul C.congruence.zero_add_zero (D.space C).space (D.space C).form
          (D.space_form_isQuadraticForm C hneg) v]
    _ = A'.zero := AlgebraOver.zero_smul_eq_zero A' C.congruence.zero_add_zero A'.one

end

end CliffordMatrixIsomorphism.NecSuf.Clifford.SplitData
