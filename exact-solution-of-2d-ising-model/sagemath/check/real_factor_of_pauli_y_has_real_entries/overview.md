# SageMath Check: real_factor_of_pauli_y_has_real_entries

## 対象

**対象ラベル**: `real_factor_of_pauli_y_has_real_entries`

- ファイル: `structured-latex/content/006_Z_Y_anticommutation.ts`
- ブロック: `Z_Y_anticommutation_claim_real_factor_of_pauli_y_has_real_entries`（R^y の成分はすべて実数）
- 範囲: 証明の鎖と、各成分について r を取る段落

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 証明の鎖の全行と成分ごとの r | `check_chain.sage` | `R^y = (0_ℂ -1_ℂ; 1_ℂ 0_ℂ) = (ι(0) ι(-1); ι(1) ι(0))` の 2 段（`def_real_factor_of_pauli_y` → `inclusion_rr_to_cc` の略記）。`ι(r) := (r, 0)` は `QQ(i)` の `r + 0·i` として組む。各成分が人手の取る `r ∈ QQ` の `ι(r)` に等しく虚部 0 であること。対照 1 件: `σ^y` は虚部 0 でない成分を持つ | **PASS** | 2 段と 4 成分 |

## 計算の帰属と範囲

- **厳密**: 成分はすべて `QQ(i)` で、浮動小数点と ℝ/ℂ への脱出はない。人手の `r` は `QQ ⊂ ℝ` の元である。
- 範囲: 主張は 2 次の具体的な行列 1 つについての性質なので、鎖の全行と 4 成分をそのまま確かめた。

- 1 行目と 2 行目は同じ成分の式から組むので構成上一致する（`def_real_factor_of_pauli_y` を開くだけの行）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_factor_of_pauli_y_has_real_entries
```

実行ログは `logs/` に保存する。
