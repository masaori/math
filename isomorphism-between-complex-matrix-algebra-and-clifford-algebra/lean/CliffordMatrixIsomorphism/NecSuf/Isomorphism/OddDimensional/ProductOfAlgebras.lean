/-
章「同型の証明」の節「系：奇数次元の二次空間」のうち、一般の ℂ-代数についての主張（二つの ℂ-代数の直積、
二つの写像を並べた直積への写像、平方が単位元の倍である元に反交換する元の倍を足した元の平方）の必要十分版。具体版
`Isomorphism/OddDimensional/ProductOfAlgebras.lean` と同じ def・calc の行を、係数 ℂ を型の変数 K に替えて書く。

  本文のラベル                                                              このファイル
  def_product_of_two_complex_algebras                                       ProductAlgebra.add・ProductAlgebra.mul・
                                                                            ProductAlgebra.smul・ProductAlgebra.zero・
                                                                            ProductAlgebra.one（集合は A₁ × A₂）
  claim_product_of_two_complex_algebras_is_complex_algebra                  productAlgebra・productAlgebra_toVectorSpace
  def_pair_of_maps_into_product_of_algebras                                 pairMap（⟨φ₁, φ₂⟩）
  claim_pair_of_algebra_homomorphisms_is_algebra_homomorphism               pairMap_isHom
  claim_square_of_sum_with_multiple_of_anticommuting_square_root_of_unity   square_of_add_smul_of_anticommuting

主張ごとに使う K の性質:

  productAlgebra（直積が K-代数であること）  なし。線型空間の条件は直和の欄（直和が線型空間であることは K の性質を使わない）、
                                             環の条件と両立の二つは A₁・A₂ の同じ名前の公理を各成分に当てるだけ
  pairMap_isHom                              なし。φ₁・φ₂ の準同型の条件を各成分に当てるだけ
  square_of_add_smul_of_anticommuting        0 + 0 = 0（`h00`）と a · 0 = 0（`hmul0`）。どちらも s ∗_A 0_A = 0_A の行で、
                                             本文が claim_scalar_multiple_of_zero_vector_is_zero_vector を U_vec(A) に当てることから来る
                                             （その主張の必要十分版 `VectorSpace.smul_zero_eq_zero` の仮定）。
                                             ほかの行は A の環の公理とスカラー倍の公理と両立の二つだけを使う

分かったこと:
  - 直積が K-代数であること・二つの準同型を並べた写像が準同型であることは、係数 K の性質を一つも使わない。
  - 平方の主張で K の性質が入るのは s ∗_A 0_A = 0_A の一行だけで、本文がそこを線型空間の主張で済ませるためである。
    A の側の性質だけからも s ∗_A 0_A = 0_A は出る（0_A = 0_A ·_A 0_A と両立から）が、それは本文と別の論法なので採らない。
  - 2 の可逆性（1 + 1 ≠ 0）・½ の存在・平方根・乗法の交換法則は、どの主張も使わない。主張の中の α + s · s は K の演算の記号だけで書ける。
-/
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.ComplexAlgebra.Definitions
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.ComplexVectorSpace.DirectSum

namespace CliffordMatrixIsomorphism.NecSuf.AlgebraOver

open CliffordMatrixIsomorphism.NecSuf.VectorSpace

universe u v w uK

variable {K : Type uK} [Add K] [Mul K] [One K] {A₁ : Type u} {A₂ : Type v} {C : Type w} {A : Type u}

namespace ProductAlgebra

variable (S₁ : AlgebraOver K A₁) (S₂ : AlgebraOver K A₂)

/-- 本文 `def_product_of_two_complex_algebras`：(x₁, x₂) +_{A₁×A₂} (y₁, y₂) := (x₁ +_{A₁} y₁, x₂ +_{A₂} y₂)。 -/
def add (p q : A₁ × A₂) : A₁ × A₂ := (S₁.add p.1 q.1, S₂.add p.2 q.2)

/-- 本文 `def_product_of_two_complex_algebras`：(x₁, x₂) ·_{A₁×A₂} (y₁, y₂) := (x₁ ·_{A₁} y₁, x₂ ·_{A₂} y₂)。 -/
def mul (p q : A₁ × A₂) : A₁ × A₂ := (S₁.mul p.1 q.1, S₂.mul p.2 q.2)

