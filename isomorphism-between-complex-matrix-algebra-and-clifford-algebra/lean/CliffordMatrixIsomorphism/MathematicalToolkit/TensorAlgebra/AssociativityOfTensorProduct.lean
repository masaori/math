/-
節「テンソル代数」のうち、テンソルの積の結合法則と、空の組の像が積の単位元であることの具体版。人手証明と 1 対 1 に対応させる。

  本文のラベル                                                  このファイル
  claim_composition_of_linear_maps_is_linear_map                IsComplexLinearMap.comp
  claim_linear_maps_agreeing_on_pure_tensors_are_equal          IsTensorProduct.linearMap_ext
  claim_concatenation_of_tuples_is_associative                  concatTuple_assoc
  claim_product_of_tensors_is_associative                       TensorPowers.tensorMul_assoc
  def_empty_tuple_of_vector_space_elements                      emptyTuple（ε_V）・eq_emptyTuple
  claim_concatenation_with_empty_tuple_on_left                  concatTuple_emptyTuple_left
  claim_concatenation_with_empty_tuple_on_right                 concatTuple_emptyTuple_right
  claim_product_with_image_of_empty_tuple_on_left               TensorPowers.tensorMul_tau_emptyTuple_left
  claim_product_with_image_of_empty_tuple_on_right              TensorPowers.tensorMul_tau_emptyTuple_right

本文の「(k+l)+p = k+(l+p) なので両辺は同じ集合の元である」は、番号の等しい二つの集合を同じ集合として読む文である。
Lean では V^{1,…,a} と V^{1,…,b}、T_a と T_b は a = b を示しても別の型の式なので、その間の写像に名前を付ける：
組には `castTuple`（番号 s をそのまま運ぶ）、T_j には `TensorPowers.castT`（型の等式で運ぶ）。どちらも a = b の証明を
`subst` すると恒等写像になり、加法・スカラー倍・τ と交換する（`castT_add`・`castT_smul`・`castT_tau`）。
本文のテンソルの積の結合法則の左辺は、Lean では castT で T_{k+(l+p)} へ運んだ元である。

本文が「m_{a,c}(X, •) と m_{a,c}(•, Y) は線型写像である」とする行は `tensorMul_right_isLinearMap`・
`tensorMul_left_isLinearMap`（本文の二つの線型性の主張を線型写像の定義へ当てたもの）。

