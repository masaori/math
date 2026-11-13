/-
節「テンソル積」のうち、基底の座標による k 重テンソル積の構成と、それが k 重テンソル積であることの必要十分版。
具体版 `MathematicalToolkit/TensorProduct/CoordinateConstruction.lean` と同じ定義と calc の行で、係数 ℂ を型の変数 K に替えて書く。

各主張が実際に使う K の性質（`ValuedMapsLaws` は T := K^X を線型空間にする八つ、`UniquenessLaws` は係数の一意性の仮定の組）:

  coordinateTensor_isMultilinear            `ValuedMapsLaws`（T の演算、番号順の積の分配法則と乗法の結合法則）・
                                            `UniquenessLaws`（座標の写像が線型形式であること）・乗法の交換法則
  coordinateTensor_basisTuple               `UniquenessLaws`（双対基底であること、1 · 1 = 1、a · 0 = 0、0 · a = 0）
  evaluationAt_isLinearMap                  `ValuedMapsLaws`（T と K^vec を線型空間にするため。行では使わない）
  eq_sum_coordinateTensor_basisTuple        `ValuedMapsLaws`・`UniquenessLaws`（0 + 0 = 0 と双対基底）・乗法の交換法則
  inducedLinearMap_isLinearMap              `ValuedMapsLaws`（T）・0 + 0 = 0・a · 0 = 0（和のスカラー倍）
  multilinear_eq_of_basisTuple              0 + 0 = 0（線型写像が線型結合を移すこと）
  inducedLinearMap_comp_coordinateTensor・coordinateTensor_isTensorProduct
                                            上のすべて

乗法の交換法則が要るのは二か所である。τ が各成分のスカラー倍を保つこと（番号順の積で λ を前の部分の積 P_{r-1} の前へ
出す行）と、F(x) ·_K δ_{x,y} = δ_{y,x} ·_K F(x) の行である。前者は、係数が可換でなければ τ がスカラー倍を保たないことを示す。
具体版と同じ手順では係数の交換法則を外せない（本文の構成は可換な係数の上でだけ k 重テンソル積を与える）。
-/
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.TensorProduct.MultilinearMap
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorProduct.BaseNNumbering
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.TensorProduct.ComplexValuedMaps
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.TensorProduct.OrderedProduct
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.FiniteSetSum.SumOverFiniteSet
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.ComplexVectorSpace.ComplexNumbersAsVectorSpace

namespace CliffordMatrixIsomorphism.NecSuf.VectorSpace

universe u v w uK

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K] {V : Type u} {U : Type v}

/-- X_{n,k} の等号の判定（クロネッカーのデルタ δ_{x,y} に使う）。 -/
noncomputable instance decEqMapsBetweenInitialSegments (n k : ℕ) :
    DecidableEq (MapsBetweenInitialSegments n k) :=
  Classical.decEq _

/-- 本文 `def_construction_of_k_fold_tensor_product` の T := ℂ^X（X := X_{n,k}）と、その各点ごとの演算。 -/
abbrev coordinateTensorSpace (L : ValuedMapsLaws K) (n k : ℕ) :
    VectorSpace K (MapsBetweenInitialSegments n k → K) :=
  complexValuedMapsVectorSpace L (MapsBetweenInitialSegments n k)

/-- K を自分自身の上の線型空間にしたもの（具体版の ℂ^vec）。 -/
abbrev coefficientsVec (L : ValuedMapsLaws K) : VectorSpace K K :=
  coefficientsVectorSpace L.add_assoc L.add_comm L.add_zero L.exists_neg L.mul_assoc L.one_mul
    L.left_distrib L.right_distrib

/-- 本文 `def_construction_of_k_fold_tensor_product` の番号順の積の因子：r ∈ {1,…,k} に β^b_{x(r)}(v(r)) を与える族
（{1,…,k} の外の値 1_ℂ は使わない）。 -/
noncomputable def coordinateFactors (S : VectorSpace K V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily S n b) {k : ℕ} (v : Tuple V k) (x : MapsBetweenInitialSegments n k) :
    ℕ → K :=
  extendFamily (fun r : Idx k => coordinate S n b hb (x r).1 (v r)) 1

theorem coordinateFactors_of_le (S : VectorSpace K V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily S n b) {k : ℕ} (v : Tuple V k) (x : MapsBetweenInitialSegments n k)
    (s : ℕ) (h1 : 1 ≤ s) (h2 : s ≤ k) :
    coordinateFactors S n b hb v x s = coordinate S n b hb (x ⟨s, h1, h2⟩).1 (v ⟨s, h1, h2⟩) :=
  extendFamily_of_le _ 1 s h1 h2

