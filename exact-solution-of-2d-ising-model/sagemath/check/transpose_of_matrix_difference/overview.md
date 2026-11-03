# SageMath Check: transpose_of_matrix_difference

## 対象

**対象ラベル**: `transpose_of_matrix_difference`

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_transpose_of_matrix_difference`（行列の差の転置は転置の差）
- 範囲: 証明の鎖の全行

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 鎖の全行 | `check_entry_chain.sage` | `((A-B)^⊤)_{ki} = (A-B)_{ik} = A_{ik}-B_{ik} = (A^⊤)_{ki}-(B^⊤)_{ki} = (A^⊤-B^⊤)_{ki}` の 4 段（`def_matrix_transpose` → `def_matrix_difference` → `def_matrix_transpose` を 2 箇所 → `def_matrix_difference`）を、`A, B` の成分を不定元にして全成分で。否定コントロール 1 件: 右辺を `B^⊤-A^⊤` にすると一致しない | **PASS** | 144 段 |

## 計算の帰属と範囲

- **厳密**: `QQ(i)` 係数の多項式環で、浮動小数点と ℝ/ℂ への脱出はない。行列の成分（と係数）は不定元で代表させる（鎖の各段は多項式の恒等式なので、どの複素数を代入しても成り立つ）。
- 範囲: 行列の大きさ `m, p = 1..3`。主張は成分ごとの等式（有限和は帰納法の段）なので、大きさによらず同じ段である。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh transpose_of_matrix_difference
```

実行ログは `logs/` に保存する。
