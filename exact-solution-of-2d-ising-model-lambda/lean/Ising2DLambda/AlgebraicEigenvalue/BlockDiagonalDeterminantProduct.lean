/-
主張「ブロック対角行列の行列式は小行列式の積である」（`claim_block_diagonal_determinant_product`）の具体版。

本文の三行目「`claim_polynomial_product_of_sums` の帰納法を各ファイバーの選択集合に適用」は、
添字 `k` ごとに選択集合 `Perm(𝒥_k)` が違う形の帰納法である。具体版
`qbarPolynomial_prod_sum_eq_sum_prod_family` は選択集合を一つに固定しているので、ここでは同じ帰納法
（本文の 𝔉(S)、W_S、ins、spl、二つの往復、重みの分離、部分集合の帰納法、全体集合への代入）を、
選択集合が添字ごとに違う形でこのファイルの中に置き、本文と同じ順に示す。
必要十分版の定義・定理は使わない。住処は Qbar。
-/
import Ising2DLambda.AlgebraicEigenvalue.BlockDiagonalTermFactorization
import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialProductSum

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

section FiberChoices

variable {K : Type*} [DecidableEq K] {P : K → Type*}

/-- 本文の 𝔉(S) の、選択集合が添字ごとに違う形。`k ∈ S` に `P k` の元を割り当てる。 -/
def FiberChoicesOn (P : K → Type*) (S : Finset K) : Type _ := ∀ k : K, k ∈ S → P k

