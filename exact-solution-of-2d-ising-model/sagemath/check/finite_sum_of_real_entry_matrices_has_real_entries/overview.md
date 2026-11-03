# SageMath Check: finite_sum_of_real_entry_matrices_has_real_entries

## 対象

**対象ラベル**: `finite_sum_of_real_entry_matrices_has_real_entries`

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_finite_sum_of_real_entry_matrices_has_real_entries`（成分がすべて実数の行列の有限和は成分がすべて実数）
- 範囲: 帰納法の `r = 1` の段と帰納法の段

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `r = 1` と帰納法の段 | `check_induction.sage` | `Σ_{j=1}^{1} X_j = X_1` と `Σ_{j=1}^{r+1} X_j = (Σ_{j=1}^{r} X_j) + X_{r+1}`（`def_finite_sum_of_matrices`、左から足す和）と、帰納法の仮定・仮定・結論の成分の虚部が 0 であることを、`X_j` の成分を `QQ` 上の不定元にして `r = 1..5`、`m, n = 1..2` で。否定コントロール 1 件: 1 項を `i` 倍すると有限和は実でない | **PASS** | 80 段 |

## 計算の帰属と範囲

- **厳密**: `QQ(i)` 係数の多項式環で、浮動小数点と ℝ/ℂ への脱出はない。人手の実数は `QQ` 上の不定元で代表させる（鎖の各段は多項式の恒等式なので、どの実数を代入しても成り立つ）。
- 範囲: `r = 1..5`、行列の大きさ `m, n = 1..2`。帰納法の段そのものは定義の式なので、`r` によらず同じである。`r = 1` と帰納法の段の 2 つの等式は、和を定義どおり左から足して組んでいるので構成上一致する（検算の実質は各段の成分の実性の側にある）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh finite_sum_of_real_entry_matrices_has_real_entries
```

実行ログは `logs/` に保存する。
