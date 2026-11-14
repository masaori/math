/-
章「複素行列環」の、行列単位とその積の規則、成分を取り出す写像、単位行列と行列の行列単位による分解の必要十分版。
具体版 `ComplexMatrixAlgebra/MatrixUnits/MatrixUnits.lean` と同じ calc の行で、係数 ℂ を型の変数 K に替えて書く。

  本文のラベル                                                  このファイル                           使う K の性質
  def_matrix_unit                                               matrixUnit・entry_matrixUnit           なし（演算の記号だけ）
  claim_product_of_matrix_units                                 matrixUnit_mul_matrixUnit              L（乗法の結合法則・0 + 0 = 0）・
                                                                                                       0 と 1 がどの元とも交換すること
  claim_matrix_entry_map_is_linear_map                          entryMap・entryMap_isLinearMap         なし（L は二つの線型空間を作るためだけ）
  claim_decomposition_of_identity_matrix_into_matrix_units      sum_matrixUnit_diagonal_eq_one         L（1 · a = a・0 + 0 = 0）
  claim_matrix_is_double_sum_of_entries_times_matrix_units      eq_double_sum_entry_smul_matrixUnit    L（乗法の結合法則・1 · a = a・0 + 0 = 0）・
                                                                                                       0 と 1 がどの元とも交換すること

L : `ValuedMapsLaws K` は、行列の積 `Mat.mul L hX` と、和をとる二つの線型空間（K^vec の `coefficientsVec L` と
Mat_X(K) の `matricesVectorSpace L X`）を作るのに要る。0 + 0 = 0 は `L.add_zero 0` で、係数 δ の和が一項を取り出す主張と
線型写像が和を値の和へ移す主張の仮定に渡す。δ の左右の入れ替え（`MatrixUnits.kroneckerDelta_swap`）は K の性質を使わない。
δ の補題の二つ（`MatrixUnits.kroneckerDelta_swap`・`MatrixUnits.kroneckerDelta_mul_comm`）は、右の単位元の主張と共有するため
`MatrixAlgebra/Product.lean` に置く。

削れなかった仮定:
- 0 と 1 がどの元とも交換すること（`h0 : ∀ a, 0 * a = a * 0`、`h1 : ∀ a, 1 * a = a * 1`）: 具体版が ℂ の乗法の交換法則を
  当てる行は、積の規則の三行（δ_{x,p}·δ_{y,t} の入れ替え、δ_{z,t}·δ_{w,q} の入れ替え、(δ_{x,p}·δ_{w,q})·δ_{z,y} の入れ替え）も
  行列の分解の二行（(F_{x,y}·δ_{x,p})·δ_{y,q} の入れ替え、F_{x,q}·δ_{x,p} の入れ替え）も、どれも片方の因子が δ の値である。
  δ の値は 0 か 1 なので、乗法の交換法則全体ではなく、0 と 1 がどの元とも交換することだけで同じ行が書ける
  （`MatrixUnits.kroneckerDelta_mul_comm`。δ_{i,j}·a = a·δ_{i,j} を場合分けで示す）。
  したがって二つの主張は、係数の乗法が可換でない環でも成り立つ。0 · a = a · 0 は環の公理（両側の a · 0 = 0 = 0 · a）から、
  1 · a = a · 1 は 1 が両側の単位元であることから従うが、K に公理を置かない必要十分版では仮定として残る。
-/
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.MatrixAlgebra.VectorSpace
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.MatrixAlgebra.Product

namespace CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra

open CliffordMatrixIsomorphism.NecSuf.VectorSpace

universe u uK

variable {K : Type uK} {X : Type u}

open MatrixUnits

/-- 本文 `def_matrix_unit` の必要十分版：(E_{x,y})_{u,v} := δ_{x,u} ·_K δ_{y,v}。 -/
def matrixUnit [Mul K] [Zero K] [One K] [DecidableEq X] (x y : X) : Mat K X := fun p => kroneckerDelta x p.1 * kroneckerDelta y p.2