/-- 𝔉(S) と部分型からの写像の型の往復。引数の受け渡しを組み替えるだけである。 -/
def fiberChoicesOnEquivSubtype (P : K → Type*) (S : Finset K) :
    FiberChoicesOn P S ≃ (∀ k : {k : K // k ∈ S}, P k.1) where
  toFun f := fun k => f k.1 k.2
  invFun f := fun k hk => f ⟨k, hk⟩
  left_inv _ := rfl
  right_inv _ := rfl

/-- 𝔉(S) は有限個の点への値の割当て全体なので有限である。 -/
noncomputable instance fiberChoicesOnFintype [∀ k, Fintype (P k)] (S : Finset K) :
    Fintype (FiberChoicesOn P S) := by
  classical
  exact Fintype.ofEquiv _ (fiberChoicesOnEquivSubtype P S).symm

/-- 本文の W_S(f) := ∏_{k∈S} g(k, f(k))。 -/
noncomputable def fiberChoiceWeight (g : (k : K) → P k → Polynomial Qbar) (S : Finset K)
    (f : FiberChoicesOn P S) : Polynomial Qbar :=
  ∏ k ∈ S.attach, g k.1 (f k.1 k.2)

/-- 本文の ins(b, f)。k = k₀ なら b、k ∈ S なら f(k)。 -/
def fiberInsertMap {S : Finset K} (k₀ : K) (b : P k₀) (f : FiberChoicesOn P S) :
    FiberChoicesOn P (insert k₀ S) :=
  fun k hk => if h : k = k₀ then h ▸ b else f k ((Finset.mem_insert.mp hk).resolve_left h)

/-- 本文の spl(h) := (h(k₀), h|_S)。 -/
def fiberSplitMap {S : Finset K} (k₀ : K) (h : FiberChoicesOn P (insert k₀ S)) :
    P k₀ × FiberChoicesOn P S :=
  (h k₀ (Finset.mem_insert_self k₀ S), fun k hk => h k (Finset.mem_insert_of_mem hk))

/-- ins の k₀ での値。 -/
theorem fiberInsertMap_apply_self {S : Finset K} (k₀ : K) (b : P k₀) (f : FiberChoicesOn P S)
    (hk : k₀ ∈ insert k₀ S) : fiberInsertMap k₀ b f k₀ hk = b := by
  simp [fiberInsertMap]

/-- ins の S 上の値。k ∈ S と k₀ ∉ S から k ≠ k₀ である。 -/
theorem fiberInsertMap_apply_of_mem {S : Finset K} {k₀ : K} (hk₀ : k₀ ∉ S) (b : P k₀)
    (f : FiberChoicesOn P S) {k : K} (hkS : k ∈ S) (hk : k ∈ insert k₀ S) :
    fiberInsertMap k₀ b f k hk = f k hkS := by
  have hne : k ≠ k₀ := fun h => hk₀ (h ▸ hkS)
  simp [fiberInsertMap, dif_neg hne]

/-- 本文の三等号 spl(ins(b,f)) = (ins(b,f)(k₀), ins(b,f)|_S) = (b, ins(b,f)|_S) = (b, f)。 -/
theorem fiberSplitMap_insertMap {S : Finset K} {k₀ : K} (hk₀ : k₀ ∉ S) (b : P k₀)
    (f : FiberChoicesOn P S) : fiberSplitMap k₀ (fiberInsertMap k₀ b f) = (b, f) := by
  refine Prod.ext ?_ ?_
  · calc
      (fiberSplitMap k₀ (fiberInsertMap k₀ b f)).1
          = fiberInsertMap k₀ b f k₀ (Finset.mem_insert_self k₀ S) := rfl
      _ = b := fiberInsertMap_apply_self _ _ _ _
  · funext k hk
    calc
      (fiberSplitMap k₀ (fiberInsertMap k₀ b f)).2 k hk
          = fiberInsertMap k₀ b f k (Finset.mem_insert_of_mem hk) := rfl
      _ = f k hk := fiberInsertMap_apply_of_mem hk₀ b f hk (Finset.mem_insert_of_mem hk)

/-- 本文の逆向き。k₀ での二等号と、k ∈ S での三等号を、点 k が k₀ かどうかで分けて辿る。 -/
theorem fiberInsertMap_splitMap {S : Finset K} {k₀ : K} (hk₀ : k₀ ∉ S)
    (h : FiberChoicesOn P (insert k₀ S)) :
    fiberInsertMap k₀ (fiberSplitMap k₀ h).1 (fiberSplitMap k₀ h).2 = h := by
  funext k hk
  by_cases hkk : k = k₀
  · subst hkk
    calc
      fiberInsertMap k (fiberSplitMap k h).1 (fiberSplitMap k h).2 k hk
          = fiberInsertMap k (h k (Finset.mem_insert_self k S)) (fiberSplitMap k h).2 k hk := rfl
      _ = h k (Finset.mem_insert_self k S) := fiberInsertMap_apply_self _ _ _ hk
      _ = h k hk := rfl
  · have hkS : k ∈ S := (Finset.mem_insert.mp hk).resolve_left hkk
    calc
      fiberInsertMap k₀ (fiberSplitMap k₀ h).1 (fiberSplitMap k₀ h).2 k hk
          = fiberInsertMap k₀ (h k₀ (Finset.mem_insert_self k₀ S))
              (fun j hj => h j (Finset.mem_insert_of_mem hj)) k hk := rfl
      _ = h k (Finset.mem_insert_of_mem hkS) := fiberInsertMap_apply_of_mem hk₀ _ _ hkS hk
      _ = h k hk := rfl

/-- 本文「ins は全単射である」。往復は上の二つの定理である。 -/
def fiberInsertMapEquiv {S : Finset K} {k₀ : K} (hk₀ : k₀ ∉ S) :
    P k₀ × FiberChoicesOn P S ≃ FiberChoicesOn P (insert k₀ S) where
  toFun p := fiberInsertMap k₀ p.1 p.2
  invFun h := fiberSplitMap k₀ h
  left_inv p := fiberSplitMap_insertMap hk₀ p.1 p.2
  right_inv h := fiberInsertMap_splitMap hk₀ h

/-- 本文の重みの四等号 W_{S⁺}(ins(b,f)) = g(k₀,b) W_S(f)。 -/
theorem fiberChoiceWeight_insertMap (g : (k : K) → P k → Polynomial Qbar) {S : Finset K}
    {k₀ : K} (hk₀ : k₀ ∉ S) (b : P k₀) (f : FiberChoicesOn P S) :
    fiberChoiceWeight g (insert k₀ S) (fiberInsertMap k₀ b f) =
      g k₀ b * fiberChoiceWeight g S f := by
  classical
  have hsplit :
      (∏ k ∈ (insert k₀ S).attach, g k.1 (fiberInsertMap k₀ b f k.1 k.2)) =
        g k₀ (fiberInsertMap k₀ b f k₀ (Finset.mem_insert_self k₀ S)) *
          ∏ k ∈ S.attach, g k.1 (fiberInsertMap k₀ b f k.1 (Finset.mem_insert_of_mem k.2)) := by
    rw [Finset.attach_insert, Finset.prod_insert, Finset.prod_image]
    · rintro ⟨a, ha⟩ - ⟨c, hc⟩ - hac
      have hac' : a = c := congrArg Subtype.val hac
      exact Subtype.ext hac'
    · intro hmem
      rw [Finset.mem_image] at hmem
      obtain ⟨⟨a, ha⟩, -, hai⟩ := hmem
      have : a = k₀ := congrArg Subtype.val hai
      exact hk₀ (this ▸ ha)
  calc
    fiberChoiceWeight g (insert k₀ S) (fiberInsertMap k₀ b f)
        = ∏ k ∈ (insert k₀ S).attach, g k.1 (fiberInsertMap k₀ b f k.1 k.2) := rfl
    _ = g k₀ (fiberInsertMap k₀ b f k₀ (Finset.mem_insert_self k₀ S)) *
          ∏ k ∈ S.attach, g k.1 (fiberInsertMap k₀ b f k.1 (Finset.mem_insert_of_mem k.2)) :=
          hsplit
    _ = g k₀ b * ∏ k ∈ S.attach, g k.1 (f k.1 k.2) := by
          rw [fiberInsertMap_apply_self]
          congr 1
          refine Finset.prod_congr rfl ?_
          intro k _
          rw [fiberInsertMap_apply_of_mem hk₀ b f k.2]
    _ = g k₀ b * fiberChoiceWeight g S f := rfl

/-- 本文の部分集合上の主張を、選択集合が添字ごとに違う形で示す。空集合の三等号と一点追加の七等号。 -/
theorem fiberPolynomial_prod_sum_eq_sum_prod_family [∀ k, Fintype (P k)]
    (g : (k : K) → P k → Polynomial Qbar) (S : Finset K) :
    (∏ k ∈ S, ∑ b : P k, g k b) =
      ∑ f : FiberChoicesOn P S, fiberChoiceWeight g S f := by
  classical
  induction S using Finset.induction_on with
  | empty =>
      have hunique : ∀ f : FiberChoicesOn P (∅ : Finset K),
          f = fun _ hk => absurd hk (Finset.notMem_empty _) :=
        fun f => funext fun _ => funext fun hk => absurd hk (Finset.notMem_empty _)
      have hcard : Fintype.card (FiberChoicesOn P (∅ : Finset K)) = 1 :=
        Fintype.card_eq_one_iff.mpr ⟨fun _ hk => absurd hk (Finset.notMem_empty _), hunique⟩
      calc
        (∏ k ∈ (∅ : Finset K), ∑ b : P k, g k b) = 1 := Finset.prod_empty
        _ = ∑ _f : FiberChoicesOn P (∅ : Finset K), (1 : Polynomial Qbar) := by
          rw [Finset.sum_const, Finset.card_univ, hcard, one_smul]
        _ = ∑ f : FiberChoicesOn P (∅ : Finset K), fiberChoiceWeight g (∅ : Finset K) f := by
          refine Finset.sum_congr rfl ?_
          intro f _
          simp [fiberChoiceWeight]
  | insert k₀ S hk₀ ih =>
      calc
        (∏ k ∈ insert k₀ S, ∑ b : P k, g k b) =
            (∑ b : P k₀, g k₀ b) * ∏ k ∈ S, ∑ b : P k, g k b :=
          Finset.prod_insert hk₀
        _ = (∑ b : P k₀, g k₀ b) * ∑ f : FiberChoicesOn P S, fiberChoiceWeight g S f :=
          congrArg ((∑ b : P k₀, g k₀ b) * ·) ih
        _ = ∑ b : P k₀, g k₀ b * (∑ f : FiberChoicesOn P S, fiberChoiceWeight g S f) :=
          Finset.sum_mul _ _ _
        _ = ∑ b : P k₀, ∑ f : FiberChoicesOn P S, g k₀ b * fiberChoiceWeight g S f := by
          refine Finset.sum_congr rfl ?_
          intro b _
          exact Finset.mul_sum _ _ _
        _ = ∑ p : P k₀ × FiberChoicesOn P S, g k₀ p.1 * fiberChoiceWeight g S p.2 := by
          rw [Fintype.sum_prod_type]
        _ = ∑ p : P k₀ × FiberChoicesOn P S,
            fiberChoiceWeight g (insert k₀ S) (fiberInsertMapEquiv hk₀ p) := by
          refine Finset.sum_congr rfl ?_
          intro p _
          exact (fiberChoiceWeight_insertMap g hk₀ p.1 p.2).symm
        _ = ∑ h : FiberChoicesOn P (insert k₀ S), fiberChoiceWeight g (insert k₀ S) h :=
          Equiv.sum_comp (fiberInsertMapEquiv hk₀) (fiberChoiceWeight g (insert k₀ S))

/-- 𝔉(𝒦) と各ファイバーの選択の組の全体の往復（所属の証明 k ∈ univ を受け取るかどうかだけが違う）。 -/
def fiberChoicesOnUnivEquiv (P : K → Type*) [Fintype K] :
    FiberChoicesOn P (univ : Finset K) ≃ (∀ k, P k) where
  toFun f := fun k => f k (Finset.mem_univ k)
  invFun f := fun k _ => f k
  left_inv _ := rfl
  right_inv _ := rfl

/-- 全体集合への代入。部分集合を全体集合に取り、重みの定義を展開し、選択の組の全体へ再添字付けする。 -/
theorem polynomial_prod_sum_fibers [Fintype K] [∀ k, Fintype (P k)]
    (g : (k : K) → P k → Polynomial Qbar) :
    (∏ k : K, ∑ p : P k, g k p) =
      ∑ parts : (∀ k, P k), ∏ k : K, g k (parts k) := by
  classical
  calc
    (∏ k : K, ∑ p : P k, g k p) =
        ∑ f : FiberChoicesOn P (univ : Finset K), fiberChoiceWeight g univ f :=
      fiberPolynomial_prod_sum_eq_sum_prod_family g univ
    _ = ∑ f : FiberChoicesOn P (univ : Finset K),
        ∏ k ∈ (univ : Finset K).attach, g k.1 (f k.1 k.2) := rfl
    _ = ∑ parts : (∀ k, P k), ∏ k ∈ (univ : Finset K).attach, g k.1 (parts k.1) :=
      Equiv.sum_comp (fiberChoicesOnUnivEquiv P)
        (fun parts => ∏ k ∈ (univ : Finset K).attach, g k.1 (parts k.1))
    _ = ∑ parts : (∀ k, P k), ∏ k : K, g k (parts k) := by
      refine Finset.sum_congr rfl ?_
      intro parts _
      exact Finset.prod_attach (univ : Finset K) (fun k => g k (parts k))

end FiberChoices

/-- A block diagonal polynomial matrix has the product of the determinants
    of its restrictions to all fibers, including empty fibers. -/
theorem blockDiagonal_det_eq_prod_fiber_dets
    {J K : Type*} [Fintype J] [LinearOrder J] [Fintype K] [LinearOrder K]
    (block : J → K) (B : Matrix J J (Polynomial Qbar))
    (hoff : ∀ i j, block i ≠ block j → B i j = 0) :
    Matrix.det B = ∏ k : K,
      Matrix.det (fun i j : {v : J // block v = k} => B i.1 j.1) := by
  classical
  let weight (k : K) (τ : Equiv.Perm {v : J // block v = k}) : Polynomial Qbar :=
    Polynomial.C (((Equiv.Perm.sign τ : ℤ) : Qbar)) *
      ∏ i : {v : J // block v = k}, B i.1 (τ i).1
  calc
    Matrix.det B =
        ∑ parts : (∀ k : K, Equiv.Perm {v : J // block v = k}),
          Polynomial.C (((Equiv.Perm.sign
            ((blockPreservingPermutationEquiv block).symm parts).1 : ℤ) : Qbar)) *
            ∏ i : J, B i (((blockPreservingPermutationEquiv block).symm parts).1 i) :=
      blockDiagonal_det_eq_sum_fiber_permutation_families block B hoff
    _ = ∑ parts : (∀ k : K, Equiv.Perm {v : J // block v = k}),
          ∏ k : K, weight k (parts k) := by
      refine Finset.sum_congr rfl ?_
      intro parts _
      simpa only [weight] using
        blockDiagonal_term_eq_prod_fiber_terms block B parts
    _ = ∏ k : K, ∑ τ : Equiv.Perm {v : J // block v = k}, weight k τ :=
      (polynomial_prod_sum_fibers weight).symm
    _ = ∏ k : K, Matrix.det (fun i j : {v : J // block v = k} => B i.1 j.1) := by
      refine Finset.prod_congr rfl ?_
      intro k _
      calc
        (∑ τ : Equiv.Perm {v : J // block v = k}, weight k τ) =
            ∑ τ : Equiv.Perm {v : J // block v = k},
              ((Equiv.Perm.sign τ : ℤ) : Polynomial Qbar) *
                ∏ i : {v : J // block v = k}, B i.1 (τ i).1 := by
          simp only [weight, map_intCast]
        _ = Matrix.det (Matrix.transpose
              (fun i j : {v : J // block v = k} => B i.1 j.1)) := by
          simpa only [Matrix.transpose_apply] using
            (Matrix.det_apply' (Matrix.transpose
              (fun i j : {v : J // block v = k} => B i.1 j.1))).symm
        _ = Matrix.det (fun i j : {v : J // block v = k} => B i.1 j.1) :=
          Matrix.det_transpose _

end Ising2DLambda.AlgebraicEigenvalue
