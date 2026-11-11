# SageMath Check: adjugate_times_matrix_two_by_two

## 対象

**対象ラベル**: `adjugate_times_matrix_two_by_two` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_45_46.ts`
  （ブロック `finite_matrix_claim_adjugate_times_matrix_two_by_two`）
- 主張: `B ∈ Mat(2,ℂ)` について `(adj B) B = (det B) I_{Mat(2,ℂ)}`
- 範囲: 4 つの成分の鎖の各行。成分の鎖が引く `negation_times_complex_is_negation_of_product_in_cc`・`negation_plus_self_is_zero_in_cc` の鎖は、それぞれのラベルのフォルダの検算が確かめる（2026-11-11 に準備 (b)・(c) を主張へ移した）。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---------|---------|-----------|------|
| check_steps.sage | 成分 (1,1)・(1,2)・(2,1)・(2,2) の鎖（10・10・9・11 行）の各行が多項式として一致すること。否定コントロール: 対角成分を入れ替えない行列では成り立たない | PASS | すべて厳密に一致 |

## 備考

- 浮動小数点は使っていない。`−u` は `(−1)·u` として書いた。

## 実行方法

```bash
cd sagemath/check/adjugate_times_matrix_two_by_two
~/micromamba/envs/sage/bin/sage check_steps.sage
```

実行ログは `logs/` に保存してある（2026-11-11）。
