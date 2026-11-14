/-
章「複素行列環」の、{1,…,M} の部分集合全体の集合 P_M の 2 進の番号付け。人手証明と 1 対 1 に対応させる。
ℂ を含まないので、具体版と必要十分版が同じこのファイルを引く（必要十分版・導出版を置かない）。

  本文のラベル                                         このファイル
  def_binary_numbering_of_power_set                    twoPower（2^M）・twoPower_succ（2^M = 2^{M-1} + 2^{M-1}）・
                                                       one_le_twoPower（2^M ≥ 1）・binaryNumbering（e_M）・
                                                       binaryNumbering_succ_of_le・binaryNumbering_succ_of_gt（e_M の二つの場合）
  claim_binary_numbering_is_numbering_of_power_set     not_mem_binaryNumbering_succ_of_le（（ア））・
                                                       mem_binaryNumbering_succ_of_gt（（イ））・
                                                       mem_binaryNumbering_succ_iff_of_gt（（ウ））・
                                                       binaryNumbering_isNumbering・isFiniteSet_powerSet

Lean の帰納的定義は M + 1 の段を M の段から作るので、本文の e_{M-1}・2^{M-1}・{1,…,M-1} は
e_M・2^M・{1,…,M} と読み、本文の e_M・{M} は e_{M+1}・{M+1} と読む。
本文の h := 2^{M-1} は `twoPower M` である。番号の整数の計算（ℕ の加減と順序）は `omega` で行う。
本文の k - 2^{M-1}（ℤ の中の差）は、k > 2^{M-1} の場合にだけ使うので ℕ の差 `k - twoPower M` で書く。
-/
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.PowerSetNumbering.PowerSet
import CliffordMatrixIsomorphism.MathematicalToolkit.FiniteSetSum.Numbering

namespace CliffordMatrixIsomorphism.ComplexMatrixAlgebra

/-- 本文 `def_binary_numbering_of_power_set`：2^0 := 1、2^M := 2 · 2^{M-1}。 -/
def twoPower : ℕ → ℕ
  | 0 => 1
  | M + 1 => 2 * twoPower M

/-- 本文 `def_binary_numbering_of_power_set` の中の 2^M = 2^{M-1} + 2^{M-1}。 -/
theorem twoPower_succ (M : ℕ) : twoPower (M + 1) = twoPower M + twoPower M := by
  show 2 * twoPower M = twoPower M + twoPower M
  omega

/-- 本文 `def_binary_numbering_of_power_set`：2^M ∈ ℤ_{≥1}。 -/
theorem one_le_twoPower : ∀ M : ℕ, 1 ≤ twoPower M
  | 0 => le_refl 1
  | M + 1 => by
    have h := one_le_twoPower M
    rw [twoPower_succ]
    omega

/-- 本文 `def_binary_numbering_of_power_set`：1 ≤ k ≤ 2^{M-1} なら e_{M-1}(k) ⊆ {1,…,M-1} ⊆ {1,…,M}。 -/
theorem subset_of_powerSet_succ {M : ℕ} (S : PowerSet M) :
    ∀ t : ℕ, t ∈ S.1 → 1 ≤ t ∧ t ≤ M + 1 :=
  fun t ht => ⟨(S.2 t ht).1, Nat.le_succ_of_le (S.2 t ht).2⟩

/-- 本文 `def_binary_numbering_of_power_set`：e_{M-1}(k - 2^{M-1}) ⊆ {1,…,M-1} かつ {M} ⊆ {1,…,M} なので、
e_{M-1}(k - 2^{M-1}) ∪ {M} ⊆ {1,…,M}。 -/
theorem union_singleton_subset_of_powerSet_succ {M : ℕ} (S : PowerSet M) :
    ∀ t : ℕ, t ∈ S.1 ∪ {M + 1} → 1 ≤ t ∧ t ≤ M + 1 := by
  intro t ht
  rcases ht with hS | hM
  · exact subset_of_powerSet_succ S t hS
  · have hM' : t = M + 1 := hM
    omega

/-- 本文 `def_binary_numbering_of_power_set`：2^{M-1} < k ≤ 2^M なら k - 2^{M-1} ∈ {1,…,2^{M-1}}。 -/
theorem sub_twoPower_mem {M : ℕ} (k : Idx (twoPower (M + 1))) (hk : ¬ k.1 ≤ twoPower M) :
    1 ≤ k.1 - twoPower M ∧ k.1 - twoPower M ≤ twoPower M := by
  have h2 : k.1 ≤ twoPower M + twoPower M := (twoPower_succ M) ▸ k.2.2
  omega

/-- 本文 `def_binary_numbering_of_power_set`：e_M : {1,…,2^M} → P_M。
e_0(1) := ∅。M + 1 の段では k ≤ 2^M なら e_{M+1}(k) := e_M(k)、k > 2^M なら e_{M+1}(k) := e_M(k - 2^M) ∪ {M+1}。 -/
def binaryNumbering : (M : ℕ) → Idx (twoPower M) → PowerSet M
  | 0 => fun _ => ⟨∅, fun _ ht => False.elim ht⟩
  | M + 1 => fun k =>
    if hk : k.1 ≤ twoPower M then
      ⟨(binaryNumbering M ⟨k.1, k.2.1, hk⟩).1,
        subset_of_powerSet_succ (binaryNumbering M ⟨k.1, k.2.1, hk⟩)⟩
    else
      ⟨(binaryNumbering M ⟨k.1 - twoPower M, sub_twoPower_mem k hk⟩).1 ∪ {M + 1},
        union_singleton_subset_of_powerSet_succ (binaryNumbering M ⟨k.1 - twoPower M, sub_twoPower_mem k hk⟩)⟩

/-- 本文 `def_binary_numbering_of_power_set` の e_M(k) := e_{M-1}(k)（k ≤ 2^{M-1}）。 -/
theorem binaryNumbering_succ_of_le (M : ℕ) (k : Idx (twoPower (M + 1))) (hk : k.1 ≤ twoPower M) :
    (binaryNumbering (M + 1) k).1 = (binaryNumbering M ⟨k.1, k.2.1, hk⟩).1 := by
  simp only [binaryNumbering, dif_pos hk]

/-- 本文 `def_binary_numbering_of_power_set` の e_M(k) := e_{M-1}(k - 2^{M-1}) ∪ {M}（k > 2^{M-1}）。 -/
theorem binaryNumbering_succ_of_gt (M : ℕ) (k : Idx (twoPower (M + 1))) (hk : ¬ k.1 ≤ twoPower M) :
    (binaryNumbering (M + 1) k).1
      = (binaryNumbering M ⟨k.1 - twoPower M, sub_twoPower_mem k hk⟩).1 ∪ {M + 1} := by
  simp only [binaryNumbering, dif_neg hk]

/-- 本文 `claim_binary_numbering_is_numbering_of_power_set` の（ア）：k ≤ h なら M ∉ e_M(k)。 -/
theorem not_mem_binaryNumbering_succ_of_le (M : ℕ) (k : Idx (twoPower (M + 1)))
    (hk : k.1 ≤ twoPower M) : M + 1 ∉ (binaryNumbering (M + 1) k).1 := by
  -- e_M(k) = e_{M-1}(k) ⊆ {1,…,M-1} であり、M ∉ {1,…,M-1}
  rw [binaryNumbering_succ_of_le M k hk]
  intro hM
  have h := ((binaryNumbering M ⟨k.1, k.2.1, hk⟩).2 (M + 1) hM).2
  omega

/-- 本文 `claim_binary_numbering_is_numbering_of_power_set` の（イ）：k > h なら M ∈ e_M(k)。 -/
theorem mem_binaryNumbering_succ_of_gt (M : ℕ) (k : Idx (twoPower (M + 1)))
    (hk : ¬ k.1 ≤ twoPower M) : M + 1 ∈ (binaryNumbering (M + 1) k).1 := by
  -- e_M(k) = e_{M-1}(k - h) ∪ {M} であり、M ∈ {M}
  rw [binaryNumbering_succ_of_gt M k hk]
  exact Or.inr rfl

/-- 本文 `claim_binary_numbering_is_numbering_of_power_set` の（ウ）：k > h なら、
すべての t ∈ {1,…,M-1} について t ∈ e_M(k) ⟺ t ∈ e_{M-1}(k - h)。 -/
theorem mem_binaryNumbering_succ_iff_of_gt (M : ℕ) (k : Idx (twoPower (M + 1)))
    (hk : ¬ k.1 ≤ twoPower M) (t : ℕ) (ht : t ≤ M) :
    t ∈ (binaryNumbering (M + 1) k).1
      ↔ t ∈ (binaryNumbering M ⟨k.1 - twoPower M, sub_twoPower_mem k hk⟩).1 :=
  calc t ∈ (binaryNumbering (M + 1) k).1
      -- e_M の定義（k > h の場合）
      ↔ t ∈ (binaryNumbering M ⟨k.1 - twoPower M, sub_twoPower_mem k hk⟩).1 ∪ {M + 1} := by
        rw [binaryNumbering_succ_of_gt M k hk]
    -- 和集合の定義
    _ ↔ (t ∈ (binaryNumbering M ⟨k.1 - twoPower M, sub_twoPower_mem k hk⟩).1 ∨ t ∈ ({M + 1} : Set ℕ)) :=
        Iff.rfl
    -- {M} の定義
    _ ↔ (t ∈ (binaryNumbering M ⟨k.1 - twoPower M, sub_twoPower_mem k hk⟩).1 ∨ t = M + 1) := Iff.rfl
    -- t ≤ M - 1 < M なので t ≠ M
    _ ↔ t ∈ (binaryNumbering M ⟨k.1 - twoPower M, sub_twoPower_mem k hk⟩).1 :=
        or_iff_left (by omega)

/-- 本文 `claim_binary_numbering_is_numbering_of_power_set`：(2^M, e_M) は P_M の番号付けである。 -/
theorem binaryNumbering_isNumbering : ∀ M : ℕ, IsNumbering (twoPower M) (binaryNumbering M)
  | 0 => by
    constructor
    · -- 単射の条件：k, l ∈ {1} なら k = 1 = l
      intro k l _
      have h1 : k.1 = 1 := le_antisymm k.2.2 k.2.1
      have h2 : l.1 = 1 := le_antisymm l.2.2 l.2.1
      exact Subtype.ext (h1.trans h2.symm)
    · -- 全射の条件：{1,…,0} は空集合なので T = ∅ = e_0(1)
      intro T
      refine ⟨⟨1, le_refl 1, le_refl 1⟩, ?_⟩
      apply PowerSet.ext
      intro t ht1 ht0
      omega
  | M + 1 => by
    -- 帰納法の仮定
    have ih := binaryNumbering_isNumbering M
    constructor
    · -- 単射の条件
      intro k l hkl
      -- M ∈ e_M(k) と M ∈ e_M(l) は同値
      have hMiff : M + 1 ∈ (binaryNumbering (M + 1) k).1 ↔ M + 1 ∈ (binaryNumbering (M + 1) l).1 := by
        rw [hkl]
      by_cases hk : k.1 ≤ twoPower M
      · by_cases hl : l.1 ≤ twoPower M
        · -- k ≤ h かつ l ≤ h：e_{M-1}(k) = e_M(k) = e_M(l) = e_{M-1}(l)
          have he : binaryNumbering M ⟨k.1, k.2.1, hk⟩ = binaryNumbering M ⟨l.1, l.2.1, hl⟩ :=
            Subtype.ext (calc
              (binaryNumbering M ⟨k.1, k.2.1, hk⟩).1 = (binaryNumbering (M + 1) k).1 :=
                  (binaryNumbering_succ_of_le M k hk).symm
              _ = (binaryNumbering (M + 1) l).1 := by rw [hkl]
              _ = (binaryNumbering M ⟨l.1, l.2.1, hl⟩).1 := binaryNumbering_succ_of_le M l hl)
          -- 帰納法の仮定の単射の条件から k = l
          have hkl' : (⟨k.1, k.2.1, hk⟩ : Idx (twoPower M)) = ⟨l.1, l.2.1, hl⟩ := ih.injective _ _ he
          have hkl'' : k.1 = l.1 := by
            have h := congrArg Subtype.val hkl'
            exact h
          exact Subtype.ext hkl''
        · -- k ≤ h かつ l > h：（ア）と（イ）が同値に反する
          exact absurd (hMiff.mpr (mem_binaryNumbering_succ_of_gt M l hl))
            (not_mem_binaryNumbering_succ_of_le M k hk)
      · by_cases hl : l.1 ≤ twoPower M
        · -- k > h かつ l ≤ h：k と l を入れ替えた同じ理由
          exact absurd (hMiff.mp (mem_binaryNumbering_succ_of_gt M k hk))
            (not_mem_binaryNumbering_succ_of_le M l hl)
        · -- k > h かつ l > h：すべての t ∈ {1,…,M-1} で t ∈ e_{M-1}(k-h) ⟺ t ∈ e_{M-1}(l-h)
          have he : binaryNumbering M ⟨k.1 - twoPower M, sub_twoPower_mem k hk⟩
              = binaryNumbering M ⟨l.1 - twoPower M, sub_twoPower_mem l hl⟩ := by
            apply PowerSet.ext
            intro t _ htM
            calc t ∈ (binaryNumbering M ⟨k.1 - twoPower M, sub_twoPower_mem k hk⟩).1
                -- （ウ）を k に適用
                ↔ t ∈ (binaryNumbering (M + 1) k).1 :=
                  (mem_binaryNumbering_succ_iff_of_gt M k hk t htM).symm
              -- e_M(k) = e_M(l)
              _ ↔ t ∈ (binaryNumbering (M + 1) l).1 := by rw [hkl]
              -- （ウ）を l に適用
              _ ↔ t ∈ (binaryNumbering M ⟨l.1 - twoPower M, sub_twoPower_mem l hl⟩).1 :=
                  mem_binaryNumbering_succ_iff_of_gt M l hl t htM
          -- 帰納法の仮定の単射の条件から k - h = l - h、すなわち k = l
          have hsub : k.1 - twoPower M = l.1 - twoPower M :=
            congrArg Subtype.val (ih.injective _ _ he)
          exact Subtype.ext (by omega)
    · -- 全射の条件
      intro T
      -- T' := {t ∈ {1,…,M-1} : t ∈ T} ∈ P_{M-1}
      let T' : PowerSet M := ⟨{t : ℕ | (1 ≤ t ∧ t ≤ M) ∧ t ∈ T.1}, fun _ ht => ht.1⟩
      -- e_{M-1}(j) = T' を満たす j ∈ {1,…,h}
      obtain ⟨j, hj⟩ := ih.surjective T'
      -- すべての t ∈ {1,…,M-1} で t ∈ T' ⟺ t ∈ T
      have hT' : ∀ t : ℕ, 1 ≤ t → t ≤ M → (t ∈ T'.1 ↔ t ∈ T.1) :=
        fun t ht1 htM => ⟨fun h => h.2, fun h => ⟨⟨ht1, htM⟩, h⟩⟩
      have h2 : twoPower (M + 1) = twoPower M + twoPower M := twoPower_succ M
      by_cases hMT : M + 1 ∈ T.1
      · -- M ∈ T のとき、k := j + h
        have hk1 : 1 ≤ j.1 + twoPower M := by have := j.2.1; omega
        have hk2 : j.1 + twoPower M ≤ twoPower (M + 1) := by have := j.2.2; omega
        let k : Idx (twoPower (M + 1)) := ⟨j.1 + twoPower M, hk1, hk2⟩
        have hk : ¬ k.1 ≤ twoPower M := by have := j.2.1; show ¬ j.1 + twoPower M ≤ twoPower M; omega
        -- k - h = j
        have hkj : (⟨k.1 - twoPower M, sub_twoPower_mem k hk⟩ : Idx (twoPower M)) = j :=
          Subtype.ext (by show j.1 + twoPower M - twoPower M = j.1; omega)
        refine ⟨k, ?_⟩
        apply PowerSet.ext
        intro t ht1 ht2
        by_cases htM : t ≤ M
        · -- t ∈ {1,…,M-1}：（ウ）から t ∈ e_M(k) ⟺ t ∈ e_{M-1}(j) ⟺ t ∈ T' ⟺ t ∈ T
          calc t ∈ (binaryNumbering (M + 1) k).1
              ↔ t ∈ (binaryNumbering M ⟨k.1 - twoPower M, sub_twoPower_mem k hk⟩).1 :=
                mem_binaryNumbering_succ_iff_of_gt M k hk t htM
            _ ↔ t ∈ (binaryNumbering M j).1 := by rw [hkj]
            _ ↔ t ∈ T'.1 := by rw [hj]
            _ ↔ t ∈ T.1 := hT' t ht1 htM
        · -- t = M：（イ）から M ∈ e_M(k)、仮定から M ∈ T
          have htM' : t = M + 1 := by omega
          rw [htM']
          exact ⟨fun _ => hMT, fun _ => mem_binaryNumbering_succ_of_gt M k hk⟩
      · -- M ∉ T のとき、k := j
        have hk2 : j.1 ≤ twoPower (M + 1) := by have := j.2.2; omega
        let k : Idx (twoPower (M + 1)) := ⟨j.1, j.2.1, hk2⟩
        have hk : k.1 ≤ twoPower M := j.2.2
        refine ⟨k, ?_⟩
        apply PowerSet.ext
        intro t ht1 ht2
        by_cases htM : t ≤ M
        · -- t ∈ {1,…,M-1}：t ∈ e_M(k) ⟺ t ∈ T' ⟺ t ∈ T（e_M(k) = e_{M-1}(j) = T'）
          calc t ∈ (binaryNumbering (M + 1) k).1
              ↔ t ∈ (binaryNumbering M ⟨k.1, k.2.1, hk⟩).1 := by
                rw [binaryNumbering_succ_of_le M k hk]
            _ ↔ t ∈ (binaryNumbering M j).1 := Iff.rfl
            _ ↔ t ∈ T'.1 := by rw [hj]
            _ ↔ t ∈ T.1 := hT' t ht1 htM
        · -- t = M：（ア）から M ∉ e_M(k)、仮定から M ∉ T
          have htM' : t = M + 1 := by omega
          rw [htM']
          exact ⟨fun h => absurd h (not_mem_binaryNumbering_succ_of_le M k hk),
            fun h => absurd h hMT⟩

/-- 本文 `claim_binary_numbering_is_numbering_of_power_set`：P_M は有限集合である。 -/
theorem isFiniteSet_powerSet (M : ℕ) : IsFiniteSet (PowerSet M) :=
  ⟨twoPower M, binaryNumbering M, binaryNumbering_isNumbering M⟩

end CliffordMatrixIsomorphism.ComplexMatrixAlgebra
