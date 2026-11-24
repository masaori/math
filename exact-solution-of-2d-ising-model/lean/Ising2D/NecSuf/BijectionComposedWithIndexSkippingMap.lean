/-
# 最後の添字へ送られる添字を飛ばしてから単射で送る写像（**必要十分版**）

対応する人手証明のラベル: `bijection_composed_with_index_skipping_map_stays_in_lower_indices`,
`def_bijection_composed_with_index_skipping_map`, `bijection_composed_with_index_skipping_map_is_bijective`
（具体版は `Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimBijectionComposedWithIndexSkippingMap.lean`）。
具体版をこの系として導くのは同じフォルダの `ClaimBijectionComposedWithIndexSkippingMapFromNecSuf.lean`。

## 何が効いているか / 効いていないか

| 具体版（`π` は全単射） | 必要十分版 | 仮定 |
| --- | --- | --- |
| `bijection_comp_skipIndex_ne_last` | `comp_skipIndex_ne_last`（同じ鎖） | `π` は単射、`π(k) = m+1` |
| `bijectionCompSkipIndex` | `compSkipIndex` | `π` は単射、`π(k) = m+1` |
| `bijectionCompSkipIndex_bijective` | `compSkipIndex_bijective`（同じ鎖） | `π` は全単射、`π(k) = m+1` |

* 値が `{1, …, m}` に入ることと `τ^{π}_{k}` の定義には、`π` の単射性（`δ^{m}_{k}(j) = k` を引き出す 1 行）しか効いていない。全射性は効いていない。
* 全単射性の主張は、単射の段で `π` の単射性を、全射の段で `π` の全射性を使う。`Fin (n + 2)` の上では単射から全射が従うが、
  それは鳩の巣原理による別の論法なので、具体版と同じ手順を保つために全射性を仮定に残す（README 4 節の要件 1）。
* 添字の集合は人手どおり `Fin` で、係数の環は現れない。
* 添字を飛ばす写像とその性質は `Ising2D/NecSuf/IndexSkippingMap.lean` の
  `skipIndex'`・`skipIndex'_ne`・`skipIndex'_injective`・`skipIndex'_reaches_every_other_index` を使う。
-/
import Mathlib.Data.Fin.SuccPred
import Ising2D.NecSuf.IndexSkippingMap

namespace Ising2D.NecSuf

/-- 値の範囲（具体版 `bijection_comp_skipIndex_ne_last`）。`π` は単射だけを仮定する。 -/
theorem comp_skipIndex_ne_last {n : ℕ} (π : Fin (n + 2) → Fin (n + 2)) (hπ : Function.Injective π)
    (k : Fin (n + 2)) (hk : π k = Fin.last (n + 1)) (j : Fin (n + 1)) :
    π (skipIndex' k j) ≠ Fin.last (n + 1) := by
  intro h                                                                     -- `π(δ^{m}_{k}(j)) = m+1` と仮定する
  have hππ : π (skipIndex' k j) = π k :=
    calc π (skipIndex' k j)
        = Fin.last (n + 1) := h                                               -- 仮定
      _ = π k := hk.symm                                                      -- `π(k) = m+1`
  exact skipIndex'_ne k j (hπ hππ)                                            -- `π` は単射。`δ^{m}_{k}(j) ≠ k` に反する

/-- `τ^{π}_{k}(j) := π(δ^{m}_{k}(j))`（具体版 `bijectionCompSkipIndex`）。`π` は単射だけを仮定する。 -/
def compSkipIndex {n : ℕ} (π : Fin (n + 2) → Fin (n + 2)) (hπ : Function.Injective π)
    (k : Fin (n + 2)) (hk : π k = Fin.last (n + 1)) (j : Fin (n + 1)) : Fin (n + 1) :=
  (π (skipIndex' k j)).castPred (comp_skipIndex_ne_last π hπ k hk j)

/-- 定義の式（`castSucc` を通した形。具体版 `bijectionCompSkipIndex_castSucc`）。 -/
theorem compSkipIndex_castSucc {n : ℕ} (π : Fin (n + 2) → Fin (n + 2)) (hπ : Function.Injective π)
    (k : Fin (n + 2)) (hk : π k = Fin.last (n + 1)) (j : Fin (n + 1)) :
    (compSkipIndex π hπ k hk j).castSucc = π (skipIndex' k j) :=
  Fin.castSucc_castPred _ _

/-- 全単射性（具体版 `bijectionCompSkipIndex_bijective`）。具体版と同じ単射の段と全射の段。 -/
theorem compSkipIndex_bijective {n : ℕ} (π : Fin (n + 2) → Fin (n + 2)) (hπ : Function.Bijective π)
    (k : Fin (n + 2)) (hk : π k = Fin.last (n + 1)) :
    Function.Bijective (compSkipIndex π hπ.1 k hk) := by
  constructor
  · intro j j' hjj'                                                           -- 単射であること
    have hππ : π (skipIndex' k j) = π (skipIndex' k j') :=
      calc π (skipIndex' k j)
          = (compSkipIndex π hπ.1 k hk j).castSucc :=
            (compSkipIndex_castSucc π hπ.1 k hk j).symm                       -- 定義を右辺から左辺へ
        _ = (compSkipIndex π hπ.1 k hk j').castSucc := by rw [hjj']          -- 仮定
        _ = π (skipIndex' k j') := compSkipIndex_castSucc π hπ.1 k hk j' -- 定義
    exact skipIndex'_injective k (hπ.1 hππ)                                   -- `π` は単射、`δ^{m}_{k}` は単射
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
    obtain ⟨j, hj⟩ := skipIndex'_reaches_every_other_index k p hpk           -- `δ^{m}_{k}` は `k` 以外のすべてを値に取る
    refine ⟨j, Fin.castSucc_injective _ ?_⟩
    calc (compSkipIndex π hπ.1 k hk j).castSucc
        = π (skipIndex' k j) := compSkipIndex_castSucc π hπ.1 k hk j          -- 定義
      _ = π p := by rw [hj]                                                   -- `δ^{m}_{k}(j) = p`
      _ = i.castSucc := hp                                                    -- `π(p) = i`

end Ising2D.NecSuf
