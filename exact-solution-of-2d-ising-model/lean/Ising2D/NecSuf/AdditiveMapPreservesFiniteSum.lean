/-
# 和を保つ写像は、左から足す有限和を保つ（必要十分版）

対応する人手証明のラベル: `real_inclusion_preserves_finite_sum`
具体版: `Ising2D/MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimRealInclusionPreservesFiniteSum.lean` の
`real_inclusion_of_finite_sum_succ`（具体版をこのファイルの系として導くのは、同じフォルダの
`ClaimRealInclusionPreservesFiniteSumFromNecSuf.lean`）。

人手の `ι_{ℝ→ℂ}` を、2 つの集合の間の写像 `f : G → H` に置き換える。有限和は `finSumLeft`
（`Ising2D/NecSuf/AdditiveToMultiplicativeMapOfFiniteSum.lean`。人手の `m ∈ ℤ_{≥1}` は Lean の `r + 1`、
`def_finite_sum_of_real_numbers`・`def_finite_sum_of_complex_numbers` の 2 つの式がそのまま 2 つの節）である。

## 何が効いているか / 効いていないか

| 人手の段 | 具体版の段 | 必要十分版の段 | 効いている仮定 |
| --- | --- | --- | --- |
| `m = 1` の 2 行 | ℂ の和の定義 → ℝ の和の定義 | `map_finSumLeft_of_map_add'` の `0` の節（同じ 2 段） | 和の定義の `Σ_{j=1}^{1} x_j := x_1`（両側） |
| 帰納法の段の 7 行 | ℂ の和の定義 → 帰納法の仮定 → 包含を各項へ・ℂ の和・ℝ の和の定義・`0 + 0 = 0`・包含 | `r + 1` の節（和の定義 → 帰納法の仮定 → `f(a) + f(b) = f(a + b)` → 和の定義） | 和の定義の `Σ_{j=1}^{m+1} x_j := (Σ_{j=1}^{m} x_j) + x_{m+1}`（両側）、`f(a + b) = f(a) + f(b)`（仮定 `hadd`） |

- 具体版の帰納法の段の 3・4・6・7 行（包含を各項へ → ℂ の和 → `0 + 0 = 0` → 包含）は、`ι_{ℝ→ℂ}` が和を保つこと
  （人手 `real_inclusion_preserves_sum`）をその場で計算したもので、必要十分版では仮定 `hadd` の 1 段に当たる。
  具体版の 5 行目（ℝ の和の定義）は、必要十分版の最後の段（和の定義を右辺から左辺へ）に当たる。
  具体版では 5 行目が 6・7 行目より前にあるが、必要十分版では `hadd` の後に来る。`f` の値の成分（実部・虚部）が見えないので、
  `hadd` を具体版の 3・4 行目と 6・7 行目に分けられないためで、証明の手順（帰納法と各段の根拠）は同じである。
- **効いていないもの**: `ℝ`・`ℂ` であること、乗法、加法の結合則・可換則・単位元・逆元、`f(0) = 0`
  （和は空でなく、左から順に畳み込むので、`0` も並べ替えも括弧の付け替えも現れない）、`f` が単射であること。
- 仮定 `hadd` は削れない: `ℝ` 上の `f(x) = x + 1` では `f(1 + 1) = 3` だが `f(1) + f(1) = 4` である。
-/
import Ising2D.NecSuf.AdditiveToMultiplicativeMapOfFiniteSum

namespace Ising2D.NecSuf

/-- **必要十分版の `real_inclusion_preserves_finite_sum`**: `f(a + b) = f(a) + f(b)` を満たす写像は、
空でない有限和を保つ: `Σ_j f(x_j) = f(Σ_j x_j)`。具体版 `real_inclusion_of_finite_sum_succ` と同じく項の個数についての帰納法。 -/
theorem map_finSumLeft_of_map_add' {G H : Type*} [Add G] [Add H]
    (f : G → H) (hadd : ∀ a b, f (a + b) = f a + f b) :
    ∀ (r : ℕ) (x : Fin (r + 1) → G), finSumLeft r (fun j => f (x j)) = f (finSumLeft r x)
  | 0, x =>
    calc finSumLeft 0 (fun j => f (x j))
        = f (x 0) := finSumLeft_zero _                                          -- 和の定義（`H` の側）
      _ = f (finSumLeft 0 x) := by rw [finSumLeft_zero]                         -- 和の定義（`G` の側）
  | r + 1, x =>
    calc finSumLeft (r + 1) (fun j => f (x j))
        = finSumLeft r (fun j => f (x (Fin.castSucc j))) + f (x (Fin.last (r + 1))) :=
          finSumLeft_succ r _                                                   -- 和の定義（`H` の側）
      _ = f (finSumLeft r (fun j => x (Fin.castSucc j))) + f (x (Fin.last (r + 1))) := by
          rw [map_finSumLeft_of_map_add' f hadd r]                              -- 帰納法の仮定
      _ = f (finSumLeft r (fun j => x (Fin.castSucc j)) + x (Fin.last (r + 1))) :=
          (hadd _ _).symm                                                       -- `f(a + b) = f(a) + f(b)` を右辺から左辺へ
      _ = f (finSumLeft (r + 1) x) := by rw [finSumLeft_succ]                   -- 和の定義（`G` の側）を右辺から左辺へ

end Ising2D.NecSuf
