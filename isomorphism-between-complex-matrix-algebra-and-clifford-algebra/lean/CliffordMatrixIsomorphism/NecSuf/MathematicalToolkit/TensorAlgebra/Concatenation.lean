/-
節「テンソル代数」のうち、二つの組をつなげた組と、組の写像に後ろの組を固定して入れた写像の必要十分版。具体版
`MathematicalToolkit/TensorAlgebra/Concatenation.lean` と同じ def と calc の行で、係数 ℂ を型の変数 K に替えて書く。

  本文のラベル                                                          このファイル                          K に要るもの
  def_concatenation_of_tuples                                           concatTuple 等                        なし
  claim_concatenation_commutes_with_replacing_component_of_first_tuple  concatTuple_replaceComponent_first    なし
  claim_concatenation_commutes_with_replacing_component_of_second_tuple concatTuple_replaceComponent_second   なし
  def_map_with_fixed_second_tuple                                       fixSecond                             なし
  claim_fixing_second_tuple_of_multilinear_map_gives_multilinear_map    fixSecond_isMultilinearMap            なし（K の公理を一つも使わない）

本文の番号の書き直しは、具体版と同じ `IndexShift.lean` の `Idx.inFirst`・`Idx.inSecond` を引く。
-/
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.TensorProduct.MultilinearMap
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorAlgebra.IndexShift

namespace CliffordMatrixIsomorphism

namespace NecSuf.VectorSpace

universe u v uK

variable {K : Type uK} [Add K] [Mul K] [One K] {V : Type u} {U : Type v}