/-- 本文 `def_construction_of_k_fold_tensor_product`：τ(v)(x) := Π_{ℂ,r=1}^{k} β^b_{x(r)}(v(r))。 -/
noncomputable def coordinateTensor (S : VectorSpace K V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily S n b) (k : ℕ) (v : Tuple V k) : MapsBetweenInitialSegments n k → K :=
  fun x => orderedProduct k (coordinateFactors S n b hb v x)

/-- 置き換える成分 r と違う番号 s では、置き換えた組の因子は置き換える値によらない
（四つの組の第 s 成分はどれも v(s)。本文 `def_tuple_with_one_component_replaced`）。 -/
theorem coordinateFactors_replaceComponent_of_ne (S : VectorSpace K V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily S n b) {k : ℕ} (v : Tuple V k) (r : Idx k) (y y' : V)
    (x : MapsBetweenInitialSegments n k) (s : ℕ) (h1 : 1 ≤ s) (h2 : s ≤ k) (hs : s ≠ r.1) :
    coordinateFactors S n b hb (replaceComponent v r y) x s
      = coordinateFactors S n b hb (replaceComponent v r y') x s := by
  have hne : (⟨s, h1, h2⟩ : Idx k) ≠ r := fun h => hs (congrArg Subtype.val h)
  rw [coordinateFactors_of_le S n b hb _ x s h1 h2, coordinateFactors_of_le S n b hb _ x s h1 h2,
    replaceComponent_of_ne v r y _ hne, replaceComponent_of_ne v r y' _ hne]

/-- 置き換える成分 r では、因子は置き換えた値の座標 β^b_{x(r)}(y) である。 -/
theorem coordinateFactors_replaceComponent_self (S : VectorSpace K V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily S n b) {k : ℕ} (v : Tuple V k) (r : Idx k) (y : V)
    (x : MapsBetweenInitialSegments n k) :
    coordinateFactors S n b hb (replaceComponent v r y) x r.1 = coordinate S n b hb (x r).1 y := by
  rw [coordinateFactors_of_le S n b hb _ x r.1 r.2.1 r.2.2]
  exact congrArg (coordinate S n b hb (x r).1) (replaceComponent_self v r y)

/-- 本文 `claim_coordinate_product_map_is_k_multilinear`：τ は V から T への k 重線型写像である。 -/
theorem coordinateTensor_isMultilinear (L : ValuedMapsLaws K) (UL : UniquenessLaws K) (hcomm : ∀ a b : K, a * b = b * a)
    (S : VectorSpace K V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily S n b) (k : ℕ) :
    IsMultilinearMap S (coordinateTensorSpace L n k) k (coordinateTensor S n b hb k) where
  map_add v r y z := funext fun x => by
    -- α_s、α'_s、α''_s は v[r ↦ y +_V z]、v[r ↦ y]、v[r ↦ z] の因子。s ≠ r では等しい
    have hne : ∀ s : ℕ, 1 ≤ s → s ≤ k → s ≠ r.1 →
        coordinateFactors S n b hb (replaceComponent v r (S.add y z)) x s
            = coordinateFactors S n b hb (replaceComponent v r y) x s ∧
          coordinateFactors S n b hb (replaceComponent v r (S.add y z)) x s
            = coordinateFactors S n b hb (replaceComponent v r z) x s :=
      fun s h1 h2 hs => ⟨coordinateFactors_replaceComponent_of_ne S n b hb v r _ _ x s h1 h2 hs,
        coordinateFactors_replaceComponent_of_ne S n b hb v r _ _ x s h1 h2 hs⟩
    -- α_r = α'_r +_ℂ α''_r
    have hr : coordinateFactors S n b hb (replaceComponent v r (S.add y z)) x r.1
        = coordinateFactors S n b hb (replaceComponent v r y) x r.1
          + coordinateFactors S n b hb (replaceComponent v r z) x r.1 := calc
      coordinateFactors S n b hb (replaceComponent v r (S.add y z)) x r.1
          = coordinate S n b hb (x r).1 (S.add y z) :=
            coordinateFactors_replaceComponent_self S n b hb v r _ x
      _ = coordinate S n b hb (x r).1 y + coordinate S n b hb (x r).1 z :=
            (coordinate_isLinearForm S UL n b hb (x r).1 (x r).2.1 (x r).2.2).map_add y z
      _ = coordinateFactors S n b hb (replaceComponent v r y) x r.1
          + coordinateFactors S n b hb (replaceComponent v r z) x r.1 := by
            rw [coordinateFactors_replaceComponent_self S n b hb v r y x,
              coordinateFactors_replaceComponent_self S n b hb v r z x]
    calc coordinateTensor S n b hb k (replaceComponent v r (S.add y z)) x
        = orderedProduct k (coordinateFactors S n b hb (replaceComponent v r (S.add y z)) x) := rfl
      _ = orderedProduct k (coordinateFactors S n b hb (replaceComponent v r y) x)
          + orderedProduct k (coordinateFactors S n b hb (replaceComponent v r z) x) :=
            orderedProduct_add_in_one_factor L.left_distrib L.right_distrib k r.1 r.2.1 r.2.2 _ _ _ hne hr
      _ = coordinateTensor S n b hb k (replaceComponent v r y) x
          + coordinateTensor S n b hb k (replaceComponent v r z) x := rfl
      _ = (coordinateTensorSpace L n k).add (coordinateTensor S n b hb k (replaceComponent v r y))
            (coordinateTensor S n b hb k (replaceComponent v r z)) x := rfl
  map_smul v r l y := funext fun x => by
    -- γ_s と α'_s は v[r ↦ λ ·_V y]、v[r ↦ y] の因子。s ≠ r では等しい
    have hne : ∀ s : ℕ, 1 ≤ s → s ≤ k → s ≠ r.1 →
        coordinateFactors S n b hb (replaceComponent v r (S.smul l y)) x s
          = coordinateFactors S n b hb (replaceComponent v r y) x s :=
      fun s h1 h2 hs => coordinateFactors_replaceComponent_of_ne S n b hb v r _ _ x s h1 h2 hs
    -- γ_r = λ ·_ℂ α'_r
    have hr : coordinateFactors S n b hb (replaceComponent v r (S.smul l y)) x r.1
        = l * coordinateFactors S n b hb (replaceComponent v r y) x r.1 := calc
      coordinateFactors S n b hb (replaceComponent v r (S.smul l y)) x r.1
          = coordinate S n b hb (x r).1 (S.smul l y) :=
            coordinateFactors_replaceComponent_self S n b hb v r _ x
      _ = l * coordinate S n b hb (x r).1 y :=
            (coordinate_isLinearForm S UL n b hb (x r).1 (x r).2.1 (x r).2.2).map_smul l y
      _ = l * coordinateFactors S n b hb (replaceComponent v r y) x r.1 := by
            rw [coordinateFactors_replaceComponent_self S n b hb v r y x]
    calc coordinateTensor S n b hb k (replaceComponent v r (S.smul l y)) x
        = orderedProduct k (coordinateFactors S n b hb (replaceComponent v r (S.smul l y)) x) := rfl
      _ = l * orderedProduct k (coordinateFactors S n b hb (replaceComponent v r y) x) :=
            orderedProduct_smul_in_one_factor L.mul_assoc k r.1 r.2.1 r.2.2 l (fun a => hcomm a l) _ _ hne hr
      _ = l * coordinateTensor S n b hb k (replaceComponent v r y) x := rfl
      _ = (coordinateTensorSpace L n k).smul l (coordinateTensor S n b hb k (replaceComponent v r y)) x :=
            rfl

/-- 本文 `claim_coordinate_product_map_at_basis_tuples_is_kronecker_delta` の b ∘ x：(b ∘ x)(r) := b_{x(r)}。 -/
def basisTuple (b : ℕ → V) {n k : ℕ} (x : MapsBetweenInitialSegments n k) : Tuple V k :=
  fun r => b (x r).1

/-- 本文 `claim_coordinate_product_map_at_basis_tuples_is_kronecker_delta` の帰納法の主張：
すべての s ∈ {1,…,m} で y(s) = x(s) なら P_m = 1_ℂ、そうでなければ P_m = 0_ℂ（m ≤ k）。 -/
theorem partialOrderedProduct_coordinateFactors_basisTuple (UL : UniquenessLaws K)
    (S : VectorSpace K V) (n : ℕ)
    (b : ℕ → V) (hb : IsBasisFamily S n b) {k : ℕ} (x y : MapsBetweenInitialSegments n k) :
    ∀ m : ℕ, m ≤ k →
      ((∀ s : Idx k, s.1 ≤ m → y s = x s) →
          partialOrderedProduct (coordinateFactors S n b hb (basisTuple b x) y) m = 1) ∧
        (¬ (∀ s : Idx k, s.1 ≤ m → y s = x s) →
          partialOrderedProduct (coordinateFactors S n b hb (basisTuple b x) y) m = 0)
  | 0, _ =>
    -- m = 0 のとき条件は空に成り立ち、P_0 = 1_ℂ
    ⟨fun _ => rfl, fun h => absurd (fun s hs => absurd (le_trans s.2.1 hs) (by omega)) h⟩
  | m + 1, hm => by
    have ih := partialOrderedProduct_coordinateFactors_basisTuple UL S n b hb x y m (by omega)
    -- α_{m} = β^b_{y(m)}(b_{x(m)}) = δ_{y(m),x(m)}
    set t : Idx k := ⟨m + 1, Nat.succ_pos m, hm⟩ with ht
    have hα : coordinateFactors S n b hb (basisTuple b x) y (m + 1)
        = (kroneckerDelta (y t).1 (x t).1 : K) := calc
      coordinateFactors S n b hb (basisTuple b x) y (m + 1)
          = coordinate S n b hb (y t).1 (basisTuple b x t) :=
            coordinateFactors_of_le S n b hb _ y (m + 1) (Nat.succ_pos m) hm
      _ = coordinate S n b hb (y t).1 (b (x t).1) := rfl
      _ = (coordinateFamily UL S n b hb (y t).1).1 (b (x t).1) := by
            rw [coordinateFamily, dif_pos (y t).2]
      _ = (kroneckerDelta (y t).1 (x t).1 : K) :=
            coordinateFamily_isDualBasis UL S n b hb (y t).1 (x t).1 (y t).2.1 (y t).2.2 (x t).2.1
              (x t).2.2
    -- P_m = P_{m-1} ·_ℂ δ_{y(m),x(m)}
    have hP : partialOrderedProduct (coordinateFactors S n b hb (basisTuple b x) y) (m + 1)
        = partialOrderedProduct (coordinateFactors S n b hb (basisTuple b x) y) m
          * (kroneckerDelta (y t).1 (x t).1 : K) := by
      show partialOrderedProduct _ m * coordinateFactors S n b hb (basisTuple b x) y (m + 1) = _
      rw [hα]
    constructor
    · -- すべての s ∈ {1,…,m} で y(s) = x(s) のとき：P_{m-1} = 1_ℂ、δ_{y(m),x(m)} = 1_ℂ
      intro hall
      have h1 := ih.1 (fun s hs => hall s (by omega))
      have hδ : (kroneckerDelta (y t).1 (x t).1 : K) = 1 := by
        rw [kroneckerDelta, if_pos (congrArg Subtype.val (hall t (le_refl _)))]
      calc partialOrderedProduct (coordinateFactors S n b hb (basisTuple b x) y) (m + 1)
          = partialOrderedProduct (coordinateFactors S n b hb (basisTuple b x) y) m
            * (kroneckerDelta (y t).1 (x t).1 : K) := hP
        _ = 1 * 1 := by rw [h1, hδ]
        _ = 1 := UL.one_mul 1
    · intro hnot
      by_cases hprev : ∀ s : Idx k, s.1 ≤ m → y s = x s
      · -- すべての s ∈ {1,…,m-1} で y(s) = x(s) で、y(m) ≠ x(m) のとき：δ_{y(m),x(m)} = 0_ℂ
        have hlast : y t ≠ x t := by
          intro heq
          apply hnot
          intro s hs
          rcases Nat.lt_or_ge s.1 (m + 1) with hlt | hge
          · exact hprev s (by omega)
          · have : s = t := Subtype.ext (by show s.1 = m + 1; omega)
            rw [this]; exact heq
        have hδ : (kroneckerDelta (y t).1 (x t).1 : K) = 0 := by
          rw [kroneckerDelta, if_neg (fun h => hlast (Subtype.ext h))]
        calc partialOrderedProduct (coordinateFactors S n b hb (basisTuple b x) y) (m + 1)
            = partialOrderedProduct (coordinateFactors S n b hb (basisTuple b x) y) m
              * (kroneckerDelta (y t).1 (x t).1 : K) := hP
          _ = partialOrderedProduct (coordinateFactors S n b hb (basisTuple b x) y) m * 0 := by
              rw [hδ]
          _ = 0 := UL.mul_zero _
      · -- y(s) ≠ x(s) となる s ∈ {1,…,m-1} があるとき：P_{m-1} = 0_ℂ
        have h0 := ih.2 hprev
        calc partialOrderedProduct (coordinateFactors S n b hb (basisTuple b x) y) (m + 1)
            = partialOrderedProduct (coordinateFactors S n b hb (basisTuple b x) y) m
              * (kroneckerDelta (y t).1 (x t).1 : K) := hP
          _ = 0 * (kroneckerDelta (y t).1 (x t).1 : K) := by rw [h0]
          _ = 0 := UL.zero_mul _

/-- 本文 `claim_coordinate_product_map_at_basis_tuples_is_kronecker_delta`：τ(b ∘ x)(y) = δ_{x,y}。
k = 0 の場合も帰納法の主張の m = 0 の段に含まれる（X の元はただ一つで、空の積は 1_ℂ）。 -/
theorem coordinateTensor_basisTuple (UL : UniquenessLaws K) (S : VectorSpace K V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily S n b) (k : ℕ) (x y : MapsBetweenInitialSegments n k) :
    coordinateTensor S n b hb k (basisTuple b x) y = (kroneckerDelta x y : K) := by
  have h := partialOrderedProduct_coordinateFactors_basisTuple UL S n b hb x y k (le_refl k)
  by_cases hxy : x = y
  · -- x = y なら P_k = 1_ℂ = δ_{x,y}
    rw [kroneckerDelta, if_pos hxy]
    exact h.1 (fun s _ => by rw [hxy])
  · -- x ≠ y なら P_k = 0_ℂ = δ_{x,y}
    rw [kroneckerDelta, if_neg hxy]
    exact h.2 (fun hall => hxy (MapsBetweenInitialSegments.ext (fun s => (hall s s.2.2).symm)))

/-- 本文 `claim_coordinate_tensor_space_element_is_sum_of_basis_tensors` の ev_y：T から ℂ^vec への線型写像。 -/
theorem evaluationAt_isLinearMap (L : ValuedMapsLaws K) (n k : ℕ) (y : MapsBetweenInitialSegments n k) :
    IsLinearMap (coordinateTensorSpace L n k) (coefficientsVec L) (fun G => G y) where
  map_add G G' := calc
    (coordinateTensorSpace L n k).add G G' y = G y + G' y := rfl
    _ = (coefficientsVec L).add (G y) (G' y) := rfl
  map_smul l G := calc
    (coordinateTensorSpace L n k).smul l G y = l * G y := rfl
    _ = (coefficientsVec L).smul l (G y) := rfl

/-- 本文 `claim_coordinate_tensor_space_element_is_sum_of_basis_tensors`：F = Σ_{x∈X} F(x) ·_T τ(b ∘ x)。 -/
theorem eq_sum_coordinateTensor_basisTuple (L : ValuedMapsLaws K) (UL : UniquenessLaws K) (hcomm : ∀ a b : K, a * b = b * a)
    (S : VectorSpace K V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily S n b) (k : ℕ) (F : MapsBetweenInitialSegments n k → K) :
    F = sumOverFiniteSet (coordinateTensorSpace L n k) (isFiniteSet_maps n k) F
      (fun x => coordinateTensor S n b hb k (basisTuple b x)) := by
  funext y
  -- F(x) ·_{ℂ^vec} δ_{x,y} = δ_{y,x} ·_{ℂ^vec} F(x)
  have hswap : ∀ x : MapsBetweenInitialSegments n k,
      (coefficientsVec L).smul (F x) (kroneckerDelta x y : K)
        = (coefficientsVec L).smul (kroneckerDelta y x : K) (F x) := by
    intro x
    show F x * (kroneckerDelta x y : K) = (kroneckerDelta y x : K) * F x
    rw [hcomm (F x) (kroneckerDelta x y : K)]
    by_cases hxy : x = y
    · rw [kroneckerDelta, kroneckerDelta, if_pos hxy, if_pos hxy.symm]
    · rw [kroneckerDelta, kroneckerDelta, if_neg hxy, if_neg (fun h => hxy h.symm)]
  symm
  calc sumOverFiniteSet (coordinateTensorSpace L n k) (isFiniteSet_maps n k) F
        (fun x => coordinateTensor S n b hb k (basisTuple b x)) y
      = (fun G : MapsBetweenInitialSegments n k → K => G y)
          (sumOverFiniteSet (coordinateTensorSpace L n k) (isFiniteSet_maps n k) F
            (fun x => coordinateTensor S n b hb k (basisTuple b x))) := rfl
    _ = sumOverFiniteSet (coefficientsVec L) (isFiniteSet_maps n k) F
          (fun x => coordinateTensor S n b hb k (basisTuple b x) y) :=
        (evaluationAt_isLinearMap L n k y).map_sumOverFiniteSet (UL.add_zero 0) (isFiniteSet_maps n k) F _
    _ = sumOverFiniteSet (coefficientsVec L) (isFiniteSet_maps n k) F
          (fun x => (kroneckerDelta x y : K)) := by
        rw [funext fun x => coordinateTensor_basisTuple UL S n b hb k x y]
    _ = sumOverFiniteSet (coefficientsVec L) (isFiniteSet_maps n k)
          (fun x => (kroneckerDelta y x : K)) F :=
        sumOverFiniteSet_congr (coefficientsVec L) (isFiniteSet_maps n k) _ _ _ _ hswap
    _ = F y := sumOverFiniteSet_kroneckerDelta (coefficientsVec L) (UL.add_zero 0) (isFiniteSet_maps n k) F y

/-- 本文 `def_map_from_coordinate_tensor_space_induced_by_multilinear_map`：h̄(F) := Σ_{x∈X} F(x) ·_U h(b ∘ x)。 -/
noncomputable def inducedLinearMap (SU : VectorSpace K U) (n : ℕ) (b : ℕ → V) (k : ℕ)
    (h : Tuple V k → U) (F : MapsBetweenInitialSegments n k → K) : U :=
  sumOverFiniteSet SU (isFiniteSet_maps n k) F (fun x => h (basisTuple b x))

/-- 本文 `claim_map_from_coordinate_tensor_space_is_linear`：h̄ は T から U への線型写像である。 -/
theorem inducedLinearMap_isLinearMap (L : ValuedMapsLaws K) (h00 : (0 : K) + 0 = 0)
    (hmul0 : ∀ a : K, a * 0 = 0) (SU : VectorSpace K U) (n : ℕ) (b : ℕ → V) (k : ℕ)
    (h : Tuple V k → U) :
    IsLinearMap (coordinateTensorSpace L n k) SU (inducedLinearMap SU n b k h) where
  map_add F G := calc
    inducedLinearMap SU n b k h ((coordinateTensorSpace L n k).add F G)
        = sumOverFiniteSet SU (isFiniteSet_maps n k) ((coordinateTensorSpace L n k).add F G)
            (fun x => h (basisTuple b x)) := rfl
    _ = sumOverFiniteSet SU (isFiniteSet_maps n k) (fun x => F x + G x)
            (fun x => h (basisTuple b x)) := rfl
    _ = SU.add (sumOverFiniteSet SU (isFiniteSet_maps n k) F (fun x => h (basisTuple b x)))
          (sumOverFiniteSet SU (isFiniteSet_maps n k) G (fun x => h (basisTuple b x))) :=
        (sumOverFiniteSet_add_of_same_family SU (isFiniteSet_maps n k) _ F G).symm
    _ = SU.add (inducedLinearMap SU n b k h F) (inducedLinearMap SU n b k h G) := rfl
  map_smul l F := calc
    inducedLinearMap SU n b k h ((coordinateTensorSpace L n k).smul l F)
        = sumOverFiniteSet SU (isFiniteSet_maps n k) ((coordinateTensorSpace L n k).smul l F)
            (fun x => h (basisTuple b x)) := rfl
    _ = sumOverFiniteSet SU (isFiniteSet_maps n k) (fun x => l * F x)
            (fun x => h (basisTuple b x)) := rfl
    _ = SU.smul l (sumOverFiniteSet SU (isFiniteSet_maps n k) F (fun x => h (basisTuple b x))) :=
        (smul_sumOverFiniteSet SU h00 hmul0 (isFiniteSet_maps n k) _ F l).symm
    _ = SU.smul l (inducedLinearMap SU n b k h F) := rfl

/-- 本文 `claim_k_multilinear_maps_agreeing_on_basis_tuples_are_equal` の B_j：
すべての s ∈ {j+1,…,k} について v(s) = b_i となる i ∈ {1,…,n} がある組 v の全体。 -/
def TuplesWithBasisTail (b : ℕ → V) (n : ℕ) {k : ℕ} (j : ℕ) (v : Tuple V k) : Prop :=
  ∀ s : Idx k, j < s.1 → ∃ i : ℕ, 1 ≤ i ∧ i ≤ n ∧ v s = b i

/-- 本文 `def_tuple_with_one_component_replaced` から：v[j ↦ v(j)] = v。 -/
theorem replaceComponent_self_eq {k : ℕ} (v : Tuple V k) (r : Idx k) :
    replaceComponent v r (v r) = v := by
  funext s
  by_cases hs : s = r
  · rw [hs, replaceComponent_self]
  · rw [replaceComponent_of_ne v r (v r) s hs]

omit [Zero K] in
/-- 本文 `claim_k_multilinear_maps_agreeing_on_basis_tuples_are_equal` の g^{v,j}(y) := g(v[j ↦ y]) が
V から U への線型写像であること（`def_k_multilinear_map` の二つの条件そのもの）。 -/
theorem IsMultilinearMap.linearMap_in_component {SV : VectorSpace K V}
    {SU : VectorSpace K U} {k : ℕ} {g : Tuple V k → U} (hg : IsMultilinearMap SV SU k g)
    (v : Tuple V k) (r : Idx k) :
    IsLinearMap SV SU (fun y => g (replaceComponent v r y)) where
  map_add y z := hg.map_add v r y z
  map_smul l y := hg.map_smul v r l y

/-- 本文 `claim_k_multilinear_maps_agreeing_on_basis_tuples_are_equal` の帰納法の主張：
すべての v ∈ B_j で g(v) = g'(v)（j ≤ k）。 -/
theorem multilinear_eq_of_basisTuple_aux (h00 : (0 : K) + 0 = 0) (S : VectorSpace K V) (SU : VectorSpace K U)
    (n : ℕ) (b : ℕ → V) (hb : IsBasisFamily S n b) (k : ℕ) (g g' : Tuple V k → U)
    (hg : IsMultilinearMap S SU k g) (hg' : IsMultilinearMap S SU k g')
    (hagree : ∀ x : MapsBetweenInitialSegments n k, g (basisTuple b x) = g' (basisTuple b x)) :
    ∀ j : ℕ, j ≤ k → ∀ v : Tuple V k, TuplesWithBasisTail b n j v → g v = g' v
  | 0, _, v, hv => by
    -- 各 s で v(s) = b_i となる i を一つ選んで x(s) := i と置くと v = b ∘ x
    let x : MapsBetweenInitialSegments n k := fun s =>
      ⟨Classical.choose (hv s s.2.1), (Classical.choose_spec (hv s s.2.1)).1,
        (Classical.choose_spec (hv s s.2.1)).2.1⟩
    have hvx : v = basisTuple b x := funext fun s => (Classical.choose_spec (hv s s.2.1)).2.2
    calc g v = g (basisTuple b x) := by rw [hvx]
      _ = g' (basisTuple b x) := hagree x
      _ = g' v := by rw [hvx]
  | j + 1, hj, v, hv => by
    -- 帰納法の仮定
    have ih := multilinear_eq_of_basisTuple_aux h00 S SU n b hb k g g' hg hg' hagree j (by omega)
    set r : Idx k := ⟨j + 1, Nat.succ_pos j, hj⟩ with hr
    -- Σ_{i=1}^{n} μ_i ·_V b_i = v(j)
    obtain ⟨μ, hμ⟩ := hb.spans (v r)
    -- v[j ↦ b_i] ∈ B_{j-1}（i ∈ {1,…,n}）
    have hmem : ∀ i : ℕ, 1 ≤ i → i ≤ n →
        TuplesWithBasisTail b n j (replaceComponent v r (b i)) := by
      intro i hi1 hin s hs
      by_cases hsr : s = r
      · exact ⟨i, hi1, hin, by rw [hsr, replaceComponent_self]⟩
      · have hs' : j + 1 < s.1 := by
          have : s.1 ≠ j + 1 := fun h => hsr (Subtype.ext h)
          omega
        obtain ⟨i', hi'1, hi'n, hvi'⟩ := hv s hs'
        exact ⟨i', hi'1, hi'n, by rw [replaceComponent_of_ne v r (b i) s hsr, hvi']⟩
    have hterms : ∀ i : ℕ, 1 ≤ i → i ≤ n →
        SU.smul (μ i) (g (replaceComponent v r (b i)))
          = SU.smul (μ i) (g' (replaceComponent v r (b i))) := by
      intro i hi1 hin
      rw [ih (replaceComponent v r (b i)) (hmem i hi1 hin)]
    calc g v = g (replaceComponent v r (linearCombination S n μ b)) := by
          rw [hμ, replaceComponent_self_eq]
      _ = linearCombination SU n μ (fun i => g (replaceComponent v r (b i))) :=
          (hg.linearMap_in_component v r).map_linearCombination h00 n μ b
      _ = linearCombination SU n μ (fun i => g' (replaceComponent v r (b i))) :=
          linearCombination_eq_of_terms_eq SU n _ _ μ μ hterms
      _ = g' (replaceComponent v r (linearCombination S n μ b)) :=
          ((hg'.linearMap_in_component v r).map_linearCombination h00 n μ b).symm
      _ = g' v := by rw [hμ, replaceComponent_self_eq]

/-- 本文 `claim_k_multilinear_maps_agreeing_on_basis_tuples_are_equal`：
すべての x ∈ X で g(b ∘ x) = g'(b ∘ x) なら g = g'。B_k は V^{1,…,k} 全体である。 -/
theorem multilinear_eq_of_basisTuple (h00 : (0 : K) + 0 = 0) (S : VectorSpace K V) (SU : VectorSpace K U)
    (n : ℕ) (b : ℕ → V) (hb : IsBasisFamily S n b) (k : ℕ) (g g' : Tuple V k → U)
    (hg : IsMultilinearMap S SU k g) (hg' : IsMultilinearMap S SU k g')
    (hagree : ∀ x : MapsBetweenInitialSegments n k, g (basisTuple b x) = g' (basisTuple b x)) :
    g = g' :=
  funext fun v => multilinear_eq_of_basisTuple_aux h00 S SU n b hb k g g' hg hg' hagree k (le_refl k) v
    (fun s hs => absurd hs (by have := s.2.2; omega))

/-- 本文 `claim_map_from_coordinate_tensor_space_composed_with_tau_is_original`：h̄ ∘ τ = h。 -/
theorem inducedLinearMap_comp_coordinateTensor (L : ValuedMapsLaws K) (UL : UniquenessLaws K) (hcomm : ∀ a b : K, a * b = b * a)
    (S : VectorSpace K V)
    (SU : VectorSpace K U) (n : ℕ) (b : ℕ → V) (hb : IsBasisFamily S n b) (k : ℕ)
    (h : Tuple V k → U) (hh : IsMultilinearMap S SU k h) :
    (fun v => inducedLinearMap SU n b k h (coordinateTensor S n b hb k v)) = h := by
  -- h̄ ∘ τ は k 重線型写像である
  have hcomp : IsMultilinearMap S SU k
      (fun v => inducedLinearMap SU n b k h (coordinateTensor S n b hb k v)) :=
    (coordinateTensor_isMultilinear L UL hcomm S n b hb k).comp_linearMap
      (inducedLinearMap_isLinearMap L (UL.add_zero 0) UL.mul_zero SU n b k h)
  apply multilinear_eq_of_basisTuple (UL.add_zero 0) S SU n b hb k _ h hcomp hh
  intro x
  calc inducedLinearMap SU n b k h (coordinateTensor S n b hb k (basisTuple b x))
      = sumOverFiniteSet SU (isFiniteSet_maps n k) (coordinateTensor S n b hb k (basisTuple b x))
          (fun y => h (basisTuple b y)) := rfl
    _ = sumOverFiniteSet SU (isFiniteSet_maps n k) (fun y => (kroneckerDelta x y : K))
          (fun y => h (basisTuple b y)) := by
        rw [funext fun y => coordinateTensor_basisTuple UL S n b hb k x y]
    _ = h (basisTuple b x) := sumOverFiniteSet_kroneckerDelta SU (UL.add_zero 0) (isFiniteSet_maps n k) _ x

/-- 本文 `claim_construction_is_k_fold_tensor_product`：(V^{⊗_b k}, τ_{b,k}) は V の k 重テンソル積である。 -/
theorem coordinateTensor_isTensorProduct (L : ValuedMapsLaws K) (UL : UniquenessLaws K) (hcomm : ∀ a b : K, a * b = b * a)
    (S : VectorSpace K V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily S n b) (k : ℕ) :
    IsTensorProduct.{u, uK, w, uK} S k (coordinateTensorSpace L n k) (coordinateTensor S n b hb k) where
  multilinear := coordinateTensor_isMultilinear L UL hcomm S n b hb k
  universal U SU h hh := by
    refine ⟨inducedLinearMap SU n b k h,
      ⟨inducedLinearMap_isLinearMap L (UL.add_zero 0) UL.mul_zero SU n b k h,
        fun v => congrFun (inducedLinearMap_comp_coordinateTensor L UL hcomm S SU n b hb k h hh) v⟩, ?_⟩
    -- 一意性：g ∘ τ = h を満たす線型写像 g は h̄ に等しい
    rintro g ⟨hg, hgτ⟩
    funext F
    calc g F
        = g (sumOverFiniteSet (coordinateTensorSpace L n k) (isFiniteSet_maps n k) F
            (fun x => coordinateTensor S n b hb k (basisTuple b x))) :=
          congrArg g (eq_sum_coordinateTensor_basisTuple L UL hcomm S n b hb k F)
      _ = sumOverFiniteSet SU (isFiniteSet_maps n k) F
            (fun x => g (coordinateTensor S n b hb k (basisTuple b x))) :=
          hg.map_sumOverFiniteSet (UL.add_zero 0) (isFiniteSet_maps n k) F _
      _ = sumOverFiniteSet SU (isFiniteSet_maps n k) F (fun x => h (basisTuple b x)) := by
          rw [funext fun x => hgτ (basisTuple b x)]
      _ = inducedLinearMap SU n b k h F := rfl

end CliffordMatrixIsomorphism.NecSuf.VectorSpace
