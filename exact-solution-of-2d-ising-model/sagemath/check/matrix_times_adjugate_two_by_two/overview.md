# SageMath Check: matrix_times_adjugate_two_by_two

## 対象

**対象ラベル**: `matrix_times_adjugate_two_by_two` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_45_46.ts`
  （ブロック `finite_matrix_claim_matrix_times_adjugate_two_by_two`）
- 主張: `B ∈ Mat(2,ℂ)` について `B (adj B) = (det B) I_{Mat(2,ℂ)}`（`adj B` は `def_adjugate_two_by_two`）
- 範囲: 4 つの成分の鎖の各行。成分の鎖が引く `complex_times_negation_is_negation_of_product_in_cc`・`negation_plus_self_is_zero_in_cc` の鎖は、それぞれのラベルのフォルダの検算が確かめる（2026-11-11 に準備 (a)・(c) を主張へ移した）。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---------|---------|-----------|------|
| check_steps.sage | 成分 (1,1)・(1,2)・(2,1)・(2,2) の鎖（9・9・10・11 行）の各行が `QQ[B11, B12, B21, B22]` の多項式として一致すること。否定コントロール: 非対角成分の符号を落とした行列では成り立たない | PASS | すべて厳密に一致 |

## 備考

- 浮動小数点は使っていない。`−u` は `(−1)·u` として書き、`multiply_by_minus_one` の読み方に合わせた。

## 実行方法

```bash
cd sagemath/check/matrix_times_adjugate_two_by_two
~/micromamba/envs/sage/bin/sage check_steps.sage
```

実行ログは `logs/` に保存してある（2026-11-11）。