/-- 本文 `def_product_of_two_complex_algebras`：λ ∗_{A₁×A₂} (x₁, x₂) := (λ ∗_{A₁} x₁, λ ∗_{A₂} x₂)。 -/
def smul (l : K) (p : A₁ × A₂) : A₁ × A₂ := (S₁.smul l p.1, S₂.smul l p.2)

/-- 本文 `def_product_of_two_complex_algebras`：0_{A₁×A₂} := (0_{A₁}, 0_{A₂})。 -/
def zero : A₁ × A₂ := (S₁.zero, S₂.zero)

/-- 本文 `def_product_of_two_complex_algebras`：1_{A₁×A₂} := (1_{A₁}, 1_{A₂})。 -/
def one : A₁ × A₂ := (S₁.one, S₂.one)

end ProductAlgebra

/-- 本文 `claim_product_of_two_complex_algebras_is_complex_algebra`：A₁ と A₂ の直積
(A₁ × A₂, +_{A₁×A₂}, ·_{A₁×A₂}, ∗_{A₁×A₂}, 0_{A₁×A₂}, 1_{A₁×A₂}) は K-代数である（必要十分版）。
線型空間の条件の欄は U_vec(A₁) と U_vec(A₂) の直和の欄（`claim_direct_sum_of_two_vector_spaces_is_complex_vector_space`）。 -/
def productAlgebra (S₁ : AlgebraOver K A₁) (S₂ : AlgebraOver K A₂) : AlgebraOver K (A₁ × A₂) where
  add := ProductAlgebra.add S₁ S₂
  mul := ProductAlgebra.mul S₁ S₂
  zero := ProductAlgebra.zero S₁ S₂
  one := ProductAlgebra.one S₁ S₂
  -- 環の加法の四つ：線型空間の条件の最初の四つと同じ式（直和の欄）
  add_assoc := (directSumVectorSpace S₁.toVectorSpace S₂.toVectorSpace).add_assoc
  add_comm := (directSumVectorSpace S₁.toVectorSpace S₂.toVectorSpace).add_comm
  add_zero := (directSumVectorSpace S₁.toVectorSpace S₂.toVectorSpace).add_zero
  exists_add_inverse :=
    (directSumVectorSpace S₁.toVectorSpace S₂.toVectorSpace).exists_add_inverse
  -- 乗法の結合法則
  mul_assoc p q r := calc
    ProductAlgebra.mul S₁ S₂ (ProductAlgebra.mul S₁ S₂ p q) r
        = ProductAlgebra.mul S₁ S₂ (S₁.mul p.1 q.1, S₂.mul p.2 q.2) r := rfl
    _ = (S₁.mul (S₁.mul p.1 q.1) r.1, S₂.mul (S₂.mul p.2 q.2) r.2) := rfl
    _ = (S₁.mul p.1 (S₁.mul q.1 r.1), S₂.mul p.2 (S₂.mul q.2 r.2)) := by
          rw [S₁.mul_assoc p.1 q.1 r.1, S₂.mul_assoc p.2 q.2 r.2]
    _ = ProductAlgebra.mul S₁ S₂ p (S₁.mul q.1 r.1, S₂.mul q.2 r.2) := rfl
    _ = ProductAlgebra.mul S₁ S₂ p (ProductAlgebra.mul S₁ S₂ q r) := rfl
  -- 乗法の単位元（右）
  mul_one p := calc
    ProductAlgebra.mul S₁ S₂ p (ProductAlgebra.one S₁ S₂)
        = ProductAlgebra.mul S₁ S₂ p (S₁.one, S₂.one) := rfl
    _ = (S₁.mul p.1 S₁.one, S₂.mul p.2 S₂.one) := rfl
    _ = (p.1, p.2) := by rw [S₁.mul_one p.1, S₂.mul_one p.2]
    _ = p := rfl
  -- 乗法の単位元（左）
  one_mul p := calc
    ProductAlgebra.mul S₁ S₂ (ProductAlgebra.one S₁ S₂) p
        = ProductAlgebra.mul S₁ S₂ (S₁.one, S₂.one) p := rfl
    _ = (S₁.mul S₁.one p.1, S₂.mul S₂.one p.2) := rfl
    _ = (p.1, p.2) := by rw [S₁.one_mul p.1, S₂.one_mul p.2]
    _ = p := rfl
  -- 分配法則（左）
  left_distrib p q r := calc
    ProductAlgebra.mul S₁ S₂ p (ProductAlgebra.add S₁ S₂ q r)
        = ProductAlgebra.mul S₁ S₂ p (S₁.add q.1 r.1, S₂.add q.2 r.2) := rfl
    _ = (S₁.mul p.1 (S₁.add q.1 r.1), S₂.mul p.2 (S₂.add q.2 r.2)) := rfl
    _ = (S₁.add (S₁.mul p.1 q.1) (S₁.mul p.1 r.1), S₂.add (S₂.mul p.2 q.2) (S₂.mul p.2 r.2)) := by
          rw [S₁.left_distrib p.1 q.1 r.1, S₂.left_distrib p.2 q.2 r.2]
    _ = ProductAlgebra.add S₁ S₂ (S₁.mul p.1 q.1, S₂.mul p.2 q.2) (S₁.mul p.1 r.1, S₂.mul p.2 r.2) := rfl
    _ = ProductAlgebra.add S₁ S₂ (ProductAlgebra.mul S₁ S₂ p q) (ProductAlgebra.mul S₁ S₂ p r) := rfl
  -- 分配法則（右）
  right_distrib p q r := calc
    ProductAlgebra.mul S₁ S₂ (ProductAlgebra.add S₁ S₂ p q) r
        = ProductAlgebra.mul S₁ S₂ (S₁.add p.1 q.1, S₂.add p.2 q.2) r := rfl
    _ = (S₁.mul (S₁.add p.1 q.1) r.1, S₂.mul (S₂.add p.2 q.2) r.2) := rfl
    _ = (S₁.add (S₁.mul p.1 r.1) (S₁.mul q.1 r.1), S₂.add (S₂.mul p.2 r.2) (S₂.mul q.2 r.2)) := by
          rw [S₁.right_distrib p.1 q.1 r.1, S₂.right_distrib p.2 q.2 r.2]
    _ = ProductAlgebra.add S₁ S₂ (S₁.mul p.1 r.1, S₂.mul p.2 r.2) (S₁.mul q.1 r.1, S₂.mul q.2 r.2) := rfl
    _ = ProductAlgebra.add S₁ S₂ (ProductAlgebra.mul S₁ S₂ p r) (ProductAlgebra.mul S₁ S₂ q r) := rfl
  -- 線型空間の条件のスカラー倍の四つ（直和の欄）
  smul := ProductAlgebra.smul S₁ S₂
  smul_assoc := (directSumVectorSpace S₁.toVectorSpace S₂.toVectorSpace).smul_assoc
  one_smul := (directSumVectorSpace S₁.toVectorSpace S₂.toVectorSpace).one_smul
  smul_add := (directSumVectorSpace S₁.toVectorSpace S₂.toVectorSpace).smul_add
  add_smul := (directSumVectorSpace S₁.toVectorSpace S₂.toVectorSpace).add_smul
  -- スカラー倍と乗法の両立（左の因子）
  smul_mul_left l p q := calc
    ProductAlgebra.smul S₁ S₂ l (ProductAlgebra.mul S₁ S₂ p q)
        = ProductAlgebra.smul S₁ S₂ l (S₁.mul p.1 q.1, S₂.mul p.2 q.2) := rfl
    _ = (S₁.smul l (S₁.mul p.1 q.1), S₂.smul l (S₂.mul p.2 q.2)) := rfl
    _ = (S₁.mul (S₁.smul l p.1) q.1, S₂.mul (S₂.smul l p.2) q.2) := by
          rw [S₁.smul_mul_left l p.1 q.1, S₂.smul_mul_left l p.2 q.2]
    _ = ProductAlgebra.mul S₁ S₂ (S₁.smul l p.1, S₂.smul l p.2) q := rfl
    _ = ProductAlgebra.mul S₁ S₂ (ProductAlgebra.smul S₁ S₂ l p) q := rfl
  -- スカラー倍と乗法の両立（右の因子）。初めの一行は、上の式変形の初めの二行を合わせたもの
  smul_mul_right l p q := calc
    ProductAlgebra.smul S₁ S₂ l (ProductAlgebra.mul S₁ S₂ p q)
        = (S₁.smul l (S₁.mul p.1 q.1), S₂.smul l (S₂.mul p.2 q.2)) := rfl
    _ = (S₁.mul p.1 (S₁.smul l q.1), S₂.mul p.2 (S₂.smul l q.2)) := by
          rw [S₁.smul_mul_right l p.1 q.1, S₂.smul_mul_right l p.2 q.2]
    _ = ProductAlgebra.mul S₁ S₂ p (S₁.smul l q.1, S₂.smul l q.2) := rfl
    _ = ProductAlgebra.mul S₁ S₂ p (ProductAlgebra.smul S₁ S₂ l q) := rfl

