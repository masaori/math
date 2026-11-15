/-
章「同型の証明」の節「系：奇数次元の二次空間」のうち、行列環の直積から奇数次元のクリフォード代数への写像 Ψ'、
それが準同型であること、Φ' と互いに逆であること、系の定理の必要十分版。具体版
`Isomorphism/OddDimensional/HomomorphismFromPairOfMatrices.lean` と同じ calc の行を、係数 ℂ を型の変数 K に、-1_ℂ を K の元 n に、
h := ½ を K の元 h に替えて書く。

二段に分けて置く（`Idempotents.lean` と同じ）。
- 前半（名前空間 `NecSuf.AlgebraOver`）：主張の本体。具体版の calc の行が A'・e_±・Φ'・j・Ψ について実際に使うのは、
  「A・A'・B が K の上の代数で j・Ψ・Φ' が準同型であること」と、本文が引く e_± の性質（平方・積・和・差・全ての元との交換）、
  Φ'(j(y))・Φ'(g)・Φ(Ψ(F))・Ψ(Φ(y)) の値、ε · ε = 1、γ'((v, t)) = j(γ(v)) + t ∗ g、γ'(V') が A' を生成することだけなので、
  それらを仮定にして、A' を任意の代数 SA'、e_± を任意の元 ep・em に替えて書く。
- 後半（名前空間 `NecSuf.Clifford.SplitData`）：前半を A' := Cl(V',q')、e_± := `D.idempotentPlus`・`D.idempotentMinus` に当てた、
  具体版と同じ名前の宣言。

本文のラベルと宣言の対応（前半の名前 / 後半の名前。後半の名前は具体版と同じ）:

  def_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra
      pairMapThroughIdempotents / homomorphismFromPairOfMatrices
  claim_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra_is_algebra_homomorphism
      pairMapThroughIdempotents_isHom / homomorphismFromPairOfMatrices_isHom
  claim_homomorphism_to_pair_of_matrices_after_homomorphism_to_odd_clifford_algebra_is_identity
      map_idempotentOfSquareRootOfOne_one・map_idempotentOfSquareRootOfOne_n（証明の前半の Φ'(e_±) の値）・
      map_pairMapThroughIdempotents / homomorphismToPairOfMatrices_idempotentPlus・homomorphismToPairOfMatrices_idempotentMinus・
      homomorphismToPairOfMatrices_homomorphismFromPairOfMatrices
  claim_homomorphism_to_odd_clifford_algebra_after_homomorphism_to_pair_of_matrices_is_identity
      pairMapThroughIdempotents_map / homomorphismFromPairOfMatrices_homomorphismToPairOfMatrices
  theorem_clifford_algebra_of_odd_dimensional_quadratic_space_is_isomorphic_to_product_of_matrix_algebras
      （後半だけ）oddCliffordAlgebra_isomorphic_pairOfMatrixAlgebras

h := ½（本文 `def_inverse_of_two_in_complex_numbers`）は K の元の変数 h で、後半の主張はすべて h ·_K (1 + 1) = 1（`hh`）を仮定に持つ。

主張ごとに使う K の性質（前半の仮定。本文が「ℂ の四則」「h は 1+1 の逆元」とした行がどの仮定になるか）:

  pairMapThroughIdempotents              なし（定義）
  pairMapThroughIdempotents_isHom        0 + 0 = 0（積の主張の「w · 0 = 0」の行。claim_element_times_zero_in_algebra_is_zero）だけ。
                                         e_± については e_+·e_+ = e_+、e_-·e_- = e_-、e_+·e_- = e_-·e_+ = 0、e_+ + e_- = 1、
                                         全ての元との交換を仮定にする
  map_idempotentOfSquareRootOfOne_one    h · (1 + 1) = 1、1 + (-1) = 0 と a · 0 = 0（ℂ の四則 h·(1+(-1)) = 0 の行）、0 + 0 = 0
                                         （零のスカラー倍）、Φ'(e_σ) の主張に渡す a · n = -a
  map_idempotentOfSquareRootOfOne_n      上と同じものと -n = 1（-_ℂ(-1_ℂ) = 1_ℂ の行）・1 + n = 0（ℂ の四則の行）
  map_pairMapThroughIdempotents          0 + 0 = 0（w · 0 = 0 の行）だけ。Φ'(e_±) は値を仮定にする
  pairMapThroughIdempotents_map          なし。e_+ + e_- = 1、e_+ + n ∗ e_- = z、z = j(ε) g、ε ε = 1 を仮定にする

分かったこと:
- この節の式変形の中で 2 の可逆性（h · (1 + 1) = 1）を直に使う行は、Φ'(e_±) の値の「h は 1+1 の逆元」の行だけである。
  前半の Ψ' の準同型性・Φ' ∘ Ψ' = id・Ψ' ∘ Φ' = id は h を含まず、e_± の性質を仮定に置けば 2 の可逆性なしで通る。
- 後半では四つの主張と系の定理の全てが h · (1 + 1) = 1 を仮定に持つ。どれも e_± = h ∗ (1 ± z) を作る段に由来する：
  Ψ' の準同型性は e_± の平方と和、Φ' ∘ Ψ' = id は Φ'(e_±) の値、Ψ' ∘ Φ' = id は e_± の和と差（と Ψ' の準同型性）を通して要る。
  台帳の行の見立て「2 の可逆性が要るのは e_± の段だけ」は、この節でも成り立つ。
- e_± の性質のほかに前半が使う K の性質は、0 + 0 = 0、a · 0 = 0、1 + (-1) = 0、-n = 1・1 + n = 0、a · n = -a だけである。
- e_+ · e_- = 0 と e_- · e_+ = 0 は Ψ' の乗法だけで要る。Φ' ∘ Ψ' と Ψ' ∘ Φ' は使わない。
- Ψ' が準同型であることは、Φ'・Φ・ε・z・g・γ' を一つも使わない（J := j ∘ Ψ が準同型で、e_± が平方・積・和・交換を満たすことだけ）。
- Φ' ∘ Ψ' = id は、Ψ' が準同型であることを使わない。Ψ' ∘ Φ' = id は、Φ ∘ Ψ = id を使わない（Ψ ∘ Φ = id だけ）。
- K の乗法の交換法則は、この節の行の中では使わない（Φ'(e_±) の値の行も e_± の差の主張も、後半で `CliffordLaws` から渡す）。
- 本文の前提 M ∈ ℤ_{≥1} は、どの主張も使わない（M = 0 でも同じ証明が通る）。
-/
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.OddDimensional.Idempotents
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.MutuallyInverseHomomorphisms.MutuallyInverseHomomorphisms

namespace CliffordMatrixIsomorphism.NecSuf.AlgebraOver

open CliffordMatrixIsomorphism.NecSuf.VectorSpace

universe u v w x uK

variable {K : Type uK} [Add K] [Mul K] [One K] {A : Type u} {A' : Type v} {B : Type w}

/-! ### Ψ' と、Ψ' が準同型であること -/

/-- 本文 `def_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra` の必要十分版：
Ψ'((F, G)) := j(Ψ(F)) ·_{A'} e_+ +_{A'} j(Ψ(G)) ·_{A'} e_-。定義には j・Ψ・e_± の性質を何も使わない。 -/
def pairMapThroughIdempotents (SA' : AlgebraOver K A') (j : A → A') (Ψ : B → A) (ep em : A') (p : B × B) : A' :=
  SA'.add (SA'.mul (j (Ψ p.1)) ep) (SA'.mul (j (Ψ p.2)) em)

/-- 本文 `claim_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra_is_algebra_homomorphism` の必要十分版：
j・Ψ が準同型で、ep・em が全ての元と交換し、ep · ep = ep、em · em = em、ep · em = 0、em · ep = 0、ep + em = 1 なら、
Ψ' は B × B から A' への準同型。係数の性質は 0 + 0 = 0（w · 0 = 0 の行）だけを使う。
2 の可逆性は使わない（e_± の性質を仮定にしているため。後半で e_± の平方と和の主張がそれを要する）。 -/
theorem pairMapThroughIdempotents_isHom [Zero K] (h00 : (0 : K) + 0 = 0) (SA : AlgebraOver K A)
    (SA' : AlgebraOver K A') (SB : AlgebraOver K B) {j : A → A'} {Ψ : B → A}
    (hΨ : IsAlgebraHomomorphism SB SA Ψ) (hj : IsAlgebraHomomorphism SA SA' j) {ep em : A'}
    (hcp : ∀ y : A', SA'.mul y ep = SA'.mul ep y) (hcm : ∀ y : A', SA'.mul y em = SA'.mul em y)
    (hpp : SA'.mul ep ep = ep) (hmm : SA'.mul em em = em) (hpm : SA'.mul ep em = SA'.zero)
    (hmp : SA'.mul em ep = SA'.zero) (hsum : SA'.add ep em = SA'.one) :
    IsAlgebraHomomorphism (productAlgebra SB SB) SA' (pairMapThroughIdempotents SA' j Ψ ep em) := by
  let BB := productAlgebra SB SB
  let Ψ' := pairMapThroughIdempotents SA' j Ψ ep em
  let J : B → A' := fun F => j (Ψ F)
  -- J := j ∘ Ψ は準同型（claim_composition_of_algebra_homomorphisms_is_algebra_homomorphism）
  have hJ : IsAlgebraHomomorphism SB SA' J := IsAlgebraHomomorphism.comp hΨ hj
  -- 加法を保つこと
  have hadd : ∀ x y : B × B, Ψ' (BB.add x y) = SA'.add (Ψ' x) (Ψ' y) := by
    rintro ⟨F, G⟩ ⟨F', G'⟩
    calc Ψ' (BB.add (F, G) (F', G'))
        = Ψ' (SB.add F F', SB.add G G') := rfl
      _ = SA'.add (SA'.mul (J (SB.add F F')) ep) (SA'.mul (J (SB.add G G')) em) := rfl
      _ = SA'.add (SA'.mul (SA'.add (J F) (J F')) ep) (SA'.mul (SA'.add (J G) (J G')) em) := by
          rw [hJ.map_add F F', hJ.map_add G G']
      _ = SA'.add (SA'.add (SA'.mul (J F) ep) (SA'.mul (J F') ep))
            (SA'.add (SA'.mul (J G) em) (SA'.mul (J G') em)) := by
          rw [SA'.right_distrib (J F) (J F') ep, SA'.right_distrib (J G) (J G') em]
      _ = SA'.add (SA'.add (SA'.mul (J F) ep) (SA'.mul (J G) em))
            (SA'.add (SA'.mul (J F') ep) (SA'.mul (J G') em)) :=
          rearrange_sum_of_two_sums SA'.toVectorSpace _ _ _ _
      _ = SA'.add (Ψ' (F, G)) (Ψ' (F', G')) := rfl
  -- スカラー倍を保つこと
  have hsmul : ∀ (l : K) (x : B × B), Ψ' (BB.smul l x) = SA'.smul l (Ψ' x) := by
    rintro l ⟨F, G⟩
    calc Ψ' (BB.smul l (F, G))
        = Ψ' (SB.smul l F, SB.smul l G) := rfl
      _ = SA'.add (SA'.mul (J (SB.smul l F)) ep) (SA'.mul (J (SB.smul l G)) em) := rfl
      _ = SA'.add (SA'.mul (SA'.smul l (J F)) ep) (SA'.mul (SA'.smul l (J G)) em) := by
          rw [hJ.map_smul l F, hJ.map_smul l G]
      _ = SA'.add (SA'.smul l (SA'.mul (J F) ep)) (SA'.smul l (SA'.mul (J G) em)) := by
          rw [SA'.smul_mul_left l (J F) ep, SA'.smul_mul_left l (J G) em]
      _ = SA'.smul l (SA'.add (SA'.mul (J F) ep) (SA'.mul (J G) em)) := (SA'.smul_add l _ _).symm
      _ = SA'.smul l (Ψ' (F, G)) := rfl
  -- 乗法の単位元を保つこと
  have hone : Ψ' BB.one = SA'.one := calc
    Ψ' BB.one = Ψ' (SB.one, SB.one) := rfl
    _ = SA'.add (SA'.mul (J SB.one) ep) (SA'.mul (J SB.one) em) := rfl
    _ = SA'.add (SA'.mul SA'.one ep) (SA'.mul SA'.one em) := by rw [hJ.map_one]
    _ = SA'.add ep em := by rw [SA'.one_mul ep, SA'.one_mul em]
    _ = SA'.one := hsum
  -- 乗法を保つこと
  have hmul : ∀ x y : B × B, Ψ' (BB.mul x y) = SA'.mul (Ψ' x) (Ψ' y) := by
    rintro ⟨F, G⟩ ⟨F', G'⟩
    let P₁ := J F
    let P₂ := J G
    let Q₁ := J F'
    let Q₂ := J G'
    symm
    calc SA'.mul (Ψ' (F, G)) (Ψ' (F', G'))
        = SA'.mul (SA'.add (SA'.mul P₁ ep) (SA'.mul P₂ em)) (SA'.add (SA'.mul Q₁ ep) (SA'.mul Q₂ em)) := rfl
      _ = SA'.add (SA'.mul (SA'.mul P₁ ep) (SA'.add (SA'.mul Q₁ ep) (SA'.mul Q₂ em)))
            (SA'.mul (SA'.mul P₂ em) (SA'.add (SA'.mul Q₁ ep) (SA'.mul Q₂ em))) :=
          SA'.right_distrib _ _ _
      _ = SA'.add (SA'.add (SA'.mul (SA'.mul P₁ ep) (SA'.mul Q₁ ep)) (SA'.mul (SA'.mul P₁ ep) (SA'.mul Q₂ em)))
            (SA'.add (SA'.mul (SA'.mul P₂ em) (SA'.mul Q₁ ep)) (SA'.mul (SA'.mul P₂ em) (SA'.mul Q₂ em))) := by
          rw [SA'.left_distrib (SA'.mul P₁ ep), SA'.left_distrib (SA'.mul P₂ em)]
      _ = SA'.add (SA'.add (SA'.mul P₁ (SA'.mul ep (SA'.mul Q₁ ep))) (SA'.mul P₁ (SA'.mul ep (SA'.mul Q₂ em))))
            (SA'.add (SA'.mul P₂ (SA'.mul em (SA'.mul Q₁ ep))) (SA'.mul P₂ (SA'.mul em (SA'.mul Q₂ em)))) := by
          rw [SA'.mul_assoc P₁ ep (SA'.mul Q₁ ep), SA'.mul_assoc P₁ ep (SA'.mul Q₂ em),
            SA'.mul_assoc P₂ em (SA'.mul Q₁ ep), SA'.mul_assoc P₂ em (SA'.mul Q₂ em)]
      _ = SA'.add (SA'.add (SA'.mul P₁ (SA'.mul (SA'.mul ep Q₁) ep)) (SA'.mul P₁ (SA'.mul (SA'.mul ep Q₂) em)))
            (SA'.add (SA'.mul P₂ (SA'.mul (SA'.mul em Q₁) ep)) (SA'.mul P₂ (SA'.mul (SA'.mul em Q₂) em))) := by
          rw [SA'.mul_assoc ep Q₁ ep, SA'.mul_assoc ep Q₂ em, SA'.mul_assoc em Q₁ ep, SA'.mul_assoc em Q₂ em]
      _ = SA'.add (SA'.add (SA'.mul P₁ (SA'.mul (SA'.mul Q₁ ep) ep)) (SA'.mul P₁ (SA'.mul (SA'.mul Q₂ ep) em)))
            (SA'.add (SA'.mul P₂ (SA'.mul (SA'.mul Q₁ em) ep)) (SA'.mul P₂ (SA'.mul (SA'.mul Q₂ em) em))) := by
          rw [hcp Q₁, hcp Q₂, hcm Q₁, hcm Q₂]
      _ = SA'.add (SA'.add (SA'.mul P₁ (SA'.mul Q₁ (SA'.mul ep ep))) (SA'.mul P₁ (SA'.mul Q₂ (SA'.mul ep em))))
            (SA'.add (SA'.mul P₂ (SA'.mul Q₁ (SA'.mul em ep))) (SA'.mul P₂ (SA'.mul Q₂ (SA'.mul em em)))) := by
          rw [SA'.mul_assoc Q₁ ep ep, SA'.mul_assoc Q₂ ep em, SA'.mul_assoc Q₁ em ep, SA'.mul_assoc Q₂ em em]
      _ = SA'.add (SA'.add (SA'.mul (SA'.mul P₁ Q₁) (SA'.mul ep ep)) (SA'.mul (SA'.mul P₁ Q₂) (SA'.mul ep em)))
            (SA'.add (SA'.mul (SA'.mul P₂ Q₁) (SA'.mul em ep)) (SA'.mul (SA'.mul P₂ Q₂) (SA'.mul em em))) := by
          rw [← SA'.mul_assoc P₁ Q₁ (SA'.mul ep ep), ← SA'.mul_assoc P₁ Q₂ (SA'.mul ep em),
            ← SA'.mul_assoc P₂ Q₁ (SA'.mul em ep), ← SA'.mul_assoc P₂ Q₂ (SA'.mul em em)]
      _ = SA'.add (SA'.add (SA'.mul (SA'.mul P₁ Q₁) ep) (SA'.mul (SA'.mul P₁ Q₂) (SA'.mul ep em)))
            (SA'.add (SA'.mul (SA'.mul P₂ Q₁) (SA'.mul em ep)) (SA'.mul (SA'.mul P₂ Q₂) em)) := by
          rw [hpp, hmm]
      _ = SA'.add (SA'.add (SA'.mul (SA'.mul P₁ Q₁) ep) (SA'.mul (SA'.mul P₁ Q₂) SA'.zero))
            (SA'.add (SA'.mul (SA'.mul P₂ Q₁) SA'.zero) (SA'.mul (SA'.mul P₂ Q₂) em)) := by
          rw [hpm, hmp]
      _ = SA'.add (SA'.add (SA'.mul (SA'.mul P₁ Q₁) ep) SA'.zero)
            (SA'.add SA'.zero (SA'.mul (SA'.mul P₂ Q₂) em)) := by
          -- claim_element_times_zero_in_algebra_is_zero（0 + 0 = 0 を使う）
          rw [mul_zero_eq_zero h00 SA' (SA'.mul P₁ Q₂), mul_zero_eq_zero h00 SA' (SA'.mul P₂ Q₁)]
      _ = SA'.add (SA'.mul (SA'.mul P₁ Q₁) ep) (SA'.add SA'.zero (SA'.mul (SA'.mul P₂ Q₂) em)) := by
          rw [SA'.add_zero (SA'.mul (SA'.mul P₁ Q₁) ep)]
      _ = SA'.add (SA'.mul (SA'.mul P₁ Q₁) ep) (SA'.add (SA'.mul (SA'.mul P₂ Q₂) em) SA'.zero) := by
          rw [SA'.add_comm SA'.zero (SA'.mul (SA'.mul P₂ Q₂) em)]
      _ = SA'.add (SA'.mul (SA'.mul P₁ Q₁) ep) (SA'.mul (SA'.mul P₂ Q₂) em) := by
          rw [SA'.add_zero (SA'.mul (SA'.mul P₂ Q₂) em)]
      _ = SA'.add (SA'.mul (J (SB.mul F F')) ep) (SA'.mul (J (SB.mul G G')) em) := by
          rw [hJ.map_mul F F', hJ.map_mul G G']
      _ = Ψ' (SB.mul F F', SB.mul G G') := rfl
      _ = Ψ' (BB.mul (F, G) (F', G')) := rfl
  exact ⟨⟨hadd, hmul, hone⟩, ⟨hadd, hsmul⟩⟩

/-! ### Φ'(e_±) の値と Φ' ∘ Ψ' = id -/

/-- 本文 `claim_homomorphism_to_pair_of_matrices_after_homomorphism_to_odd_clifford_algebra_is_identity` の証明の前半の
必要十分版：Φ'(e_1) = (1_B, 0_B)。2 の可逆性 `hh` は「h は 1+1 の逆元」の行で要る。
本文の「ℂ の四則」h · (1 + (-1)) = 0 の行は、1 + (-1) = 0 と a · 0 = 0 を続けて当てる。 -/
theorem map_idempotentOfSquareRootOfOne_one [Zero K] [Neg K] (h00 : (0 : K) + 0 = 0)
    (hmul0 : ∀ a : K, a * 0 = 0) (h1neg1 : (1 : K) + -1 = 0) (SA : AlgebraOver K A) (SB : AlgebraOver K B)
    {F : A → B × B} (hF : IsAlgebraHomomorphism SA (productAlgebra SB SB) F) {z : A} {n : K}
    (hFz : F z = (SB.one, SB.smul n SB.one)) (hmul_n : ∀ a : K, a * n = -a) (h : K) (hh : h * (1 + 1) = 1) :
    F (idempotentOfSquareRootOfOne SA h z 1) = (SB.one, SB.zero) := calc
  F (idempotentOfSquareRootOfOne SA h z 1)
      = (SB.smul (h * (1 + 1)) SB.one, SB.smul (h * (1 + -1)) SB.one) :=
        -- claim_homomorphism_to_pair_of_matrices_on_idempotents（σ := 1）
        map_idempotentOfSquareRootOfOne SA SB hF hFz hmul_n h 1
  _ = (SB.smul 1 SB.one, SB.smul (h * (1 + -1)) SB.one) := by
        -- h は 1 + 1 の乗法の逆元。2 の可逆性はここで要る
        rw [hh]
  _ = (SB.smul 1 SB.one, SB.smul 0 SB.one) := by
        -- 本文の「ℂ の四則」の行：h · (1 + (-1)) = 0
        rw [h1neg1, hmul0 h]
  _ = (SB.one, SB.smul 0 SB.one) := by rw [SB.one_smul SB.one]
  _ = (SB.one, SB.zero) := by
        -- claim_zero_scalar_multiple_is_zero_vector（0 + 0 = 0 を使う）
        rw [zero_smul_eq_zero SB h00 SB.one]

/-- 本文 `claim_homomorphism_to_pair_of_matrices_after_homomorphism_to_odd_clifford_algebra_is_identity` の証明の前半の
必要十分版：Φ'(e_n) = (0_B, 1_B)。2 の可逆性 `hh` は「h は 1+1 の逆元」の行で要る。
本文の -_ℂ(-1_ℂ) = 1_ℂ の行は -n = 1、「ℂ の四則」h · (1 + (-1)) = 0 の行は 1 + n = 0 と a · 0 = 0 である。 -/
theorem map_idempotentOfSquareRootOfOne_n [Zero K] [Neg K] (h00 : (0 : K) + 0 = 0)
    (hmul0 : ∀ a : K, a * 0 = 0) (SA : AlgebraOver K A) (SB : AlgebraOver K B)
    {F : A → B × B} (hF : IsAlgebraHomomorphism SA (productAlgebra SB SB) F) {z : A} {n : K}
    (hn1 : -n = 1) (h1n : 1 + n = 0)
    (hFz : F z = (SB.one, SB.smul n SB.one)) (hmul_n : ∀ a : K, a * n = -a) (h : K) (hh : h * (1 + 1) = 1) :
    F (idempotentOfSquareRootOfOne SA h z n) = (SB.zero, SB.one) := calc
  F (idempotentOfSquareRootOfOne SA h z n)
      = (SB.smul (h * (1 + n)) SB.one, SB.smul (h * (1 + -n)) SB.one) :=
        -- claim_homomorphism_to_pair_of_matrices_on_idempotents（σ := n）
        map_idempotentOfSquareRootOfOne SA SB hF hFz hmul_n h n
  _ = (SB.smul (h * (1 + n)) SB.one, SB.smul (h * (1 + 1)) SB.one) := by
        -- 本文の「-_ℂ(-1_ℂ) = 1_ℂ」の行
        rw [hn1]
  _ = (SB.smul (h * (1 + n)) SB.one, SB.smul 1 SB.one) := by
        -- h は 1 + 1 の乗法の逆元。2 の可逆性はここで要る
        rw [hh]
  _ = (SB.smul 0 SB.one, SB.smul 1 SB.one) := by
        -- 本文の「ℂ の四則」の行：h · (1 + (-1)) = 0
        rw [h1n, hmul0 h]
  _ = (SB.zero, SB.smul 1 SB.one) := by rw [zero_smul_eq_zero SB h00 SB.one]
  _ = (SB.zero, SB.one) := by rw [SB.one_smul SB.one]

/-- 本文 `claim_homomorphism_to_pair_of_matrices_after_homomorphism_to_odd_clifford_algebra_is_identity` の必要十分版：
Φ' が準同型で、Φ'(j(y)) = (Φ(y), Φ(y))、Φ(Ψ(F)) = F、Φ'(ep) = (1, 0)、Φ'(em) = (0, 1) なら Φ'(Ψ'((F, G))) = (F, G)。
係数の性質は 0 + 0 = 0（w · 0 = 0 の行）だけを使う。Ψ' が準同型であることも j が準同型であることも使わない。 -/
theorem map_pairMapThroughIdempotents [Zero K] (h00 : (0 : K) + 0 = 0) (SA' : AlgebraOver K A')
    (SB : AlgebraOver K B) {j : A → A'} {Ψ : B → A} {Φ : A → B} {Φ' : A' → B × B}
    (hΦ' : IsAlgebraHomomorphism SA' (productAlgebra SB SB) Φ') (hΦ'j : ∀ y : A, Φ' (j y) = (Φ y, Φ y))
    (hΦΨ : ∀ H : B, Φ (Ψ H) = H) {ep em : A'} (hep : Φ' ep = (SB.one, SB.zero)) (hem : Φ' em = (SB.zero, SB.one))
    (F G : B) :
    Φ' (pairMapThroughIdempotents SA' j Ψ ep em (F, G)) = (F, G) := by
  let BB := productAlgebra SB SB
  calc Φ' (pairMapThroughIdempotents SA' j Ψ ep em (F, G))
      = Φ' (SA'.add (SA'.mul (j (Ψ F)) ep) (SA'.mul (j (Ψ G)) em)) := rfl
    _ = BB.add (Φ' (SA'.mul (j (Ψ F)) ep)) (Φ' (SA'.mul (j (Ψ G)) em)) := hΦ'.map_add _ _
    _ = BB.add (BB.mul (Φ' (j (Ψ F))) (Φ' ep)) (BB.mul (Φ' (j (Ψ G))) (Φ' em)) := by
        rw [hΦ'.map_mul (j (Ψ F)) ep, hΦ'.map_mul (j (Ψ G)) em]
    _ = BB.add (BB.mul (Φ (Ψ F), Φ (Ψ F)) (Φ' ep)) (BB.mul (Φ (Ψ G), Φ (Ψ G)) (Φ' em)) := by
        rw [hΦ'j (Ψ F), hΦ'j (Ψ G)]
    _ = BB.add (BB.mul (F, F) (Φ' ep)) (BB.mul (G, G) (Φ' em)) := by rw [hΦΨ F, hΦΨ G]
    _ = BB.add (BB.mul (F, F) (SB.one, SB.zero)) (BB.mul (G, G) (SB.zero, SB.one)) := by rw [hep, hem]
    _ = BB.add (SB.mul F SB.one, SB.mul F SB.zero) (SB.mul G SB.zero, SB.mul G SB.one) := rfl
    _ = BB.add (F, SB.mul F SB.zero) (SB.mul G SB.zero, G) := by rw [SB.mul_one F, SB.mul_one G]
    _ = BB.add (F, SB.zero) (SB.zero, G) := by
        -- claim_element_times_zero_in_algebra_is_zero（0 + 0 = 0 を使う）
        rw [mul_zero_eq_zero h00 SB F, mul_zero_eq_zero h00 SB G]
    _ = (SB.add F SB.zero, SB.add SB.zero G) := rfl
    _ = (SB.add F SB.zero, SB.add G SB.zero) := by rw [SB.add_comm SB.zero G]
    _ = (F, G) := by rw [SB.add_zero F, SB.add_zero G]

/-! ### Ψ' ∘ Φ' = id -/

/-- 本文 `claim_homomorphism_to_odd_clifford_algebra_after_homomorphism_to_pair_of_matrices_is_identity` の必要十分版：
j・Ψ・Φ'・Ψ' が準同型で、Φ'(j(y)) = (Φ(y), Φ(y))、Ψ(Φ(y)) = y、Φ'(g) = (Φ(ε), n ∗ Φ(ε))、ep + em = 1、
ep + n ∗ em = z、z = j(ε) · g、ε · ε = 1、γ'((v, t)) = j(γ(v)) + t ∗ g、γ'(V × K) が A' を生成するなら、Ψ'(Φ'(a)) = a。
係数の性質を一つも使わない（2 の可逆性は e_± の和と差の仮定の中にだけある）。 -/
theorem pairMapThroughIdempotents_map {V : Type x} (SA : AlgebraOver K A) (SA' : AlgebraOver K A')
    (SB : AlgebraOver K B) {j : A → A'} {Ψ : B → A} {Φ : A → B} {Φ' : A' → B × B}
    (hj : IsAlgebraHomomorphism SA SA' j) (hΨ : IsAlgebraHomomorphism SB SA Ψ)
    (hΦ' : IsAlgebraHomomorphism SA' (productAlgebra SB SB) Φ') {ep em z g : A'} {ε : A} {n : K}
    (hΨ' : IsAlgebraHomomorphism (productAlgebra SB SB) SA' (pairMapThroughIdempotents SA' j Ψ ep em))
    (hΦ'j : ∀ y : A, Φ' (j y) = (Φ y, Φ y)) (hΨΦ : ∀ y : A, Ψ (Φ y) = y)
    (hΦ'g : Φ' g = (Φ ε, SB.smul n (Φ ε))) (hsum : SA'.add ep em = SA'.one)
    (hdiff : SA'.add ep (SA'.smul n em) = z) (hz : z = SA'.mul (j ε) g) (hεε : SA.mul ε ε = SA.one)
    (γ : V → A) (γ' : V × K → A') (hgen : GeneratesAlgebra SA' (Set.range γ'))
    (hpair : ∀ (v : V) (t : K), γ' (v, t) = SA'.add (j (γ v)) (SA'.smul t g)) (a : A') :
    pairMapThroughIdempotents SA' j Ψ ep em (Φ' a) = a := by
  let Ψ' := pairMapThroughIdempotents SA' j Ψ ep em
  let Ξ : A' → A' := fun x => Ψ' (Φ' x)
  have hΞ : IsAlgebraHomomorphism SA' SA' Ξ := IsAlgebraHomomorphism.comp hΦ' hΨ'
  have hid : IsAlgebraHomomorphism SA' SA' (fun x => x) := isAlgebraHomomorphism_id SA'
  -- y ∈ A について Ξ(j(y)) = j(y)
  have hjy : ∀ y : A, Ξ (j y) = j y := fun y => calc
    Ξ (j y) = Ψ' (Φ y, Φ y) := by
        show Ψ' (Φ' (j y)) = _
        rw [hΦ'j y]
    _ = SA'.add (SA'.mul (j (Ψ (Φ y))) ep) (SA'.mul (j (Ψ (Φ y))) em) := rfl
    _ = SA'.add (SA'.mul (j y) ep) (SA'.mul (j y) em) := by rw [hΨΦ y]
    _ = SA'.mul (j y) (SA'.add ep em) := (SA'.left_distrib _ _ _).symm
    _ = SA'.mul (j y) SA'.one := by rw [hsum]
    _ = j y := SA'.mul_one (j y)
  -- Ξ(g) = g
  have hg : Ξ g = g := calc
    Ξ g = Ψ' (Φ ε, SB.smul n (Φ ε)) := by
        show Ψ' (Φ' g) = _
        rw [hΦ'g]
    _ = SA'.add (SA'.mul (j (Ψ (Φ ε))) ep) (SA'.mul (j (Ψ (SB.smul n (Φ ε)))) em) := rfl
    _ = SA'.add (SA'.mul (j (Ψ (Φ ε))) ep) (SA'.mul (j (SA.smul n (Ψ (Φ ε)))) em) := by
        rw [hΨ.map_smul n (Φ ε)]
    _ = SA'.add (SA'.mul (j ε) ep) (SA'.mul (j (SA.smul n ε)) em) := by rw [hΨΦ ε]
    _ = SA'.add (SA'.mul (j ε) ep) (SA'.mul (SA'.smul n (j ε)) em) := by rw [hj.map_smul n ε]
    _ = SA'.add (SA'.mul (j ε) ep) (SA'.smul n (SA'.mul (j ε) em)) := by
        rw [← SA'.smul_mul_left n (j ε) em]
    _ = SA'.add (SA'.mul (j ε) ep) (SA'.mul (j ε) (SA'.smul n em)) := by
        rw [SA'.smul_mul_right n (j ε) em]
    _ = SA'.mul (j ε) (SA'.add ep (SA'.smul n em)) := (SA'.left_distrib _ _ _).symm
    _ = SA'.mul (j ε) z := by rw [hdiff]
    _ = SA'.mul (j ε) (SA'.mul (j ε) g) := by rw [hz]
    _ = SA'.mul (SA'.mul (j ε) (j ε)) g := (SA'.mul_assoc _ _ _).symm
    _ = SA'.mul (j (SA.mul ε ε)) g := by rw [hj.map_mul ε ε]
    _ = SA'.mul (j SA.one) g := by rw [hεε]
    _ = SA'.mul SA'.one g := by rw [hj.map_one]
    _ = g := SA'.one_mul g
  have hagree : ∀ x ∈ Set.range γ', Ξ x = (fun y => y) x := by
    rintro _ ⟨⟨v, t⟩, rfl⟩
    calc Ξ (γ' (v, t))
        = Ξ (SA'.add (j (γ v)) (SA'.smul t g)) := by rw [hpair v t]
      _ = SA'.add (Ξ (j (γ v))) (Ξ (SA'.smul t g)) := hΞ.map_add _ _
      _ = SA'.add (Ξ (j (γ v))) (SA'.smul t (Ξ g)) := by rw [hΞ.map_smul t g]
      _ = SA'.add (j (γ v)) (SA'.smul t (Ξ g)) := by rw [hjy (γ v)]
      _ = SA'.add (j (γ v)) (SA'.smul t g) := by rw [hg]
      _ = γ' (v, t) := (hpair v t).symm
      _ = (fun y => y) (γ' (v, t)) := rfl
  exact eq_of_agree_on_generators hΞ hid (Set.range γ') hgen hagree a

end CliffordMatrixIsomorphism.NecSuf.AlgebraOver

namespace CliffordMatrixIsomorphism.NecSuf.Clifford.SplitData

open CliffordMatrixIsomorphism.NecSuf.AlgebraOver
open CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra (PowerSet)

universe u uK

noncomputable section

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K] [Neg K] {n : K} (C : CliffordLaws K n)
  {W : Type u} (D : SplitData K W)

/-! ### 前半を A' := Cl(V',q')、e_± := D.idempotentPlus・D.idempotentMinus に当てる -/

/-- 本文 `def_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra` の必要十分版：
Ψ'((F, G)) := j(Ψ(F)) ·_{A'} e_+ +_{A'} j(Ψ(G)) ·_{A'} e_-。 -/
def homomorphismFromPairOfMatrices (hneg : ∀ a : K, a + -a = 0) (h : K)
    (p : Mat K (PowerSet D.M) × Mat K (PowerSet D.M)) : (D.oddSpace C).Cl C :=
  pairMapThroughIdempotents ((D.oddSpace C).cliffordAlgebra C) (D.oddInclusionHom C hneg) (D.homomorphismFromMatrix C)
    (D.idempotentPlus C hneg h) (D.idempotentMinus C hneg h) p

/-- 本文 `claim_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra_is_algebra_homomorphism` の必要十分版。
2 の可逆性 h · (1 + 1) = 1 を仮定に持つ（e_± の平方と和の主張が要する）。 -/
theorem homomorphismFromPairOfMatrices_isHom (hneg : ∀ a : K, a + -a = 0) (h : K) (hh : h * (1 + 1) = 1) :
    IsAlgebraHomomorphism (D.pairOfMatricesAlgebra C) ((D.oddSpace C).cliffordAlgebra C)
      (D.homomorphismFromPairOfMatrices C hneg h) :=
  pairMapThroughIdempotents_isHom C.congruence.zero_add_zero ((D.space C).cliffordAlgebra C) _ (D.matrixAlgebra C)
    (D.homomorphismFromMatrix_isHom C hneg) (D.oddInclusionHom_isHom C hneg)
    (D.idempotent_comm C hneg h 1) (D.idempotent_comm C hneg h n)
    (D.idempotentPlus_mul_self C hneg h hh) (D.idempotentMinus_mul_self C hneg h hh)
    (D.idempotentPlus_mul_idempotentMinus C hneg h) (D.idempotentMinus_mul_idempotentPlus C hneg h)
    (D.idempotentPlus_add_idempotentMinus C hneg h hh)

/-- 本文 `claim_homomorphism_to_pair_of_matrices_after_homomorphism_to_odd_clifford_algebra_is_identity` の証明の前半の
必要十分版：Φ'(e_+) = (1_B, 0_B)。2 の可逆性 h · (1 + 1) = 1 を仮定に持つ。 -/
theorem homomorphismToPairOfMatrices_idempotentPlus (hneg : ∀ a : K, a + -a = 0) (h : K) (hh : h * (1 + 1) = 1) :
    D.homomorphismToPairOfMatrices C hneg (D.idempotentPlus C hneg h)
      = ((D.matrixAlgebra C).one, (D.matrixAlgebra C).zero) :=
  map_idempotentOfSquareRootOfOne_one C.congruence.zero_add_zero C.uniqueness.mul_zero (hneg 1) _ (D.matrixAlgebra C)
    (D.homomorphismToPairOfMatrices_isHom C hneg) (D.homomorphismToPairOfMatrices_centralElement C hneg)
    (mul_n_eq_neg C hneg) h hh

/-- 本文 `claim_homomorphism_to_pair_of_matrices_after_homomorphism_to_odd_clifford_algebra_is_identity` の証明の前半の
必要十分版：Φ'(e_-) = (0_B, 1_B)。2 の可逆性 h · (1 + 1) = 1 を仮定に持つ。-n = 1 は n + 1 = 0 から導く。 -/
theorem homomorphismToPairOfMatrices_idempotentMinus (hneg : ∀ a : K, a + -a = 0) (h : K) (hh : h * (1 + 1) = 1) :
    D.homomorphismToPairOfMatrices C hneg (D.idempotentMinus C hneg h)
      = ((D.matrixAlgebra C).zero, (D.matrixAlgebra C).one) :=
  map_idempotentOfSquareRootOfOne_n C.congruence.zero_add_zero C.uniqueness.mul_zero _ (D.matrixAlgebra C)
    (D.homomorphismToPairOfMatrices_isHom C hneg)
    (C.eq_neg_of_add_eq_zero hneg (C.congruence.n_add_one.trans C.congruence.one_add_n)).symm C.congruence.one_add_n
    (D.homomorphismToPairOfMatrices_centralElement C hneg) (mul_n_eq_neg C hneg) h hh

/-- 本文 `claim_homomorphism_to_pair_of_matrices_after_homomorphism_to_odd_clifford_algebra_is_identity` の必要十分版：
すべての F, G について Φ'(Ψ'((F, G))) = (F, G)。2 の可逆性は Φ'(e_±) の値で要る。 -/
theorem homomorphismToPairOfMatrices_homomorphismFromPairOfMatrices (hneg : ∀ a : K, a + -a = 0) (h : K)
    (hh : h * (1 + 1) = 1) (F G : Mat K (PowerSet D.M)) :
    D.homomorphismToPairOfMatrices C hneg (D.homomorphismFromPairOfMatrices C hneg h (F, G)) = (F, G) :=
  map_pairMapThroughIdempotents C.congruence.zero_add_zero _ (D.matrixAlgebra C)
    (D.homomorphismToPairOfMatrices_isHom C hneg) (D.homomorphismToPairOfMatrices_oddInclusionHom C hneg)
    (D.homomorphismToMatrix_homomorphismFromMatrix C hneg)
    (D.homomorphismToPairOfMatrices_idempotentPlus C hneg h hh)
    (D.homomorphismToPairOfMatrices_idempotentMinus C hneg h hh) F G