/-- 本文 `def_concatenation_of_tuples`：cat_{k,l}(u, u')(s) は、s ≤ k なら u(s)、k + 1 ≤ s なら u'(s - k)。 -/
def concatTuple {k l : ℕ} (u : Tuple V k) (u' : Tuple V l) : Tuple V (k + l) :=
  fun s => if h : s.1 ≤ k then u ⟨s.1, s.2.1, h⟩
    else u' ⟨s.1 - k, by have := s.2; omega, by have := s.2; omega⟩

/-- 本文 `def_concatenation_of_tuples` の一つ目の場合（1 ≤ s ≤ k）。 -/
theorem concatTuple_of_le {k l : ℕ} (u : Tuple V k) (u' : Tuple V l) (s : Idx (k + l))
    (h : s.1 ≤ k) : concatTuple u u' s = u ⟨s.1, s.2.1, h⟩ := by
  unfold concatTuple
  rw [dif_pos h]

/-- 本文 `def_concatenation_of_tuples` の二つ目の場合（k + 1 ≤ s ≤ k + l）。 -/
theorem concatTuple_of_gt {k l : ℕ} (u : Tuple V k) (u' : Tuple V l) (s : Idx (k + l))
    (h : k < s.1) :
    concatTuple u u' s = u' ⟨s.1 - k, by have := s.2; omega, by have := s.2; omega⟩ := by
  unfold concatTuple
  rw [dif_neg (Nat.not_le.mpr h)]

/-- 本文 `claim_concatenation_commutes_with_replacing_component_of_first_tuple`：
cat_{k,l}(u[r ↦ x], u') = cat_{k,l}(u, u')[r ↦ x]。s = r、s ≤ k かつ s ≠ r、s ≥ k + 1 の三つの場合に分ける。 -/
theorem concatTuple_replaceComponent_first {k l : ℕ} (u : Tuple V k) (u' : Tuple V l) (r : Idx k)
    (x : V) :
    concatTuple (replaceComponent u r x) u' = replaceComponent (concatTuple u u') (Idx.inFirst l r) x := by
  funext s
  by_cases hk : s.1 ≤ k
  · by_cases hr : s.1 = r.1
    · -- s = r のとき
      have hs : s = Idx.inFirst l r := Subtype.ext hr
      have hsr : (⟨s.1, s.2.1, hk⟩ : Idx k) = r := Subtype.ext hr
      calc concatTuple (replaceComponent u r x) u' s
          = replaceComponent u r x ⟨s.1, s.2.1, hk⟩ := concatTuple_of_le _ u' s hk
        _ = x := by rw [hsr, replaceComponent_self u r x]
        _ = replaceComponent (concatTuple u u') (Idx.inFirst l r) x s := by
              rw [hs, replaceComponent_self]
    · -- s ≤ k かつ s ≠ r のとき
      have hne : (⟨s.1, s.2.1, hk⟩ : Idx k) ≠ r := fun h => hr (congrArg Subtype.val h)
      have hne' : s ≠ Idx.inFirst l r := fun h => hr (congrArg Subtype.val h)
      calc concatTuple (replaceComponent u r x) u' s
          = replaceComponent u r x ⟨s.1, s.2.1, hk⟩ := concatTuple_of_le _ u' s hk
        _ = u ⟨s.1, s.2.1, hk⟩ := replaceComponent_of_ne u r x _ hne
        _ = concatTuple u u' s := (concatTuple_of_le u u' s hk).symm
        _ = replaceComponent (concatTuple u u') (Idx.inFirst l r) x s :=
              (replaceComponent_of_ne _ _ x s hne').symm
  · -- s ≥ k + 1 のとき（s ≠ r）
    have hgt : k < s.1 := Nat.lt_of_not_le hk
    have hne' : s ≠ Idx.inFirst l r := fun h => by
      have h' : s.1 = r.1 := congrArg Subtype.val h
      have := r.2.2
      omega
    calc concatTuple (replaceComponent u r x) u' s
        = u' ⟨s.1 - k, by have := s.2; omega, by have := s.2; omega⟩ := concatTuple_of_gt _ u' s hgt
      _ = concatTuple u u' s := (concatTuple_of_gt u u' s hgt).symm
      _ = replaceComponent (concatTuple u u') (Idx.inFirst l r) x s :=
            (replaceComponent_of_ne _ _ x s hne').symm

/-- 本文 `claim_concatenation_commutes_with_replacing_component_of_second_tuple`：
cat_{k,l}(u, u'[r ↦ x]) = cat_{k,l}(u, u')[k + r ↦ x]。s = k + r、s ≤ k、s ≥ k + 1 かつ s ≠ k + r の三つの場合に分ける。 -/
theorem concatTuple_replaceComponent_second {k l : ℕ} (u : Tuple V k) (u' : Tuple V l) (r : Idx l)
    (x : V) :
    concatTuple u (replaceComponent u' r x) = replaceComponent (concatTuple u u') (Idx.inSecond k r) x := by
  funext s
  by_cases hk : s.1 ≤ k
  · -- s ≤ k のとき（s ≠ k + r）
    have hne' : s ≠ Idx.inSecond k r := fun h => by
      have h' : s.1 = k + r.1 := congrArg Subtype.val h
      have := r.2.1
      omega
    calc concatTuple u (replaceComponent u' r x) s
        = u ⟨s.1, s.2.1, hk⟩ := concatTuple_of_le u _ s hk
      _ = concatTuple u u' s := (concatTuple_of_le u u' s hk).symm
      _ = replaceComponent (concatTuple u u') (Idx.inSecond k r) x s :=
            (replaceComponent_of_ne _ _ x s hne').symm
  · have hgt : k < s.1 := Nat.lt_of_not_le hk
    by_cases hr : s.1 = k + r.1
    · -- s = k + r のとき
      have hs : s = Idx.inSecond k r := Subtype.ext hr
      have hsr : (⟨s.1 - k, by have := s.2; omega, by have := s.2; omega⟩ : Idx l) = r :=
        Subtype.ext (by show s.1 - k = r.1; omega)
      calc concatTuple u (replaceComponent u' r x) s
          = replaceComponent u' r x ⟨s.1 - k, by have := s.2; omega, by have := s.2; omega⟩ :=
            concatTuple_of_gt u _ s hgt
        _ = replaceComponent u' r x r := by rw [hsr]
        _ = x := replaceComponent_self u' r x
        _ = replaceComponent (concatTuple u u') (Idx.inSecond k r) x s := by
              rw [hs, replaceComponent_self]
    · -- s ≥ k + 1 かつ s ≠ k + r のとき（s - k ≠ r）
      have hne : (⟨s.1 - k, by have := s.2; omega, by have := s.2; omega⟩ : Idx l) ≠ r :=
        fun h => hr (by have h' : s.1 - k = r.1 := congrArg Subtype.val h; omega)
      have hne' : s ≠ Idx.inSecond k r := fun h => hr (congrArg Subtype.val h)
      calc concatTuple u (replaceComponent u' r x) s
          = replaceComponent u' r x ⟨s.1 - k, by have := s.2; omega, by have := s.2; omega⟩ :=
            concatTuple_of_gt u _ s hgt
        _ = u' ⟨s.1 - k, by have := s.2; omega, by have := s.2; omega⟩ := replaceComponent_of_ne u' r x _ hne
        _ = concatTuple u u' s := (concatTuple_of_gt u u' s hgt).symm
        _ = replaceComponent (concatTuple u u') (Idx.inSecond k r) x s :=
              (replaceComponent_of_ne _ _ x s hne').symm

/-- 本文 `def_map_with_fixed_second_tuple`：g_{•,u'}(u) := g(cat_{k,l}(u, u'))。 -/
def fixSecond {k l : ℕ} (g : Tuple V (k + l) → U) (u' : Tuple V l) : Tuple V k → U :=
  fun u => g (concatTuple u u')

/-- 本文 `claim_fixing_second_tuple_of_multilinear_map_gives_multilinear_map`：
k + l 重線型写像 g に後ろの組 u' を固定して入れた写像 g_{•,u'} は k 重線型写像である。 -/
theorem fixSecond_isMultilinearMap {SV : VectorSpace K V} {SU : VectorSpace K U}
    {k l : ℕ} {g : Tuple V (k + l) → U} (hg : IsMultilinearMap SV SU (k + l) g) (u' : Tuple V l) :
    IsMultilinearMap SV SU k (fixSecond g u') where
  map_add u r x y := calc
    fixSecond g u' (replaceComponent u r (SV.add x y))
        = g (concatTuple (replaceComponent u r (SV.add x y)) u') := rfl
    _ = g (replaceComponent (concatTuple u u') (Idx.inFirst l r) (SV.add x y)) := by
          rw [concatTuple_replaceComponent_first]
    _ = SU.add (g (replaceComponent (concatTuple u u') (Idx.inFirst l r) x))
          (g (replaceComponent (concatTuple u u') (Idx.inFirst l r) y)) :=
          hg.map_add (concatTuple u u') (Idx.inFirst l r) x y
    _ = SU.add (g (concatTuple (replaceComponent u r x) u'))
          (g (concatTuple (replaceComponent u r y) u')) := by
          rw [concatTuple_replaceComponent_first, concatTuple_replaceComponent_first]
    _ = SU.add (fixSecond g u' (replaceComponent u r x)) (fixSecond g u' (replaceComponent u r y)) := rfl
  map_smul u r c x := calc
    fixSecond g u' (replaceComponent u r (SV.smul c x))
        = g (concatTuple (replaceComponent u r (SV.smul c x)) u') := rfl
    _ = g (replaceComponent (concatTuple u u') (Idx.inFirst l r) (SV.smul c x)) := by
          rw [concatTuple_replaceComponent_first]
    _ = SU.smul c (g (replaceComponent (concatTuple u u') (Idx.inFirst l r) x)) :=
          hg.map_smul (concatTuple u u') (Idx.inFirst l r) c x
    _ = SU.smul c (g (concatTuple (replaceComponent u r x) u')) := by
          rw [concatTuple_replaceComponent_first]
    _ = SU.smul c (fixSecond g u' (replaceComponent u r x)) := rfl

end NecSuf.VectorSpace

end CliffordMatrixIsomorphism
