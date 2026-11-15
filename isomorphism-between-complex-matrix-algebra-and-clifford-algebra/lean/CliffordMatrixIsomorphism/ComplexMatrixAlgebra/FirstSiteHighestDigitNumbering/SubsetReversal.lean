/-
章「複素行列環」の、部分集合の番号を逆順に付け替える写像 ϱ_M と、番号 1 を最上位の桁にする部分集合全体の番号付け r_M。
人手証明と 1 対 1 に対応させる。ℂ を含まないので、具体版と必要十分版が同じこのファイルを引く（必要十分版・導出版を置かない）。

  本文のラベル                                                                  このファイル
  def_reversal_of_subsets                                                       reversal（ϱ_M）・reversal_subset（右辺が P_M の元であること）
  claim_membership_in_reversed_subset                                           mem_reversal_iff
  claim_reversal_of_subsets_is_involution                                       reversal_reversal
  def_numbering_of_power_set_with_first_site_as_highest_digit                   firstSiteHighestNumbering（r_M）
  claim_numbering_with_first_site_as_highest_digit_is_numbering_of_power_set    firstSiteHighestNumbering_isNumbering

本文の M + 1 - s は ℤ の中の差である。s ∈ T なら s ≤ M なので M + 1 - s ≥ 1 であり、ℕ の差 `M + 1 - s` と同じ値になる。
Lean では ℕ の差で書き、番号の整数の計算（ℕ の加減と順序）は `omega` で行う。
本文の e_M^{-1}（`def_numbering_of_finite_set` の逆写像）は `(binaryNumbering_isNumbering M).inv`、
e(e^{-1}(x)) = x は `IsNumbering.apply_inv` である。
-/
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.PowerSetNumbering.BinaryNumbering

namespace CliffordMatrixIsomorphism.ComplexMatrixAlgebra

/-- 本文 `def_reversal_of_subsets` の後半：s ∈ T なら 1 ≤ s ≤ M なので 1 ≤ M + 1 - s ≤ M であり、
右辺 {M + 1 - s : s ∈ T} は {1,…,M} の部分集合である。 -/
theorem reversal_subset {M : ℕ} (T : PowerSet M) :
    ∀ t : ℕ, t ∈ {t : ℕ | ∃ s : ℕ, s ∈ T.1 ∧ t = M + 1 - s} → 1 ≤ t ∧ t ≤ M := by
  intro t ht
  obtain ⟨s, hs, hts⟩ := ht
  have h := T.2 s hs
  omega

/-- 本文 `def_reversal_of_subsets`：ϱ_M(T) := {M + 1 - s : s ∈ T}。 -/
def reversal (M : ℕ) (T : PowerSet M) : PowerSet M :=
  ⟨{t : ℕ | ∃ s : ℕ, s ∈ T.1 ∧ t = M + 1 - s}, reversal_subset T⟩

/-- 本文 `claim_membership_in_reversed_subset`：t ∈ {1,…,M} について t ∈ ϱ_M(T) ⟺ M + 1 - t ∈ T。 -/
theorem mem_reversal_iff {M : ℕ} (T : PowerSet M) (t : ℕ) (ht1 : 1 ≤ t) (htM : t ≤ M) :
    t ∈ (reversal M T).1 ↔ M + 1 - t ∈ T.1 := by
  constructor
  · -- （⇒）def_reversal_of_subsets により t = M + 1 - s を満たす s ∈ T がある。M + 1 - t = s ∈ T
    intro ht
    obtain ⟨s, hs, hts⟩ := ht
    have h := T.2 s hs
    have hst : M + 1 - t = s := by omega
    rw [hst]
    exact hs
  · -- （⇐）s := M + 1 - t は s ∈ T を満たし、M + 1 - s = t。def_reversal_of_subsets により t ∈ ϱ_M(T)
    intro hs
    exact ⟨M + 1 - t, hs, by omega⟩

/-- 本文 `claim_reversal_of_subsets_is_involution`：ϱ_M(ϱ_M(T)) = T。 -/
theorem reversal_reversal (M : ℕ) (T : PowerSet M) : reversal M (reversal M T) = T := by
  -- 集合の等しさ（def_power_set_of_first_m_positive_integers）を確かめる
  apply PowerSet.ext
  intro t ht1 htM
  -- M + 1 - t ∈ {1,…,M}
  have h1 : 1 ≤ M + 1 - t := by omega
  have h2 : M + 1 - t ≤ M := by omega
  calc t ∈ (reversal M (reversal M T)).1
      -- claim_membership_in_reversed_subset で T → ϱ_M(T)
      ↔ M + 1 - t ∈ (reversal M T).1 := mem_reversal_iff (reversal M T) t ht1 htM
    -- claim_membership_in_reversed_subset で t → M + 1 - t
    _ ↔ M + 1 - (M + 1 - t) ∈ T.1 := mem_reversal_iff T (M + 1 - t) h1 h2
    -- M + 1 - (M + 1 - t) = t
    _ ↔ t ∈ T.1 := by rw [show M + 1 - (M + 1 - t) = t by omega]

/-- 本文 `def_numbering_of_power_set_with_first_site_as_highest_digit`：r_M(k) := ϱ_M(e_M(k))。 -/
def firstSiteHighestNumbering (M : ℕ) (k : Idx (twoPower M)) : PowerSet M :=
  reversal M (binaryNumbering M k)

/-- 本文 `claim_numbering_with_first_site_as_highest_digit_is_numbering_of_power_set`：
(2^M, r_M) は P_M の番号付けである。 -/
theorem firstSiteHighestNumbering_isNumbering (M : ℕ) :
    IsNumbering (twoPower M) (firstSiteHighestNumbering M) := by
  -- (2^M, e_M) は P_M の番号付け（claim_binary_numbering_is_numbering_of_power_set）。e_M^{-1} は he.inv
  have he := binaryNumbering_isNumbering M
  constructor
  · -- 単射の条件
    intro k l hkl
    have h : binaryNumbering M k = binaryNumbering M l := calc
      binaryNumbering M k
          -- claim_reversal_of_subsets_is_involution
          = reversal M (reversal M (binaryNumbering M k)) := (reversal_reversal M _).symm
      -- def_numbering_of_power_set_with_first_site_as_highest_digit
      _ = reversal M (firstSiteHighestNumbering M k) := rfl
      -- r_M(k) = r_M(l)
      _ = reversal M (firstSiteHighestNumbering M l) := by rw [hkl]
      -- def_numbering_of_power_set_with_first_site_as_highest_digit
      _ = reversal M (reversal M (binaryNumbering M l)) := rfl
      -- claim_reversal_of_subsets_is_involution
      _ = binaryNumbering M l := reversal_reversal M _
    -- e_M は単射の条件を満たす（claim_binary_numbering_is_numbering_of_power_set）
    exact he.injective k l h
  · -- 全射の条件：k := e_M^{-1}(ϱ_M(T))
    intro T
    refine ⟨he.inv (reversal M T), ?_⟩
    calc firstSiteHighestNumbering M (he.inv (reversal M T))
        -- def_numbering_of_power_set_with_first_site_as_highest_digit（k の置き方）
        = reversal M (binaryNumbering M (he.inv (reversal M T))) := rfl
      -- def_numbering_of_finite_set の e(e^{-1}(x)) = x
      _ = reversal M (reversal M T) := by rw [he.apply_inv]
      -- claim_reversal_of_subsets_is_involution
      _ = T := reversal_reversal M T

end CliffordMatrixIsomorphism.ComplexMatrixAlgebra