/-- 本文 `claim_homomorphism_to_odd_clifford_algebra_after_homomorphism_to_pair_of_matrices_is_identity` の必要十分版：
すべての a ∈ A' について Ψ'(Φ'(a)) = a。2 の可逆性は Ψ' が準同型であることと e_± の和・差の主張で要る。 -/
theorem homomorphismFromPairOfMatrices_homomorphismToPairOfMatrices (hneg : ∀ a : K, a + -a = 0) (h : K)
    (hh : h * (1 + 1) = 1) (a : (D.oddSpace C).Cl C) :
    D.homomorphismFromPairOfMatrices C hneg h (D.homomorphismToPairOfMatrices C hneg a) = a :=
  pairMapThroughIdempotents_map ((D.space C).cliffordAlgebra C) _ (D.matrixAlgebra C) (D.oddInclusionHom_isHom C hneg)
    (D.homomorphismFromMatrix_isHom C hneg) (D.homomorphismToPairOfMatrices_isHom C hneg)
    (D.homomorphismFromPairOfMatrices_isHom C hneg h hh) (D.homomorphismToPairOfMatrices_oddInclusionHom C hneg)
    (D.homomorphismFromMatrix_homomorphismToMatrix C hneg) (D.homomorphismToPairOfMatrices_addedGenerator C hneg)
    (D.idempotentPlus_add_idempotentMinus C hneg h hh) (D.idempotentPlus_sub_idempotentMinus C hneg h hh) rfl
    (D.parityElement_mul_self C hneg) ((D.space C).γ C) ((D.oddSpace C).γ C) ((D.oddSpace C).γ_generates C)
    (D.oddSpace_γ_pair C hneg) a

/-- 本文 `theorem_clifford_algebra_of_odd_dimensional_quadratic_space_is_isomorphic_to_product_of_matrix_algebras` の
必要十分版：Φ' と Ψ' は準同型で、Ψ'(Φ'(a)) = a、Φ'(Ψ'((F, G))) = (F, G)。Φ' は全単射で、Φ'(a) = (F, G) を満たす a は
Ψ'((F, G)) である。2 の可逆性 h · (1 + 1) = 1 を仮定に持つ。 -/
theorem oddCliffordAlgebra_isomorphic_pairOfMatrixAlgebras (hneg : ∀ a : K, a + -a = 0) (h : K)
    (hh : h * (1 + 1) = 1) :
    IsAlgebraHomomorphism ((D.oddSpace C).cliffordAlgebra C) (D.pairOfMatricesAlgebra C)
        (D.homomorphismToPairOfMatrices C hneg) ∧
      IsAlgebraHomomorphism (D.pairOfMatricesAlgebra C) ((D.oddSpace C).cliffordAlgebra C)
        (D.homomorphismFromPairOfMatrices C hneg h) ∧
      (∀ a : (D.oddSpace C).Cl C,
        D.homomorphismFromPairOfMatrices C hneg h (D.homomorphismToPairOfMatrices C hneg a) = a) ∧
      (∀ F G : Mat K (PowerSet D.M),
        D.homomorphismToPairOfMatrices C hneg (D.homomorphismFromPairOfMatrices C hneg h (F, G)) = (F, G)) ∧
      Function.Bijective (D.homomorphismToPairOfMatrices C hneg) ∧
      (∀ (F G : Mat K (PowerSet D.M)) (a : (D.oddSpace C).Cl C),
        D.homomorphismToPairOfMatrices C hneg a = (F, G) → a = D.homomorphismFromPairOfMatrices C hneg h (F, G)) := by
  let Φ' := D.homomorphismToPairOfMatrices C hneg
  let Ψ' := D.homomorphismFromPairOfMatrices C hneg h
  -- 単射であること
  have hinj : Function.Injective Φ' := by
    intro a a' haa'
    calc a = Ψ' (Φ' a) := (D.homomorphismFromPairOfMatrices_homomorphismToPairOfMatrices C hneg h hh a).symm
      _ = Ψ' (Φ' a') := by rw [haa']
      _ = a' := D.homomorphismFromPairOfMatrices_homomorphismToPairOfMatrices C hneg h hh a'
  -- 全射であること
  have hsurj : Function.Surjective Φ' := fun p =>
    ⟨Ψ' (p.1, p.2), D.homomorphismToPairOfMatrices_homomorphismFromPairOfMatrices C hneg h hh p.1 p.2⟩
  -- Φ'(a) = (F, G) を満たすただ一つの a は Ψ'((F, G))
  have hinv : ∀ (F G : Mat K (PowerSet D.M)) (a : (D.oddSpace C).Cl C), Φ' a = (F, G) → a = Ψ' (F, G) := by
    intro F G a ha
    apply hinj
    calc Φ' a = (F, G) := ha
      _ = Φ' (Ψ' (F, G)) := (D.homomorphismToPairOfMatrices_homomorphismFromPairOfMatrices C hneg h hh F G).symm
  exact ⟨D.homomorphismToPairOfMatrices_isHom C hneg, D.homomorphismFromPairOfMatrices_isHom C hneg h hh,
    D.homomorphismFromPairOfMatrices_homomorphismToPairOfMatrices C hneg h hh,
    D.homomorphismToPairOfMatrices_homomorphismFromPairOfMatrices C hneg h hh, ⟨hinj, hsurj⟩, hinv⟩

end

end CliffordMatrixIsomorphism.NecSuf.Clifford.SplitData
