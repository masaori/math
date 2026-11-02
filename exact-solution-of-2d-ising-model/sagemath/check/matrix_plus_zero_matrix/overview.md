# SageMath Check: matrix_plus_zero_matrix

## 対象

**対象ラベル**: `matrix_plus_zero_matrix` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`
- ブロック: `linear_space_general_claim_matrix_plus_zero_matrix`
- 主張: `X ∈ Mat(m,n,ℂ)` について `X + O = X`
- 範囲: 証明の成分ごとの鎖の 7 行

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---------|---------|-----------|------|
| check_steps.sage | 複素数を `definition_of_cc` の実数の組 `(a,b)` で持ち、鎖の 8 つの項を各行の式どおりに別々に組んで隣り合う項が等しいこと。全成分が一致すること。独立な経路として Sage の行列の和でも確かめた。否定コントロール: 零でない行列を足すと変わる | PASS | すべて一致 |

## 備考

- 浮動小数点は使っていない。和は `definition_of_cc` の成分ごとの和を自前で組んだ。
- 帰属: `QQ` 上の多項式環（または `QQ`）。不定元で成り立つ多項式の等号は、成分へ任意の実数を代入しても成り立つ。
- 大きさは `m, n ∈ {1, 2, 3}` の 9 通りで、一般の大きさは人手証明が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh matrix_plus_zero_matrix
```

実行ログは `logs/` に保存してある（2026-11-01）。
