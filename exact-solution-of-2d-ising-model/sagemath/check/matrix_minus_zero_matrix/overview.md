# SageMath Check: matrix_minus_zero_matrix

## 対象

**対象ラベル**: `matrix_minus_zero_matrix` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_matrix_minus_zero_matrix`
- 主張: `X ∈ Mat(m,n,ℂ)` について `X - O = X`
- 範囲: 証明の成分ごとの鎖の 10 行と、続く `X - O = X + O = X` の 2 行

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---------|---------|-----------|------|
| check_steps.sage | 複素数の差を `def_complex_difference`、符号反転を `multiply_by_minus_one`、積を `definition_of_cc` の式どおりに組み、成分の鎖の 11 個の項が隣り合って等しいこと。`X - O = X + O` と `X + O = X` が成分ごとに成り立つこと。独立な経路として Sage の行列の差でも確かめた。否定コントロール: 零でない数を引くと変わる | PASS | すべて一致 |

## 備考

- 浮動小数点は使っていない。差・積は本文の定義どおりに自前で組んだ。
- 帰属: `QQ` 上の多項式環（または `QQ`）。不定元で成り立つ多項式の等号は、成分へ任意の実数を代入しても成り立つ。
- 大きさは `m, n ∈ {1, 2, 3}` の 9 通りで、一般の大きさは人手証明が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh matrix_minus_zero_matrix
```

実行ログは `logs/` に保存してある（2026-11-01）。
