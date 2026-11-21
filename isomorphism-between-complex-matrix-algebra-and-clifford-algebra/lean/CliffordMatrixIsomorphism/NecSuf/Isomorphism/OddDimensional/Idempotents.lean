/-
章「同型の証明」の節「系：奇数次元の二次空間」のうち、Φ'(z) の値と、中心の元 z から作る二つの冪等元 e_σ についての
定義と主張の必要十分版。具体版 `Isomorphism/OddDimensional/Idempotents.lean` と同じ calc の行を、係数 ℂ を型の変数 K に、
-1_ℂ を K の元 n に、h := ½ を K の元 h に替えて書く。

二段に分けて置く。
- 前半（名前空間 `NecSuf.AlgebraOver`）：主張の本体。具体版の calc の行が A' と z について実際に使うのは、
  「A' が K の上の代数であること」と「z ·_{A'} z = 1_{A'}」（平方と積の主張）・「z ·_{A'} y = y ·_{A'} z」（交換の主張）だけなので、
  A' を任意の代数 SA に、z を任意の元に替えて書く。Φ'(z)・Φ'(e_σ) も、Φ' が SA から直積 B × B への準同型であることと、
  本文が引く値（Φ'(j(ε))・Φ'(g)・Φ'(z)）だけを仮定にして書く。クリフォード代数の構造は、どの行も使わない。
- 後半（名前空間 `NecSuf.Clifford.SplitData`）：前半を A' := Cl(V',q')、z := D.centralElement に当てた、具体版と同じ名前の宣言。
  後続の主張（Ψ'・Φ' ∘ Ψ'・Ψ' ∘ Φ'）が引くのはこちらである。

本文のラベルと宣言の対応（前半の名前 / 後半の名前。後半の名前は具体版と同じ）:

  claim_homomorphism_to_pair_of_matrices_on_central_element
      map_mul_of_diagonal_and_signed_values / homomorphismToPairOfMatrices_centralElement
  def_idempotents_of_odd_dimensional_clifford_algebra
      idempotentOfSquareRootOfOne / idempotent・idempotentPlus・idempotentMinus
  claim_idempotent_of_odd_dimensional_clifford_algebra_squares_to_itself
      idempotentOfSquareRootOfOne_mul_self / idempotent_mul_self・idempotentPlus_mul_self・idempotentMinus_mul_self
  claim_product_of_different_idempotents_of_odd_dimensional_clifford_algebra_is_zero
      idempotentOfSquareRootOfOne_mul_neg / idempotent_mul_idempotent_neg・idempotentPlus_mul_idempotentMinus・
      idempotentMinus_mul_idempotentPlus
  claim_sum_of_idempotents_of_odd_dimensional_clifford_algebra_is_one
      idempotentOfSquareRootOfOne_add / idempotentPlus_add_idempotentMinus
  claim_difference_of_idempotents_of_odd_dimensional_clifford_algebra_is_central_element
      idempotentOfSquareRootOfOne_sub / idempotentPlus_sub_idempotentMinus（e_+ + n ∗ e_- = z）
  claim_idempotents_of_odd_dimensional_clifford_algebra_commute_with_every_element
      idempotentOfSquareRootOfOne_comm / idempotent_comm
  claim_homomorphism_to_pair_of_matrices_on_idempotents
      map_idempotentOfSquareRootOfOne / homomorphismToPairOfMatrices_idempotent

h := ½（本文 `def_inverse_of_two_in_complex_numbers`）は K の元の変数 h で、使う主張だけが h ·_K (1 + 1) = 1（`hh`）を仮定に持つ。
`GeneralEvenDimensional/IsometryToSplitSpace.lean` の `IsInverseOfTwo h` の欄 `mul_two` と同じ式で、もう一つの欄 (1 + 1) · h = 1 はどの主張も使わない。

主張ごとに使う K の性質（前半の仮定。本文が「ℂ の四則」「σ ∈ {1, -1} なので」「h の定義」とした行がどの仮定になるか）:

  map_mul_of_diagonal_and_signed_values   なし（Φ・Φ' が準同型、ε · ε = 1、Φ'(j(ε))・Φ'(g) の値だけ）
  idempotentOfSquareRootOfOne             なし（定義）
  …_mul_self                              σ · σ = 1、h · (1 + 1) = 1、乗法の結合法則と a · 1 = a（(h·h)·(1+1) = h の行）
  …_mul_neg                               σ · σ = 1、a · (-b) = -(a · b)、-1 = n、1 + n = 0・-a + a = 0（ℂ の四則の行）、
                                          0 + 0 = 0（零のスカラー倍）と a · 0 = 0（零ベクトルのスカラー倍）
  …_add                                   1 + n = 0、0 + 0 = 0、h · (1 + 1) = 1
  …_sub                                   n · h = h · n、n · n = 1、1 + n = 0、0 + 0 = 0、h · (1 + 1) = 1
  …_comm                                  なし（z が y と交換することだけ）
  map_idempotentOfSquareRootOfOne         a · n = -a（σ · (-1) = -σ の行）

分かったこと:
- 2 の可逆性（h · (1 + 1) = 1 となる h の存在）が要るのは、e_σ の平方・e_+ + e_-・e_+ + n ∗ e_- の三つの主張だけである。
  e_σ e_σ̄ = 0、e_σ が全ての元と交換すること、Φ'(e_σ)・Φ'(z) は、h を K の任意の元にしても通る（h · (1 + 1) = 1 を使わない）。
  1 + 1 ≠ 0 そのものも、(1 + 1) · h = 1 も使わない。
- z · z = 1 が要るのは平方と積の主張だけで、和と差の主張は z が A の任意の元でも通る。
- σ ∈ {1, -1} が要るのは平方と積の主張だけで、そこでも σ · σ = 1 しか使わない。交換と Φ'(e_σ) は σ が K の任意の元でも通る。
- K の乗法の交換法則は、差の主張の (-1)·h = h·(-1) の行で n · h = h · n としてだけ要る。後半ではこれを
  `CliffordLaws` の欄 `mul_comm` から渡すが、n = -1 と分配法則からも出る（具体版の導出には ℂ の `mul_comm` を渡す）。
- Φ'(z) は、j が準同型であることを使わない（Φ'(j(ε)) の値だけを使う）。
- 本文の前提 M ∈ ℤ_{≥1} は、どの主張も使わない（M = 0 でも同じ証明が通る）。
-/
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.OddDimensional.CentralElement
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.OddDimensional.CommutingElements
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.OddDimensional.HomomorphismToPairOfMatrices
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.GeneralEvenDimensional.InducedHomomorphism

namespace CliffordMatrixIsomorphism.NecSuf.AlgebraOver

universe u v w uK

variable {K : Type uK} [Add K] [Mul K] [One K] {A : Type u} {A' : Type v} {B : Type w}

/-! ### Φ'(z) -/

/-- 本文 `claim_homomorphism_to_pair_of_matrices_on_central_element` の必要十分版：Φ : A → B と Φ' : A' → B × B が
準同型で、ε · ε = 1、Φ'(x) = (Φ(ε), Φ(ε))、Φ'(g) = (Φ(ε), n ∗_B Φ(ε)) なら、Φ'(x ·_{A'} g) = (1_B, n ∗_B 1_B)。
本文では x := j(ε)、x ·_{A'} g = z である。 -/
theorem map_mul_of_diagonal_and_signed_values (SA : AlgebraOver K A) (SA' : AlgebraOver K A') (SB : AlgebraOver K B)
    {Φ : A → B} {Φ' : A' → B × B} (hΦ : IsAlgebraHomomorphism SA SB Φ)
    (hΦ' : IsAlgebraHomomorphism SA' (productAlgebra SB SB) Φ') {n : K} (ε : A) (x g : A')
    (hε : SA.mul ε ε = SA.one) (hx : Φ' x = (Φ ε, Φ ε)) (hg : Φ' g = (Φ ε, SB.smul n (Φ ε))) :
    Φ' (SA'.mul x g) = (SB.one, SB.smul n SB.one) := by
  let BB := productAlgebra SB SB
  calc Φ' (SA'.mul x g)
      = BB.mul (Φ' x) (Φ' g) := hΦ'.map_mul _ _
    _ = BB.mul (Φ ε, Φ ε) (Φ' g) := by rw [hx]
    _ = BB.mul (Φ ε, Φ ε) (Φ ε, SB.smul n (Φ ε)) := by rw [hg]
    _ = (SB.mul (Φ ε) (Φ ε), SB.mul (Φ ε) (SB.smul n (Φ ε))) := rfl
    _ = (SB.mul (Φ ε) (Φ ε), SB.smul n (SB.mul (Φ ε) (Φ ε))) := by
        -- スカラー倍と乗法の両立、右の因子
        rw [← SB.smul_mul_right n (Φ ε) (Φ ε)]
    _ = (Φ (SA.mul ε ε), SB.smul n (Φ (SA.mul ε ε))) := by
        -- Φ は乗法を保つ
        rw [hΦ.map_mul ε ε]
    _ = (Φ SA.one, SB.smul n (Φ SA.one)) := by rw [hε]
    _ = (SB.one, SB.smul n SB.one) := by
        -- Φ は乗法の単位元を保つ
        rw [hΦ.map_one]

/-! ### 冪等元 e_σ -/

/-- 本文 `def_idempotents_of_odd_dimensional_clifford_algebra` の必要十分版：e_σ := h ∗ (1 + σ ∗ z)。
定義には h・σ・z の性質を何も使わない。 -/
def idempotentOfSquareRootOfOne (SA : AlgebraOver K A) (h : K) (z : A) (σ : K) : A :=
  SA.smul h (SA.add SA.one (SA.smul σ z))

/-- 本文 `claim_idempotent_of_odd_dimensional_clifford_algebra_squares_to_itself` の必要十分版：z · z = 1、σ · σ = 1、
h · (1 + 1) = 1 なら e_σ · e_σ = e_σ。2 の可逆性 `hh` は最後から二行目の (h·h)·(1+1) = h で要る。 -/
theorem idempotentOfSquareRootOfOne_mul_self (SA : AlgebraOver K A) {z : A} (hz : SA.mul z z = SA.one)
    (hmul_assoc : ∀ a b c : K, (a * b) * c = a * (b * c)) (hmul_one : ∀ a : K, a * 1 = a)
    (h : K) (hh : h * (1 + 1) = 1) (σ : K) (hσ : σ * σ = 1) :
    SA.mul (idempotentOfSquareRootOfOne SA h z σ) (idempotentOfSquareRootOfOne SA h z σ)
      = idempotentOfSquareRootOfOne SA h z σ := by
  let U := SA.add SA.one (SA.smul σ z)
  -- 準備：U · U = (1 + 1) ∗ U
  have hU : SA.mul U U = SA.smul (1 + 1) U := calc
    SA.mul U U = SA.add (SA.mul SA.one U) (SA.mul (SA.smul σ z) U) := SA.right_distrib _ _ _
    _ = SA.add U (SA.mul (SA.smul σ z) U) := by rw [SA.one_mul U]
    _ = SA.add U (SA.add (SA.mul (SA.smul σ z) SA.one) (SA.mul (SA.smul σ z) (SA.smul σ z))) :=
        congrArg (SA.add U) (SA.left_distrib _ _ _)
    _ = SA.add U (SA.add (SA.smul σ z) (SA.mul (SA.smul σ z) (SA.smul σ z))) := by
        rw [SA.mul_one (SA.smul σ z)]
    _ = SA.add U (SA.add (SA.smul σ z) (SA.smul σ (SA.mul z (SA.smul σ z)))) := by
        rw [← SA.smul_mul_left σ z (SA.smul σ z)]
    _ = SA.add U (SA.add (SA.smul σ z) (SA.smul σ (SA.smul σ (SA.mul z z)))) := by
        rw [← SA.smul_mul_right σ z z]
    _ = SA.add U (SA.add (SA.smul σ z) (SA.smul (σ * σ) (SA.mul z z))) := by
        rw [SA.smul_assoc σ σ (SA.mul z z)]
    _ = SA.add U (SA.add (SA.smul σ z) (SA.smul (σ * σ) SA.one)) := by rw [hz]
    -- 本文の「σ ∈ {1, -1} なので σ · σ = 1」の行
    _ = SA.add U (SA.add (SA.smul σ z) (SA.smul 1 SA.one)) := by rw [hσ]
    _ = SA.add U (SA.add (SA.smul σ z) SA.one) := by rw [SA.one_smul SA.one]
    _ = SA.add U U := by rw [SA.add_comm (SA.smul σ z) SA.one]
    _ = SA.add (SA.smul 1 U) (SA.smul 1 U) := by rw [SA.one_smul U]
    _ = SA.smul (1 + 1) U := (SA.add_smul 1 1 U).symm
  calc SA.mul (idempotentOfSquareRootOfOne SA h z σ) (idempotentOfSquareRootOfOne SA h z σ)
      = SA.mul (SA.smul h U) (SA.smul h U) := rfl
    _ = SA.smul h (SA.mul U (SA.smul h U)) := (SA.smul_mul_left h U _).symm
    _ = SA.smul h (SA.smul h (SA.mul U U)) := by rw [← SA.smul_mul_right h U U]
    _ = SA.smul (h * h) (SA.mul U U) := (SA.smul_assoc h h _).symm
    _ = SA.smul (h * h) (SA.smul (1 + 1) U) := by rw [hU]
    _ = SA.smul ((h * h) * (1 + 1)) U := (SA.smul_assoc _ _ _).symm
    _ = SA.smul (h * (h * (1 + 1))) U := by rw [hmul_assoc h h (1 + 1)]
    -- 本文の「h · (1 + 1) = 1」の行。2 の可逆性はここで要る
    _ = SA.smul (h * 1) U := by rw [hh]
    _ = SA.smul h U := by rw [hmul_one h]
    _ = idempotentOfSquareRootOfOne SA h z σ := rfl

/-- 本文 `claim_product_of_different_idempotents_of_odd_dimensional_clifford_algebra_is_zero` の必要十分版：
z · z = 1、σ · σ = 1 なら e_σ · e_{-σ} = 0。h は K の任意の元でよい（2 の可逆性を使わない）。 -/
theorem idempotentOfSquareRootOfOne_mul_neg [Zero K] [Neg K] (SA : AlgebraOver K A) {z : A}
    (hz : SA.mul z z = SA.one) (h00 : (0 : K) + 0 = 0) (hmul0 : ∀ a : K, a * 0 = 0)
    (hmul_neg : ∀ a b : K, a * -b = -(a * b)) {n : K} (hn : -(1 : K) = n) (h1n : 1 + n = 0)
    (hneg_add : ∀ a : K, -a + a = 0) (h : K) (σ : K) (hσ : σ * σ = 1) :
    SA.mul (idempotentOfSquareRootOfOne SA h z σ) (idempotentOfSquareRootOfOne SA h z (-σ)) = SA.zero := by
  let U := SA.add SA.one (SA.smul σ z)
  let U' := SA.add SA.one (SA.smul (-σ) z)
  -- 準備：U · Ū = 0
  have hU : SA.mul U U' = SA.zero := calc
    SA.mul U U' = SA.add (SA.mul SA.one U') (SA.mul (SA.smul σ z) U') := SA.right_distrib _ _ _
    _ = SA.add U' (SA.mul (SA.smul σ z) U') := by rw [SA.one_mul U']
    _ = SA.add U' (SA.add (SA.mul (SA.smul σ z) SA.one) (SA.mul (SA.smul σ z) (SA.smul (-σ) z))) :=
        congrArg (SA.add U') (SA.left_distrib _ _ _)
    _ = SA.add U' (SA.add (SA.smul σ z) (SA.mul (SA.smul σ z) (SA.smul (-σ) z))) := by
        rw [SA.mul_one (SA.smul σ z)]
    _ = SA.add U' (SA.add (SA.smul σ z) (SA.smul σ (SA.mul z (SA.smul (-σ) z)))) := by
        rw [← SA.smul_mul_left σ z (SA.smul (-σ) z)]
    _ = SA.add U' (SA.add (SA.smul σ z) (SA.smul σ (SA.smul (-σ) (SA.mul z z)))) := by
        rw [← SA.smul_mul_right (-σ) z z]
    _ = SA.add U' (SA.add (SA.smul σ z) (SA.smul (σ * -σ) (SA.mul z z))) := by
        rw [SA.smul_assoc σ (-σ) (SA.mul z z)]
    _ = SA.add U' (SA.add (SA.smul σ z) (SA.smul (σ * -σ) SA.one)) := by rw [hz]
    _ = SA.add U' (SA.add (SA.smul σ z) (SA.smul (σ * -σ) SA.one)) := rfl  -- σ̄ の定義
    -- 本文の「ℂ の中で x · (-y) = -(x · y)」の行
    _ = SA.add U' (SA.add (SA.smul σ z) (SA.smul (-(σ * σ)) SA.one)) := by rw [hmul_neg σ σ]
    -- 本文の「σ ∈ {1, -1} なので σ · σ = 1」の行
    _ = SA.add U' (SA.add (SA.smul σ z) (SA.smul (-1) SA.one)) := by rw [hσ]
    -- 本文の「-1_ℂ の定義」の行：-1 = n
    _ = SA.add U' (SA.add (SA.smul σ z) (SA.smul n SA.one)) := by rw [hn]
    _ = SA.add U' (SA.add (SA.smul n SA.one) (SA.smul σ z)) := by
        rw [SA.add_comm (SA.smul σ z) (SA.smul n SA.one)]
    _ = SA.add (SA.add SA.one (SA.smul n SA.one)) (SA.add (SA.smul (-σ) z) (SA.smul σ z)) :=
        VectorSpace.rearrange_sum_of_two_sums SA.toVectorSpace _ _ _ _
    _ = SA.add (SA.add (SA.smul 1 SA.one) (SA.smul n SA.one)) (SA.add (SA.smul (-σ) z) (SA.smul σ z)) := by
        rw [SA.one_smul SA.one]
    _ = SA.add (SA.smul (1 + n) SA.one) (SA.smul (-σ + σ) z) := by
        rw [SA.add_smul 1 n SA.one, SA.add_smul (-σ) σ z]
    -- 本文の「ℂ の四則」の行：1 + (-1) = 0 と σ̄ + σ = 0
    _ = SA.add (SA.smul 0 SA.one) (SA.smul 0 z) := by rw [h1n, hneg_add σ]
    _ = SA.add SA.zero SA.zero := by
        rw [zero_smul_eq_zero SA h00 SA.one, zero_smul_eq_zero SA h00 z]
    _ = SA.zero := SA.add_zero SA.zero
  calc SA.mul (idempotentOfSquareRootOfOne SA h z σ) (idempotentOfSquareRootOfOne SA h z (-σ))
      = SA.mul (SA.smul h U) (SA.smul h U') := rfl
    _ = SA.smul h (SA.mul U (SA.smul h U')) := (SA.smul_mul_left h U _).symm
    _ = SA.smul h (SA.smul h (SA.mul U U')) := by rw [← SA.smul_mul_right h U U']
    _ = SA.smul h (SA.smul h SA.zero) := by rw [hU]
    _ = SA.smul h SA.zero := congrArg (SA.smul h) (smul_zero_eq_zero SA h00 hmul0 h)
    _ = SA.zero := smul_zero_eq_zero SA h00 hmul0 h

/-- 本文 `claim_sum_of_idempotents_of_odd_dimensional_clifford_algebra_is_one` の必要十分版：
1 + n = 0、h · (1 + 1) = 1 なら e_1 + e_n = 1。z は A の任意の元でよい（z · z = 1 を使わない）。
2 の可逆性 `hh` は最後から二行目で要る。 -/
theorem idempotentOfSquareRootOfOne_add [Zero K] (SA : AlgebraOver K A) (z : A) (h00 : (0 : K) + 0 = 0)
    {n : K} (h1n : 1 + n = 0) (h : K) (hh : h * (1 + 1) = 1) :
    SA.add (idempotentOfSquareRootOfOne SA h z 1) (idempotentOfSquareRootOfOne SA h z n) = SA.one := by
  calc SA.add (idempotentOfSquareRootOfOne SA h z 1) (idempotentOfSquareRootOfOne SA h z n)
      = SA.add (SA.smul h (SA.add SA.one (SA.smul 1 z))) (SA.smul h (SA.add SA.one (SA.smul n z))) := rfl
    _ = SA.smul h (SA.add (SA.add SA.one (SA.smul 1 z)) (SA.add SA.one (SA.smul n z))) :=
        (SA.smul_add h _ _).symm
    _ = SA.smul h (SA.add (SA.add SA.one SA.one) (SA.add (SA.smul 1 z) (SA.smul n z))) :=
        congrArg (SA.smul h) (VectorSpace.rearrange_sum_of_two_sums SA.toVectorSpace _ _ _ _)
    _ = SA.smul h (SA.add (SA.add (SA.smul 1 SA.one) (SA.smul 1 SA.one)) (SA.add (SA.smul 1 z) (SA.smul n z))) := by
        rw [SA.one_smul SA.one]
    _ = SA.smul h (SA.add (SA.smul (1 + 1) SA.one) (SA.smul (1 + n) z)) := by
        rw [SA.add_smul 1 1 SA.one, SA.add_smul 1 n z]
    -- 本文の「ℂ の四則」の行：1 + (-1) = 0
    _ = SA.smul h (SA.add (SA.smul (1 + 1) SA.one) (SA.smul 0 z)) := by rw [h1n]
    _ = SA.smul h (SA.add (SA.smul (1 + 1) SA.one) SA.zero) := by rw [zero_smul_eq_zero SA h00 z]
    _ = SA.smul h (SA.smul (1 + 1) SA.one) := by rw [SA.add_zero (SA.smul (1 + 1) SA.one)]
    _ = SA.smul (h * (1 + 1)) SA.one := (SA.smul_assoc _ _ _).symm
    -- 本文の「h の定義」の行。2 の可逆性はここで要る
    _ = SA.smul 1 SA.one := by rw [hh]
    _ = SA.one := SA.one_smul _

/-- 本文 `claim_difference_of_idempotents_of_odd_dimensional_clifford_algebra_is_central_element` の必要十分版：
n · h = h · n、n · n = 1、1 + n = 0、h · (1 + 1) = 1 なら e_1 + n ∗ e_n = z。z は A の任意の元でよい。
2 の可逆性 `hh` は最後から二行目で要る。 -/
theorem idempotentOfSquareRootOfOne_sub [Zero K] (SA : AlgebraOver K A) (z : A) (h00 : (0 : K) + 0 = 0)
    {n : K} (h1n : 1 + n = 0) (hnn : n * n = 1) (h : K) (hnh : n * h = h * n) (hh : h * (1 + 1) = 1) :
    SA.add (idempotentOfSquareRootOfOne SA h z 1) (SA.smul n (idempotentOfSquareRootOfOne SA h z n)) = z := by
  calc SA.add (idempotentOfSquareRootOfOne SA h z 1) (SA.smul n (idempotentOfSquareRootOfOne SA h z n))
      = SA.add (SA.smul h (SA.add SA.one (SA.smul 1 z)))
          (SA.smul n (SA.smul h (SA.add SA.one (SA.smul n z)))) := rfl
    _ = SA.add (SA.smul h (SA.add SA.one (SA.smul 1 z)))
          (SA.smul (n * h) (SA.add SA.one (SA.smul n z))) := by
        rw [SA.smul_assoc n h (SA.add SA.one (SA.smul n z))]
    -- 本文の「ℂ の四則」の行：(-1) · h = h · (-1)。K の乗法の交換法則はここでだけ、n と h の交換として要る
    _ = SA.add (SA.smul h (SA.add SA.one (SA.smul 1 z)))
          (SA.smul (h * n) (SA.add SA.one (SA.smul n z))) := by rw [hnh]
    _ = SA.add (SA.smul h (SA.add SA.one (SA.smul 1 z)))
          (SA.smul h (SA.smul n (SA.add SA.one (SA.smul n z)))) := by
        rw [SA.smul_assoc h n (SA.add SA.one (SA.smul n z))]
    _ = SA.smul h (SA.add (SA.add SA.one (SA.smul 1 z)) (SA.smul n (SA.add SA.one (SA.smul n z)))) :=
        (SA.smul_add h _ _).symm
    _ = SA.smul h (SA.add (SA.add SA.one (SA.smul 1 z))
          (SA.add (SA.smul n SA.one) (SA.smul n (SA.smul n z)))) := by
        rw [SA.smul_add n SA.one (SA.smul n z)]
    _ = SA.smul h (SA.add (SA.add SA.one (SA.smul 1 z))
          (SA.add (SA.smul n SA.one) (SA.smul (n * n) z))) := by
        rw [SA.smul_assoc n n z]
    -- 本文の「ℂ の四則」の行：(-1) · (-1) = 1
    _ = SA.smul h (SA.add (SA.add SA.one (SA.smul 1 z)) (SA.add (SA.smul n SA.one) (SA.smul 1 z))) := by
        rw [hnn]
    _ = SA.smul h (SA.add (SA.add SA.one (SA.smul n SA.one)) (SA.add (SA.smul 1 z) (SA.smul 1 z))) :=
        congrArg (SA.smul h) (VectorSpace.rearrange_sum_of_two_sums SA.toVectorSpace _ _ _ _)
    _ = SA.smul h (SA.add (SA.add (SA.smul 1 SA.one) (SA.smul n SA.one)) (SA.add (SA.smul 1 z) (SA.smul 1 z))) := by
        rw [SA.one_smul SA.one]
    _ = SA.smul h (SA.add (SA.smul (1 + n) SA.one) (SA.smul (1 + 1) z)) := by
        rw [SA.add_smul 1 n SA.one, SA.add_smul 1 1 z]
    -- 本文の「ℂ の四則」の行：1 + (-1) = 0
    _ = SA.smul h (SA.add (SA.smul 0 SA.one) (SA.smul (1 + 1) z)) := by rw [h1n]
    _ = SA.smul h (SA.add SA.zero (SA.smul (1 + 1) z)) := by rw [zero_smul_eq_zero SA h00 SA.one]
    _ = SA.smul h (SA.add (SA.smul (1 + 1) z) SA.zero) := by rw [SA.add_comm SA.zero (SA.smul (1 + 1) z)]
    _ = SA.smul h (SA.smul (1 + 1) z) := by rw [SA.add_zero (SA.smul (1 + 1) z)]
    _ = SA.smul (h * (1 + 1)) z := (SA.smul_assoc _ _ _).symm
    -- 本文の「h の定義」の行。2 の可逆性はここで要る
    _ = SA.smul 1 z := by rw [hh]
    _ = z := SA.one_smul _

/-- 本文 `claim_idempotents_of_odd_dimensional_clifford_algebra_commute_with_every_element` の必要十分版：
z ·_A y = y ·_A z なら y ·_A e_σ = e_σ ·_A y。係数の性質を一つも使わない（h・σ は K の任意の元でよい）。 -/
theorem idempotentOfSquareRootOfOne_comm (SA : AlgebraOver K A) (h : K) {z : A} (σ : K) (y : A)
    (hzy : SA.mul z y = SA.mul y z) :
    SA.mul y (idempotentOfSquareRootOfOne SA h z σ) = SA.mul (idempotentOfSquareRootOfOne SA h z σ) y := by
  -- claim_elements_commuting_with_fixed_element_form_subalgebra
  have hC : IsSubalgebra SA (commutingElements SA y) := commutingElements_isSubalgebra SA y
  have h1 : SA.one ∈ commutingElements SA y := hC.one_mem
  have hz : z ∈ commutingElements SA y := hzy.symm
  have h2 : SA.smul σ z ∈ commutingElements SA y := hC.smul_mem σ z hz
  have h3 : SA.add SA.one (SA.smul σ z) ∈ commutingElements SA y := hC.add_mem _ _ h1 h2
  have h4 : idempotentOfSquareRootOfOne SA h z σ ∈ commutingElements SA y := hC.smul_mem h _ h3
  exact h4

/-- 本文 `claim_homomorphism_to_pair_of_matrices_on_idempotents` の必要十分版：F : A → B × B が準同型で
F(z) = (1_B, n ∗_B 1_B)、a · n = -a なら F(e_σ) = ((h·(1+σ)) ∗ 1_B, (h·(1+(-σ))) ∗ 1_B)。
h・σ は K の任意の元でよい（2 の可逆性も σ · σ = 1 も使わない）。 -/
theorem map_idempotentOfSquareRootOfOne [Neg K] (SA : AlgebraOver K A) (SB : AlgebraOver K B) {F : A → B × B}
    (hF : IsAlgebraHomomorphism SA (productAlgebra SB SB) F) {z : A} {n : K}
    (hFz : F z = (SB.one, SB.smul n SB.one)) (hmul_n : ∀ a : K, a * n = -a) (h σ : K) :
    F (idempotentOfSquareRootOfOne SA h z σ)
      = (SB.smul (h * (1 + σ)) SB.one, SB.smul (h * (1 + -σ)) SB.one) := by
  let BB := productAlgebra SB SB
  calc F (idempotentOfSquareRootOfOne SA h z σ)
      = F (SA.smul h (SA.add SA.one (SA.smul σ z))) := rfl
    _ = BB.smul h (F (SA.add SA.one (SA.smul σ z))) := hF.map_smul _ _
    _ = BB.smul h (BB.add (F SA.one) (F (SA.smul σ z))) := by rw [hF.map_add SA.one (SA.smul σ z)]
    _ = BB.smul h (BB.add (F SA.one) (BB.smul σ (F z))) := by rw [hF.map_smul σ z]
    _ = BB.smul h (BB.add BB.one (BB.smul σ (F z))) := by rw [hF.map_one]
    _ = BB.smul h (BB.add (SB.one, SB.one) (BB.smul σ (F z))) := rfl
    _ = BB.smul h (BB.add (SB.one, SB.one) (BB.smul σ (SB.one, SB.smul n SB.one))) := by rw [hFz]
    _ = BB.smul h (BB.add (SB.one, SB.one) (SB.smul σ SB.one, SB.smul σ (SB.smul n SB.one))) := rfl
    _ = BB.smul h (SB.add SB.one (SB.smul σ SB.one), SB.add SB.one (SB.smul σ (SB.smul n SB.one))) := rfl
    _ = (SB.smul h (SB.add SB.one (SB.smul σ SB.one)), SB.smul h (SB.add SB.one (SB.smul σ (SB.smul n SB.one)))) :=
        rfl
    _ = (SB.smul h (SB.add SB.one (SB.smul σ SB.one)), SB.smul h (SB.add SB.one (SB.smul (σ * n) SB.one))) := by
        rw [SB.smul_assoc σ n SB.one]
    -- 本文の「ℂ の四則」の行：σ · (-1) = -σ
    _ = (SB.smul h (SB.add SB.one (SB.smul σ SB.one)), SB.smul h (SB.add SB.one (SB.smul (-σ) SB.one))) := by
        rw [hmul_n σ]
    _ = (SB.smul h (SB.add (SB.smul 1 SB.one) (SB.smul σ SB.one)),
          SB.smul h (SB.add (SB.smul 1 SB.one) (SB.smul (-σ) SB.one))) := by
        rw [SB.one_smul SB.one]
    _ = (SB.smul h (SB.smul (1 + σ) SB.one), SB.smul h (SB.smul (1 + -σ) SB.one)) := by
        rw [SB.add_smul 1 σ SB.one, SB.add_smul 1 (-σ) SB.one]
    _ = (SB.smul (h * (1 + σ)) SB.one, SB.smul (h * (1 + -σ)) SB.one) := by
        rw [SB.smul_assoc h (1 + σ) SB.one, SB.smul_assoc h (1 + -σ) SB.one]

end CliffordMatrixIsomorphism.NecSuf.AlgebraOver

namespace CliffordMatrixIsomorphism.NecSuf.Clifford.SplitData

open CliffordMatrixIsomorphism.NecSuf.AlgebraOver
open CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra (PowerSet)

universe u uK

noncomputable section

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K] [Neg K] {n : K} (C : CliffordLaws K n)
  {W : Type u} (D : SplitData K W)

/-! ### 前半を A' := Cl(V',q')、z := D.centralElement に当てる -/

/-- 本文 `claim_homomorphism_to_pair_of_matrices_on_central_element` の必要十分版：Φ'(z) = (1_B, n ∗_B 1_B)。 -/
theorem homomorphismToPairOfMatrices_centralElement (hneg : ∀ a : K, a + -a = 0) :
    D.homomorphismToPairOfMatrices C hneg (D.centralElement C hneg)
      = ((D.matrixAlgebra C).one, (D.matrixAlgebra C).smul n (D.matrixAlgebra C).one) :=
  map_mul_of_diagonal_and_signed_values ((D.space C).cliffordAlgebra C) ((D.oddSpace C).cliffordAlgebra C)
    (D.matrixAlgebra C) (D.homomorphismToMatrix_isHom C hneg) (D.homomorphismToPairOfMatrices_isHom C hneg)
    (D.parityElement C) (D.oddInclusionHom C hneg (D.parityElement C)) (D.addedGenerator C)
    (D.parityElement_mul_self C hneg) (D.homomorphismToPairOfMatrices_oddInclusionHom C hneg (D.parityElement C))
    (D.homomorphismToPairOfMatrices_addedGenerator C hneg)

/-- 本文 `def_idempotents_of_odd_dimensional_clifford_algebra` の必要十分版：e_σ := h ∗_{A'} (1_{A'} +_{A'} σ ∗_{A'} z)。 -/
def idempotent (hneg : ∀ a : K, a + -a = 0) (h σ : K) : (D.oddSpace C).Cl C :=
  idempotentOfSquareRootOfOne ((D.oddSpace C).cliffordAlgebra C) h (D.centralElement C hneg) σ

/-- 本文 `def_idempotents_of_odd_dimensional_clifford_algebra` の必要十分版：e_+ := e_1。 -/
def idempotentPlus (hneg : ∀ a : K, a + -a = 0) (h : K) : (D.oddSpace C).Cl C := D.idempotent C hneg h 1

/-- 本文 `def_idempotents_of_odd_dimensional_clifford_algebra` の必要十分版：e_- := e_n（n は -1_ℂ の役）。 -/
def idempotentMinus (hneg : ∀ a : K, a + -a = 0) (h : K) : (D.oddSpace C).Cl C := D.idempotent C hneg h n

omit [Neg K] in
include C in
/-- σ ∈ {1, n} なら σ · σ = 1（本文の「σ ∈ {1, -1} なので σ · σ = 1」）。 -/
theorem mul_self_of_mem_one_n {σ : K} (hσ : σ = 1 ∨ σ = n) : σ * σ = 1 := by
  rcases hσ with rfl | rfl
  · exact C.uniqueness.one_mul 1
  · exact C.congruence.n_mul_n

/-- 本文 `claim_idempotent_of_odd_dimensional_clifford_algebra_squares_to_itself` の必要十分版：
σ ∈ {1, n} について e_σ ·_{A'} e_σ = e_σ。2 の可逆性 h · (1 + 1) = 1 を仮定に持つ。 -/
theorem idempotent_mul_self (hneg : ∀ a : K, a + -a = 0) (h : K) (hh : h * (1 + 1) = 1) (σ : K)
    (hσ : σ = 1 ∨ σ = n) :
    ((D.oddSpace C).cliffordAlgebra C).mul (D.idempotent C hneg h σ) (D.idempotent C hneg h σ)
      = D.idempotent C hneg h σ :=
  idempotentOfSquareRootOfOne_mul_self _ (D.centralElement_mul_self C hneg) C.valuedMaps.mul_assoc C.mul_one
    h hh σ (mul_self_of_mem_one_n C hσ)

/-- 本文 `claim_idempotent_of_odd_dimensional_clifford_algebra_squares_to_itself` を σ := 1 に当てたもの。 -/
theorem idempotentPlus_mul_self (hneg : ∀ a : K, a + -a = 0) (h : K) (hh : h * (1 + 1) = 1) :
    ((D.oddSpace C).cliffordAlgebra C).mul (D.idempotentPlus C hneg h) (D.idempotentPlus C hneg h)
      = D.idempotentPlus C hneg h :=
  D.idempotent_mul_self C hneg h hh 1 (Or.inl rfl)

/-- 本文 `claim_idempotent_of_odd_dimensional_clifford_algebra_squares_to_itself` を σ := n に当てたもの。 -/
theorem idempotentMinus_mul_self (hneg : ∀ a : K, a + -a = 0) (h : K) (hh : h * (1 + 1) = 1) :
    ((D.oddSpace C).cliffordAlgebra C).mul (D.idempotentMinus C hneg h) (D.idempotentMinus C hneg h)
      = D.idempotentMinus C hneg h :=
  D.idempotent_mul_self C hneg h hh n (Or.inr rfl)

/-- 本文 `claim_product_of_different_idempotents_of_odd_dimensional_clifford_algebra_is_zero` の必要十分版：
σ ∈ {1, n}、σ̄ := -σ について e_σ ·_{A'} e_{σ̄} = 0_{A'}。h は K の任意の元でよい。 -/
theorem idempotent_mul_idempotent_neg (hneg : ∀ a : K, a + -a = 0) (h σ : K) (hσ : σ = 1 ∨ σ = n) :
    ((D.oddSpace C).cliffordAlgebra C).mul (D.idempotent C hneg h σ) (D.idempotent C hneg h (-σ))
      = ((D.oddSpace C).cliffordAlgebra C).zero :=
  idempotentOfSquareRootOfOne_mul_neg _ (D.centralElement_mul_self C hneg) C.congruence.zero_add_zero
    C.uniqueness.mul_zero (C.mul_neg_eq_neg_mul hneg) (C.neg_one_eq_n hneg) C.congruence.one_add_n
    (fun a => (C.uniqueness.add_comm (-a) a).trans (hneg a)) h σ (mul_self_of_mem_one_n C hσ)

/-- 本文 `claim_product_of_different_idempotents_of_odd_dimensional_clifford_algebra_is_zero` を σ := 1 に当てたもの：
e_+ ·_{A'} e_- = 0_{A'}（σ̄ = -1 = n）。 -/
theorem idempotentPlus_mul_idempotentMinus (hneg : ∀ a : K, a + -a = 0) (h : K) :
    ((D.oddSpace C).cliffordAlgebra C).mul (D.idempotentPlus C hneg h) (D.idempotentMinus C hneg h)
      = ((D.oddSpace C).cliffordAlgebra C).zero := by
  have e := D.idempotent_mul_idempotent_neg C hneg h 1 (Or.inl rfl)
  rw [C.neg_one_eq_n hneg] at e
  exact e

/-- 本文 `claim_product_of_different_idempotents_of_odd_dimensional_clifford_algebra_is_zero` を σ := n に当てたもの：
e_- ·_{A'} e_+ = 0_{A'}（σ̄ = -n = 1。n + 1 = 0 から）。 -/
theorem idempotentMinus_mul_idempotentPlus (hneg : ∀ a : K, a + -a = 0) (h : K) :
    ((D.oddSpace C).cliffordAlgebra C).mul (D.idempotentMinus C hneg h) (D.idempotentPlus C hneg h)
      = ((D.oddSpace C).cliffordAlgebra C).zero := by
  have e := D.idempotent_mul_idempotent_neg C hneg h n (Or.inr rfl)
  have hn1 : -n = 1 :=
    (C.eq_neg_of_add_eq_zero hneg (C.congruence.n_add_one.trans C.congruence.one_add_n)).symm
  rw [hn1] at e
  exact e

/-- 本文 `claim_sum_of_idempotents_of_odd_dimensional_clifford_algebra_is_one` の必要十分版：e_+ +_{A'} e_- = 1_{A'}。
2 の可逆性 h · (1 + 1) = 1 を仮定に持つ。 -/
theorem idempotentPlus_add_idempotentMinus (hneg : ∀ a : K, a + -a = 0) (h : K) (hh : h * (1 + 1) = 1) :
    ((D.oddSpace C).cliffordAlgebra C).add (D.idempotentPlus C hneg h) (D.idempotentMinus C hneg h)
      = ((D.oddSpace C).cliffordAlgebra C).one :=
  idempotentOfSquareRootOfOne_add _ _ C.congruence.zero_add_zero C.congruence.one_add_n h hh

/-- 本文 `claim_difference_of_idempotents_of_odd_dimensional_clifford_algebra_is_central_element` の必要十分版：
e_+ +_{A'} n ∗_{A'} e_- = z。2 の可逆性 h · (1 + 1) = 1 を仮定に持つ。n · h = h · n は `CliffordLaws` の `mul_comm` から渡す。 -/
theorem idempotentPlus_sub_idempotentMinus (hneg : ∀ a : K, a + -a = 0) (h : K) (hh : h * (1 + 1) = 1) :
    ((D.oddSpace C).cliffordAlgebra C).add (D.idempotentPlus C hneg h)
        (((D.oddSpace C).cliffordAlgebra C).smul n (D.idempotentMinus C hneg h))
      = D.centralElement C hneg :=
  idempotentOfSquareRootOfOne_sub _ _ C.congruence.zero_add_zero C.congruence.one_add_n C.congruence.n_mul_n h
    (C.n_comm h) hh

/-- 本文 `claim_idempotents_of_odd_dimensional_clifford_algebra_commute_with_every_element` の必要十分版：
すべての y ∈ A' について y ·_{A'} e_σ = e_σ ·_{A'} y。h・σ は K の任意の元でよい。 -/
theorem idempotent_comm (hneg : ∀ a : K, a + -a = 0) (h σ : K) (y : (D.oddSpace C).Cl C) :
    ((D.oddSpace C).cliffordAlgebra C).mul y (D.idempotent C hneg h σ)
      = ((D.oddSpace C).cliffordAlgebra C).mul (D.idempotent C hneg h σ) y :=
  idempotentOfSquareRootOfOne_comm _ h σ y (D.centralElement_comm C hneg y)

include C in
/-- a · n = -a（本文の「ℂ の四則」σ · (-1) = -σ）。-1 = n、a · (-b) = -(a · b)、a · 1 = a から導く。 -/
theorem mul_n_eq_neg (hneg : ∀ a : K, a + -a = 0) (a : K) : a * n = -a := calc
  a * n = a * -1 := by rw [C.neg_one_eq_n hneg]
  _ = -(a * 1) := C.mul_neg_eq_neg_mul hneg a 1
  _ = -a := by rw [C.mul_one a]

/-- 本文 `claim_homomorphism_to_pair_of_matrices_on_idempotents` の必要十分版：
Φ'(e_σ) = ((h · (1 + σ)) ∗_B 1_B, (h · (1 + (-σ))) ∗_B 1_B)。h・σ は K の任意の元でよい。 -/
theorem homomorphismToPairOfMatrices_idempotent (hneg : ∀ a : K, a + -a = 0) (h σ : K) :
    D.homomorphismToPairOfMatrices C hneg (D.idempotent C hneg h σ)
      = ((D.matrixAlgebra C).smul (h * (1 + σ)) (D.matrixAlgebra C).one,
          (D.matrixAlgebra C).smul (h * (1 + -σ)) (D.matrixAlgebra C).one) :=
  map_idempotentOfSquareRootOfOne _ (D.matrixAlgebra C) (D.homomorphismToPairOfMatrices_isHom C hneg)
    (D.homomorphismToPairOfMatrices_centralElement C hneg) (mul_n_eq_neg C hneg) h σ

end

end CliffordMatrixIsomorphism.NecSuf.Clifford.SplitData