theorem entry_matrixUnit [Mul K] [Zero K] [One K] [DecidableEq X] (x y u v : X) :
    Mat.entry (matrixUnit x y : Mat K X) u v = kroneckerDelta x u * kroneckerDelta y v := rfl

variable [Add K] [Mul K] [One K] [Zero K]

/-- 本文 `claim_product_of_matrix_units` の必要十分版：E_{x,y} · E_{z,w} = δ_{y,z} ∗ E_{x,w}。 -/
theorem matrixUnit_mul_matrixUnit (L : ValuedMapsLaws K) (h0 : ∀ a : K, 0 * a = a * 0)
    (h1 : ∀ a : K, 1 * a = a * 1) (hX : IsFiniteSet X) [DecidableEq X] (x y z w : X) :
    Mat.mul L hX (matrixUnit x y) (matrixUnit z w)
      = Mat.smul (kroneckerDelta y z) (matrixUnit x w : Mat K X) :=
  Mat.ext fun p q => by
  let S := coefficientsVec L
  -- （準備）r_t := (δ_{x,p} ·_K δ_{w,q}) ·_K δ_{z,t}
  let r : X → K := fun t => (kroneckerDelta x p * kroneckerDelta w q) * kroneckerDelta z t
  -- （準備）(δ_{x,p} ·_K δ_{y,t}) ·_{K^vec} (δ_{z,t} ·_K δ_{w,q}) = δ_{y,t} ·_{K^vec} r_t
  have hprep : ∀ t : X,
      S.smul ((kroneckerDelta x p : K) * kroneckerDelta y t) ((kroneckerDelta z t : K) * kroneckerDelta w q)
        = S.smul (kroneckerDelta y t) (r t) := fun t => calc
    S.smul ((kroneckerDelta x p : K) * kroneckerDelta y t) ((kroneckerDelta z t : K) * kroneckerDelta w q)
        = ((kroneckerDelta x p : K) * kroneckerDelta y t) * ((kroneckerDelta z t : K) * kroneckerDelta w q) := rfl
    _ = ((kroneckerDelta y t : K) * kroneckerDelta x p) * ((kroneckerDelta z t : K) * kroneckerDelta w q) := by
        rw [kroneckerDelta_mul_comm h0 h1 x p (kroneckerDelta y t : K)]
    _ = (kroneckerDelta y t : K) * ((kroneckerDelta x p : K) * ((kroneckerDelta z t : K) * kroneckerDelta w q)) := by
        rw [L.mul_assoc (kroneckerDelta y t) (kroneckerDelta x p)
          ((kroneckerDelta z t : K) * kroneckerDelta w q)]
    _ = (kroneckerDelta y t : K) * ((kroneckerDelta x p : K) * ((kroneckerDelta w q : K) * kroneckerDelta z t)) := by
        rw [kroneckerDelta_mul_comm h0 h1 z t (kroneckerDelta w q : K)]
    _ = (kroneckerDelta y t : K) * (((kroneckerDelta x p : K) * kroneckerDelta w q) * kroneckerDelta z t) := by
        rw [L.mul_assoc (kroneckerDelta x p) (kroneckerDelta w q) (kroneckerDelta z t)]
    _ = (kroneckerDelta y t : K) * r t := rfl
    _ = S.smul (kroneckerDelta y t) (r t) := rfl
  calc Mat.entry (Mat.mul L hX (matrixUnit x y) (matrixUnit z w)) p q
      = sumOverFiniteSet S hX (fun t => Mat.entry (matrixUnit x y : Mat K X) p t)
          (fun t => Mat.entry (matrixUnit z w : Mat K X) t q) := rfl
    _ = sumOverFiniteSet S hX (fun t => (kroneckerDelta x p : K) * kroneckerDelta y t)
          (fun t => (kroneckerDelta z t : K) * kroneckerDelta w q) :=
        sumOverFiniteSet_congr S hX _ _ _ _ (fun _ => rfl)
    _ = sumOverFiniteSet S hX (fun t => (kroneckerDelta y t : K)) (fun t => r t) :=
        sumOverFiniteSet_congr S hX _ _ _ _ hprep
    _ = r y := sumOverFiniteSet_kroneckerDelta S (L.add_zero 0) hX (fun t => r t) y
    _ = ((kroneckerDelta x p : K) * kroneckerDelta w q) * kroneckerDelta z y := rfl
    _ = (kroneckerDelta z y : K) * ((kroneckerDelta x p : K) * kroneckerDelta w q) := by
        rw [kroneckerDelta_mul_comm h0 h1 z y ((kroneckerDelta x p : K) * kroneckerDelta w q)]
    _ = (kroneckerDelta y z : K) * ((kroneckerDelta x p : K) * kroneckerDelta w q) := by
        rw [kroneckerDelta_swap z y]
    _ = (kroneckerDelta y z : K) * Mat.entry (matrixUnit x w : Mat K X) p q := rfl
    _ = Mat.entry (Mat.smul (kroneckerDelta y z) (matrixUnit x w : Mat K X)) p q := rfl