/-- 本文 `claim_product_of_two_complex_algebras_is_complex_algebra` の「線型空間の条件」：
組 (A₁ × A₂, +_{A₁×A₂}, ∗_{A₁×A₂}, 0_{A₁×A₂}) は U_vec(A₁) と U_vec(A₂) の直和そのものである。 -/
theorem productAlgebra_toVectorSpace (S₁ : AlgebraOver K A₁) (S₂ : AlgebraOver K A₂) :
    (productAlgebra S₁ S₂).toVectorSpace
      = directSumVectorSpace S₁.toVectorSpace S₂.toVectorSpace := rfl

/-- 本文 `def_pair_of_maps_into_product_of_algebras`：⟨φ₁, φ₂⟩(c) := (φ₁(c), φ₂(c))。 -/
def pairMap (φ₁ : C → A₁) (φ₂ : C → A₂) (c : C) : A₁ × A₂ := (φ₁ c, φ₂ c)

/-- 本文 `claim_pair_of_algebra_homomorphisms_is_algebra_homomorphism`：φ₁ : C → A₁ と φ₂ : C → A₂ が
K-代数の準同型なら、⟨φ₁, φ₂⟩ : C → A₁ × A₂ は K-代数の準同型である（必要十分版）。本文の四つの等式を順に示す。 -/
theorem pairMap_isHom {SC : AlgebraOver K C} {S₁ : AlgebraOver K A₁} {S₂ : AlgebraOver K A₂}
    {φ₁ : C → A₁} {φ₂ : C → A₂} (h₁ : IsAlgebraHomomorphism SC S₁ φ₁)
    (h₂ : IsAlgebraHomomorphism SC S₂ φ₂) :
    IsAlgebraHomomorphism SC (productAlgebra S₁ S₂) (pairMap φ₁ φ₂) := by
  have hadd : ∀ c c' : C, pairMap φ₁ φ₂ (SC.add c c')
      = ProductAlgebra.add S₁ S₂ (pairMap φ₁ φ₂ c) (pairMap φ₁ φ₂ c') := fun c c' => calc
    pairMap φ₁ φ₂ (SC.add c c') = (φ₁ (SC.add c c'), φ₂ (SC.add c c')) := rfl
    _ = (S₁.add (φ₁ c) (φ₁ c'), S₂.add (φ₂ c) (φ₂ c')) := by rw [h₁.map_add c c', h₂.map_add c c']
    _ = ProductAlgebra.add S₁ S₂ (φ₁ c, φ₂ c) (φ₁ c', φ₂ c') := rfl
    _ = ProductAlgebra.add S₁ S₂ (pairMap φ₁ φ₂ c) (pairMap φ₁ φ₂ c') := rfl
  have hmul : ∀ c c' : C, pairMap φ₁ φ₂ (SC.mul c c')
      = ProductAlgebra.mul S₁ S₂ (pairMap φ₁ φ₂ c) (pairMap φ₁ φ₂ c') := fun c c' => calc
    pairMap φ₁ φ₂ (SC.mul c c') = (φ₁ (SC.mul c c'), φ₂ (SC.mul c c')) := rfl
    _ = (S₁.mul (φ₁ c) (φ₁ c'), S₂.mul (φ₂ c) (φ₂ c')) := by rw [h₁.map_mul c c', h₂.map_mul c c']
    _ = ProductAlgebra.mul S₁ S₂ (φ₁ c, φ₂ c) (φ₁ c', φ₂ c') := rfl
    _ = ProductAlgebra.mul S₁ S₂ (pairMap φ₁ φ₂ c) (pairMap φ₁ φ₂ c') := rfl
  have hone : pairMap φ₁ φ₂ SC.one = ProductAlgebra.one S₁ S₂ := calc
    pairMap φ₁ φ₂ SC.one = (φ₁ SC.one, φ₂ SC.one) := rfl
    _ = (S₁.one, S₂.one) := by rw [h₁.map_one, h₂.map_one]
    _ = ProductAlgebra.one S₁ S₂ := rfl
  have hsmul : ∀ (l : K) (c : C), pairMap φ₁ φ₂ (SC.smul l c)
      = ProductAlgebra.smul S₁ S₂ l (pairMap φ₁ φ₂ c) := fun l c => calc
    pairMap φ₁ φ₂ (SC.smul l c) = (φ₁ (SC.smul l c), φ₂ (SC.smul l c)) := rfl
    _ = (S₁.smul l (φ₁ c), S₂.smul l (φ₂ c)) := by rw [h₁.map_smul l c, h₂.map_smul l c]
    _ = ProductAlgebra.smul S₁ S₂ l (φ₁ c, φ₂ c) := rfl
    _ = ProductAlgebra.smul S₁ S₂ l (pairMap φ₁ φ₂ c) := rfl
  exact ⟨⟨hadd, hmul, hone⟩, ⟨hadd, hsmul⟩⟩

/-- 本文 `claim_square_of_sum_with_multiple_of_anticommuting_square_root_of_unity`：X ·_A X = α ∗_A 1_A、
Y ·_A Y = 1_A、X ·_A Y +_A Y ·_A X = 0_A なら、すべての s ∈ K について
(X +_A s ∗_A Y) ·_A (X +_A s ∗_A Y) = (α + s·s) ∗_A 1_A（必要十分版）。 -/
theorem square_of_add_smul_of_anticommuting (SA : AlgebraOver K A) (X Y : A) [Zero K] (h00 : (0 : K) + 0 = 0) (hmul0 : ∀ a : K, a * 0 = 0) (α : K)
    (hX : SA.mul X X = SA.smul α SA.one) (hY : SA.mul Y Y = SA.one)
    (hXY : SA.add (SA.mul X Y) (SA.mul Y X) = SA.zero) (s : K) :
    SA.mul (SA.add X (SA.smul s Y)) (SA.add X (SA.smul s Y)) = SA.smul (α + s * s) SA.one := calc
  SA.mul (SA.add X (SA.smul s Y)) (SA.add X (SA.smul s Y))
      = SA.add (SA.mul X (SA.add X (SA.smul s Y))) (SA.mul (SA.smul s Y) (SA.add X (SA.smul s Y))) := by
        -- U_ring(A) の分配法則（右）
        rw [SA.right_distrib X (SA.smul s Y) (SA.add X (SA.smul s Y))]
  _ = SA.add (SA.add (SA.mul X X) (SA.mul X (SA.smul s Y)))
        (SA.add (SA.mul (SA.smul s Y) X) (SA.mul (SA.smul s Y) (SA.smul s Y))) := by
        -- U_ring(A) の分配法則（左）を二か所に
        rw [SA.left_distrib X X (SA.smul s Y), SA.left_distrib (SA.smul s Y) X (SA.smul s Y)]
  _ = SA.add (SA.add (SA.mul X X) (SA.smul s (SA.mul X Y)))
        (SA.add (SA.mul (SA.smul s Y) X) (SA.mul (SA.smul s Y) (SA.smul s Y))) := by
        -- スカラー倍と乗法の両立、右の因子
        rw [← SA.smul_mul_right s X Y]
  _ = SA.add (SA.add (SA.mul X X) (SA.smul s (SA.mul X Y)))
        (SA.add (SA.smul s (SA.mul Y X)) (SA.mul (SA.smul s Y) (SA.smul s Y))) := by
        -- スカラー倍と乗法の両立、左の因子
        rw [← SA.smul_mul_left s Y X]
  _ = SA.add (SA.add (SA.mul X X) (SA.smul s (SA.mul X Y)))
        (SA.add (SA.smul s (SA.mul Y X)) (SA.smul s (SA.mul Y (SA.smul s Y)))) := by
        -- スカラー倍と乗法の両立、左の因子
        rw [← SA.smul_mul_left s Y (SA.smul s Y)]
  _ = SA.add (SA.add (SA.mul X X) (SA.smul s (SA.mul X Y)))
        (SA.add (SA.smul s (SA.mul Y X)) (SA.smul s (SA.smul s (SA.mul Y Y)))) := by
        -- スカラー倍と乗法の両立、右の因子
        rw [← SA.smul_mul_right s Y Y]
  _ = SA.add (SA.add (SA.mul X X) (SA.smul s (SA.mul X Y)))
        (SA.add (SA.smul s (SA.mul Y X)) (SA.smul (s * s) (SA.mul Y Y))) := by
        -- U_vec(A) のスカラー倍の結合法則
        rw [← SA.smul_assoc s s (SA.mul Y Y)]
  _ = SA.add (SA.mul X X) (SA.add (SA.smul s (SA.mul X Y))
        (SA.add (SA.smul s (SA.mul Y X)) (SA.smul (s * s) (SA.mul Y Y)))) := by
        -- U_ring(A) の加法の結合法則
        rw [SA.add_assoc (SA.mul X X) (SA.smul s (SA.mul X Y))
          (SA.add (SA.smul s (SA.mul Y X)) (SA.smul (s * s) (SA.mul Y Y)))]
  _ = SA.add (SA.mul X X) (SA.add (SA.add (SA.smul s (SA.mul X Y)) (SA.smul s (SA.mul Y X)))
        (SA.smul (s * s) (SA.mul Y Y))) := by
        -- U_ring(A) の加法の結合法則
        rw [← SA.add_assoc (SA.smul s (SA.mul X Y)) (SA.smul s (SA.mul Y X)) (SA.smul (s * s) (SA.mul Y Y))]
  _ = SA.add (SA.mul X X) (SA.add (SA.smul s (SA.add (SA.mul X Y) (SA.mul Y X)))
        (SA.smul (s * s) (SA.mul Y Y))) := by
        -- U_vec(A) のベクトルの加法についての分配法則
        rw [← SA.smul_add s (SA.mul X Y) (SA.mul Y X)]
  _ = SA.add (SA.mul X X) (SA.add (SA.smul s SA.zero) (SA.smul (s * s) (SA.mul Y Y))) := by
        -- X ·_A Y +_A Y ·_A X = 0_A
        rw [hXY]
  _ = SA.add (SA.mul X X) (SA.add SA.zero (SA.smul (s * s) (SA.mul Y Y))) := by
        -- claim_scalar_multiple_of_zero_vector_is_zero_vector を U_vec(A) に当てる
        rw [show SA.smul s SA.zero = SA.zero from VectorSpace.smul_zero_eq_zero SA.toVectorSpace h00 hmul0 s]
  _ = SA.add (SA.mul X X) (SA.add (SA.smul (s * s) (SA.mul Y Y)) SA.zero) := by
        -- U_ring(A) の加法の交換法則
        rw [SA.add_comm SA.zero (SA.smul (s * s) (SA.mul Y Y))]
  _ = SA.add (SA.mul X X) (SA.smul (s * s) (SA.mul Y Y)) := by
        -- U_ring(A) の加法の単位元
        rw [SA.add_zero (SA.smul (s * s) (SA.mul Y Y))]
  _ = SA.add (SA.smul α SA.one) (SA.smul (s * s) (SA.mul Y Y)) := by
        -- X ·_A X = α ∗_A 1_A
        rw [hX]
  _ = SA.add (SA.smul α SA.one) (SA.smul (s * s) SA.one) := by
        -- Y ·_A Y = 1_A
        rw [hY]
  _ = SA.smul (α + s * s) SA.one := by
        -- U_vec(A) のスカラーの加法についての分配法則
        rw [SA.add_smul α (s * s) SA.one]

end CliffordMatrixIsomorphism.NecSuf.AlgebraOver