必要十分版は `NecSuf/MathematicalToolkit/TensorAlgebra/AssociativityOfTensorProduct.lean`、
導出版は `TensorAlgebraStructureFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorAlgebra.ProductOfTensors

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

universe u v w w'

variable {V : Type u} {U : Type v} {W : Type w}

/-- 本文 `claim_composition_of_linear_maps_is_linear_map`：線型写像 f : V → U と g : U → W の合成 g ∘ f は線型写像である。 -/
theorem IsComplexLinearMap.comp {SV : ComplexVectorSpace V} {SU : ComplexVectorSpace U}
    {SW : ComplexVectorSpace W} {f : V → U} {g : U → W} (hf : IsComplexLinearMap SV SU f)
    (hg : IsComplexLinearMap SU SW g) : IsComplexLinearMap SV SW (fun x => g (f x)) where
  map_add x y := calc
    g (f (SV.add x y)) = g (SU.add (f x) (f y)) := by rw [hf.map_add x y]
    _ = SW.add (g (f x)) (g (f y)) := hg.map_add (f x) (f y)
  map_smul l x := calc
    g (f (SV.smul l x)) = g (SU.smul l (f x)) := by rw [hf.map_smul l x]
    _ = SW.smul l (g (f x)) := hg.map_smul l (f x)

/-- 恒等写像は加法とスカラー倍を保つので線型写像である（本文 `def_linear_map` を恒等写像に当てたもの）。 -/
theorem isComplexLinearMap_id (SV : ComplexVectorSpace V) : IsComplexLinearMap SV SV (fun x => x) where
  map_add _ _ := rfl
  map_smul _ _ := rfl

/-- 本文 `claim_linear_maps_agreeing_on_pure_tensors_are_equal`：すべての組 v で f(τ(v)) = g(τ(v)) なら f = g。
h := f ∘ τ と置き、f と g がどちらも h̄ ∘ τ = h を満たすことから、普遍性の一意性で f = g を得る。 -/
theorem IsTensorProduct.linearMap_ext {SV : ComplexVectorSpace V} {k : ℕ} {T : Type v}
    {ST : ComplexVectorSpace T} {τ : Tuple V k → T} {SW : ComplexVectorSpace W}
    (hT : IsTensorProduct.{u, v, w} SV k ST τ) {f g : T → W} (hf : IsComplexLinearMap ST SW f)
    (hg : IsComplexLinearMap ST SW g) (h : ∀ v : Tuple V k, f (τ v) = g (τ v)) : f = g := by
  -- h := f ∘ τ は k 重線型写像（claim_linear_map_after_k_multilinear_map_is_k_multilinear）
  have hh : IsMultilinearMap SV SW k (fun v => f (τ v)) := hT.multilinear.comp_linearMap hf
  obtain ⟨hbar, _, huniq⟩ := hT.universal W SW (fun v => f (τ v)) hh
  -- f ∘ τ = h と g ∘ τ = h
  have hfbar : f = hbar := huniq f ⟨hf, fun _ => rfl⟩
  have hgbar : g = hbar := huniq g ⟨hg, fun v => (h v).symm⟩
  rw [hfbar, hgbar]

/-- 番号の等しい二つの組の集合の間の写像：a = b のとき、V^{1,…,a} の組 u を、番号 s に u(s) を与える V^{1,…,b} の組として書く。 -/
def castTuple {a b : ℕ} (h : a = b) (u : Tuple V a) : Tuple V b :=
  fun s => u ⟨s.1, s.2.1, by have := s.2.2; omega⟩

/-- 本文 `claim_concatenation_of_tuples_is_associative`：cat_{k+l,p}(cat_{k,l}(u, u'), u'') = cat_{k,l+p}(u, cat_{l,p}(u', u''))。
s ≤ k、k+1 ≤ s ≤ k+l、k+l+1 ≤ s の三つの場合に分けて値を比べる。 -/
theorem concatTuple_assoc {k l p : ℕ} (u : Tuple V k) (u' : Tuple V l) (u'' : Tuple V p) :
    castTuple (Nat.add_assoc k l p) (concatTuple (concatTuple u u') u'')
      = concatTuple u (concatTuple u' u'') := by
  funext s
  have hs1 := s.2.1
  have hs2 := s.2.2
  by_cases h1 : s.1 ≤ k
  · -- s ≤ k のとき（このとき s ≤ k + l）
    calc castTuple (Nat.add_assoc k l p) (concatTuple (concatTuple u u') u'') s
        = concatTuple (concatTuple u u') u'' ⟨s.1, s.2.1, by omega⟩ := rfl
      _ = concatTuple u u' ⟨s.1, s.2.1, by omega⟩ :=
          concatTuple_of_le (concatTuple u u') u'' ⟨s.1, s.2.1, by omega⟩ (by show s.1 ≤ k + l; omega)
      _ = u ⟨s.1, s.2.1, h1⟩ := concatTuple_of_le u u' ⟨s.1, s.2.1, by omega⟩ h1
      _ = concatTuple u (concatTuple u' u'') s := (concatTuple_of_le u (concatTuple u' u'') s h1).symm
  · by_cases h2 : s.1 ≤ k + l
    · -- k + 1 ≤ s ≤ k + l のとき（このとき 1 ≤ s - k ≤ l）
      calc castTuple (Nat.add_assoc k l p) (concatTuple (concatTuple u u') u'') s
          = concatTuple (concatTuple u u') u'' ⟨s.1, s.2.1, by omega⟩ := rfl
        _ = concatTuple u u' ⟨s.1, s.2.1, h2⟩ :=
            concatTuple_of_le (concatTuple u u') u'' ⟨s.1, s.2.1, by omega⟩ h2
        _ = u' ⟨s.1 - k, by omega, by omega⟩ :=
            concatTuple_of_gt u u' ⟨s.1, s.2.1, h2⟩ (by show k < s.1; omega)
        _ = concatTuple u' u'' ⟨s.1 - k, by omega, by omega⟩ :=
            (concatTuple_of_le u' u'' ⟨s.1 - k, by omega, by omega⟩ (by show s.1 - k ≤ l; omega)).symm
        _ = concatTuple u (concatTuple u' u'') s :=
            (concatTuple_of_gt u (concatTuple u' u'') s (by omega)).symm
    · -- k + l + 1 ≤ s のとき（このとき l + 1 ≤ s - k ≤ l + p）
      calc castTuple (Nat.add_assoc k l p) (concatTuple (concatTuple u u') u'') s
          = concatTuple (concatTuple u u') u'' ⟨s.1, s.2.1, by omega⟩ := rfl
        _ = u'' ⟨s.1 - (k + l), by omega, by omega⟩ :=
            concatTuple_of_gt (concatTuple u u') u'' ⟨s.1, s.2.1, by omega⟩ (by show k + l < s.1; omega)
        _ = u'' ⟨(s.1 - k) - l, by omega, by omega⟩ := by
            -- s - (k + l) = (s - k) - l
            have hidx : (⟨s.1 - (k + l), by omega, by omega⟩ : Idx p) = ⟨(s.1 - k) - l, by omega, by omega⟩ :=
              Subtype.ext (by show s.1 - (k + l) = (s.1 - k) - l; omega)
            rw [hidx]
        _ = concatTuple u' u'' ⟨s.1 - k, by omega, by omega⟩ :=
            (concatTuple_of_gt u' u'' ⟨s.1 - k, by omega, by omega⟩ (by show l < s.1 - k; omega)).symm
        _ = concatTuple u (concatTuple u' u'') s :=
            (concatTuple_of_gt u (concatTuple u' u'') s (by omega)).symm

/-- 本文 `def_empty_tuple_of_vector_space_elements`：空集合から V への写像ただ一つ、空の組 ε_V ∈ V^{1,…,0}。 -/
def emptyTuple (V : Type u) : Tuple V 0 :=
  fun s => absurd (le_trans s.2.1 s.2.2) (by omega)

/-- 本文 `def_empty_tuple_of_vector_space_elements`：すべての v ∈ V^{1,…,0} について v = ε_V。 -/
theorem eq_emptyTuple (v : Tuple V 0) : v = emptyTuple V :=
  funext fun s => absurd (le_trans s.2.1 s.2.2) (by omega)

/-- 本文 `claim_concatenation_with_empty_tuple_on_left`：cat_{0,l}(ε_V, u') = u'。 -/
theorem concatTuple_emptyTuple_left {l : ℕ} (u' : Tuple V l) :
    castTuple (Nat.zero_add l) (concatTuple (emptyTuple V) u') = u' := by
  funext s
  have hs1 := s.2.1
  calc castTuple (Nat.zero_add l) (concatTuple (emptyTuple V) u') s
      = concatTuple (emptyTuple V) u' ⟨s.1, s.2.1, by have := s.2.2; omega⟩ := rfl
    _ = u' ⟨s.1 - 0, by omega, by have := s.2.2; omega⟩ :=
        concatTuple_of_gt (emptyTuple V) u' ⟨s.1, s.2.1, by have := s.2.2; omega⟩ (by show 0 < s.1; omega)
    _ = u' s := rfl

/-- 本文 `claim_concatenation_with_empty_tuple_on_right`：cat_{k,0}(u, ε_V) = u。 -/
theorem concatTuple_emptyTuple_right {k : ℕ} (u : Tuple V k) :
    castTuple (Nat.add_zero k) (concatTuple u (emptyTuple V)) = u := by
  funext s
  calc castTuple (Nat.add_zero k) (concatTuple u (emptyTuple V)) s
      = concatTuple u (emptyTuple V) ⟨s.1, s.2.1, s.2.2⟩ := rfl
    _ = u ⟨s.1, s.2.1, s.2.2⟩ := concatTuple_of_le u (emptyTuple V) ⟨s.1, s.2.1, s.2.2⟩ s.2.2
    _ = u s := rfl

namespace TensorPowers

variable {SV : ComplexVectorSpace V} (P : TensorPowers.{u, v} SV)

/-- 番号の等しい T_a と T_b の間の写像（a = b）。本文の「a = b なので T_a の元は T_b の元である」を、型の等式で運ぶ写像として書く。 -/
def castT {a b : ℕ} (h : a = b) (X : P.T a) : P.T b :=
  cast (congrArg P.T h) X

theorem castT_self {a : ℕ} (h : a = a) (X : P.T a) : P.castT h X = X := rfl

theorem castT_castT {a b c : ℕ} (h : a = b) (h' : b = c) (X : P.T a) :
    P.castT h' (P.castT h X) = P.castT (h.trans h') X := by
  subst h
  subst h'
  rfl

theorem castT_add {a b : ℕ} (h : a = b) (X Y : P.T a) :
    P.castT h ((P.space a).add X Y) = (P.space b).add (P.castT h X) (P.castT h Y) := by
  subst h
  rfl

theorem castT_smul {a b : ℕ} (h : a = b) (c : ℂ) (X : P.T a) :
    P.castT h ((P.space a).smul c X) = (P.space b).smul c (P.castT h X) := by
  subst h
  rfl

theorem castT_zero {a b : ℕ} (h : a = b) : P.castT h (P.space a).zero = (P.space b).zero := by
  subst h
  rfl

/-- castT は T_a から T_b への線型写像である。 -/
theorem castT_isLinearMap {a b : ℕ} (h : a = b) :
    IsComplexLinearMap (P.space a) (P.space b) (P.castT h) where
  map_add X Y := P.castT_add h X Y
  map_smul c X := P.castT_smul h c X

/-- castT は τ と交換する：τ_a(u) を T_b へ運んだ元は τ_b(castTuple(u))。 -/
theorem castT_tau {a b : ℕ} (h : a = b) (u : Tuple V a) : P.castT h (P.τ a u) = P.τ b (castTuple h u) := by
  subst h
  rfl

/-- 本文の「m_{a,c}(X, •) は線型写像である」（`claim_product_of_tensors_is_linear_in_second_factor` と `def_linear_map`）。 -/
theorem tensorMul_right_isLinearMap (a c : ℕ) (X : P.T a) :
    IsComplexLinearMap (P.space c) (P.space (a + c)) (fun Z => P.tensorMul a c X Z) where
  map_add Z Z' := P.tensorMul_add_right a c X Z Z'
  map_smul l Z := P.tensorMul_smul_right a c X l Z

/-- 本文の「m_{a,c}(•, Y) は線型写像である」（`claim_product_of_tensors_is_linear_in_first_factor` と `def_linear_map`）。 -/
theorem tensorMul_left_isLinearMap (a c : ℕ) (Y : P.T c) :
    IsComplexLinearMap (P.space a) (P.space (a + c)) (fun Z => P.tensorMul a c Z Y) where
  map_add Z Z' := P.tensorMul_add_left a c Z Z' Y
  map_smul l Z := P.tensorMul_smul_left a c l Z Y

/-- 本文 `claim_product_of_tensors_is_associative` の（組の像が三つのとき）。 -/
theorem tensorMul_assoc_tau (k l p : ℕ) (u : Tuple V k) (u' : Tuple V l) (u'' : Tuple V p) :
    P.castT (Nat.add_assoc k l p) (P.tensorMul (k + l) p (P.tensorMul k l (P.τ k u) (P.τ l u')) (P.τ p u''))
      = P.tensorMul k (l + p) (P.τ k u) (P.tensorMul l p (P.τ l u') (P.τ p u'')) := calc
  P.castT (Nat.add_assoc k l p) (P.tensorMul (k + l) p (P.tensorMul k l (P.τ k u) (P.τ l u')) (P.τ p u''))
      = P.castT (Nat.add_assoc k l p) (P.tensorMul (k + l) p (P.τ (k + l) (concatTuple u u')) (P.τ p u'')) := by
        rw [P.tensorMul_tau_tau k l u u']
    _ = P.castT (Nat.add_assoc k l p) (P.τ (k + l + p) (concatTuple (concatTuple u u') u'')) := by
        rw [P.tensorMul_tau_tau (k + l) p (concatTuple u u') u'']
    _ = P.τ (k + (l + p)) (castTuple (Nat.add_assoc k l p) (concatTuple (concatTuple u u') u'')) :=
        P.castT_tau (Nat.add_assoc k l p) _
    _ = P.τ (k + (l + p)) (concatTuple u (concatTuple u' u'')) := by rw [concatTuple_assoc u u' u'']
    _ = P.tensorMul k (l + p) (P.τ k u) (P.τ (l + p) (concatTuple u' u'')) :=
        (P.tensorMul_tau_tau k (l + p) u (concatTuple u' u'')).symm
    _ = P.tensorMul k (l + p) (P.τ k u) (P.tensorMul l p (P.τ l u') (P.τ p u'')) := by
        rw [P.tensorMul_tau_tau l p u' u'']

/-- 本文 `claim_product_of_tensors_is_associative` の（前の二つが組の像のとき）。
T_p から T_{k+(l+p)} への二つの線型写像が τ_p(u'') で一致することから、`IsTensorProduct.linearMap_ext` で等しい。 -/
theorem tensorMul_assoc_tau_tau (k l p : ℕ) (u : Tuple V k) (u' : Tuple V l) (H : P.T p) :
    P.castT (Nat.add_assoc k l p) (P.tensorMul (k + l) p (P.tensorMul k l (P.τ k u) (P.τ l u')) H)
      = P.tensorMul k (l + p) (P.τ k u) (P.tensorMul l p (P.τ l u') H) := by
  have heq : (fun H => P.castT (Nat.add_assoc k l p)
        (P.tensorMul (k + l) p (P.tensorMul k l (P.τ k u) (P.τ l u')) H))
      = (fun H => P.tensorMul k (l + p) (P.τ k u) (P.tensorMul l p (P.τ l u') H)) :=
    IsTensorProduct.linearMap_ext (P.isTensorProduct p)
      ((P.tensorMul_right_isLinearMap (k + l) p _).comp (P.castT_isLinearMap (Nat.add_assoc k l p)))
      ((P.tensorMul_right_isLinearMap l p _).comp (P.tensorMul_right_isLinearMap k (l + p) _))
      (fun u'' => P.tensorMul_assoc_tau k l p u u' u'')
  exact congrFun heq H

/-- 本文 `claim_product_of_tensors_is_associative` の（前の一つが組の像のとき）。
T_l から T_{k+(l+p)} への二つの合成が τ_l(u') で一致することから等しい。 -/
theorem tensorMul_assoc_tau_left (k l p : ℕ) (u : Tuple V k) (G : P.T l) (H : P.T p) :
    P.castT (Nat.add_assoc k l p) (P.tensorMul (k + l) p (P.tensorMul k l (P.τ k u) G) H)
      = P.tensorMul k (l + p) (P.τ k u) (P.tensorMul l p G H) := by
  have heq : (fun G => P.castT (Nat.add_assoc k l p) (P.tensorMul (k + l) p (P.tensorMul k l (P.τ k u) G) H))
      = (fun G => P.tensorMul k (l + p) (P.τ k u) (P.tensorMul l p G H)) :=
    IsTensorProduct.linearMap_ext (P.isTensorProduct l)
      (((P.tensorMul_right_isLinearMap k l _).comp (P.tensorMul_left_isLinearMap (k + l) p H)).comp
        (P.castT_isLinearMap (Nat.add_assoc k l p)))
      ((P.tensorMul_left_isLinearMap l p H).comp (P.tensorMul_right_isLinearMap k (l + p) _))
      (fun u' => P.tensorMul_assoc_tau_tau k l p u u' H)
  exact congrFun heq G

/-- 本文 `claim_product_of_tensors_is_associative`：m_{k+l,p}(m_{k,l}(F, G), H) = m_{k,l+p}(F, m_{l,p}(G, H))
（左辺は castT で T_{k+(l+p)} へ運んだ元）。（一般のとき）T_k から T_{k+(l+p)} への二つの線型写像が τ_k(u) で一致することから等しい。 -/
theorem tensorMul_assoc (k l p : ℕ) (F : P.T k) (G : P.T l) (H : P.T p) :
    P.castT (Nat.add_assoc k l p) (P.tensorMul (k + l) p (P.tensorMul k l F G) H)
      = P.tensorMul k (l + p) F (P.tensorMul l p G H) := by
  have heq : (fun F => P.castT (Nat.add_assoc k l p) (P.tensorMul (k + l) p (P.tensorMul k l F G) H))
      = (fun F => P.tensorMul k (l + p) F (P.tensorMul l p G H)) :=
    IsTensorProduct.linearMap_ext (P.isTensorProduct k)
      (((P.tensorMul_left_isLinearMap k l G).comp (P.tensorMul_left_isLinearMap (k + l) p H)).comp
        (P.castT_isLinearMap (Nat.add_assoc k l p)))
      (P.tensorMul_left_isLinearMap k (l + p) _)
      (fun u => P.tensorMul_assoc_tau_left k l p u G H)
  exact congrFun heq F

/-- 本文 `claim_product_with_image_of_empty_tuple_on_left`：m_{0,l}(τ_0(ε_V), G) = G（左辺は castT で T_l へ運んだ元）。
線型写像 m_{0,l}(τ_0(ε_V), •) と恒等写像が τ_l(u') で一致することから等しい。 -/
theorem tensorMul_tau_emptyTuple_left (l : ℕ) (G : P.T l) :
    P.castT (Nat.zero_add l) (P.tensorMul 0 l (P.τ 0 (emptyTuple V)) G) = G := by
  have heq : (fun G => P.castT (Nat.zero_add l) (P.tensorMul 0 l (P.τ 0 (emptyTuple V)) G)) = (fun G => G) :=
    IsTensorProduct.linearMap_ext (P.isTensorProduct l)
      ((P.tensorMul_right_isLinearMap 0 l _).comp (P.castT_isLinearMap (Nat.zero_add l)))
      (isComplexLinearMap_id (P.space l))
      (fun u' => calc
        P.castT (Nat.zero_add l) (P.tensorMul 0 l (P.τ 0 (emptyTuple V)) (P.τ l u'))
            = P.castT (Nat.zero_add l) (P.τ (0 + l) (concatTuple (emptyTuple V) u')) := by
              rw [P.tensorMul_tau_tau 0 l (emptyTuple V) u']
          _ = P.τ l (castTuple (Nat.zero_add l) (concatTuple (emptyTuple V) u')) :=
              P.castT_tau (Nat.zero_add l) _
          _ = P.τ l u' := by rw [concatTuple_emptyTuple_left u']
          _ = (fun G => G) (P.τ l u') := rfl)
  exact congrFun heq G

/-- 本文 `claim_product_with_image_of_empty_tuple_on_right`：m_{k,0}(F, τ_0(ε_V)) = F（左辺は castT で T_k へ運んだ元）。 -/
theorem tensorMul_tau_emptyTuple_right (k : ℕ) (F : P.T k) :
    P.castT (Nat.add_zero k) (P.tensorMul k 0 F (P.τ 0 (emptyTuple V))) = F := by
  have heq : (fun F => P.castT (Nat.add_zero k) (P.tensorMul k 0 F (P.τ 0 (emptyTuple V)))) = (fun F => F) :=
    IsTensorProduct.linearMap_ext (P.isTensorProduct k)
      ((P.tensorMul_left_isLinearMap k 0 _).comp (P.castT_isLinearMap (Nat.add_zero k)))
      (isComplexLinearMap_id (P.space k))
      (fun u => calc
        P.castT (Nat.add_zero k) (P.tensorMul k 0 (P.τ k u) (P.τ 0 (emptyTuple V)))
            = P.castT (Nat.add_zero k) (P.τ (k + 0) (concatTuple u (emptyTuple V))) := by
              rw [P.tensorMul_tau_tau k 0 u (emptyTuple V)]
          _ = P.τ k (castTuple (Nat.add_zero k) (concatTuple u (emptyTuple V))) :=
              P.castT_tau (Nat.add_zero k) _
          _ = P.τ k u := by rw [concatTuple_emptyTuple_right u]
          _ = (fun F => F) (P.τ k u) := rfl)
  exact congrFun heq F

end TensorPowers

end CliffordMatrixIsomorphism.ComplexVectorSpace