/-- 本文 `claim_matrix_entry_map_is_linear_map` の ent_{p,q} の必要十分版：ent_{p,q}(A) := A_{p,q}。 -/
def entryMap (p q : X) : Mat K X → K := fun A => Mat.entry A p q

/-- 本文 `claim_matrix_entry_map_is_linear_map` の必要十分版：ent_{p,q} は Mat_X(K) から K^vec への線型写像である。 -/
theorem entryMap_isLinearMap (L : ValuedMapsLaws K) (X : Type u) (p q : X) :
    IsLinearMap (matricesVectorSpace L X) (coefficientsVec L) (entryMap p q) where
  map_add A B := calc
    entryMap p q ((matricesVectorSpace L X).add A B) = Mat.entry (Mat.add A B) p q := rfl
    _ = Mat.entry A p q + Mat.entry B p q := rfl
    _ = (coefficientsVec L).add (Mat.entry A p q) (Mat.entry B p q) := rfl
    _ = (coefficientsVec L).add (entryMap p q A) (entryMap p q B) := rfl
  map_smul l A := calc
    entryMap p q ((matricesVectorSpace L X).smul l A) = Mat.entry (Mat.smul l A) p q := rfl
    _ = l * Mat.entry A p q := rfl
    _ = (coefficientsVec L).smul l (Mat.entry A p q) := rfl
    _ = (coefficientsVec L).smul l (entryMap p q A) := rfl

