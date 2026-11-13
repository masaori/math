# SageMath Check: pauli_z_has_real_entries

## 対象

**対象ラベル**: `pauli_z_has_real_entries`

- ファイル: `structured-latex/content/006_Z_Y_anticommutation.ts`
- ブロック: `Z_Y_anticommutation_claim_pauli_z_has_real_entries`（σ^z の成分はすべて実数）
- 範囲: 証明の鎖と、各成分について r を取る段落

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 証明の鎖の全行と成分ごとの r | `check_chain.sage` | `σ^z = (1_ℂ 0_ℂ; 0_ℂ -1_ℂ) = (ι(1) ι(0); ι(0) ι(-1))` の 2 段（`def_pauli_matrices` → `inclusion_rr_to_cc` の略記）。`ι(r) := (r, 0)` は `QQ(i)` の `r + 0·i` として組む。各成分が人手の取る `r ∈ QQ` の `ι(r)` に等しく虚部 0 であること。対照 1 件: `σ^y` は虚部 0 でない成分を持つ | **PASS** | 2 段と 4 成分 |

共通の準備は `sagemath/_shared/pauli_sites_exact.sage`（σ^x, σ^y, σ^z は `def_pauli_matrices`、I は `def_identity_matrix` の成分）。

## 計算の帰属と範囲

- **厳密**: 成分はすべて `QQ(i)` で、浮動小数点と ℝ/ℂ への脱出はない。人手の `r` は `QQ ⊂ ℝ` の元である。
- 範囲: 主張は 2 次の具体的な行列 1 つについての性質なので、鎖の全行と 4 成分をそのまま確かめた。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh pauli_z_has_real_entries
```

実行ログは `logs/` に保存する。
