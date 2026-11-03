# SageMath Check: transpose_of_matrix_scalar_multiple

## 対象

**対象ラベル**: `transpose_of_matrix_scalar_multiple`

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_transpose_of_matrix_scalar_multiple`（行列のスカラー倍の転置は転置のスカラー倍）
- 範囲: 証明の鎖の全行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 鎖の全行 | `check_entry_chain.sage` | `((cA)^⊤)_{pq} = (cA)_{qp} = cA_{qp} = c(A^⊤)_{pq} = (cA^⊤)_{pq}` の 4 段（`def_matrix_transpose` → `def_matrix_scalar_multiple` → `def_matrix_transpose` → `def_matrix_scalar_multiple`）を、`c` と `A` の成分を不定元にして全成分で。否定コントロール 1 件: 係数を落とすと一致しない | **PASS** | 144 段 |

## 計算の帰属と範囲

- **厳密**: `QQ(i)` 係数の多項式環で、浮動小数点と ℝ/ℂ への脱出はない。行列の成分（と係数）は不定元で代表させる（鎖の各段は多項式の恒等式なので、どの複素数を代入しても成り立つ）。
- 範囲: 行列の大きさ `m, n = 1..3`。主張は成分ごとの等式（有限和は帰納法の段）なので、大きさによらず同じ段である。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh transpose_of_matrix_scalar_multiple
```

実行ログは `logs/` に保存する。