/-- 本文 `claim_decomposition_of_identity_matrix_into_matrix_units` の必要十分版：Σ_{x∈X} 1 ∗ E_{x,x} = 1。 -/
theorem sum_matrixUnit_diagonal_eq_one (L : ValuedMapsLaws K) (hX : IsFiniteSet X) [DecidableEq X] :
    sumOverFiniteSet (matricesVectorSpace L X) hX (fun _ => 1) (fun x => matrixUnit x x) = Mat.one :=
  Mat.ext fun p q => by
  let S := coefficientsVec L
  -- （準備）1 ·_{K^vec} ent_{p,q}(E_{x,x}) = δ_{p,x} ·_{K^vec} δ_{q,x}
  have hprep : ∀ x : X, S.smul 1 (entryMap p q (matrixUnit x x : Mat K X))
      = S.smul (kroneckerDelta p x) (kroneckerDelta q x) := fun x => calc
    S.smul 1 (entryMap p q (matrixUnit x x : Mat K X))
        = S.smul 1 (Mat.entry (matrixUnit x x : Mat K X) p q) := rfl
    _ = S.smul 1 ((kroneckerDelta x p : K) * kroneckerDelta x q) := rfl
    _ = 1 * ((kroneckerDelta x p : K) * kroneckerDelta x q) := rfl
    _ = (kroneckerDelta x p : K) * kroneckerDelta x q := by
        rw [L.one_mul ((kroneckerDelta x p : K) * kroneckerDelta x q)]
    _ = (kroneckerDelta p x : K) * kroneckerDelta q x := by
        rw [kroneckerDelta_swap x p, kroneckerDelta_swap x q]
    _ = S.smul (kroneckerDelta p x) (kroneckerDelta q x) := rfl
  calc Mat.entry (sumOverFiniteSet (matricesVectorSpace L X) hX (fun _ => 1) (fun x => matrixUnit x x)) p q
      = entryMap p q
          (sumOverFiniteSet (matricesVectorSpace L X) hX (fun _ => 1) (fun x => matrixUnit x x)) := rfl
    _ = sumOverFiniteSet S hX (fun _ => 1) (fun x => entryMap p q (matrixUnit x x : Mat K X)) :=
        (entryMap_isLinearMap L X p q).map_sumOverFiniteSet (L.add_zero 0) hX _ _
    _ = sumOverFiniteSet S hX (fun x => (kroneckerDelta p x : K)) (fun x => (kroneckerDelta q x : K)) :=
        sumOverFiniteSet_congr S hX _ _ _ _ hprep
    _ = kroneckerDelta q p :=
        sumOverFiniteSet_kroneckerDelta S (L.add_zero 0) hX (fun x => (kroneckerDelta q x : K)) p
    _ = kroneckerDelta p q := kroneckerDelta_swap q p
    _ = Mat.entry (Mat.one : Mat K X) p q := rfl

