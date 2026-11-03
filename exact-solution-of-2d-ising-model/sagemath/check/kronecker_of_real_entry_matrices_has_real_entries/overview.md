# SageMath Check: kronecker_of_real_entry_matrices_has_real_entries

## 対象

**対象ラベル**: `kronecker_of_real_entry_matrices_has_real_entries`

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_kronecker_of_real_entry_matrices_has_real_entries`（成分がすべて実数の行列のクロネッカー積は成分がすべて実数）
- 範囲: 主張と、成分の 2 行の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 成分の鎖の 2 行（`def_kronecker` → `r` の取り方） | `check_entry_chain.sage` | 因子の成分を実数の不定元に置き、クロネッカー積を `def_kronecker` の成分の式で組んで Sage の `tensor_product` との一致を見てから、全成分が `r := ∏_k r_k` の包含であること（虚部 0）を確かめる。対照 1 件: 純虚数の成分を持つ `σ^y` を因子に含むと実数でない成分が出る | **PASS** | `M = 1..4` の全成分（340 個） |

## 計算の帰属と範囲

- **厳密**: `QQ(i)[a_{k,p,q}]` の多項式の等号で確かめた。浮動小数点はない。
- 一般の `M` は、`finite_product_of_real_inclusions_is_real` の帰納法と、成分の式の当てはめが担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh kronecker_of_real_entry_matrices_has_real_entries
```

実行ログは `logs/` に保存する。
