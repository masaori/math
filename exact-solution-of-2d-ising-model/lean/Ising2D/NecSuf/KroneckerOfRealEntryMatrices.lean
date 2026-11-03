/-
# 実数の包含の有限積・成分が実数の行列のクロネッカー積（必要十分版）

具体版:
- `Ising2D/MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimFiniteProductOfRealInclusionsIsReal.lean`（人手 `finite_product_of_real_inclusions_is_real`）
- `Ising2D/MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimKroneckerOfRealEntryMatricesHasRealEntries.lean`（人手 `kronecker_of_real_entry_matrices_has_real_entries`）

具体版をこのファイルの特殊化として得るのは
`Ising2D/MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimKroneckerOfRealEntryMatricesFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `finite_product_of_real_inclusions_is_real` の `0` の場合の 2 段（有限積の定義 → 仮定） | `prod_mem_of_mul_closed` の `0` の場合の 2 段 |
| `m + 1` の場合の 4 段（有限積の定義 → `s` の取り方 → 仮定を `j = m+1` で → `real_inclusion_preserves_product`） | `m + 1` の場合の 2 段（有限積の定義 → 帰納法の仮定と仮定を積で閉じること `hmul` に渡す） |
| `siteProd_hasRealEntries` の 2 段（クロネッカー積の定義 → `r` の取り方） | `kroneckerProdOf_entries_mem` の 2 段 |

## 何が効いているか / 効いていないか

- 「`r_ℂ` の形に書ける」（`ℝ` の像に入る）を、係数の型 `R` の任意の性質 `S` に置き換えた。効いているのは
  **`S` が積で閉じていること**（`hmul`）だけである。`S` を `ℝ` の像に取ると、`hmul` は具体版の `real_inclusion_preserves_product` の段が与える。
  `S` が加法・零元・単位元・符号反転で閉じていることは使わない。
- 具体版の `m + 1` の場合の 2〜4 段目（`s` の取り方 → 仮定を `j = m+1` で → `real_inclusion_preserves_product`）は、ここでは `hmul` を引く 1 段にまとまる。
  具体版で 3 段に分かれているのは、`S` の元を `r_ℂ` と書いて実数 `s`・`r_{m+1}` を取り出す書き方のためで、手順（定義で積を割り、帰納法の仮定と仮定を積で閉じることに渡す）は同じである。
- 係数の型 `R` に置いた `CommMonoid` は `Finset.prod` が要求するもので、積の可換性・結合性・単位元は鎖のどの段でも**引いていない**
  （有限積を 1 個の元と、`m` 個の積に右から掛けたものに読む `Fin.prod_univ_one`・`Fin.prod_univ_castSucc` の 2 つだけを使う）。
- 有限積の添字が `Fin (m + 1)` であること（`1` 個以上）は効いている。`0` 個の積は単位元で、`S` が単位元を含むとは仮定していないので、
  `m = 0` から始める主張は `hmul` だけでは示せない（具体版でも人手でも `m ≥ 1`）。
- クロネッカー積の主張では、因子の添字 `α`・`β` は任意の型で、**正方であることも 2 次であることも効いていない**。
-/
import Mathlib.Algebra.BigOperators.Fin
import Ising2D.NecSuf.KroneckerTranspose

namespace Ising2D.NecSuf

variable {R : Type*} [CommMonoid R]

/-- **有限積は、積で閉じた性質を保つ**（具体版 `finite_product_of_real_inclusions_is_real`）。 -/
theorem prod_mem_of_mul_closed (S : R → Prop) (hmul : ∀ a b, S a → S b → S (a * b)) :
    ∀ (m : ℕ) (z : Fin (m + 1) → R), (∀ j, S (z j)) → S (∏ j, z j)
  | 0, z, hz => by
    have h : ∏ j, z j = z 0 := Fin.prod_univ_one z                            -- 有限積の定義
    rw [h]
    exact hz 0                                                               -- 仮定を `j = 1` で
  | m + 1, z, hz => by
    have h : ∏ j, z j = (∏ j : Fin (m + 1), z (Fin.castSucc j)) * z (Fin.last (m + 1)) :=
      Fin.prod_univ_castSucc z                                               -- 有限積の定義
    rw [h]
    exact hmul _ _ (prod_mem_of_mul_closed S hmul m (fun j => z (Fin.castSucc j)) (fun j => hz _))
      (hz (Fin.last (m + 1)))                                                -- 帰納法の仮定と仮定を、積で閉じること `hmul` に

/-- **因子の成分がすべて `S` に入るなら、クロネッカー積の成分もすべて `S` に入る**
（具体版 `siteProd_hasRealEntries`）。 -/
theorem kroneckerProdOf_entries_mem {α β : Type*} (S : R → Prop) (hmul : ∀ a b, S a → S b → S (a * b))
    {r : ℕ} (x : Fin (r + 1) → Matrix α β R) (hx : ∀ k p q, S (x k p q)) :
    ∀ s t, S (kroneckerProdOf x s t) := by
  intro s t
  have h : kroneckerProdOf x s t = ∏ k, x k (s k) (t k) := rfl               -- クロネッカー積の定義
  rw [h]
  exact prod_mem_of_mul_closed S hmul r (fun k => x k (s k) (t k)) (fun k => hx k (s k) (t k))
                                                                             -- `r` の取り方（有限積が `S` に入る）

end Ising2D.NecSuf