/-- 本文 `claim_matrix_is_double_sum_of_entries_times_matrix_units` の必要十分版：
F = Σ_{x∈X} 1 ∗ (Σ_{y∈X} F_{x,y} ∗ E_{x,y})。 -/
theorem eq_double_sum_entry_smul_matrixUnit (L : ValuedMapsLaws K) (h0 : ∀ a : K, 0 * a = a * 0)
    (h1 : ∀ a : K, 1 * a = a * 1) (hX : IsFiniteSet X) [DecidableEq X] (F : Mat K X) :
    F = sumOverFiniteSet (matricesVectorSpace L X) hX (fun _ => 1)
      (fun x => sumOverFiniteSet (matricesVectorSpace L X) hX (fun y => Mat.entry F x y)
        (fun y => matrixUnit x y)) :=
  Mat.ext fun p q => by
  let S := coefficientsVec L
  -- （準備の一つ目）F_{x,y} ·_{K^vec} ent_{p,q}(E_{x,y}) = δ_{q,y} ·_{K^vec} (F_{x,y} ·_K δ_{x,p})
  have hprep1 : ∀ x y : X, S.smul (Mat.entry F x y) (entryMap p q (matrixUnit x y : Mat K X))
      = S.smul (kroneckerDelta q y) (Mat.entry F x y * kroneckerDelta x p) := fun x y => calc
    S.smul (Mat.entry F x y) (entryMap p q (matrixUnit x y : Mat K X))
        = S.smul (Mat.entry F x y) (Mat.entry (matrixUnit x y : Mat K X) p q) := rfl
    _ = S.smul (Mat.entry F x y) ((kroneckerDelta x p : K) * kroneckerDelta y q) := rfl
    _ = Mat.entry F x y * ((kroneckerDelta x p : K) * kroneckerDelta y q) := rfl
    _ = (Mat.entry F x y * kroneckerDelta x p) * kroneckerDelta y q := by
        rw [L.mul_assoc (Mat.entry F x y) (kroneckerDelta x p) (kroneckerDelta y q)]
    _ = (kroneckerDelta y q : K) * (Mat.entry F x y * kroneckerDelta x p) := by
        rw [kroneckerDelta_mul_comm h0 h1 y q (Mat.entry F x y * kroneckerDelta x p)]
    _ = (kroneckerDelta q y : K) * (Mat.entry F x y * kroneckerDelta x p) := by
        rw [kroneckerDelta_swap y q]
    _ = S.smul (kroneckerDelta q y) (Mat.entry F x y * kroneckerDelta x p) := rfl
  -- （準備の二つ目）Σ_{y∈X} δ_{q,y} ·_{K^vec} (F_{x,y} ·_K δ_{x,p}) = F_{x,q} ·_K δ_{x,p}
  have hprep2 : ∀ x : X,
      sumOverFiniteSet S hX (fun y => (kroneckerDelta q y : K)) (fun y => Mat.entry F x y * kroneckerDelta x p)
        = Mat.entry F x q * kroneckerDelta x p := fun x =>
    sumOverFiniteSet_kroneckerDelta S (L.add_zero 0) hX (fun y => Mat.entry F x y * kroneckerDelta x p) q
  -- （準備の三つ目）1 ·_{K^vec} (F_{x,q} ·_K δ_{x,p}) = δ_{p,x} ·_{K^vec} F_{x,q}
  have hprep3 : ∀ x : X, S.smul 1 (Mat.entry F x q * kroneckerDelta x p)
      = S.smul (kroneckerDelta p x) (Mat.entry F x q) := fun x => calc
    S.smul 1 (Mat.entry F x q * kroneckerDelta x p) = 1 * (Mat.entry F x q * kroneckerDelta x p) := rfl
    _ = Mat.entry F x q * kroneckerDelta x p := by
        rw [L.one_mul (Mat.entry F x q * kroneckerDelta x p)]
    _ = (kroneckerDelta x p : K) * Mat.entry F x q := by
        rw [kroneckerDelta_mul_comm h0 h1 x p (Mat.entry F x q)]
    _ = (kroneckerDelta p x : K) * Mat.entry F x q := by rw [kroneckerDelta_swap x p]
    _ = S.smul (kroneckerDelta p x) (Mat.entry F x q) := rfl
  calc Mat.entry F p q
      = sumOverFiniteSet S hX (fun x => (kroneckerDelta p x : K)) (fun x => Mat.entry F x q) :=
        (sumOverFiniteSet_kroneckerDelta S (L.add_zero 0) hX (fun x => Mat.entry F x q) p).symm
    _ = sumOverFiniteSet S hX (fun _ => 1) (fun x => Mat.entry F x q * kroneckerDelta x p) :=
        sumOverFiniteSet_congr S hX _ _ _ _ (fun x => (hprep3 x).symm)
    _ = sumOverFiniteSet S hX (fun _ => 1)
          (fun x => sumOverFiniteSet S hX (fun y => (kroneckerDelta q y : K))
            (fun y => Mat.entry F x y * kroneckerDelta x p)) :=
        sumOverFiniteSet_congr S hX _ _ _ _ (fun x => by rw [hprep2 x])
    _ = sumOverFiniteSet S hX (fun _ => 1)
          (fun x => sumOverFiniteSet S hX (fun y => Mat.entry F x y)
            (fun y => entryMap p q (matrixUnit x y : Mat K X))) :=
        sumOverFiniteSet_double_congr S hX hX _ _ _ _ (fun x y => (hprep1 x y).symm)
    _ = entryMap p q
          (sumOverFiniteSet (matricesVectorSpace L X) hX (fun _ => 1)
            (fun x => sumOverFiniteSet (matricesVectorSpace L X) hX (fun y => Mat.entry F x y)
              (fun y => matrixUnit x y))) :=
        ((entryMap_isLinearMap L X p q).map_double_sumOverFiniteSet (L.add_zero 0) hX hX
          (fun x y => Mat.entry F x y) (fun x y => matrixUnit x y)).symm
    _ = Mat.entry
          (sumOverFiniteSet (matricesVectorSpace L X) hX (fun _ => 1)
            (fun x => sumOverFiniteSet (matricesVectorSpace L X) hX (fun y => Mat.entry F x y)
              (fun y => matrixUnit x y))) p q := rfl

end CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra
