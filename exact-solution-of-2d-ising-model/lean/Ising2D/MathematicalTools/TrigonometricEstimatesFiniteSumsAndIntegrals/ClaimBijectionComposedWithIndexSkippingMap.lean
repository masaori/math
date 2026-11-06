/-
# 最後の添字へ送られる添字を飛ばしてから全単射で送る写像（**具体版**）

対応する人手証明のラベル: `bijection_composed_with_index_skipping_map_stays_in_lower_indices`,
`def_bijection_composed_with_index_skipping_map`, `bijection_composed_with_index_skipping_map_is_bijective`
（`structured-latex/content/000_calculation_formulae_00_09.ts` の
`calc_formulae_claim_bijection_composed_with_index_skipping_map_stays_in_lower_indices`,
`calc_formulae_definition_bijection_composed_with_index_skipping_map`,
`calc_formulae_claim_bijection_composed_with_index_skipping_map_is_bijective`）。

## 人手証明との対応

* 人手の `m ≥ 1` は Lean の `n + 1` で、`π : {1, …, m+1} → {1, …, m+1}` は `π : Fin (n + 2) → Fin (n + 2)`、
  人手の「全単射」は `Function.Bijective π`（単射 `.1` と全射 `.2`）、人手の `m + 1` は `Fin.last (n + 1)`、`δ^{m}_{k}` は `skipIndex k` である。
* 人手の `{1, …, m} ⊂ {1, …, m+1}` の包含は `Fin.castSucc` である。人手の `τ^{π}_{k}(j) := π(δ^{m}_{k}(j))` は値を `{1, …, m}` の元として読むので、
  Lean では `Fin.castPred`（`castSucc` の逆。`≠ last` の証明を取る）で `Fin (n + 1)` へ戻す。その証明が
  `bijection_comp_skipIndex_ne_last`（人手 `bijection_composed_with_index_skipping_map_stays_in_lower_indices`）である。
  人手の定義の式そのものは、`castSucc` で包含した形の `bijectionCompSkipIndex_castSucc` になる。
* 鎖を人手の行と 1 対 1 の `calc` にした。人手の「`π` は単射なので」「`π` は全射なので」は `hπ.1`・`hπ.2` を当てる 1 行である。
* **必要十分版**: `Ising2D/NecSuf/BijectionComposedWithIndexSkippingMap.lean`。値の範囲の主張と `τ^{π}_{k}` の定義は `π` の単射性しか使わない
  （全射を使うのは全単射性の主張の全射の段だけ）ので、必要十分版はそこを単射の仮定で立てる。具体版は人手どおり `π` を全単射として立て、
  その特殊化として得ることを `ClaimBijectionComposedWithIndexSkippingMapFromNecSuf.lean` に書く。
-/
import Mathlib.Data.Fin.SuccPred
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimIndexSkippingMapProperties

namespace Ising2D

/-- **`bijection_composed_with_index_skipping_map_stays_in_lower_indices`**: `π(k) = m + 1` なら `π(δ^{m}_{k}(j)) ≠ m + 1`
（値は `{1, …, m}` に入る）。 -/
theorem bijection_comp_skipIndex_ne_last {n : ℕ} (π : Fin (n + 2) → Fin (n + 2)) (hπ : Function.Bijective π)
    (k : Fin (n + 2)) (hk : π k = Fin.last (n + 1)) (j : Fin (n + 1)) :
    π (skipIndex k j) ≠ Fin.last (n + 1) := by
  intro h                                                                     -- `π(δ^{m}_{k}(j)) = m+1` と仮定する
  have hππ : π (skipIndex k j) = π k :=
    calc π (skipIndex k j)
        = Fin.last (n + 1) := h                                               -- 仮定
      _ = π k := hk.symm                                                      -- `π(k) = m+1`
  exact skipIndex_ne k j (hπ.1 hππ)                                           -- `π` は単射。`index_skipping_map_never_takes_skipped_index` に反する

/-- **`def_bijection_composed_with_index_skipping_map`**: `τ^{π}_{k}(j) := π(δ^{m}_{k}(j))`（値を `{1, …, m}` の元として読む）。 -/
def bijectionCompSkipIndex {n : ℕ} (π : Fin (n + 2) → Fin (n + 2)) (hπ : Function.Bijective π)
    (k : Fin (n + 2)) (hk : π k = Fin.last (n + 1)) (j : Fin (n + 1)) : Fin (n + 1) :=
  (π (skipIndex k j)).castPred (bijection_comp_skipIndex_ne_last π hπ k hk j)

/-- `def_bijection_composed_with_index_skipping_map` の式（`{1, …, m} ⊂ {1, …, m+1}` の包含 `castSucc` を通した形）。 -/
theorem bijectionCompSkipIndex_castSucc {n : ℕ} (π : Fin (n + 2) → Fin (n + 2)) (hπ : Function.Bijective π)
    (k : Fin (n + 2)) (hk : π k = Fin.last (n + 1)) (j : Fin (n + 1)) :
    (bijectionCompSkipIndex π hπ k hk j).castSucc = π (skipIndex k j) :=
  Fin.castSucc_castPred _ _

/-- **`bijection_composed_with_index_skipping_map_is_bijective`**: `τ^{π}_{k}` は全単射。 -/
theorem bijectionCompSkipIndex_bijective {n : ℕ} (π : Fin (n + 2) → Fin (n + 2)) (hπ : Function.Bijective π)
    (k : Fin (n + 2)) (hk : π k = Fin.last (n + 1)) :
    Function.Bijective (bijectionCompSkipIndex π hπ k hk) := by
  constructor
  · intro j j' hjj'                                                           -- 単射であること
    have hππ : π (skipIndex k j) = π (skipIndex k j') :=
      calc π (skipIndex k j)
          = (bijectionCompSkipIndex π hπ k hk j).castSucc :=
            (bijectionCompSkipIndex_castSucc π hπ k hk j).symm                -- `def_bijection_composed_with_index_skipping_map` を右辺から左辺へ
        _ = (bijectionCompSkipIndex π hπ k hk j').castSucc := by rw [hjj']   -- 仮定
        _ = π (skipIndex k j') := bijectionCompSkipIndex_castSucc π hπ k hk j' -- `def_bijection_composed_with_index_skipping_map`
    exact skipIndex_injective k (hπ.1 hππ)                                    -- `π` は単射、`index_skipping_map_is_injective`
  · intro i                                                                   -- 全射であること
    obtain ⟨p, hp⟩ := hπ.2 i.castSucc                                         -- `π` は全射なので `π(p) = i`
    have hpk : p ≠ k := by
      intro hpk                                                               -- `p = k` と仮定する
      have hi : i.castSucc = Fin.last (n + 1) :=
        calc i.castSucc
            = π p := hp.symm                                                  -- `π(p) = i`
          _ = π k := by rw [hpk]                                              -- `p = k`
          _ = Fin.last (n + 1) := hk                                          -- `π(k) = m+1`
      exact Fin.castSucc_ne_last i hi                                         -- `i ≤ m` に反する
    obtain ⟨j, hj⟩ := skipIndex_reaches_every_other_index k p hpk            -- `index_skipping_map_reaches_every_other_index`
    refine ⟨j, Fin.castSucc_injective _ ?_⟩
    calc (bijectionCompSkipIndex π hπ k hk j).castSucc
        = π (skipIndex k j) := bijectionCompSkipIndex_castSucc π hπ k hk j    -- `def_bijection_composed_with_index_skipping_map`
      _ = π p := by rw [hj]                                                   -- `δ^{m}_{k}(j) = p`
      _ = i.castSucc := hp                                                    -- `π(p) = i`

end Ising2D
